From: Dilip M <dilipm79@gmail.com>
Subject: Re: Installing full fledged git on solaris? - solved
Date: Sun, 11 Oct 2009 22:08:00 +0530
Message-ID: <c94f8e120910110938m36c6e05bhd10ef86ed382cfd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sun Oct 11 18:48:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx1ai-0005vQ-Vn
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 18:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbZJKQqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 12:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755812AbZJKQqj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 12:46:39 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:64074 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbZJKQqj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Oct 2009 12:46:39 -0400
Received: by pxi9 with SMTP id 9so8023147pxi.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=bcXhjmU6hDsi1JgyDtLMqknhjDTnDKB4f37dSPnZNaI=;
        b=SmeNheiMvfl9nclo5eaH2thrasVp6X+3OmFEoVMwfTiVty1sdfppUja1NUJeFyj5fV
         D6FrKv3f8YaJ8OvGII2hpk/8vAixF0nDcb+V59OCJmXv8DhGzwr3r+goxeLazGHHBgil
         TYJ+TVxQGLg/uCkhxTjvlZQakHDOt7SDDHf60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=WD4fvYNdHIwRU4WFoukuxdY+Bga8nkXcz1cKD6pFwyU6nFgeAoWSGaH03daHVxCyFX
         qW7SLs8ya8Yfft+YyKdde0Gks/3181fgtXnr84COPpYowXyoJWRnYj4dW85t7ZLhrJ6h
         9I7X53ol4TTag3YYpyiaAAbOggbxdOgRkp3LU=
Received: by 10.140.255.21 with SMTP id c21mr351451rvi.198.1255279100043; Sun, 
	11 Oct 2009 09:38:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129937>

On Sun, Oct 11, 2009 at 6:42 PM, Ben Walton <bwalton@artsci.utoronto.ca=
> wrote:
> Excerpts from Dilip M's message of Sun Oct 11 08:26:10 -0400 2009:
>
> Hi Dilip,
>
>> Has anyone has the list of pkg's to be installed on solaris 10 sparc=
,
>> to get the GIT compiled (with all features)..
>
> This may not be what you want, but if you use the CSW package stack,
> you can get git easily. =A0This is, I believe, a very complete git
> installation. =A0There will soon be an update to 1.6.5.
>
> http://www.opencsw.org/packages/git
>
> If your intent is to build it yourself, let me know and I'll share
> with you the build recipe I use, which will outline (within the CSW
> stack) which packages are used for compilation and which for runtime
> dependencies. =A0You should be able to translate it to use the
> libs/tools available to solaris 10 (that aren't in 8, which we also
> support).

Thank Ben.  You saved my day!

BTW, any info on making tig package available! Just asking...


--=20
Dilip
