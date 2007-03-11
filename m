From: Xavier Maillard <zedek@gnu.org>
Subject: git merge and merge message
Date: Sun, 11 Mar 2007 16:05:04 +0100
Organization: GNU's Not UNIX!
Message-ID: <200703111505.l2BF54Kq006625@localhost.localdomain>
Reply-To: Xavier Maillard <zedek@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 16:07:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQPeM-0002IN-VL
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 16:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933736AbXCKPHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 11:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933738AbXCKPHw
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 11:07:52 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:42602 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933736AbXCKPHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 11:07:51 -0400
Received: from zogzog.home (cha51-2-82-244-211-40.fbx.proxad.net [82.244.211.40])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 415E47D11
	for <git@vger.kernel.org>; Sun, 11 Mar 2007 16:07:50 +0100 (CET)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by zogzog.home (8.13.8/8.13.8) with ESMTP id l2BF55kc006628
	for <git@vger.kernel.org>; Sun, 11 Mar 2007 16:05:05 +0100
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2BF54Kq006625;
	Sun, 11 Mar 2007 16:05:04 +0100
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
Jabber-ID: zedek@im.lolica.org
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41931>

Hi,

I have setup several 'topic branches' for a project I am
maintaining.

For several ones, I want to merge them into master.

Here is what I am trying to use:

git checkout master
git merge -m "Message" topic-branch

The merge is correct but there is not merge message when I do a
git log.

I have tried either with and without -m, I even tried with git
merge "merge message" topic-branch but then it failed.

What is the correct way to have merge message ?

Thank you
-- 
Xavier
