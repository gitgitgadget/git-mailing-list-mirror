From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ls-files and read-tree need core.filemode
Date: Tue, 8 Nov 2005 10:15:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511081010510.3247@g5.osdl.org>
References: <81b0412b0511080023k1384dc26j944e9a07987be436@mail.gmail.com>
 <7vacgfldry.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 19:22:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZY0S-0000gd-Gp
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 19:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbVKHSPh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 13:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbVKHSPh
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 13:15:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965240AbVKHSPg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 13:15:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA8IFTnO015914
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 8 Nov 2005 10:15:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA8IFRI7011679;
	Tue, 8 Nov 2005 10:15:28 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacgfldry.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11346>



On Tue, 8 Nov 2005, Junio C Hamano wrote:
> 
> Attachments are a bit cumbersome to quote but otherwise OK, at
> least for me.  Linus never admits it, but I am hoping that he is
> having a bit easier time applying e-mailed patches ever since
> rudimentally MIME attachment handling was added.

Actually, the MIME attachment support in git means that I have to remove 
the "Content-Type: .. boundary: " line too when editing emails. 

I do all my patch validation in mbox format (which is why when you look at 
commit dates, you'll generally see a second or less between commits when I 
actually apply a mbox series), and the MIME format makes emails totally 
unreadable.

So I refuse to have anything to do with attachments and MIME types not 
because my tools couldn't apply the patches, but because I can't go 
through the patches manually sanely with them.

So I can do plain/text attachments, but they inevitably mean that I just 
have to edit the damn mailbox to make sense of it. Anything else (like 
base64-encoding or similar) I just refuse to touch.

			Linus
