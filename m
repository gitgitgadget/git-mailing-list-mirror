From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-pull and tag objects
Date: Sun, 11 Feb 2007 11:25:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702111124410.8424@woody.linux-foundation.org>
References: <1170933407.15431.38.camel@okra.transitives.com>
 <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
 <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org>
 <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
 <7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702110948120.8424@woody.linux-foundation.org>
 <7vire8ec6w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 20:27:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGKLq-0000Gk-DR
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 20:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbXBKT0H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 14:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbXBKTZ4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 14:25:56 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55000 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932104AbXBKTZY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 14:25:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1BJPGUI009628
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Feb 2007 11:25:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1BJPFpA011867;
	Sun, 11 Feb 2007 11:25:15 -0800
In-Reply-To: <7vire8ec6w.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.433 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39304>



On Sun, 11 Feb 2007, Junio C Hamano wrote:
> 
> Well, what you are saying is that it used to be Ok in Jul 5 2005
> version but with tag following it is not Ok anymore, isn't it?

Do we actually do it with automatic tag following? I tested, and it didn't 
do anything bad for me.

		Linus
