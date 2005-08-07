From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: use of temporary refs in resolve
Date: Sun, 7 Aug 2005 13:18:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508071317060.3258@g5.osdl.org>
References: <7v3bplwmzg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508071256140.3258@g5.osdl.org> <7vd5opv74u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 22:19:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1rbB-0008GH-MJ
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 22:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbVHGUST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 16:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbVHGUST
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 16:18:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60594 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752681AbVHGUSS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2005 16:18:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j77KIDjA005716
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 Aug 2005 13:18:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j77KICBG019016;
	Sun, 7 Aug 2005 13:18:13 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5opv74u.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 7 Aug 2005, Junio C Hamano wrote:
> 
> How about LAST_MERGE?

I don't think it matters. I kind of saw it as the "other side" of 
ORIG_HEAD, but since we now clean it up and since I've never used it, I 
think it falls under the status of "well-intentioned but useless".

		Linus
