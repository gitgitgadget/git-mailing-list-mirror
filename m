From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Sun, 2 Apr 2006 14:16:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021411300.23419@g5.osdl.org>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
 <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 23:16:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ9w0-0003Eu-FV
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 23:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWDBVQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 17:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWDBVQ3
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 17:16:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965023AbWDBVQ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 17:16:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k32LGOEX021459
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 14:16:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k32LGOeh023354;
	Sun, 2 Apr 2006 14:16:24 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18286>



On Sun, 2 Apr 2006, Junio C Hamano wrote:
> 
> I should have tried your pristine xdiff code myself before
> bothering you, but I haven't (sorry).

It definitely happens with plain libxdiff-0.17 too.

In general, unless it's related to the "\ No newline" or the extra stuff 
on the "@@"-line, I'd be very surprised if we have any differences in the 
diff output wrt libxdiff-0.17. I was really pretty careful, and didn't 
change the code at all, just removed unnecessary files and functions.

		Linus
