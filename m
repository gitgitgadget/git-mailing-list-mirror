From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 11:10:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508031108550.3258@g5.osdl.org>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508031014070.3258@g5.osdl.org> <7virymdirb.fsf@assigned-by-dhcp.cox.net>
 <200508031946.01017.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 20:12:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Nhh-0005rv-TE
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 20:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVHCSK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVHCSK3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 14:10:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262384AbVHCSKW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 14:10:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j73IAFjA009884
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 11:10:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j73IAEcX032047;
	Wed, 3 Aug 2005 11:10:15 -0700
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200508031946.01017.Josef.Weidendorfer@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 3 Aug 2005, Josef Weidendorfer wrote:
> 
> But my example shows that the error happens even with 2 branches totally 
> unrelated to each other: if branch1 got a new commit, you can not push to
> branch2 from another clone.

Sure you can.

	git-send-pack remote branch2

and you've just done so.

The shorthand of "no branches listed" expands to _all_ branches, and if 
you try to send all branches, then you're trying to update "branch1" with 
something you don't have. That's your usage error.

		Linus
