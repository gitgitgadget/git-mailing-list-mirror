From: walt <wa1ter@myrealbox.com>
Subject: Real-life kernel debugging scenario
Date: Mon, 07 Nov 2005 16:51:50 -0800
Organization: none
Message-ID: <dkosr7$f4s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 08 01:55:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZHkt-0004pY-US
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 01:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVKHAy2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 19:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVKHAy2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 19:54:28 -0500
Received: from main.gmane.org ([80.91.229.2]:24707 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030216AbVKHAy1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 19:54:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EZHjT-0004Q1-Vv
	for git@vger.kernel.org; Tue, 08 Nov 2005 01:53:04 +0100
Received: from adsl-69-234-218-246.dsl.irvnca.pacbell.net ([69.234.218.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Nov 2005 01:53:03 +0100
Received: from wa1ter by adsl-69-234-218-246.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Nov 2005 01:53:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-218-246.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20051106)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11297>

This describes a real problem I've had twice in the last two
years while tracking Linus's kernel tree:

I update my local kernel sources every morning using cg-update
(formerly bk-pull) and compile and install and reboot the new
kernel.

Okay.  On rare occasions I get a kernel panic on reboot.  So...
I know that something Linus committed in the last 24 hours is
responsible for the problem.

The last two times this happened I was able to guess which
commit caused the problem and I emailed the developer off-
list and got the problem fixed very quickly. (This is why
I love open-source software!)

My worry:  what happens when I'm not smart enough to guess
which developer to email?  My first instinct is to back out
the most recent commits one-by-one until the bug goes away.

First:  is this an optimal tactic?

Second:  how to back out individual commits using git or
cogito?  I suppose this is already spelled out in the docs,
but I invite everyone to point me to the relevant places
in the docs that have escaped my attention so far.

Thanks!
