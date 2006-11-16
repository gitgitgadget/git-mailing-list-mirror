X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Richard CURNOW <richard.curnow@st.com>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 07:51:53 +0000
Message-ID: <20061116075153.GA29363@tigerwolf.bri.st.com>
References: <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org> <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com> <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home> <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <87velgs9hx.wl%cworth@cworth.org> <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org> <87psbos4pb.wl%cworth@cworth.org> <20061115180722.83ff8990.seanlkml@sympatico.ca> <20061115231542.GB25270@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 07:53:15 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Sean <seanlkml@sympatico.ca>,
	Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061115231542.GB25270@spearce.org>
User-Agent: mutt-ng/devel-r804 (Linux)
X-O-Spoofed: Not Scanned
X-O-General-Status: No
X-O-Spam1-Status: Not Scanned
X-O-Spam2-Status: Not Scanned
X-O-URL-Status: Not Scanned
X-O-Virus1-Status: No
X-O-Virus2-Status: Not Scanned
X-O-Virus3-Status: No
X-O-Virus4-Status: No
X-O-Virus5-Status: Not Scanned
X-O-Image-Status: Not Scanned
X-O-Attach-Status: Not Scanned
X-SpheriQ-Ver: 4.2.04
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31563>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkc3b-0006wb-Ad for gcvg-git@gmane.org; Thu, 16 Nov
 2006 08:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161966AbWKPHw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 02:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161965AbWKPHw5
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 02:52:57 -0500
Received: from lon-del-02.spheriq.net ([195.46.50.98]:21457 "EHLO
 lon-del-02.spheriq.net") by vger.kernel.org with ESMTP id S1161966AbWKPHw4
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 02:52:56 -0500
Received: from lon-out-01.spheriq.net ([195.46.50.129]) by
 lon-del-02.spheriq.net with ESMTP id kAG7qrWV023433 for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 07:52:54 GMT
Received: from lon-cus-02.spheriq.net (lon-cus-02.spheriq.net [195.46.50.38])
 by lon-out-01.spheriq.net with ESMTP id kAG7qoUT019696 for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 07:52:53 GMT
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35]) by
 lon-cus-02.spheriq.net with ESMTP id kAG7qmp8030464 (version=TLSv1/SSLv3
 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK); Thu, 16 Nov 2006 07:52:50
 GMT
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9]) by
 beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1CCDCDA52; Thu, 16 Nov
 2006 07:52:04 +0000 (GMT)
Received: from mail1.bri.st.com (mail1.bri.st.com [164.129.8.218]) by
 zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 33E8A4724D; Thu, 16 Nov
 2006 07:52:02 +0000 (GMT)
Received: from tigerwolf (tigerwolf.bri.st.com [164.129.15.46]) by
 mail1.bri.st.com (MOS 3.7.5a-GA) with ESMTP id CIF54211 (AUTH curnowr); Thu,
 16 Nov 2006 07:52:00 GMT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

* Shawn Pearce <spearce@spearce.org> [2006-11-15]:
> 
> So what about making git-merge take a -m "msg" argument to supply
> the commit message, in which case it does the current behavior
> (and thus git-pull needs to change to supply -m); and then make
> git-merge without any -m parameter invoke "git pull . $@" ?

Sounds good to me.

When I'm merging in my own projects, I currently always use merge
(possibly preceded by fetch) rather than pull.  Why?  Because I don't
want my history full of commit messages like

Merge branch "trial_hack" from "../scratch_dir_with_silly_name"

In contrast to Linus's case of wanting to record where the remote merge
came from, I expressly don't want to record that - I want the merge
commit to describe conceptually what was being merged with what.

OK, I could use probably use pull with --no-commit, but I've already
trained my fingers to type out the merge syntax.  They'd be happier with
'git merge -m "Merge feature foo with fixes for bar" bar" though.
