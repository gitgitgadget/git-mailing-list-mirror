From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Tue, 26 Apr 2005 15:25:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261522340.18901@ppc970.osdl.org>
References: <Pine.LNX.4.44.0504261400570.4678-100000@wax.eds.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 00:19:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYOQ-0002Sk-W3
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVDZWYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 18:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVDZWYJ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 18:24:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:29913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261818AbVDZWYE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 18:24:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QMO0s4032298
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 15:24:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QMNwUa013867;
	Tue, 26 Apr 2005 15:23:59 -0700
To: Bram Cohen <bram@bitconjurer.org>
In-Reply-To: <Pine.LNX.4.44.0504261400570.4678-100000@wax.eds.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Bram Cohen wrote:
> 
> So you think that a system which supports snapshots and history but has no
> merging functionality whatsoever is the right thing?

You haven't looked at git, have you?

Git already merges better than _any_ open-source SCM out there. It just 
does it so effortlessly that you didn't even realize it does that.

Today I've done four (count them) fully automated merges on the kernel
tree: serial, networking, usb and arm.

And they took a fraction of a second (plus the download of the new
objects, which is the real cost).

This is something that SVN _still_ cannot do, for example. 

		Linus
