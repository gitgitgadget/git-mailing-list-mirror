From: Junio C Hamano <gitster@pobox.com>
Subject: [Bradford C. Smith] [PATCH 2/2] use lockfile.c routines in git_commit_set_multivar()
Date: Wed, 25 Jul 2007 16:39:26 -0700
Message-ID: <7v7ioocatt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:39:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDqS2-00053C-Ir
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 01:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbXGYXj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 19:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbXGYXj2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 19:39:28 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43321 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbXGYXj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 19:39:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725233926.ZQZR1358.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 25 Jul 2007 19:39:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TzfS1X00K1kojtg0000000; Wed, 25 Jul 2007 19:39:26 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53739>

    From: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
    Subject: [PATCH 2/2] use lockfile.c routines in git_commit_set_multivar()
    Date: Wed, 25 Jul 2007 12:49:53 -0400
    Message-Id: <11853821962210-git-send-email-bradford.carl.smith@gmail.com>

    Changed git_commit_set_multivar() to use the routines provided by
    lockfile.c to reduce code duplication and ensure consistent behavior.

    Signed-off-by: "Bradford C. Smith" <bradford.carl.smith@gmail.com>

Dscho, I think this is worth doing regardless of that "symlinked
config" issue.  I haven't followed the code closely enough,
though.

What do you think?
