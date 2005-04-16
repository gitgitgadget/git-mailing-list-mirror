From: Ingo Molnar <mingo@elte.hu>
Subject: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 14:31:55 +0200
Message-ID: <20050416123155.GA19908@elte.hu>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 14:29:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMmQo-0000vC-Ga
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 14:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVDPMd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 08:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVDPMd0
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 08:33:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10425 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262652AbVDPMdX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 08:33:23 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 50268319852;
	Sat, 16 Apr 2005 14:32:20 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 806911FC2; Sat, 16 Apr 2005 14:33:13 +0200 (CEST)
To: David Lang <david.lang@digitalinsight.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* David Lang <david.lang@digitalinsight.com> wrote:

> this issue was raised a few days ago in the context of someone 
> tampering with the files and it was decided that the extra checks were 
> good enough to prevent this (at least for now), but what about 
> accidental collisions?
> 
> if I am understanding things right the objects get saved in the 
> filesystem in filenames that are the SHA1 hash. of two legitimate 
> files have the same hash I don't see any way for both of them to 
> exist.
> 
> yes the risk of any two files having the same has is low, but in the 
> earlier thread someone chimed in and said that they had two files on 
> their system that had the same hash..

you can add -DCOLLISION_CHECK to Makefile:CFLAGS to turn on collision 
checking (disabled currently). If there indeed exist two files that have 
different content but the same hash, could someone send those two files?

	Ingo
