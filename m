From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add basic test-script for git-submodule
Date: Thu, 31 May 2007 20:54:14 -0700
Message-ID: <7vzm3kz5w9.fsf@assigned-by-dhcp.cox.net>
References: <11802980992216-git-send-email-hjemli@gmail.com>
	<7v7iqs6r6p.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580705292348q74281f7eu15b3b61f45b2c6f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 05:54:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtyDY-0005AY-8o
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 05:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbXFADyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 23:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbXFADyT
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 23:54:19 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:43410 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbXFADyT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 23:54:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070601035415.VKGD5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 31 May 2007 23:54:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 63uF1X00J1kojtg0000000; Thu, 31 May 2007 23:54:16 -0400
In-Reply-To: <8c5c35580705292348q74281f7eu15b3b61f45b2c6f5@mail.gmail.com>
	(Lars Hjemli's message of "Wed, 30 May 2007 08:48:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48841>

"Lars Hjemli" <hjemli@gmail.com> writes:

> Would you prefer a patch on top of this version of the test-script or
> on top of the later patch which uses .git/config to store submodule
> url?

As you said you will be redoing submodule + .git/config stuff in
your other message, I would expect a replacement (i.e. not on
top of this) patch for tests to check the existing submodule
features.  If you want to finish the submodule + .git/config one
first and then test script on top to test both existing featues
and submodule + .git/config features, that is fine as well.
Your choice.

One important point is to treat the test-script take #1 as
"already rejected", and not basing further patches on it.
