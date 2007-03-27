From: Xavier Maillard <zedek@gnu.org>
Subject: Re: [PATCH 1/2] git-blame.el: separate git-blame-mode to ease maintenance
Date: Tue, 27 Mar 2007 16:56:48 +0200
Organization: GNU's Not UNIX!
Message-ID: <200703271456.l2REumU4007939@localhost.localdomain>
References: <200703262100.l2QL0svB012536@localhost.localdomain> <87fy7rrsi2.fsf@morpheus.local>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org
To: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Mar 27 18:36:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWEeS-0001fk-RI
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 18:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933115AbXC0Qfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 12:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933127AbXC0Qfl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 12:35:41 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:40796 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933115AbXC0Qfk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 12:35:40 -0400
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 20AD336510;
	Tue, 27 Mar 2007 18:35:39 +0200 (CEST)
Received: from localhost.localdomain (IDENT:25@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l2RFWf5l008377;
	Tue, 27 Mar 2007 17:32:41 +0200
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2REumU4007939;
	Tue, 27 Mar 2007 16:56:48 +0200
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <87fy7rrsi2.fsf@morpheus.local> (davidk@lysator.liu.se)
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Jabber-ID: zedek@im.lolica.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43279>

Hi,

   > String displayed on the mode line is now configurable through
   > `git-blame-mode-line-string` (default to " blame").

   Why do you feel the need for this?  I don't remember seeing any other
   minor mode that does this.

Because, I like when I can hide mode line strings for certains
minor modes or even just shorten it. Here for example, I do not
feel the need to display "Blame" in the mode line since
git-blame.el is easily identifiable.

Xavier
