From: santos2010 <santos.claudia2009@googlemail.com>
Subject: GIT Performance question
Date: Sat, 17 Apr 2010 01:55:49 -0800 (PST)
Message-ID: <1271498149921-4917066.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 17 11:55:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O34km-0002ss-3z
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 11:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab0DQJzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 05:55:51 -0400
Received: from kuber.nabble.com ([216.139.236.158]:48520 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab0DQJzu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 05:55:50 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <santos.claudia2009@googlemail.com>)
	id 1O34kf-00057H-Tq
	for git@vger.kernel.org; Sat, 17 Apr 2010 02:55:49 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145128>


Hello,

Our company is evaluating SCM solutions, one of our most important
requirements is performance as we develop over 3 differents sites across the
world.
I read that GIT doesn't use deltas, it uses snapshots. My question is: how
could GIT have high performance (most of the users say that) if for
synchronization (pull/push command) with e.g. a shared repository GIT
transfers all modified files (and references) instead of the respective
deltas? 

Thanks in advance,

Santos
-- 
View this message in context: http://n2.nabble.com/GIT-Performance-question-tp4917066p4917066.html
Sent from the git mailing list archive at Nabble.com.
