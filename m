From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH v2 3/3] Documentation: Describe other situations where -z
 affects git diff
Date: Sun, 18 Apr 2010 19:28:17 +0100
Message-ID: <20100418182817.GC29329@hashpling.org>
References: <9eaa7a4672f2010c9e6e3b3f473f1c09abcfcc45.1271614677.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:28:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ZEK-00073f-A6
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371Ab0DRS2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:28:20 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:18633 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757336Ab0DRS2T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Apr 2010 14:28:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEANPryktUXeby/2dsb2JhbACbeXG4a4UQBINP
Received: from relay01.plus.net ([84.93.230.242])
  by relay.ptn-ipout02.plus.net with ESMTP; 18 Apr 2010 19:28:18 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by relay01.plus.net with esmtp (Exim) id 1O3ZE9-0005FZ-PG; Sun, 18 Apr 2010 19:28:17 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1O3ZE9-0007ll-JC; Sun, 18 Apr 2010 19:28:17 +0100
Content-Disposition: inline
In-Reply-To: <9eaa7a4672f2010c9e6e3b3f473f1c09abcfcc45.1271614677.git.charles@hashpling.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Plusnet-Relay: ecd46431f4333dbde462d845962f6111
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145229>

-z also alters the behaviour of --name-only and --name-status.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

As I'm relying on diff --name-only -z "doing the right thing", I quite
wanted it to be part of the documented interface.

 Documentation/diff-options.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 60e922e..c9c6c2b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -94,8 +94,8 @@ Also, when `--raw` or `--numstat` has been given, do not munge
 pathnames and use NULs as output field terminators.
 endif::git-log[]
 ifndef::git-log[]
-	When `--raw` or `--numstat` has been given, do not munge
-	pathnames and use NULs as output field terminators.
+	When `--raw`, `--numstat`, `--name-only` or `--name-status` has been
+	given, do not munge pathnames and use NULs as output field terminators.
 endif::git-log[]
 +
 Without this option, each pathname output will have TAB, LF, double quotes,
-- 
1.7.1.rc1.241.g4e72f
