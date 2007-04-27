From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch
 content
Date: Fri, 27 Apr 2007 16:41:12 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704271636130.9964@woody.linux-foundation.org>
References: <ps5qyry4.fsf@cante.net> <7vslalmwcx.fsf@assigned-by-dhcp.cox.net>
 <87y7kdo6pn.wl%cworth@cworth.org> <alpine.LFD.0.98.0704271430490.9964@woody.linux-foundation.org>
 <87wszxo2b5.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Jari Aalto <jari.aalto@cante.net>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Apr 28 01:41:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hha4B-0003Yf-OF
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 01:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757908AbXD0Xl2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 19:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757911AbXD0Xl2
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 19:41:28 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:35532 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757908AbXD0Xl1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2007 19:41:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3RNfDcR024319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Apr 2007 16:41:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3RNfCIC010784;
	Fri, 27 Apr 2007 16:41:12 -0700
In-Reply-To: <87wszxo2b5.wl%cworth@cworth.org>
X-Spam-Status: No, hits=-3.005 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45760>



On Fri, 27 Apr 2007, Carl Worth wrote:
> 
> PS. A separate reason I like attachments is that I like the subject
> and message body to be the actual discussion of the patch, (and the
> commit message and patch content to come later).

And the reason I _hate_ attachements is that you cannot say "no, that one 
is wrong", and just skip/edit it.

Because once you start doing attachments, you're not going have just one 
patch per email. You're going to have people send you ten attachments in 
one email for patches 1-10.

And when patch 5 is crap, you're basically screwed. There is almost no 
support for replying to that _individually_ and saying "That one sucks". 
You press "reply", and you get all ten.

So the fundamental rule *must* be: one patch, one email. That's the 
starting point. Anything else is simply broken. 

And once you accept that fundamental rule (and quite frankly, I don't care 
if others accept it or not - I'm personally 100% convinved that anythign 
else is a major mistake), suddenly attachments have no upsides at all, 
only downsides. They mean that when you send the patch top a mailing list, 
everybody sees it differently, and a *lot* of people will be unable to 
reply to it with proper quoting.

		Linus
