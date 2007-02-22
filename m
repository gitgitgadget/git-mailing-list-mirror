From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-email
Date: Thu, 22 Feb 2007 13:38:17 -0800
Message-ID: <7vd541dgae.fsf@assigned-by-dhcp.cox.net>
References: <20070222211313.GA23674@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 22:38:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKLdw-0004Yv-8Z
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 22:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbXBVViT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 16:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbXBVViT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 16:38:19 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64771 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbXBVViS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 16:38:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222213818.JMUR233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 16:38:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SleH1W00R1kojtg0000000; Thu, 22 Feb 2007 16:38:18 -0500
In-Reply-To: <20070222211313.GA23674@informatik.uni-freiburg.de> (Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig's?= message of "Thu, 22 Feb 2007 22:13:14
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40396>

When git-send-email reads from the mbox, it should expect From:
to be in 2047 (because the input is in Unix mbox format) and
unwrap it before doing the comparison.  Perhaps it is not doing
that.
