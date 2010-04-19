From: Samuel Tardieu <sam@rfc1149.net>
Subject: [v3 PATCH 0/2] Add --tags/--no-tags options to "git add remote"
Date: Tue, 20 Apr 2010 01:31:19 +0200
Message-ID: <20100419233026.3631.67086.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 20 01:31:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O40R6-0006Is-3U
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 01:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab0DSXbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 19:31:22 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:36916 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab0DSXbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 19:31:21 -0400
Received: from localhost.localdomain (unknown [192.168.9.2])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 2FE396541
	for <git@vger.kernel.org>; Tue, 20 Apr 2010 01:31:20 +0200 (CEST)
User-Agent: StGit/0.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145341>

The following series adds the "--[no-]tags" option to "git add remote".
Since "-t" was already taken for "--track", I only let the long
"--tags" and "--no-tags" options.

In order to implement the "--tags" behaviour, I first had to add correct
handling of "tagopt = --tags" in remote configuration options.

---

Samuel Tardieu (2):
      Honor "tagopt = --tags" configuration option
      remote add: add a --no-tags (-n) option


 Documentation/git-remote.txt |    8 +++++
 builtin/remote.c             |   21 +++++++++++++-
 remote.c                     |    2 +
 t/t5505-remote.sh            |   63 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 2 deletions(-)
