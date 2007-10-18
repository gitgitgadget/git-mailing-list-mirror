From: walt <wa1ter@myrealbox.com>
Subject: git-merge: need a tap with the cluestick, please
Date: Thu, 18 Oct 2007 09:17:55 -0700
Organization: none
Message-ID: <ff80tr$hh1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 18:17:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiY3m-0002v0-Md
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 18:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433AbXJRQRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 12:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757193AbXJRQRK
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 12:17:10 -0400
Received: from main.gmane.org ([80.91.229.2]:39274 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756952AbXJRQRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 12:17:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IiY3V-0002rt-L7
	for git@vger.kernel.org; Thu, 18 Oct 2007 16:17:05 +0000
Received: from adsl-69-234-211-250.dsl.irvnca.pacbell.net ([69.234.211.250])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 16:17:05 +0000
Received: from wa1ter by adsl-69-234-211-250.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 16:17:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-211-250.dsl.irvnca.pacbell.net
User-Agent: Thunderbird 3.0a1pre (X11/2007101707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61543>

I just tried my first local modification to Linus's tree, and I
can't get the merge to work.  Maybe my whole approach is wrong?

I wanted start compiling the kernel out-of-tree, so I added my
own 'obj' directory at the top level.

I then got conflicts when trying to pull from Linus, so I added
my 'obj' directory to my toplevel .gitignore file and committed
the local change to my 'master' branch.  (This is my only local
modification because I'm only tracking Linus, not developing the
kernel.)

Now when I pull from Linus the merge stops in the middle because of
conflicts with my .gitignore file <sigh>.  Anything I try now with
git-merge tells me I can't do that in the middle of a conflicted
merge.  Yes, I know that now, but what should I do instead?

I could move my 'obj' out-of-tree but then I wouldn't learn anything.
This has to be bone-head easy, but not for me :)

Clues most welcome.
