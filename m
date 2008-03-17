From: Xavier Maillard <xma@gnu.org>
Subject: Re: Should 'git config' support key with dot such as 'a.b'
Date: Mon, 17 Mar 2008 02:00:03 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803170100.m2H103CF020765@localhost.localdomain>
References: <46dff0320803140124t1469defsf7002f720cf2002e@mail.gmail.com>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 02:35:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb4GN-0006lO-Op
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 02:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbYCQBfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 21:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbYCQBfE
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 21:35:04 -0400
Received: from master.uucpssh.org ([193.218.105.66]:56030 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYCQBfB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 21:35:01 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 970CED531C; Mon, 17 Mar 2008 02:34:39 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2H104DB020800;
	Mon, 17 Mar 2008 02:00:04 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2H103CF020765;
	Mon, 17 Mar 2008 02:00:03 +0100
In-reply-to: <46dff0320803140124t1469defsf7002f720cf2002e@mail.gmail.com>
	(pkufranky@gmail.com)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77408>



   I think the following form is more simple
   ---------------------------------
   [submodule]
	crawler.url = url1
	search.url = url2
   ---------------------------------

   So, could we support such simpler form?

Dunno if my vote will count but I really don't like your
proposition. I find clearer with the current notation. What's
more it forces people to be more rigorous when touching their
configuration file.

git config is really simple to use and there should not be
difficult for anybody (even new git users) to set up git using
this helper tool. We should not recommend beginners to manually
edit their .git/config file when git-config could be used.

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
