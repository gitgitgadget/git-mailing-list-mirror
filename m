From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log,
 etc.
Date: Wed, 30 May 2007 08:40:57 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705300832410.26602@woody.linux-foundation.org>
References: <87bqg724gp.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
 <87odk6y6cd.fsf@rho.meyering.net> <alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
 <87sl9hw0o0.fsf@rho.meyering.net> <alpine.LFD.0.98.0705280929140.26602@woody.linux-foundation.org>
 <871wh0ww80.fsf@rho.meyering.net> <alpine.LFD.0.98.0705281957160.26602@woody.linux-foundation.org>
 <87r6ozs7q5.fsf@rho.meyering.net> <alpine.LFD.0.98.0705291412060.26602@woody.linux-foundation.org>
 <87k5uqqz0y.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed May 30 17:42:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtQJV-0001OI-1M
	for gcvg-git@gmane.org; Wed, 30 May 2007 17:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241AbXE3PmH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 11:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756442AbXE3PmG
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 11:42:06 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:49750 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756241AbXE3PmE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2007 11:42:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4UFew45023657
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2007 08:40:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4UFevbL029215;
	Wed, 30 May 2007 08:40:57 -0700
In-Reply-To: <87k5uqqz0y.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-4.664 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48768>



On Wed, 30 May 2007, Jim Meyering wrote:
> 
> No.  I'm glad to see that perhaps even you are surprised by your words.

If you thought I was a polite person and am surpised by calling things 
crap after the fact, I'm afraid you have a few shocking moments coming to 
you. My reply was fairly polite by my standards. My tag-line is often "On 
the internet, nobody can hear you being subtle".

So let me rephrase my message to you:

	I think your INTERMEDIATE PATCH WAS TOTAL AND UTTER CRAP.

	EVERY SINGLE HUNK WAS SH*T. 

	You expressly IGNORED my point that some errors aren't errors, and 
	MADE GIT WORSE.

Are we on the same page now? 

In contrast, your final patch was fine. The one where you finally fixed 
the issue that I complained about FROM THE VERY BEGINNING.

Comprende?

> The only editing was to capitalize WHOLE.  Here's what you wrote:
> 
>     > I think this patch is fundamentally WRONG. This fragment is just a prime
>     > example of why the whole patch is crap. The old code was correct, and you
>     > broke it.
> 
> Umm... are the above three lines the only part of my message you're
> prepared to talk about?  You haven't addressed any of the interesting
> (technical) parts.

Umm. Your final patch was a few trivial lines. I addressed all interesting 
technical parts IN MY ORIGINAL REPLY WHEN YOU FIRST POSTED IT.

Which you ignored (or rather, explicitly chose to disagree with, and 
added MORE crap to the patch).

Go away. I'm not interested in flaming you any more. The patch wasn't that 
interesting to begin with, and you have shown that you're more interested 
in being contrary than to actually fix the problems that were pointed out 
to you _immediately_ and without any flames. 

			Linus
