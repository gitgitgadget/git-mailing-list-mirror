From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] diff --check: use colour
Date: Fri, 26 Jan 2007 12:05:27 +0000
Message-ID: <200701261205.28504.andyparkins@gmail.com>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17849.17947.645022.282882@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 13:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAPqA-00033D-VJ
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 13:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965465AbXAZMFf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 07:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965620AbXAZMFf
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 07:05:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:45904 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965465AbXAZMFe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 07:05:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so699341uga
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 04:05:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Qpwu8rRQ2M+6LLVF2FvagCBwNfPPLyQeG4yJIugDsunCj1b/7sAUNHlEVh365omeygwCO4zrudsGvPRIbIGHwKtYIJlWeeu3nwQH5GxAJP58fURc6hM2ayeg/iABs71tJvzhgv1Z8utE1/txsnaldv8gt/0s34GSo0Qywdesf4w=
Received: by 10.67.22.14 with SMTP id z14mr4213934ugi.1169813133044;
        Fri, 26 Jan 2007 04:05:33 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id s7sm4239304uge.2007.01.26.04.05.31;
        Fri, 26 Jan 2007 04:05:31 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <17849.17947.645022.282882@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37849>

On Friday 2007 January 26 00:06, Bill Lear wrote:

> git log -S --check foo
>
> and the thing went off into outer space.  Now at over 2 1/2 minutes of
> CPU time on my 2 Ghz Opteron box...

I would guess it's because you've used "-S<space>--check"; the --check will be 
ignored as git-log doesn't use it, but the -S is saying "search for the empty 
string" in all log messages - that's probably a long list, and so takes a 
while to compile.

> Is it really '-S--check'?

Yep - it's "-S<string to search for>", so you'd be searching for the 
string "--check" in that example.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
