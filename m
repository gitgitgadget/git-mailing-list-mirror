From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 10:48:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508031048360.3258@g5.osdl.org>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508021942500.3341@g5.osdl.org> <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030808530.3341@g5.osdl.org> <7vr7dbhvci.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030913060.3341@g5.osdl.org> <7vk6j3f044.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030944210.3258@g5.osdl.org> <7voe8fdkd7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508031014070.3258@g5.osdl.org> <7virymdirb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 19:50:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0NMc-0002nB-5C
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 19:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVHCRtD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 13:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVHCRtD
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 13:49:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37531 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262374AbVHCRtC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 13:49:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j73HmojA008517
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 10:48:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j73HmnZ9031020;
	Wed, 3 Aug 2005 10:48:50 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virymdirb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 3 Aug 2005, Junio C Hamano wrote:
> 
> I think in addition to the existing ref_newer() check, which
> makes sure you are advancing the remote head, not just replacing
> with something unrelated, making sure that we have objects
> referenced by ref->old_sha1 we obtained from the remote on our
> end for all branches involved would be the only thing needed.

Yes.

		Linus
