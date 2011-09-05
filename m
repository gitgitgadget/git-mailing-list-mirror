From: Eli Barzilay <eli@barzilay.org>
Subject: Pushing with --mirror over HTTP?
Date: Mon, 5 Sep 2011 00:05:37 -0400
Message-ID: <20068.19089.303108.950233@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 06:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Qgk-0005Os-P2
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 06:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833Ab1IEEVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 00:21:23 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:52380 "EHLO
	winooski.ccs.neu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab1IEEVV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 00:21:21 -0400
X-Greylist: delayed 942 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Sep 2011 00:21:21 EDT
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id p8545bMu032548
	for <git@vger.kernel.org>; Mon, 5 Sep 2011 00:05:37 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id p8545bN7032545;
	Mon, 5 Sep 2011 00:05:37 -0400
X-Mailer: VM 8.1.93a under 23.2.1 (x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180715>

Is there anything broken with pushing with mirror over HTTP?  I'm
trying that with a github url, and I get a broken-looking error
message:

  remote part of refspec is not a valid name in :.have

and with the google code, I get:

  error: unable to push to unqualified destination: HEAD

Pushing to both of these work fine without `--mirror'.


(BTW, as a workaround, I'm using
  push --force --tags <url> :
is this achieving the same effect for a repo without weird refs?)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
