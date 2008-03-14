From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH] help: implement multi-valued "man.viewer" config option
Date: Fri, 14 Mar 2008 02:00:05 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803140100.m2E105o5004664@localhost.localdomain>
References: <20080311085113.176df1af.chriscool@tuxfamily.org> <200803120100.m2C105YM010496@localhost.localdomain> <200803120823.38100.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 02:36:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZyqU-0001OA-W1
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 02:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbYCNBfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 21:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbYCNBfv
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 21:35:51 -0400
Received: from master.uucpssh.org ([193.218.105.66]:50805 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbYCNBfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 21:35:50 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id D5E2CD11F9; Fri, 14 Mar 2008 02:34:19 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2E106H3004671;
	Fri, 14 Mar 2008 02:00:06 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2E105o5004664;
	Fri, 14 Mar 2008 02:00:05 +0100
In-reply-to: <200803120823.38100.chriscool@tuxfamily.org> (message from
	Christian Couder on Wed, 12 Mar 2008 08:23:37 +0100)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77163>


   > Ok, woma in not supported here and it is reported like this but
   > would it be possible to just throw an error on stdout and try
   > another viewer ? 

   Yes, with the following patch on top:

See my "tested-by" message.

   > We could even imagine something even more 
   > general like the possibility for the user to write his own man
   > viewer (a bash script for example) and set it as a candidate.

   I will do that in a latter patch, it has been suggested a lot of times 
   already.

Glad to read that !

   > By the way, I do not see any reason to put man as a candidate.
   > "man" should be the default when nothing is specified or when all
   > candidates have failed.

   It may be more explicit.

Well, I do not buy this argument and I am pretty sure that a
simple note into the manual would suffice but, that's me :)

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
