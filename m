From: Alexander Daniel <alexander.daniel@openforce.com>
Subject: [BUG] `git stash drop --help` removes stash
Date: Tue, 22 May 2012 09:29:40 +0200
Message-ID: <95877607-FED0-41C0-9F12-B91FE9DE7871@openforce.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 09:38:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWjfY-0004R5-Bf
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 09:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534Ab2EVHiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 03:38:09 -0400
Received: from outbound.openforce.com ([81.223.107.118]:61482 "EHLO
	outbound.openforce.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab2EVHiI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 03:38:08 -0400
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 May 2012 03:38:08 EDT
Received: from [10.200.1.130] (unknown [10.200.1.130])
	by outbound.openforce.com (Postfix) with ESMTPSA id E882CFA382
	for <git@vger.kernel.org>; Tue, 22 May 2012 09:29:40 +0200 (CEST)
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198186>

SUMMARY
`git stash drop --help` removes stash@{0}

VERSION
$ git --version
git version 1.7.10.2

STEPS TO REPRODUCE
- put something on the stash with `git stash`
- Naively try to show help for `git stash drop` with `git stash drop --help`
- `git stash drop --help` actually removes stash@{0}:

  $ git stash drop --help
  Dropped refs/stash@{0} (bfee7acd94b85e2b0bb5ef172893872140ba0520)

EXPECTED BEHAVIOR:
Invalid parameter error message is displayed (no modification of the stash)

Alex
