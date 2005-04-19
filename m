From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: SCSI trees, merges and git status
Date: Mon, 18 Apr 2005 17:29:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181724170.15725@ppc970.osdl.org>
References: <1113856118.4998.70.camel@mulgrave>  <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org>
  <1113866092.4998.92.camel@mulgrave>  <Pine.LNX.4.58.0504181651241.15725@ppc970.osdl.org>
 <1113869594.4998.103.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, SCSI Mailing List <linux-scsi@vger.kernel.org>
X-From: linux-scsi-owner@vger.kernel.org Tue Apr 19 02:24:07 2005
Return-path: <linux-scsi-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgWw-0003Oo-6Y
	for lnx-linux-scsi@gmane.org; Tue, 19 Apr 2005 02:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVDSA1z (ORCPT <rfc822;lnx-linux-scsi@m.gmane.org>);
	Mon, 18 Apr 2005 20:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVDSA1z
	(ORCPT <rfc822;linux-scsi-outgoing>);
	Mon, 18 Apr 2005 20:27:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:63695 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261209AbVDSA1d (ORCPT
	<rfc822;linux-scsi@vger.kernel.org>);
	Mon, 18 Apr 2005 20:27:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3J0RRs4014670
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 17:27:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3J0RQUN014021;
	Mon, 18 Apr 2005 17:27:26 -0700
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1113869594.4998.103.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org



On Mon, 18 Apr 2005, James Bottomley wrote:
> 
> Then the git-pull... script actually does the merge and the resulting
> tree checks out against BK

So?

What do you intend to do with all the other stuff I've already put on top?

Yes, I can undo my tree, but my tree has had more stuff in it since I 
pulled from you, so not only will that confuse everybody who already got 
the up-to-date tree, it will also undo stuff that was correct.

In other words, HISTORY CANNOT BE UNDONE.

That's the rule, and it's a damn good one. It was the rule when we used
BK, and it's the rule now. The fact that you can undo your history in
_your_ tree doesn't change anything at all.

So I can merge with your new tree, but that won't actually help any: I'll 
just get a superset, the way you did things. 

The way to remove patches is to explicitly revert them (effectively
applying a reverse diff), but I'm wondering if it's worth it in this case. 
I looked at the patches I did get, and they didn't look horribly bad per 
se. Are they dangerous?

2.6.12 is some time away, if for no other reason than the fact that this 
SCM thing has obviously eaten two weeks of my time. So I'd be inclined to 
chalk this up as a "learning experience" with git, and just go forward.

		Linus
