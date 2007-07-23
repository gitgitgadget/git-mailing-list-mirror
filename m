From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 09:55:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
 <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
 <20070722211314.GA13850@linux-sh.org> <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr>
 <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
 <46A3D5EA.2050600@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 18:56:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID1Ce-0005MK-VZ
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 18:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbXGWQzl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 12:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753809AbXGWQzk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 12:55:40 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35377 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753443AbXGWQzj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 12:55:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NGtU5Z011986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 09:55:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NGtOBU001690;
	Mon, 23 Jul 2007 09:55:24 -0700
In-Reply-To: <46A3D5EA.2050600@zytor.com>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53444>



On Sun, 22 Jul 2007, H. Peter Anvin wrote:
> 
> Wouldn't be hard to make a git tree with all the patches all the way
> back to 0.01 even...

I actually tried to get something like this together back in the BK days 
and early in the SCO saga. It was pretty painful to try to find all the 
historic trees and patches - they're all in different format, and some of 
them are unreliable (ie CVS imports by people like Ted).

The good news is that git would be a lot more natural to the process of 
trying to create a history, because you could basically import random 
trees, and tag them as just independent trees, and then re-create the 
history after-the-fact by trying to stitch them all together. And if you 
find a new tree, you'd just re-stitch it - something that was very hard to 
do with BK (and BK generally wouldn't help you with keeping multiple 
independent trees around, and wouldn't generally accept the notion of 
re-doing the histories and keeping various versions of the histories 
around).

So I've been thinking about trying to re-create some really old history 
into git, but it's still a lot of work.. And obviously not very useful, 
just interesting from an archeological standpoint.

			Linus
