From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH] Documentation/git-remote.txt: remove description for useless
 -n option
Date: Sun, 08 Jun 2008 13:03:40 +0200
Message-ID: <484BBC8C.80700@free.fr>
References: <484B2DD3.8050307@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 13:04:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5IhG-0001ke-65
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 13:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185AbYFHLDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 07:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757558AbYFHLDc
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 07:03:32 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:35937 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757071AbYFHLDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 07:03:31 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 7635D12B6F7
	for <git@vger.kernel.org>; Sun,  8 Jun 2008 13:03:30 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id C01B312B6BD
	for <git@vger.kernel.org>; Sun,  8 Jun 2008 13:03:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <484B2DD3.8050307@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84262>

From: Olivier Marin <dkr@freesurf.fr>

This option comes from the original git-remote.perl script and is not
used nor needed in the current builtin.

So, remove it from the documentation so that we can reuse it later for
something else.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
  Documentation/git-remote.txt |    7 -------
  1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index e97dc09..e51d232 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -61,9 +61,6 @@ configuration settings for the remote are removed.
  'show'::

  Gives some information about the remote <name>.
-+
-With `-n` option, the remote heads are not queried first with
-`git ls-remote <name>`; cached information is used instead.

  'prune'::

@@ -71,10 +68,6 @@ Deletes all stale tracking branches under <name>.
  These stale branches have already been removed from the remote repository
  referenced by <name>, but are still locally available in
  "remotes/<name>".
-+
-With `-n` option, the remote heads are not confirmed first with `git
-ls-remote <name>`; cached information is used instead.  Use with
-caution.

  'update'::

-- 1.5.6.rc2.160.ga44ac
