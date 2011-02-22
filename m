From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 1/4] Typos: t/README
Date: Tue, 22 Feb 2011 17:15:00 +0000
Message-ID: <ca8eabbf-ed1b-4b46-a7f7-4b068a2de5b7-mfwitten@gmail.com>
References: <1fbceaa8-398c-44ec-8833-a03e4cca6805-mfwitten@gmail.com>
            <5bddd028-bf38-46b9-a189-bdb09038dfdd-mfwitten@gmail.com>
            <a59d19d0-f279-43fe-8ac6-06c4bd13c941-mfwitten@gmail.com>
            <d92be3a1-6f30-4b04-ac38-39058e5a6959-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:02:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4ynA-0001WA-7s
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 19:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933Ab1C3RCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 13:02:31 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53563 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933004Ab1C3RC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 13:02:29 -0400
Received: by pzk9 with SMTP id 9so231348pzk.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=IYIX8Wqmhf+C18I5YHFfc0pxie3QaKLea0KWGQk1VKw=;
        b=VV+AfbeUfEJbvjxskCYBsX+gMJuGyUXUxgiZy4ASE6aWvXaDK10Io9FW4HXJHMBpgs
         szWYMXLFq5sgy59Xx54NZQROCzc6j/TLxjtOWIYNl5W4dpRrLH+GhvQiY8Cl+bdzmS77
         kYe8o2V+0mdrec0s5/3hOkEVguowAE43jcR2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        b=dvEZ1w9OJZlfHtPa+rP98sWhQ3p53yepkpx/FLpBzQdHUMRT5QDbgYrhGs4Nmo1/cO
         faf0XtKkiSh2ig9OGJNuUnRHLXc/sYrRCiFcGZLn8C6N5qxKltjdLzakSjDuEUQGOIYo
         HBrsX90fh3uWvXEN3Dxpz7J9cNqsnnpdlb4v0=
Received: by 10.142.7.4 with SMTP id 4mr1112476wfg.386.1301504549117;
        Wed, 30 Mar 2011 10:02:29 -0700 (PDT)
Received: from gmail.com (u199-48-147-004.appliedops.net [199.48.147.4])
        by mx.google.com with ESMTPS id x11sm322246wfd.1.2011.03.30.10.02.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 10:02:28 -0700 (PDT)
In-Reply-To: <1fbceaa8-398c-44ec-8833-a03e4cca6805-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170392>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 t/README |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/README b/t/README
index ccf6a53..39408b4 100644
--- a/t/README
+++ b/t/README
@@ -201,7 +201,7 @@ we are testing.
 If you create files under t/ directory (i.e. here) that is not
 the top-level test script, never name the file to match the above
 pattern.  The Makefile here considers all such files as the
-top-level test script and tries to run all of them.  A care is
+top-level test script and tries to run all of them.  Care is
 especially needed if you are creating a common test library
 file, similar to test-lib.sh, because such a library file may
 not be suitable for standalone execution.
@@ -248,7 +248,7 @@ This test harness library does the following things:
    consistently when command line arguments --verbose (or -v),
    --debug (or -d), and --immediate (or -i) is given.
 
-Do's, don'ts & things to keep in mind
+Dos, don'ts & things to keep in mind
 -------------------------------------
 
 Here are a few examples of things you probably should and shouldn't do
@@ -285,9 +285,8 @@ Do:
  - Check the test coverage for your tests. See the "Test coverage"
    below.
 
-   Don't blindly follow test coverage metrics, they're a good way to
-   spot if you've missed something. If a new function you added
-   doesn't have any coverage you're probably doing something wrong,
+   Don't blindly follow test coverage metrics; if a new function you added
+   doesn't have any coverage, then you're probably doing something wrong,
    but having 100% coverage doesn't necessarily mean that you tested
    everything.
 
@@ -431,7 +430,7 @@ library for your script to use.
  - test_tick
 
    Make commit and tag names consistent by setting the author and
-   committer times to defined stated.  Subsequent calls will
+   committer times to defined state.  Subsequent calls will
    advance the times by a fixed amount.
 
  - test_commit <message> [<filename> [<contents>]]
-- 
1.7.4.18.g68fe8
