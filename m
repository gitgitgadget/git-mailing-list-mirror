From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.5.2
Date: Sun, 20 May 2007 03:00:16 -0700
Message-ID: <7vejlbq0gf.fsf@assigned-by-dhcp.cox.net>
References: <7vsl9rq2u2.fsf@assigned-by-dhcp.cox.net>
	<20070520093732.GA5015@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sun May 20 12:00:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpiDA-0002ES-9B
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805AbXETKAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756156AbXETKAT
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:00:19 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:58826 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbXETKAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:00:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520100016.LLEQ19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 20 May 2007 06:00:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1N0G1X0061kojtg0000000; Sun, 20 May 2007 06:00:17 -0400
In-Reply-To: <20070520093732.GA5015@cip.informatik.uni-erlangen.de> (Thomas
	Glanzmann's message of "Sun, 20 May 2007 11:37:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47809>

Gaah.  I hate these last minute brown paper bags.

If your build needs anything from compat/ (more specifically, if
you have any of those things in git-compat-util.h that we have
replacement routines for platforms that need NO_IDONTHAVETHAT,
that would not build as the build rule for test-chmtime (and
probably test-genrandom) is screwed up.

Please add $(LIBS) at the end and try again.  Sorry.
