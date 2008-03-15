From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH 1/2] web--browse: use custom commands defined at config time
Date: Sat, 15 Mar 2008 14:00:33 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803151300.m2FD0XWh003243@localhost.localdomain>
References: <20080314055649.0bd59b47.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: junkio@cox.net, normalperson@yhbt.net, git@vger.kernel.org,
	jaysoffian@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 14:08:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaW7d-00035z-PW
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 14:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbYCONHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 09:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbYCONHq
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 09:07:46 -0400
Received: from master.uucpssh.org ([193.218.105.66]:41029 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbYCONHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 09:07:45 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 601FEC65B3; Sat, 15 Mar 2008 14:05:42 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2FD0c7K003253;
	Sat, 15 Mar 2008 14:00:38 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2FD0XWh003243;
	Sat, 15 Mar 2008 14:00:33 +0100
In-reply-to: <20080314055649.0bd59b47.chriscool@tuxfamily.org> (message from
	Christian Couder on Fri, 14 Mar 2008 05:56:49 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.39,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.01,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77327>


   This patch adds a git config variable "browser.<tool>.cmd" which
   allows a more flexible browser choice.

Well done ! Now we need it in help.c too :)

   Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Tested-by: Xavier Maillard <xma@gnu.org>

   ---
    git-web--browse.sh |   15 +++++++++++++--
    1 files changed, 13 insertions(+), 2 deletions(-)

Please update the header file as well (copyright header, it is
year 2008 here :)).

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
