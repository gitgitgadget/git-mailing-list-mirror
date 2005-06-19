From: Ingo Molnar <mingo@elte.hu>
Subject: Re: qgit-0.6
Date: Sun, 19 Jun 2005 15:00:35 +0200
Message-ID: <20050619130035.GA15355@elte.hu>
References: <20050618103805.8461.qmail@web26302.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, berkus@gmail.com
X-From: git-owner@vger.kernel.org Sun Jun 19 14:56:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjzL6-0000Y6-03
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 14:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVFSNBd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 09:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVFSNBd
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 09:01:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:2437 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261851AbVFSNBb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 09:01:31 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id E21D6315875;
	Sun, 19 Jun 2005 14:58:07 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 5D9841FC2; Sun, 19 Jun 2005 15:01:14 +0200 (CEST)
To: Marco Costalba <mcostalba@yahoo.it>
Content-Disposition: inline
In-Reply-To: <20050618103805.8461.qmail@web26302.mail.ukl.yahoo.com>
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

> A word on annotate: In file viewer, after a while :-), the file 
> contents will change to show the annotations. Annotations are 
> calculated in background so it may takes some time to show (it depends 
> mostly on fetching history patches with git-diff-tree -p ). History is 
> snapshotted to actual loaded data so peraphs you need qgit to have 
> loaded an interesting amount of data before calling file viewer.

works fine here and is nice and fast, but there are a few minor visual 
glitches:

- annotated file contents are not properly aligned over each other. E.g.  
  check commit 7875b50d1a9928e683299b283bfe94778b6c344e in the current 
  git repository, and select read-tree.c and view it annotated - the 
  lines start right after the author field ends, not in any aligned way.

- the tree visualization is hard to follow - gitk's output is much 
  nicer. As an example of nice rendering check out the octopus merge 
  around commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e. One glance at 
  the gitk output shows what happened - qgit's output is in essence 
  unreadable.

and a few requests for enhancements if you dont mind:

 - in annotated mode, it would be nice to select a particular line 
   and then double-click would jump to the commit that added that line.  
   This would nicely round up annotation support.

 - plaintext search capability in every window. E.g. in the annotated
   file window i often would like to search for some code, or to jump to
   a given line.

	Ingo
