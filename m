From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH 1/2] help: add "man.viewer" config var to use "woman" or
 "konqueror"
Date: Sat, 1 Mar 2008 02:00:05 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803010100.m21105LU008843@localhost.localdomain>
References: <20080228051956.2f36edf0.chriscool@tuxfamily.org>
 <200802290200.m1T2023x017992@localhost.localdomain>
 <200802290814.39366.chriscool@tuxfamily.org> <7vfxvcdx23.fsf@gitster.siamese.dyndns.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: chriscool@tuxfamily.org, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 02:34:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVGcO-0001T0-GP
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 02:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbYCABdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 20:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbYCABdq
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 20:33:46 -0500
Received: from master.uucpssh.org ([193.218.105.66]:38916 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbYCABdp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 20:33:45 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id BF787C931D; Sat,  1 Mar 2008 02:33:00 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m21106t2008846;
	Sat, 1 Mar 2008 02:00:06 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m21105LU008843;
	Sat, 1 Mar 2008 02:00:05 +0100
In-reply-to: <7vfxvcdx23.fsf@gitster.siamese.dyndns.org> (message from Junio C
	Hamano on Thu, 28 Feb 2008 23:46:44 -0800)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.4,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.00,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75597>


   Looking at this exchange really makes me suspect that these
   things should not be in C.  Every time Emacs updates we need
   recompilation?  Yuck.

In fact, I am pretty confident that emacsclient has always
printed its version onto stdout so I do not think we need to
recompile every week :)

   What was the reason we gave up calling out to a single generic
   scripted wrapper that the users can just munge to suit their
   tastes?

Good question. Though I find chriscool's implementation nicely
thought. With the modifications I made, this works as expected
with either emacs22 and emacs23 (aka CVS). What's more, how a
user could have tested if emacsclient was provided in the right
version using a generic scripted wrapper ?

I guess, chriscool should provide a more consistent emacsclient
wrapper with support for GNU Emacs version >= 21. This won't be
an enormous amount of work to do it (I can help him if he wants
to but I do not want to steal the paternity of his idea).

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
