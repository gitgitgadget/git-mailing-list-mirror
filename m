From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH] Shorten and simplify sendemail.alias* configuration variables.
Date: Wed, 19 Mar 2008 02:00:03 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803190100.m2J103PU032019@localhost.localdomain>
References: <1205794384-14513-1-git-send-email-xma@gnu.org> <20080318081305.GG18624@mail-vs.djpig.de>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:43:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4BH-0002JK-Ow
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709AbYCSTgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756700AbYCSTgT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:36:19 -0400
Received: from master.uucpssh.org ([193.218.105.66]:41299 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678AbYCSTgM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:36:12 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 61CF9C99D2; Wed, 19 Mar 2008 02:35:05 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2J1034b032026;
	Wed, 19 Mar 2008 02:00:03 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2J103PU032019;
	Wed, 19 Mar 2008 02:00:03 +0100
In-reply-to: <20080318081305.GG18624@mail-vs.djpig.de> (message from Frank
	Lichtenheld on Tue, 18 Mar 2008 09:13:05 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.3 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.383,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.02,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77514>


   On Mon, Mar 17, 2008 at 11:53:04PM +0100, Xavier Maillard wrote:
   > I find it more consistent and less error prone to have aliasfile
   > instead of aliasesfile and aliastype instead of aliasfiletype.

   I don't think that justifies breaking existing configs (which I assume
   it does).

Yes it is likely to break configs after this patch has been
applied. The m;ore confusing part in the current config variables
is the *aliases* (plural) of the _aliasesfile_ variable.
Actually, I am pretty sure, many people did not notice this
plural form at first, so did I :)

Anyway, this is just a proposition of changes. Feel free not to
apply it at all.

Regards

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
