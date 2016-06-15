From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] denser delta header encoding
Date: Tue, 28 Jun 2005 22:44:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506282244110.19755@ppc970.osdl.org>
References: <Pine.LNX.4.63.0506290021050.1667@localhost.localdomain>
 <7vmzp9kbcf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506282217010.19755@ppc970.osdl.org>
 <7virzxk9nd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 07:36:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnVEf-0006i3-NK
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 07:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVF2Fmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 01:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVF2Fmx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 01:42:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262429AbVF2Fmu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 01:42:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5T5gijA023301
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 22:42:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5T5ghQv022053;
	Tue, 28 Jun 2005 22:42:43 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virzxk9nd.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Junio C Hamano wrote:
> 
> OK, not too much damage done.  I'll fix the rest up.

Actually, I already did, and pushed out. And this time I verified it by 
doing a "git-cat-file -s" on every object on a packed repo.

		Linus
