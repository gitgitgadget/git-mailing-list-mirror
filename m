From: Ingo Molnar <mingo@elte.hu>
Subject: Re: qgit-0.7
Date: Sun, 10 Jul 2005 15:43:09 +0200
Message-ID: <20050710134309.GA24935@elte.hu>
References: <20050710122531.15175.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 15:43:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Drc5Z-0007gS-3C
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 15:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVGJNnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 09:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVGJNnM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 09:43:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35025 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261931AbVGJNnK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 09:43:10 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id EB54C32AAFA;
	Sun, 10 Jul 2005 15:42:31 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id EB8BE1FC2; Sun, 10 Jul 2005 15:42:59 +0200 (CEST)
To: Marco Costalba <mcostalba@yahoo.it>
Content-Disposition: inline
In-Reply-To: <20050710122531.15175.qmail@web26303.mail.ukl.yahoo.com>
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


* Marco Costalba <mcostalba@yahoo.it> wrote:

> So I cannot reproduce the bug. [...]

weird - i cannot reproduce it either anymore, and annotate works now as 
advertised - it's fast and accurate as far as i checked. But i synced to 
the latest tree meanwhile. Perhaps i had an inconsistent tree?

(i'll keep an eye on this, i've uncommented that printout, so if it ever 
happens again i'll have the data.)

now that everything is working fine, may i suggest improvements? :-) 
Firstly, now i'm listed as the author for most portions of sched.c, 
which is accurate for a fair portion of that, but is only done by qgit 
because i happened to be the author of the first commit. So it would be 
more accurate to denote version 1's author as empty (or with some other, 
nonintrusive string that shows that this file came here due to the 
initial commit)? We dont know the full history yet, because the current 
DB's history starts at 2.6.12-rc2, with a full sched.c file. (I think an 
empty author field would reflect version #1's authorship most 
accurately, and would be the visually least intrusive.)

	Ingo
