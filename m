From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 02/10] Documentation/git-pull: put verbosity options before merge/fetch ones
Date: Wed, 24 Feb 2010 20:50:21 +0800
Message-ID: <1267015829-5344-3-git-send-email-rctay89@gmail.com>
References: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@googlemail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:51:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkGi2-0005M5-HO
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 13:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab0BXMuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 07:50:52 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:20746 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0BXMuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 07:50:50 -0500
Received: by qw-out-2122.google.com with SMTP id 8so870366qwh.37
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PrAzLBHbPdkQU928Plea5vq6BI6+ekTnFTaQtj9QClA=;
        b=jGevl9xjTU01YbTv5TrD/eKLLRA2SBZ2IfRpgdMyndE2FFV7UuK5V6iXhfpmAMN+vT
         Hp1HilfEOQYzO+B4uKKzo34V9JDoz294+384w59epvxgyJFsx9zoHyQAnJ/H/n7UyKPI
         ks7hHqFZEwnjFvK0eQnK4OwpkE92hj+71qr+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=quvfBcy4USgZuYDU1qL0VAtdUJG/Fi9AqvaY2j/zAFkZPTF+vFhpLrcXNt0p1AC7y/
         hNUsFPeIOvlNcc2EVj+Z0v3u7iyRUSBb6VwN60UK2HyPSEZEzZGFtNLmWNhTecRiIoqs
         kSM9I7guPTJ7s5f4JRGizhJwtdyrYKktUS/OA=
Received: by 10.224.110.11 with SMTP id l11mr7672791qap.107.1267015849204;
        Wed, 24 Feb 2010 04:50:49 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 23sm253680qyk.15.2010.02.24.04.50.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 04:50:48 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140934>

After 3f7a9b5 (Documentation/git-pull.txt: Add subtitles above included
option files, Thu Oct 22 2009), the -q/-v options were mentioned only
for the merge options section, giving the impression that git-fetch did
not take those arguments.

Follow 90e4311 (git-pull: do not mention --quiet and --verbose twice,
Mon Sep 7 2009) and hide -q/-v for merge options, while mentioning -q/-v
before the merge- and fetch-specific options.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changes from v1:
  - put verbosity options (-v and -q) in a common area for the
    documentation for git-pull, as per Junio's suggestion
    (<7vhbpe5jvo.fsf@alter.siamese.dyndns.org>).

 Documentation/git-pull.txt      |    8 ++++++++
 Documentation/merge-options.txt |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 31f42ea..d47f9dd 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -31,6 +31,14 @@ in a state that is hard to back out of in the case of a conflict.
 OPTIONS
 -------

+-q::
+--quiet::
+	Pass --quiet to git-fetch and git-merge.
+
+-v::
+--verbose::
+	Pass --verbose to git-fetch and git-merge.
+
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 3b83dba..37ce9a1 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -67,6 +67,7 @@ option can be used to override --squash.
 	Synonyms to --stat and --no-stat; these are deprecated and will be
 	removed in the future.

+ifndef::git-pull[]
 -q::
 --quiet::
 	Operate quietly.
@@ -74,6 +75,7 @@ option can be used to override --squash.
 -v::
 --verbose::
 	Be verbose.
+endif::git-pull[]

 -X <option>::
 --strategy-option=<option>::
--
1.7.0.20.gcb44ed
