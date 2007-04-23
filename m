From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] dir.c(common_prefix): Fix two bugs
Date: Mon, 23 Apr 2007 01:47:24 -0700
Message-ID: <7vzm4zh3z7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704231020070.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 10:47:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfuCn-0004j2-Fu
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 10:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbXDWIr0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 04:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbXDWIr0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 04:47:26 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40158 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbXDWIrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 04:47:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423084725.VUUE1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 23 Apr 2007 04:47:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qYnQ1W00L1kojtg0000000; Mon, 23 Apr 2007 04:47:25 -0400
In-Reply-To: <Pine.LNX.4.64.0704231020070.8822@racer.site> (Johannes
	Schindelin's message of "Mon, 23 Apr 2007 10:21:25 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45304>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	If you're up for a very surprising error message, run the test 
> 	without compiling git-add first...

$ PATH=/usr/bin:/bin sh t3700-add.sh -i -v
* expecting success: touch foo && git-add foo
./test-lib.sh: line 136: git-add: command not found
* FAIL 1: Test of git-add
        touch foo && git-add foo
$ echo $?
1
