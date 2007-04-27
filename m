From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch
 content
Date: Fri, 27 Apr 2007 16:47:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704271644460.9964@woody.linux-foundation.org>
References: <ps5qyry4.fsf@cante.net> <7vslalmwcx.fsf@assigned-by-dhcp.cox.net>
 <87y7kdo6pn.wl%cworth@cworth.org> <alpine.LFD.0.98.0704271430490.9964@woody.linux-foundation.org>
 <87wszxo2b5.wl%cworth@cworth.org>
 <alpine.LFD.0.98.0704271636130.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Jari Aalto <jari.aalto@cante.net>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Apr 28 01:47:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhaA7-00051d-5s
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 01:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917AbXD0Xrf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 19:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757913AbXD0Xrf
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 19:47:35 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:37747 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757917AbXD0Xre (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2007 19:47:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3RNl8U6024491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Apr 2007 16:47:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3RNl6AX010894;
	Fri, 27 Apr 2007 16:47:06 -0700
In-Reply-To: <alpine.LFD.0.98.0704271636130.9964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.004 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45761>



On Fri, 27 Apr 2007, Linus Torvalds wrote:
>
> And when patch 5 is crap, you're basically screwed. There is almost no 
> support for replying to that _individually_ and saying "That one sucks". 
> You press "reply", and you get all ten.

Btw, this is true even when the attachment itself is just an mbox.

Yes, you can (and probably do) just save the mbox to a file, and then 
start _another_ mail reader on that file. That's actually what I end up 
doing a lot for my "doit" file (which is just where I save all the 
messages that I'll apply) when I go through them more carefully.

But it doesn't change the fact that if you just see something wrong, you 
can't just reply to it and say "that's crap". You have to basically exit 
your primary mail-reader, and start a secondary one on the file you saved.

Also, I assume that this means that nobody else is ever Cc'd on the 
patches you get? Like a public mailing list?

		Linus
