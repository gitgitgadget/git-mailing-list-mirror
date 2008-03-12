From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH 1/2 resend] help: add "man.viewer" config var to use "woman" or "konqueror"
Date: Wed, 12 Mar 2008 02:00:03 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803120100.m2C103RP010488@localhost.localdomain>
References: <20080307084628.0b311793.chriscool@tuxfamily.org> <200803110100.m2B102k9007026@localhost.localdomain> <200803110648.16117.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 02:36:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZFtT-0001ON-GH
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 02:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbYCLBf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 21:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbYCLBfz
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 21:35:55 -0400
Received: from master.uucpssh.org ([193.218.105.66]:52661 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYCLBfy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 21:35:54 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id E06E5C987C; Wed, 12 Mar 2008 02:34:12 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2C104Qa010491;
	Wed, 12 Mar 2008 02:00:04 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2C103RP010488;
	Wed, 12 Mar 2008 02:00:03 +0100
In-reply-to: <200803110648.16117.chriscool@tuxfamily.org> (message from
	Christian Couder on Tue, 11 Mar 2008 06:48:15 +0100)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76902>

   > There is something wrong though. git cmd --help should wait for
   > the server to return in my opinion.

   When I try something like the following on the command line:

   $ emacsclient -e '(woman "fork")'

   emacsclient doesn't wait for the server to return.

   So I don't see how and why we should wait.

You are right. In fact, we can only wait for the server to return
when we edit a file. Sorry for the noise

Tested-by: Xavier Maillard <xma@gnu.org>

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
