From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Date: Sun, 7 Jan 2007 14:53:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701071452300.3661@woody.osdl.org>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com>
 <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
 <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net>
 <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net>
 <45A07587.3080503@garzik.org> <20070107201146.GA21956@suse.de>
 <7v4pr21p0o.fsf@assigned-by-dhcp.cox.net> <45A1727B.7070302@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Greg KH <gregkh@suse.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 23:53:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3gth-0004od-Iq
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 23:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbXAGWxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 17:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbXAGWxq
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 17:53:46 -0500
Received: from smtp.osdl.org ([65.172.181.24]:54572 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965240AbXAGWxp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 17:53:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l07MrVWi005635
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 Jan 2007 14:53:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l07MrU0a026998;
	Sun, 7 Jan 2007 14:53:30 -0800
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <45A1727B.7070302@garzik.org>
X-Spam-Status: No, hits=-1.167 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36203>



On Sun, 7 Jan 2007, Jeff Garzik wrote:
> 
> Yes but what about existing trees?
> 
> Can you add an alternatives file, then prune, and get the same result as if
> you had done a clone -s ?

Yes. Also do

	git repack -a -d -l

where the "-l" flag is the magic (it says to repack only objects that 
aren't already packed in the alternate repository)

		Linus
