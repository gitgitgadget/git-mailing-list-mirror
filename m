From: walt <wa1ter@myrealbox.com>
Subject: git-bisect is magical
Date: Mon, 09 Jan 2006 14:41:18 -0800
Organization: none
Message-ID: <dpuoqf$3rp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 09 23:43:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew5iv-00088S-TK
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 23:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWAIWmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 17:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWAIWmQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 17:42:16 -0500
Received: from main.gmane.org ([80.91.229.2]:49562 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751589AbWAIWmP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 17:42:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ew5hn-0007tJ-W1
	for git@vger.kernel.org; Mon, 09 Jan 2006 23:41:36 +0100
Received: from adsl-69-234-210-171.dsl.irvnca.pacbell.net ([69.234.210.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jan 2006 23:41:35 +0100
Received: from wa1ter by adsl-69-234-210-171.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Jan 2006 23:41:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-210-171.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20060109)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14379>

Arthur C. Clarke's Third Law states:  Any sufficiently advanced
technology is indistinguishable from magic.

You guys have done it -- I can't distinguish git-bisect from
magic.  It's wonderful, and thank you!

I used it for the first time this morning to find the commit
which caused some kernel breakage.  I just sent off an email
to the developer whose commit did the breakage, and it only
took me about 45 minutes.  (Now all I need to do is sit back
and wait for his reply saying 'You're an idiot!')

I have one minor suggestion for howto/isolate-bugs-with-bisect.
Linus states:
       git bisect good ORIG_HEAD       <- mark ORIG_HEAD as good (or
                                           whatever other known-good
                                           thing you booted last)

Well, in my case, I new the last good kernel was *two* updates ago,
so ORIG_HEAD wasn't the right thing to use.  I had to guess what
to type instead of 'ORIG_HEAD'.

Which leads to one more question:  I have my kernel configured to
add the -gxxxxxxxx localversion string to the kernel name.  I took
a wild guess that the xxxxxxxx was the right thing to substitute
for 'ORIG_HEAD' and I got lucky.  But what about someone who
doesn't know the magic 'xxxxxxxx' to use?  If I didn't know enough
to keep a week's worth of daily kernel-builds with the 'xxxxxxxx'
to guide me, would I still be able to do what I did today?
(For example, if this had been a 'git' bug instead of a kernel bug,
I don't think I could have figured out how to use git-bisect to find
the bug -- could I?)

Thanks!
