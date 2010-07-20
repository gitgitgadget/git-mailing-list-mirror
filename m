From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/README: clarify test_must_fail description
Date: Tue, 20 Jul 2010 12:17:12 -0500
Message-ID: <0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil>
References: <20100720163822.GA8492@localhost.localdomain>
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: jaredhance@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 20 19:18:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObGSW-00035u-1R
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 19:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063Ab0GTRSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 13:18:18 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50268 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab0GTRSS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 13:18:18 -0400
Received: by mail.nrlssc.navy.mil id o6KHHRsb023770; Tue, 20 Jul 2010 12:17:27 -0500
In-Reply-To: <20100720163822.GA8492@localhost.localdomain>
X-OriginalArrivalTime: 20 Jul 2010 17:17:27.0198 (UTC) FILETIME=[6D44A3E0:01CB282F]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151333>

From: Brandon Casey <drafnel@gmail.com>

Some have found the wording of the description to be somewhat ambiguous
with respect to when it is desirable to use test_must_fail instead of
"! <git-command>".  Tweak the wording somewhat to hopefully clarify that
it is _because_ test_must_fail can detect segmentation fault that it is
desirable to use it instead of "! <git-command>".

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


On 07/20/2010 11:38 AM, Jared Hance wrote:
> I think the wording of description of test_must_fail is slightly
> ambiguous. I read it to mean that:
> 
>     Use test_must_fail only when you are testing to see if git will
>     segfault.

I think that is a correct interpretation.  But I ask you this:
Are there times when we would _not_ want to test for segfault? :)

> Rather than:
>     
>     Use test_must_fail to be safe from git segfaults.
> 
> 
> Perhaps the description should be updated to be a bit more clear?

How about this?


 t/README |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/README b/t/README
index b906ceb..a830daa 100644
--- a/t/README
+++ b/t/README
@@ -451,8 +451,8 @@ library for your script to use.
  - test_must_fail <git-command>
 
    Run a git command and ensure it fails in a controlled way.  Use
-   this instead of "! <git-command>" to fail when git commands
-   segfault.
+   this instead of "! <git-command>" since it will fail when git
+   commands segfault.
 
  - test_might_fail <git-command>
 
-- 
1.6.6.2
