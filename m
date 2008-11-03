From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: why not TortoiseGit
Date: Mon, 3 Nov 2008 10:00:14 +0000
Message-ID: <320075ff0811030200q606b76a8i16496cf7b8b1b7d2@mail.gmail.com>
References: <7FD1F85C96D70C4A89DA1DF7667EAE96125890@zch01exm23.fsl.freescale.net>
	 <20081031121913.GE18221@sys-0.hiltweb.site> <490AFBA5.5090700@op5.se>
	 <d411cc4a0810310857y5b4f8c46ue33e1f6a9e2c13d1@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE961E728C@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Scott Chacon" <schacon@gmail.com>, "Andreas Ericsson" <ae@op5.se>,
	"Ian Hilt" <ian.hilt@gmx.com>, git@vger.kernel.org
To: "Li Frank" <Frank.Li@freescale.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 11:01:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwwFd-0001gL-SC
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 11:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbYKCKAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 05:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbYKCKAS
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 05:00:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:47129 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbYKCKAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 05:00:16 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2137230fgg.17
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 02:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hUVrfiudyeeiXHezexRRCJfRGY5G8737X8NeL+DLoks=;
        b=hbsyoyazpDSn7iuTbR4Wi1l2IJV7XSE6m0w3b98Qig9TtdYQavLTq19AtBbUXMIM1W
         erXy/e/sib+oCxg0hbHuyi/A+ORA9I9fUGHhBNqnKQFmhBi1EJp0U/LGGfi2iwe/mXg2
         7BkHD9rNkPXaJyWUCCb7C1LZpdh0LEBhzZjy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MMkIlYV5HgSarM3ZSCZX523cXmmGAMoct+5kSXrp7pJq/fNquY51D+jPaMBz4IGk+F
         OUb1i9D4EqFPk2h4VuYZk6EYFCQeyIZQFL8navDcw26CY5qRfkYG41e4hgGEmJb3AQil
         7aSYGMg6Q/UWc4+M2mSOs7aFQ3y3hZpua6nfk=
Received: by 10.187.182.10 with SMTP id j10mr1871160fap.12.1225706414493;
        Mon, 03 Nov 2008 02:00:14 -0800 (PST)
Received: by 10.187.164.7 with HTTP; Mon, 3 Nov 2008 02:00:14 -0800 (PST)
In-Reply-To: <7FD1F85C96D70C4A89DA1DF7667EAE961E728C@zch01exm23.fsl.freescale.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99926>

> I read some code of TortoiseSVN and TortoiseHg Code.
> At beginning, TortoiseGit can git command to get information like Qgit.
> After linkable library ready, replace "git command".
>
> I think TortoiseGit can start base on below way.
>
> 1.  Base on TortoiseHg, It is python Script.  Replace below hg operator
> with Git.
> 2.  Base on TortoiseSVN, It is developed with C++. Need VS2008.
> ToritoiseSVN provide some built in diff and merge tools.
> 3.  Base on Qgit, which provide some basic UI, such comment dialogbox,
> history view and file annotate.
>
>

TortoiseSVN is a good place to start because it separates out the
windows icon decorators into a separate DLL (shared with TortoiseCVS).
This is significant, as these are a finite resource in the windows
shell, and so having a TortoiseSVN + TortoiseGIT on one machine and
you might run out, and I'd imagine lots of people wanting both.

On the minus side, building (Tortoise)SVN requires a lot of
environment setup just to get it to build - most of which can be
immediately thrown away as it's specific to SVN.

But it doesn't look like a hard project to me, just requires stripping
out a lot of junk and re-patching callouts to a git executable (which
could be the standard git tools) and a minimal git library that knows
if files are dirty.
