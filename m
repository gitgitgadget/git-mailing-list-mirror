From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add commit.editor configuration variable
Date: Wed, 18 Jul 2007 23:08:11 -0700
Message-ID: <7v7iox3oz8.fsf@assigned-by-dhcp.cox.net>
References: <11848235881723-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 08:08:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBPBg-0004KU-0u
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 08:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbXGSGIS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 02:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbXGSGIS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 02:08:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:38303 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbXGSGIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 02:08:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070719060817.KXLX1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Jul 2007 02:08:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RJ8G1X00K1kojtg0000000; Thu, 19 Jul 2007 02:08:17 -0400
In-Reply-To: <11848235881723-git-send-email-aroben@apple.com> (Adam Roben's
	message of "Wed, 18 Jul 2007 22:39:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52939>

I do not think commit.editor is a good name.  Wouldn't we want
that customized editor for "git tag -a" as well?  Probably
core.editor would come nicely next to core.pager we already
have.
