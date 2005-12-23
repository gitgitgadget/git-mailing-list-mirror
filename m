From: Jon Nelson <jnelson-git@jamponi.net>
Subject: git-checkout and SUBDIRECTORY_OK='Yes'
Date: Thu, 22 Dec 2005 22:20:13 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0512222217040.6812@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Dec 23 05:20:29 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpePo-0006wF-65
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 05:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbVLWEUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 23:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbVLWEUQ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 23:20:16 -0500
Received: from mtai02.charter.net ([209.225.8.182]:34737 "EHLO
	mtai02.charter.net") by vger.kernel.org with ESMTP id S1030409AbVLWEUP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 23:20:15 -0500
Received: from mxip36-10.charter.net ([10.20.203.76]) by mtai02.charter.net
          (InterMail vM.6.01.05.04 201-2131-123-105-20051025) with ESMTP
          id <20051223042014.DQZD3855.mtai02.charter.net@mxip36-10.charter.net>
          for <git@vger.kernel.org>; Thu, 22 Dec 2005 23:20:14 -0500
Received: from 24-183-46-83.dhcp.mdsn.wi.charter.com (HELO turnip.jamponi.pvt) ([24.183.46.83])
  by mxip36-10.charter.net with ESMTP; 22 Dec 2005 23:20:14 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
Received: by turnip.jamponi.pvt (Postfix, from userid 1000)
	id 2FA8FC092; Thu, 22 Dec 2005 22:20:13 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by turnip.jamponi.pvt (Postfix) with ESMTP id 1EBFCC091
	for <git@vger.kernel.org>; Thu, 22 Dec 2005 22:20:13 -0600 (CST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13985>


Is it safe to set SUBDIRECTORY_OK='Yes' in git-checkout.sh?
What about the other *.sh that don't already set it?

--
Jon Nelson <jnelson-git@jamponi.net>
