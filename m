From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Re: Merge with git-pasky II.
Date: Sun, 17 Apr 2005 17:28:41 +0200
Message-ID: <20050417152841.GA6157@elte.hu>
References: <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org> <1113559330.12012.292.camel@baythorne.infradead.org> <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org> <20050416014442.GW4488@himi.org> <Pine.LNX.4.62.0504160518310.21837@qynat.qvtvafvgr.pbz> <20050416155536.GX4488@himi.org> <20050416160333.GF19099@pasky.ji.cz> <Pine.LNX.4.58.0504160913180.7211@ppc970.osdl.org> <20050417145232.GA5289@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Simon Fowler <simon@himi.org>,
	David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 17:25:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNBdv-0003Xn-QJ
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVDQP2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVDQP2x
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:28:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16565 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261333AbVDQP2v (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 11:28:51 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 482AC31EBB6;
	Sun, 17 Apr 2005 17:28:04 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id CF7771FC2; Sun, 17 Apr 2005 17:28:43 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050417145232.GA5289@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> The compromise relies on you having reviewed something harmless, while 
> in reality what happened within the DB was far less harmless. And the 
> DB remains self-consistent: neither fsck, nor others importing your 
> tree will be able to detect the compromise. This attack can only be 
> detected when you apply the patch, after that point all the 
> information (except Malice's message in your inbox) is gone.

in fact, this attack cannot even be proven to be malicious, purely via 
the email from Malice: it could be incredible bad luck that caused that 
good-looking patch to be mistakenly matching a dangerous object.

In fact this could happen even today, _accidentally_. (but i'm willing 
to bet that hell will be freezing over first, and i'll have some really 
good odds ;) There's probably a much higher likelyhood of Linus' tree 
getting corrupted in some old fashioned way and introducing a security 
hole by accident)

	Ingo
