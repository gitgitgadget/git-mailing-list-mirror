From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unexpected behavior in git-rev-list
Date: Wed, 21 Sep 2005 11:45:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509211144141.2553@g5.osdl.org>
References: <20050918144931.GA9561@ebar091.ebar.dtu.dk>
 <Pine.LNX.4.58.0509181013250.26803@g5.osdl.org> <20050918175847.GA10427@ebar091.ebar.dtu.dk>
 <20050921164948.GB23525@ebar091.ebar.dtu.dk> <Pine.LNX.4.58.0509211022180.2553@g5.osdl.org>
 <7vfyryw9ra.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 20:55:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI9bK-0000Xq-3E
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 20:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVIUSpr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 14:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVIUSpr
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 14:45:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750786AbVIUSpq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 14:45:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8LIjfBo009670
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Sep 2005 11:45:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8LIjevq022002;
	Wed, 21 Sep 2005 11:45:40 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyryw9ra.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9069>



On Wed, 21 Sep 2005, Junio C Hamano wrote:
>
> Ah, you told him to use 'rev-list --parents' and you can rewrite
> the list of parents there -- clever.

Exactly. 

Yes, anything that would parse the "raw" commit information would be very 
lost indeed, and not able to figure out parenthood from the sparse list. 
But gitk already uses the "fakey" parents.

		Linus
