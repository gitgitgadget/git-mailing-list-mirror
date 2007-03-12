From: Xavier Maillard <zedek@gnu.org>
Subject: Re: What's the best method between merging and rebasing ?
Date: Mon, 12 Mar 2007 17:34:55 +0100
Organization: GNU's Not UNIX!
Message-ID: <200703121634.l2CGYtGx027263@localhost.localdomain>
References: <200703121139.l2CBdcUL022906@localhost.localdomain> <20070312120820.GE18952@mad.intersec.eu>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:38:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQnX3-00044T-96
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 17:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030628AbXCLQhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 12:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbXCLQhl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 12:37:41 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:44159 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030628AbXCLQhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 12:37:40 -0400
Received: from zogzog.home (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 68EED7DCF;
	Mon, 12 Mar 2007 17:37:39 +0100 (CET)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by zogzog.home (8.13.8/8.13.8) with ESMTP id l2CGYtx6027268;
	Mon, 12 Mar 2007 17:34:56 +0100
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2CGYtGx027263;
	Mon, 12 Mar 2007 17:34:55 +0100
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <20070312120820.GE18952@mad.intersec.eu> (madcoder@debian.org)
Jabber-ID: zedek@im.lolica.org
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42039>

   From: Pierre Habouzit <madcoder@debian.org>

   On Mon, Mar 12, 2007 at 12:39:38PM +0100, Xavier Maillard wrote:
   > Hi,

   > Say I have a project in this state:

   > orig master -> A -> B -> C -> HEAD

   > I want to make A diverging from the original branch so I would be
   > at this state :

   > orig master -> A -> B -> C -> HEAD
   >      	    \
   > 	             -> D -> E -> F ->

   > I want master to be at  HEAD of the new branch and I want to pick
   > commits here and there from the original master branch.

     I'm not sure I get this right, but if I understand you correctly, I'd
   say that you could branch your master into a old-master branch.

What I am tryin to explain is that I want to get rid of the old
master branch and pick commits from it here and there (that's
what is called cherry-pick I guess).

So in the end I will end with:

-> D -> E -> F -> several commits from old master -> HEAD (of new master)

So it seems to be cherry-picks + rebase master on new HEAD but I
am not sure at how things are doing :)

Thank you
-- 
Xavier
