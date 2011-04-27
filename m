From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 16:07:26 +0300
Message-ID: <BANLkTikvwoCCmCofbVVPzmuA8uHxqATjTg@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 15:07:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF4Sr-0004DE-Ak
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 15:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759022Ab1D0NH2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 09:07:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39313 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561Ab1D0NH1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 09:07:27 -0400
Received: by fxm17 with SMTP id 17so1102185fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GN97E3SR40+KDUq7dG1IeTKpZTbukRZKQQyQLiC1ODY=;
        b=J59wEnni3tOY+T3GYapKrD9+V2cdBc/C95ayQ4FG2Ntp4Dphf86hRzL1NpFjtdoBqz
         Z95dh/xzZK1yG7IULAXidFS5uTnm7AzYDp6f5ZOrWbQgMCZhco5gtKUp1idxCx+FEvEC
         Ai2lEAaGrwBNZpdHOrXKrqyi8IzE/yyB8kCCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YgwtNg/D/wywr2XlVsvrUpijva14FZuSD3pg5GBSxGhaWyrKb5TAq1sDDI3Qvo1wSl
         MQROTp3iJzqBBj2DQtDS3UjG4LqtW+lQKwhHVnxIbBmR0omYqGyRRoVn5zef0Ox4Pk/4
         Itsw4hvsbpGw7RDmTRdtisTK6oS82fdho+Vsg=
Received: by 10.223.100.86 with SMTP id x22mr2293016fan.108.1303909646333;
 Wed, 27 Apr 2011 06:07:26 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Wed, 27 Apr 2011 06:07:26 -0700 (PDT)
In-Reply-To: <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172236>

On Wed, Apr 27, 2011 at 3:50 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> On Wednesday, April 27, 2011, Andreas Ericsson =C2=A0wrote:
>> Horrible idea. There are already as many package managers as there
>> are packages without us throwing another one into the mix.
>
> I agree that there are too many package managers. But do you know
> what? There isn't a single package manager that reliably works across
> platform. apt-get? great. Except you need something else for Mac,
> cywgin, or, um Fedora. Brew? Fine then you only need to worry about
> Linux and cygwin. Cygwin? ...

gem works on all of them :)

--=20
=46elipe Contreras
