From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [fixed PATCH] git-filter-branch.sh: Fix broken setting of GIT_DIR
Date: Sat, 11 Aug 2007 12:53:36 -0700
Message-ID: <7vbqddn8zj.fsf@assigned-by-dhcp.cox.net>
References: <868x8j7aj2.fsf@lola.quinscape.zz>
	<864pj74ay9.fsf@lola.quinscape.zz>
	<7vk5s2mllf.fsf@assigned-by-dhcp.cox.net>
	<85r6mawedp.fsf@lola.goethe.zz> <858x8iw9q1.fsf@lola.goethe.zz>
	<851weaw8z6.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 21:53:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJx1t-0005l1-Q7
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 21:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbXHKTxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 15:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbXHKTxi
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 15:53:38 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58161 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbXHKTxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 15:53:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811195338.NJWJ3478.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 15:53:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ajtc1X00P1kojtg0000000; Sat, 11 Aug 2007 15:53:37 -0400
In-Reply-To: <851weaw8z6.fsf@lola.goethe.zz> (David Kastrup's message of "Sat,
	11 Aug 2007 14:29:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55624>

I think your other patch to always give full path to the shell
scripts from git-sh-setup makes sense.  Could you please make
test scripts to expose the problems you described in the message
I am replying to and add it as say t/t2050-git-dir-relative.sh?
