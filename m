From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 15:38:12 +0100
Message-ID: <AANLkTikb_mWdgF4gf6FEBF=CLxLeefJJkRgDzEB5=3SO@mail.gmail.com>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
	<AANLkTimLRc4LybUvmD2ZCKfQqEP+vr+2aBnb4n3B+Mb2@mail.gmail.com>
	<4D67A293.2050306@drmicha.warpmail.net>
	<AANLkTimqszvGjVeJHKLPWicDugeOuqbgO1+wy5BO-AE0@mail.gmail.com>
	<4D67A92D.2000300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dario Rodriguez <soft.d4rio@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 15:38:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsyoF-0007Wy-1c
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 15:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216Ab1BYOiO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 09:38:14 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34835 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab1BYOiN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 09:38:13 -0500
Received: by vxi39 with SMTP id 39so1399228vxi.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TnUpfpo+Befmskauo+AbnmrYfzw8ucXp0HGF3w/8I+I=;
        b=x0PP6Hxl6VXH/N6gz7bo+U1mz4vOq+ve1kDwAyF603RGiHPq1s7ulrD9lwjarm/osz
         uI2sfVnfD9jhFPN/in6QdoMLs4GNxhXx+S3vEdwOhB+hxaZe3jX7+YeY8rvRFBo/iYIs
         lmDEQhwSnFqOCtCL75eEJOid2oyW/J7AYZbpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZESlR75f0eZ+dam3O5YQD9YqGLsPcxEZwgQM4RUBVNbf224XsgTsay6q+ghUeCnBJT
         hLHWD6Misk3aCBFCCQ9lCGZQHD2Fj+yfHSyNAO/kuRfUPaago0Ul+pYFZtqk4XTkaFNe
         VTVweoadcRagTAFqxUBrWnz/zryWYD7HY9deo=
Received: by 10.52.167.68 with SMTP id zm4mr4068681vdb.214.1298644692593; Fri,
 25 Feb 2011 06:38:12 -0800 (PST)
Received: by 10.220.186.131 with HTTP; Fri, 25 Feb 2011 06:38:12 -0800 (PST)
In-Reply-To: <4D67A92D.2000300@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167906>

=C6var, Michael, thanks for the tips.

Dario: Yes, I understand the reasoning. It's not often a problem, and
when it occurs there are ways to do it. I just thought I'd bring it up
on the list cause it feels like expected behavior (other git commands
behave correspondingly).

On Fri, Feb 25, 2011 at 2:05 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Note that you can also
>
> git show <commit> -- <path> | git apply -R
>
> to achieve a partial revert. That might be the easiest route to take.

Indeed it is. Neat command, thanks again!
