From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Terminology
Date: Sun, 31 Jul 2005 15:52:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507311541340.29235@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jul 31 15:52:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzEF0-0004la-I2
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 15:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVGaNw1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 09:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263218AbVGaNw1
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 09:52:27 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15579 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261761AbVGaNw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 09:52:26 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 93525E1CE2
	for <git@vger.kernel.org>; Sun, 31 Jul 2005 15:52:25 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 78DB591B52
	for <git@vger.kernel.org>; Sun, 31 Jul 2005 15:52:25 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 493EA91B50
	for <git@vger.kernel.org>; Sun, 31 Jul 2005 15:52:25 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 33B9BE1CE2
	for <git@vger.kernel.org>; Sun, 31 Jul 2005 15:52:25 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

the other day I got confused by the terminology. Maybe I'm not the only
one:

The GIT equivalent of a CVS branch is sometimes called a branch
(git-new-branch), sometimes a tree (git-switch-tree), and sometimes a
head (which seems counterintuitive to CVS people: they only have one
HEAD; pun(s) intended).

What is worse: a tree often refers to something different, namely a
directory structure corresponding to a certain commit (which SVN people
would call revision). And in $GIT_DIR/branches, short cuts for remote
addresses are stored (and therefore I would have preferred
$GIT_DIR/remotes).

Maybe we should decide on a common terminology before kicking out 1.0, and
look through all files in Documentation/ to have a consistent vocabulary.
And poor me does not get confused no more.

Ciao,
Dscho

--
Git-R-Done
