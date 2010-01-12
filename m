From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: gitosis user on Windows
Date: Tue, 12 Jan 2010 15:38:30 +0000
Message-ID: <26ae428a1001120738i71378354l48b586ce32260122@mail.gmail.com>
References: <26ae428a1001120142j36619d62xcf3ffee3539a03b7@mail.gmail.com>
	 <alpine.DEB.2.00.1001121121380.30408@ds9.cixit.se>
	 <26ae428a1001120245q51c922ccr9787581c2886222c@mail.gmail.com>
	 <4B4C960E.5080004@pizarro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: matias@pizarro.net
X-From: git-owner@vger.kernel.org Tue Jan 12 16:38:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUipN-00049P-1g
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 16:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab0ALPih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2010 10:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651Ab0ALPig
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 10:38:36 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:44573 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab0ALPig convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 10:38:36 -0500
Received: by ewy1 with SMTP id 1so4785921ewy.28
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 07:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=9awgEAzPOdWnyMaFYlhxN2rvP0ro9puQUKm6ymC764w=;
        b=LVs7+Q/XiMOgE8HsIyeYDe066fBmCJyFO8r7A7gJLo7Zn1haI6YX8Bc5MmGVSRkm6C
         SLdXSN9u4utZQNfaJ6u+/6HA4XoSVmZNn0eZCMAuFkn/hTExvaV80sQ3BX5VEsy9h9oY
         kywP8x7JQUr7dHIpsZ/QkiYLEpYPcjia5fOdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=IRg4MCyVpbc2uTYVQlESZdDOqQfS6ySIxLckUTGzDDpn3TIeTnJZlgSPtmWWCchAsg
         SGtrgMQxOqeONGpaLnI22fCFTvkBVAmrAXZB0sjA16MMX3DIZB3rBNgcCtMSH2BsO0t8
         Vi+1QDy6yMEw1V+RTzV+39coMKZrxJ3sw7ZVk=
Received: by 10.213.57.69 with SMTP id b5mr989935ebh.74.1263310711098; Tue, 12 
	Jan 2010 07:38:31 -0800 (PST)
In-Reply-To: <4B4C960E.5080004@pizarro.net>
X-Google-Sender-Auth: 41b77cd93e196ccc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136724>

2010/1/12  <matias@pizarro.net>:
> Hi,
>
> If he is using tortoise git there are 2 different ways, mutually excl=
usive,
> depending on what he choses regarding which version of plink.exe to u=
se.
> He has to chose this there: 'Start' > 'All Programs' > 'TortoiseGit' =
>
> 'Settings'=A0 Then choose an SSH client. Typical examples of values f=
or this
> would be:
> =A0 - C:\Program Files\TortoiseGit\bin\TortoisePLink.exe=A0 if he cho=
oses to use
> TortoiseGit's plink
> =A0 - C:\Program Files\Putty\plink.exe if he chooses to use putty
>
> I understand he is using TortoiseGit, so he would have to use the fir=
st
> option and then open 'Start' > 'All Programs' > 'TortoiseGit' > Putty=
gen
>
> Then click on 'Generate' and follow instructions.
>
> Once he has created his public key, he has to load it after each rebo=
ot,
> using 'Start' > 'All Programs' > 'TortoiseGit' > 'Pageant'.
> He will then be prompted to locate his public key and then to enter t=
he
> password that protects it.
> If he wants pageant to point directly to his certificate he can creat=
e a
> link and specify as target:
> "C:\Program Files\TortoiseGit\bin\pageant.exe" "PATH/TO/MY/public_key=
=2Eppk"
> changing of course the paths to reflect his own values.
>
> Hope this helps. Just let me know if you need more information.
>
> mat=EDas pizarro

Thanks Mat=EDas,

It *almost* worked. We couldn't get the key pairs to work though. What
we had to do was to generate the keypair on a linux box and transfer
the private key to the windows box. We couldn't figure out how to
generate the right type of keys and that was just easier. Problem
solved :)

Howard
