From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log,
 etc.
Date: Tue, 29 May 2007 14:19:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705291412060.26602@woody.linux-foundation.org>
References: <87bqg724gp.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
 <87odk6y6cd.fsf@rho.meyering.net> <alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
 <87sl9hw0o0.fsf@rho.meyering.net> <alpine.LFD.0.98.0705280929140.26602@woody.linux-foundation.org>
 <871wh0ww80.fsf@rho.meyering.net> <alpine.LFD.0.98.0705281957160.26602@woody.linux-foundation.org>
 <87r6ozs7q5.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue May 29 23:20:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht97Q-0007B9-3J
	for gcvg-git@gmane.org; Tue, 29 May 2007 23:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbXE2VUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 17:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbXE2VUS
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 17:20:18 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:52831 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751327AbXE2VUP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2007 17:20:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4TLJfT0018731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 May 2007 14:19:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4TLJfRC011699;
	Tue, 29 May 2007 14:19:41 -0700
In-Reply-To: <87r6ozs7q5.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-4.631 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48710>



On Tue, 29 May 2007, Jim Meyering wrote:
> >
> > Maybe you have not noticed, but my argument has ben about EPIPE.
> 
> Ha ha.  That's a good one.
> The point was that even you must see that your
> "[Jim's] WHOLE patch is crap" statement was wrong.

Ehh. That's a rather edited version of what I said, isn't it?

That's after I explicitly _quoted_ the part where you actively removed the 
code that said "EPIPE is right", and also after I had told you several 
times that you should consider EPIPE as a special case in your other part.

In other words, yes, EVERY SINGLE HUNK of your patch was wrong, and I had 
told you exactly why.

How wrong does a patch have to be to be "crap"? Maybe I have higher 
standards than you do (apparently so), but "every single hunk was wrong" 
should certainly be a damn good reason to consider _any_ patch crap, 
wouldn't you say?

And now you have trouble accepting that, even after you have sent out a 
fixed patch without the crap. Thanks for finally bothering to get the 
patch right, but I don't see why you have to try to make-believe that it 
was ever about anything but EPIPE.

So go back and read my emails. You'll see that in every single one I made 
it very clear that EPIPE was special. From the very first one (where I 
didn't call your patch crap, btw: I said it was wrong, and that some 
errors are expected and good, and I explicitly told you about EPIPE).

So what did you do? Instead of acknowledging that EPIPE was different, you 
actually *expanded* on that original patch, and made the other places 
where we _did_ handle EPIPE correctly, and made those places handle it 
_incorrectly_.

And then you expect me to be _polite_ about it? Grow up. I was polite 
before you started explicitly doing the reverse of what I told you you 
should do. At that point, your patch went from "meant well, but the patch 
was wrong" to "That's just obviously crap".

		Linus
