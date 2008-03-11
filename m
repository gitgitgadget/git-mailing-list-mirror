From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH 1/2 resend] help: add "man.viewer" config var to use "woman"
 or "konqueror"
Date: Tue, 11 Mar 2008 02:00:02 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803110100.m2B102k9007026@localhost.localdomain>
References: <20080307084628.0b311793.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 02:36:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYtPi-0001ya-As
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 02:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbYCKBf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 21:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbYCKBf2
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 21:35:28 -0400
Received: from master.uucpssh.org ([193.218.105.66]:44304 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYCKBf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 21:35:26 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 91ED5C78A9; Tue, 11 Mar 2008 02:34:03 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2B103kK007029;
	Tue, 11 Mar 2008 02:00:03 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2B102k9007026;
	Tue, 11 Mar 2008 02:00:02 +0100
In-reply-to: <20080307084628.0b311793.chriscool@tuxfamily.org> (message from
	Christian Couder on Fri, 7 Mar 2008 08:46:28 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.389,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.01,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76780>

   This patch makes it possible to view man pages using other tools
   than the "man" program. It also implements support for emacs'
   "woman" and konqueror with the man KIO slave to view man pages.

   Note that "emacsclient" is used with option "-e" to launch "woman"
   on emacs and this works only on versions >= 22.

   Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Acked-off-by: Xavier Maillard <xma@gnu.org>

There is something wrong though. git cmd --help should wait for
the server to return in my opinion.

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
