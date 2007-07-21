From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Fri, 20 Jul 2007 23:34:02 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707202329220.27249@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org>
 <20070721050912.GB20622@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707202304350.27249@woody.linux-foundation.org>
 <20070721061857.GB29820@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 21 08:34:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC8Xg-00086W-S1
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 08:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbXGUGeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 02:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbXGUGeN
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 02:34:13 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35518 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752701AbXGUGeN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 02:34:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L6Y8Ox025212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 23:34:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L6Y22X004420;
	Fri, 20 Jul 2007 23:34:02 -0700
In-Reply-To: <20070721061857.GB29820@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.714 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53147>



On Sat, 21 Jul 2007, Jeff King wrote:
> 
> I just independently came to the same conclusion. Your patch looks
> correct to me (though there are some unrelated formatting changes which
> made it a little harder to read).

Yeah, I shouldn't have done that - I just ended up changing the "for()" to 
a "while()" (because we should *not* do the same thing at the end of the 
loop each time).  And as a part of that I changed the initialization to be 
at the head of the while-loop rather than in the variable declaration, 
because that's how I tend to mostly write while-loops.

But I probably should have tried to keep the patch minimal instead, so 
that it would show the changes better. Probably not a big deal.

		Linus
