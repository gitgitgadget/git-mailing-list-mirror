From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.9b
Date: Tue, 01 Nov 2005 23:25:59 -0800
Message-ID: <7vbr13y0hk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932618AbVKBH0E@vger.kernel.org Wed Nov 02 08:27:18 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932618AbVKBH0E@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXD14-00054Y-7H
	for glk-linux-kernel-3@gmane.org; Wed, 02 Nov 2005 08:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbVKBH0E (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 2 Nov 2005 02:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVKBH0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:26:01 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:36004 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932618AbVKBH0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:26:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102072517.DRJF776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 02:25:17 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11003>

The second maintenance release of 0.99.9 series is found at the
usual place.  0.99.9a was purely to work around RPM build
issues; this one contains all the good changes in the master
branch -- mostly documentation updates, with some cvsimport
fixes from Martin.

The workaround for building RPMs has not changed since 0.99.9a,
mainly because I haven't heard back if it was good enough for
kernel.org consumption, or otherwise what changes are needed.

Note that package split we discussed earlier is not something I
consider "needed"; it is more like "nice to have before 1.0".  I
am hoping 0.99.9b to hit kernel.org machines soon, so people do
not have to be bitten by 0.99.8f glitches as reported for the
last couple of days.

That is, provided if the RPM workaround in 0.99.9a and this one
is good enough to produce an installable package, of course.
