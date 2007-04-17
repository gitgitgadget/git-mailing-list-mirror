From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 14:10:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704171405060.5473@woody.linux-foundation.org>
References: <200704171041.46176.andyparkins@gmail.com>
 <200704172012.31280.andyparkins@gmail.com> <Pine.LNX.4.64.0704171229360.5473@woody.linux-foundation.org>
 <200704172146.33665.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 23:11:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HduxC-0004Jl-4B
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 23:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031239AbXDQVLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 17:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031243AbXDQVLF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 17:11:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36640 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031239AbXDQVLE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 17:11:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HLAtC0017964
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 14:10:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HLAspX008043;
	Tue, 17 Apr 2007 14:10:55 -0700
In-Reply-To: <200704172146.33665.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.964 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44826>



On Tue, 17 Apr 2007, Andy Parkins wrote:
> 
> If you define "work" as "works like cvs/svn does", then I was fine with 
> it.

I can't really argue against that. Yes, I agree 100% that we can "work" in 
the sense that "cvs/svn works". There's clearly no fundamental reasons why 
you can't, since svn/cvs obviously do it.

I just do have higher standards. I really dislike CVS, and in many ways I 
actually think that SVN is even worse (not because it's really "worse", 
but because I think it is such a waste - it fixes the _trivial_ things 
about CVS, but doesn't really fix any of the underlying problems).

So I don't actually think that CVS "works". 

> Bit-for-bit as in CRLF is untouched?  No?  Bit-for-bit as in you said 
> you were okay with keyword-collapsing but not expansion?  You're just 
> as willing to compromise as me, you've just drawn the line in a 
> different place.

Bit-for-bit as in "you have to be able to trust every single bit".

And no, I don't actually love CRLF either. But it doesn't have quite the 
same fundamental problems. It has issues too, but they are fundamentally 
smaller, and I think making "git compatible with Windows" is also a lot 
more important than making "git compatible with CVS users".

Windows we cannot change. CVS users we can try to help. 

		Linus
