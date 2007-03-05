From: Bill Lear <rael@zopyra.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 17:20:15 -0600
Message-ID: <17900.42415.750335.329874@lisa.zopyra.com>
References: <17895.18265.710811.536526@lisa.zopyra.com>
	<20070302091426.GA2605@diana.vm.bytemark.co.uk>
	<17896.9631.316001.869157@lisa.zopyra.com>
	<Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070302162136.GA9593@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070305072323.GA31169@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.27067.247950.419438@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.30394.172067.743310@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.36569.805689.922989@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
	<17900.39124.763603.695942@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOMU3-0002dw-27
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 00:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbXCEXU1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 18:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbXCEXU1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 18:20:27 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60349 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbXCEXU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 18:20:26 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l25NKIf12891;
	Mon, 5 Mar 2007 17:20:18 -0600
In-Reply-To: <Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41503>

On Monday, March 5, 2007 at 14:37:15 (-0800) Linus Torvalds writes:
>On Mon, 5 Mar 2007, Bill Lear wrote:
>> I edit sourcefile.c, compile it, then commit it with
>> N=timestamp(sourcefile.c) on master.  N is <
>> timestamp(.master/sourcefile.o).  I then switch to branchX.  N is
>> stored by git for master:sourcefile.c.  No stored timestamp are on
>> this branch, so the file gets the timestamp it gets on checkout
>> M=timestamp(sourcefile.c).  I compile the file again, all is well.  I
>> move back to master branch.  Git stores M as branchX:sourcefile.c Git
>> checks out the file, and stamps it with N.  I do a make.  No
>> recompilation happens.
>
>WHICH IS WRONG! You need to recompile, since the compile you did on the 
>other branch DOES NOT MATCH in "sourcefile.c" any more. 

Well, I'll let it drop after this, but I think you're wrong.  I do NOT
need it to recompile when I do the third make above.  The time stamps
match up perfectly with the make products, the make system is NOT
confused, the appropriate rebuilds occurs WHEN I want them to, and my
make products are thereafter a model of wholesome sanity and blissful
unity.

Again, this may be violating a sacred rule of "thou shalt not f~ck
with timestamps", but I'm not religious on that point.

I share the desire of never getting make products when I should not,
and appreciate the desire to never, ever, NOT recompile something when
it must, which is what the above example does.  I also understand
there are better ways than having git do this with timestamps, it's
just that I'm not understanding your logical argument, even with all
caps emphasizing your points.  Perhaps I'll build a prototype, have it
blow up in my face, and then understand ...

>And if sourcefile.c _does_ match in the two branches, then git *already* 
>won't have changed it at all, so git already does the obvious 
>optimization.

I'll let this drop.  It appears we are not communicating, which you
seem to be translating and signaling (in all caps, no less) as "you
are stupid".  That's ok, I've felt that way about others from time to
time, so I understand and sympathize with your frustration.

I do thank you (all) for pointing out the much less invasive
alternatives, using git (right now) and still, despite this rather
heated exchange, think git is a very cool and thoughtfully put
together collection of software.


Bill
