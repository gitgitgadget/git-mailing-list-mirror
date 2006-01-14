From: walt <wa1ter@myrealbox.com>
Subject: Re: My first git success [not quite]
Date: Sat, 14 Jan 2006 07:39:28 -0800
Organization: none
Message-ID: <dqb5vg$a09$1@sea.gmane.org>
References: <dq8epd$k28$1@sea.gmane.org> <Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 14 16:39:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExnVP-0000PI-Ri
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 16:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWANPjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 10:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWANPjn
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 10:39:43 -0500
Received: from main.gmane.org ([80.91.229.2]:35534 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932106AbWANPjm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 10:39:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ExnVE-0000NE-5f
	for git@vger.kernel.org; Sat, 14 Jan 2006 16:39:40 +0100
Received: from adsl-69-234-211-25.dsl.irvnca.pacbell.net ([69.234.211.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 16:39:40 +0100
Received: from wa1ter by adsl-69-234-211-25.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 16:39:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-211-25.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20060114)
In-Reply-To: <Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14666>

Linus Torvalds wrote:
> 
> On Fri, 13 Jan 2006, walt wrote:
>> And it was all so easy I never broke a sweat.  Amazing!

>  ...Most people don't bother to 
> explain their problems well...

I see I still have a problem:  my mental model of how git
works is still wrong.

I used 'git-checkout -b test' to create a disposable place
to test the patch I was given.

Okay, making sure I'm now sitting in 'test', I apply the
patch to foo.c and do my testing.

Now, intending to delete my 'test' branch, I do git-checkout
master.  My mental model predicts that 'master' should still
be identical to 'origin' because I did the patching in 'test'.
Am I right so far?

The problem I see is that, after switching back to 'master',
foo.c is the patched version, not your original version.  I
figured that the git-checkout would overwrite any changes I
made to foo.c, but that doesn't seem to be the case.  To get
your original version back I had to delete foo.c and do a
git-checkout foo.c (or git-checkout -f master).

So, I clearly don't understand what git-checkout does.  It
doesn't seem to touch the already-checked-out sources at
all, which is what I would expect it to do.

Can someone hit me with the clue-stick here?  Thanks!
