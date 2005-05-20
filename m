From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff overhaul
Date: Thu, 19 May 2005 22:30:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505192229540.2206@ppc970.osdl.org>
References: <7vll6awta3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 07:27:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ02y-00035v-Oo
	for gcvg-git@gmane.org; Fri, 20 May 2005 07:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVETF2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 01:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVETF2g
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 01:28:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:1199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261347AbVETF2e (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 01:28:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4K5SSU3019433
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 May 2005 22:28:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4K5SRUO028981;
	Thu, 19 May 2005 22:28:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll6awta3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 19 May 2005, Junio C Hamano wrote:
> 
> This also allowed diff-cache and diff-files to acquire -R
> (reverse) option to generate diff in reverse.  Users of
> diff-tree can swap two trees easily so I did not add -R there.

Actually, diff-tree would want it too.

You can only swap the trees easily if you give two trees, not if you give 
a commit.

		Linus
