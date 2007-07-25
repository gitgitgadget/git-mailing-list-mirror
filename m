From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Tue, 24 Jul 2007 21:03:56 -0700
Message-ID: <7vabtlf7tf.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 06:04:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDY6e-0005Og-Fw
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 06:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbXGYED6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 00:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbXGYED6
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 00:03:58 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54741 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbXGYED6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 00:03:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725040357.KFWZ1358.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Jul 2007 00:03:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Tg3w1X0071kojtg0000000; Wed, 25 Jul 2007 00:03:56 -0400
In-Reply-To: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	(Marco Costalba's message of "Sat, 14 Jul 2007 18:52:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53666>

I've been re-reviewing recent patches, and this is one of them.
However, I am wondering if this is an intended behaviour...

: git.git master; ./git-log --log-size --abbrev-commit --pretty=oneline \
  ko/master..master
9d468ac... log size 47
Add --log-size to git log to print message size
ca193cf... log size 40
git am: skip pine's internal folder data
d1cc130... log size 48
Teach git-commit about commit message templates.
af66366... log size 41
Teach approxidate() to understand "never"
7b69b87... log size 64
git log -g: Complain, but do not fail, when no reflogs are there
2d8ae40... log size 49
send-email: Update regex parsing for pine aliases
f836f1a... log size 40
cvsexportcommit: avoid racy CVS problem.
1843d8d... log size 53
cleanup unpack-trees.c: shrink struct tree_entry_list
24d0063... log size 56
filter-branch: fix dash complaining about "Missing '))'"
3473e7d... log size 56
gitweb: More detailed error messages for snapshot format
93c22ee... log size 47
git.el: Support for incremental status updates.
