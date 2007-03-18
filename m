From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Sun, 18 Mar 2007 08:57:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703180854470.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
 <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
 <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 16:57:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSxlY-0003Iv-JU
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 16:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbXCRP5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 11:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbXCRP5v
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 11:57:51 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43960 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932260AbXCRP5u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 11:57:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2IFvYcD020561
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Mar 2007 08:57:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2IFvXIW025729;
	Sun, 18 Mar 2007 07:57:33 -0800
In-Reply-To: <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.98 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42500>



On Sun, 18 Mar 2007, Linus Torvalds wrote:
> 
> That's an interesting test-case (and I get 53 seconds, nyaah, nyaah ;)

Btw, it's also an example of why the incremental blame is so much nicer.

No way would I want to wait 53 seconds to get the whole blame. But doing

	git gui blame HEAD block/ll_rw_blk.c

(the "git gui" command line is a bit unwieldly) you get something quite 
usable!

Of course, the git gui blame colorization is clearly done by somebody who 
is still actively popping LSD with both fists and didn't realize that the 
60's are long done, but that's another issue.

		Linus
