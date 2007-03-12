From: Xavier Maillard <zedek@gnu.org>
Subject: What's the best method between merging and rebasing ?
Date: Mon, 12 Mar 2007 12:39:38 +0100
Organization: GNU's Not UNIX!
Message-ID: <200703121139.l2CBdcUL022906@localhost.localdomain>
Reply-To: Xavier Maillard <zedek@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 12:43:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQivd-0008Lw-Bo
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 12:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965703AbXCLLm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 07:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965706AbXCLLmZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 07:42:25 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:42407 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965703AbXCLLmY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 07:42:24 -0400
Received: from zogzog.home (cha51-2-82-244-211-40.fbx.proxad.net [82.244.211.40])
	by smtp2-g19.free.fr (Postfix) with ESMTP id AD8498BC68
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 12:42:23 +0100 (CET)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by zogzog.home (8.13.8/8.13.8) with ESMTP id l2CBdecO022909
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 12:39:40 +0100
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2CBdcUL022906;
	Mon, 12 Mar 2007 12:39:38 +0100
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
Jabber-ID: zedek@im.lolica.org
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42019>

Hi,

Say I have a project in this state:

orig master -> A -> B -> C -> HEAD

I want to make A diverging from the original branch so I would be
at this state :

orig master -> A -> B -> C -> HEAD
     	    \
	     -> D -> E -> F -> 

I want master to be at  HEAD of the new branch and I want to pick
commits here and there from the original master branch.

How would you do that ?

I think I can't merge directly old master onto new master since
there are several commits I want to drop but what about rebasing
?

I guess I should cherry-pick interesting commits and rebase but I
am not sure.

Help would be greatly appreciated here :)
-- 
Xavier
