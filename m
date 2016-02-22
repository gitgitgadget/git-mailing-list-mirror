From: Peter Dave Hello <hsu@peterdavehello.org>
Subject: [PATCH] Update diff-highlight
Date: Mon, 22 Feb 2016 04:14:15 +0000
Message-ID: <00000153072f5465-fd36f07c-e5e6-4a0f-8cf1-77be99424892-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 05:24:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXi2b-0004Sx-CH
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 05:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbcBVEYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 23:24:04 -0500
Received: from a6-247.smtp-out.eu-west-1.amazonses.com ([54.240.6.247]:59325
	"EHLO a6-247.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752539AbcBVEYD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 23:24:03 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Feb 2016 23:24:03 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1456114455;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=R+RT9LsaMAUy863VTyMYva4wHqTXl3zRURZ72Noh5DY=;
	b=DBCAJ3KIZsODcMQ6s2sjidnkVyBm0ZuHP4zZ7AF7Swsm4W/rxxcshrJG1d5+Autf
	JHIDbCrNBHMdXX7nVBfY4pRyuuMc7RftNrO2T6KWQTkh44cS5E2zzpIWR8SPFviv5GJ
	56ZfJ0VwIyAH/PhjfVk0wm9BodfwHKGiRgF67PBU=
X-SES-Outgoing: 2016.02.22-54.240.6.247
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286878>

From: Peter Dave Hello <peterdavehello@users.noreply.github.com>

Use `#!/usr/bin/env perl` instead of `#!/usr/bin/perl`

So that it can works on FreeBSD.
---
 contrib/diff-highlight/diff-highlight | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ffefc31..b57b0fd 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use 5.008;
 use warnings FATAL => 'all';

--
https://github.com/git/git/pull/200
