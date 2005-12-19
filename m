From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: using-topic-branches.txt
Date: Sun, 18 Dec 2005 23:52:43 -0500
Message-ID: <43A63C9B.7080306@pobox.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056F93AC@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Luck, Tony" <tony.luck@intel.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 05:54:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoD1G-0003GR-IL
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 05:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVLSEw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 23:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVLSEw6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 23:52:58 -0500
Received: from mail.dvmed.net ([216.237.124.58]:61572 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030262AbVLSEw5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 23:52:57 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EoD0w-0000jV-HW; Mon, 19 Dec 2005 04:52:48 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30056F93AC@hdsmsx401.amr.corp.intel.com>
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Brown, Len wrote:
	>>file:4698abe46bff0b878dcfcd05771f5760483b4278 ->
	file:494429738f8f86bbe21f38b5f90cc94344ad0630 >>---
	a/Documentation/howto/using-topic-branches.txt >>+++
	b/Documentation/howto/using-topic-branches.txt >>@@ -31,7 +31,7 @@ test
	tree and then pull to the release t >>patches blocked in the test tree
	waiting for complex changes to accumulate >>enough test time to
	graduate. >>-Back in the BitKeeper days I achieved this my creating
	small forests of >>+Back in the BitKeeper days I achieved this by
	creating small forests of >>temporary trees, one tree for each logical
	grouping of patches, and then >>pulling changes from these trees first
	to the test tree, and then to the >>release tree. At first I replicated
	this in GIT, but then I realised >>@@ -42,7 +42,8 @@ So here is the
	step-by-step guide how th >>First create your work tree by cloning
	Linus's public tree: >>- $ git clone
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
	work >>+ $ git clone \ >>+
	master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work
	>>Change directory into the cloned tree you just created >>@@ -52,7
	+53,7 @@ Set up a remotes file so that you can fe >>branch into a local
	branch named "linus": >>$ cat > .git/remotes/linus >>- URL:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
	>>+ URL:
	master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
	>>Pull: master:linus >>^D > > > This works for me, but now it requires
	a password to update > when before it did not. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13812>

Brown, Len wrote:
>>file:4698abe46bff0b878dcfcd05771f5760483b4278 -> file:494429738f8f86bbe21f38b5f90cc94344ad0630
>>--- a/Documentation/howto/using-topic-branches.txt
>>+++ b/Documentation/howto/using-topic-branches.txt
>>@@ -31,7 +31,7 @@ test tree and then pull to the release t
>>patches blocked in the test tree waiting for complex changes to accumulate
>>enough test time to graduate.
>>-Back in the BitKeeper days I achieved this my creating small forests of
>>+Back in the BitKeeper days I achieved this by creating small forests of
>>temporary trees, one tree for each logical grouping of patches, and then
>>pulling changes from these trees first to the test tree, and then to the
>>release tree. At first I replicated this in GIT, but then I realised
>>@@ -42,7 +42,8 @@ So here is the step-by-step guide how th
>>First create your work tree by cloning Linus's public tree:
>>- $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work
>>+ $ git clone \
>>+ master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work
>>Change directory into the cloned tree you just created
>>@@ -52,7 +53,7 @@ Set up a remotes file so that you can fe
>>branch into a local branch named "linus":
>>$ cat > .git/remotes/linus
>>- URL: rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>>+ URL: master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>>Pull: master:linus
>>^D
> 
> 
> This works for me, but now it requires a password to update
> when before it did not.

master.kernel.org is non-public, so it shouldn't be mentioned in 
documentation...

	Jeff
