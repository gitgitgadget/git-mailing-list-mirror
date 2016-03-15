From: Josh Triplett <josh@joshtriplett.org>
Subject: Can't git stash after using git add -N
Date: Tue, 15 Mar 2016 16:07:54 -0700
Message-ID: <20160315230754.GA12058@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 00:08:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afy4I-0006dt-HQ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 00:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbcCOXH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 19:07:59 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57065 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbcCOXH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 19:07:57 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DB46417209C
	for <git@vger.kernel.org>; Wed, 16 Mar 2016 00:07:54 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288927>

After using "git add -N", "git stash" can no longer stash:

/tmp/temp$ git init
Initialized empty Git repository in /tmp/temp/.git/
/tmp/temp$ echo a > a
/tmp/temp$ git add a
/tmp/temp$ git commit -m 'Initial commit of a'
[master (root-commit) d7242c4] Initial commit of a
 1 file changed, 1 insertion(+)
 create mode 100644 a
/tmp/temp$ echo b > b
/tmp/temp$ git add -N b
/tmp/temp$ git stash
error: Entry 'b' not uptodate. Cannot merge.
Cannot save the current worktree state

- Josh Triplett
