From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 19:31:44 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707191930030.27249@woody.linux-foundation.org>
References: <858x9ez1li.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
 <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org>
 <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com>
 <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com>
 <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org>
 <7vir8f24o2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	David Kastrup <dak@gnu.org>,
	"Shawn O.Pearce" <spearce@spearce.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 04:42:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBiRc-0006yX-Kz
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 04:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbXGTCmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 22:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbXGTCmN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 22:42:13 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58313 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728AbXGTCmM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 22:42:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6K2VoPZ032285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2007 19:31:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6K2Vi6N002932;
	Thu, 19 Jul 2007 19:31:44 -0700
In-Reply-To: <7vir8f24o2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.199 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53048>



On Thu, 19 Jul 2007, Junio C Hamano wrote:
> 
> But you _could_ treat that "should-be-kept-even-when-empty"-ness
> just like we treat executable bit on blobs, I think.

True. Or you could make it a path attribute and/or a per-repository 
decision, so that while the data wouldn't necessarily be in the database 
itself, the user could specify the behaviour he wanted.

> This will involve a lot of changes, so I would not recommend
> anybody doing so, though.

Agreed. The upside just isn't there.

		Linus
