From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: why not TortoiseGit
Date: Mon, 3 Nov 2008 13:39:47 +0000
Message-ID: <320075ff0811030539q476ab4f4kd332a37acdc1ca87@mail.gmail.com>
References: <7FD1F85C96D70C4A89DA1DF7667EAE96125890@zch01exm23.fsl.freescale.net>
	 <20081031121913.GE18221@sys-0.hiltweb.site> <490AFBA5.5090700@op5.se>
	 <d411cc4a0810310857y5b4f8c46ue33e1f6a9e2c13d1@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE961E728C@zch01exm23.fsl.freescale.net>
	 <320075ff0811030200q606b76a8i16496cf7b8b1b7d2@mail.gmail.com>
	 <alpine.DEB.1.00.0811031425080.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Li Frank" <Frank.Li@freescale.com>,
	"Scott Chacon" <schacon@gmail.com>, "Andreas Ericsson" <ae@op5.se>,
	"Ian Hilt" <ian.hilt@gmx.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 14:41:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwzg5-0004TX-2p
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 14:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245AbYKCNjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 08:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbYKCNju
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 08:39:50 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:51016 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245AbYKCNju (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 08:39:50 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3090149fkq.5
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 05:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lPZTMeEptpFY3OyQKKxMRQfZpPYEhFDOVr3GsszLW30=;
        b=f6KEV8PwCfbe/suhBNHfhQ9Ga0VjbmH9U+pbBd/yRGKEghq2UQh3mNxrP/FcE4gTWf
         z7zifIqOuyHAE8v8seg24Of4O36iZsxUA6mjfYZc8q5p7uajl96+C8Wxii164swqXi6Z
         lLvoNhNxt60NvL3zWx0idOcGPVng42NIJwCY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ez/BMlnO9/lZ99c+JFoLB8Ufe+gHZafGFKvdFsfgTxEGNTL0xHPFBI6PezBIHMS80k
         feWX2+gvC2HAWHjvYmmnoMSfLQ5wuWKLcNe+2q9GXgaiqzQ8d/uL0/Xf4S51iIFE1O6w
         ob0rYMFg5+EwTQgtKUEqFNPWGkdrSECJg6ECg=
Received: by 10.187.232.14 with SMTP id j14mr23076far.90.1225719587975;
        Mon, 03 Nov 2008 05:39:47 -0800 (PST)
Received: by 10.187.164.7 with HTTP; Mon, 3 Nov 2008 05:39:47 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811031425080.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99942>

>> But it doesn't look like a hard project to me, just requires stripping
>> out a lot of junk and re-patching callouts to a git executable (which
>> could be the standard git tools) and a minimal git library that knows if
>> files are dirty.
>
> I only wish that people would put their code where there mouth is.
>
> At least with GitCheetah, we have working code, _and_ an opportunity to go
> cross-platform.
>

Well, hey, I don't care there's no TortoiseGit. I looked at these
things back when I had colleagues stuck on Windows, and at the time
wanted to try and wean them off SVN.

The shell-icon overlay limit on Windows looked a significant problem
to me, and a good reason for at least re-using that bit of code (which
is common to even tortoiseCVS). It looked like it had been through a
significant number of iterations to get platform shell subtleties
right.

I even looked at wacky things, like using IKVM.Net and JGit to hack it
quickly, but that's a non-starter because of MS' stupid
one-clr-per-process.

That's what I found. Maybe it'll be useful for anyone else that wants
to continue. Since it's not an itch for me any more, and it won't feed
my children, until someone that cares enough does something there
won't be one.
