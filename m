From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 01/10] Documentation/git-pull.txt: mention --quiet and --verbose for fetching
Date: Thu, 18 Feb 2010 20:37:02 +0800
Message-ID: <1266496631-3980-2-git-send-email-rctay89@gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:37:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5dW-0003oa-LJ
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758147Ab0BRMhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 07:37:39 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:60410 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758099Ab0BRMhi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 07:37:38 -0500
Received: by yxe38 with SMTP id 38so6323162yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gFe61Eb6OOkagVpYfXSuzDCNeIIdWpz+b1AUjkmk0E8=;
        b=Ad711MFn5ZpHBNrILGe46GYuJ2E9uA+hF9bOMgR81EQr8vyavPGnIFNk/b4ZWnddV5
         e+pogsdXK29Rhvroj6cA/WNKmqcybmc6hKLZq0qaBik2JCNTVrBZ2GIe+DxqkY1+szl+
         heLfew0hsr9Id3JuP1IUBbl8v9hNbhR1kbbeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VMqRfBNKWdhasp1qokgtMndYllDVIwpi3hZFYMi1Q5w5ZrA3kjvoGPDMOCR9eojDuA
         iWGKidQveQ105udyL4iwgR7i/QPPIbsWb+lJ3aImXKjfay39KB83UWBInSvx76EBazJQ
         kkLHu9r4J7vDxKtpxyaDrNvrUd6IjfJfHgtWw=
Received: by 10.101.138.10 with SMTP id q10mr3264699ann.37.1266496656754;
        Thu, 18 Feb 2010 04:37:36 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 21sm381013ywh.17.2010.02.18.04.37.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 04:37:36 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140324>

This reverts 90e4311 (git-pull: do not mention --quiet and --verbose
twice, Mon Sep 7 2009).

Then, the subtitles "Options related to merging" and "Options related to
fetching" weren't present, and the options for git-merge and git-fetch
options were in a monolithic block.

After 3f7a9b5 (Documentation/git-pull.txt: Add subtitles above included
option files, Thu Oct 22 2009), it is ok to repeat options in the
same document, since they are distinguished between those for git-merge
and git-fetch.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/fetch-options.txt |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index fe716b2..83606f4 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -74,7 +74,6 @@ endif::git-pull[]
 	the command to specify non-default path for the command
 	run on the other end.
 
-ifndef::git-pull[]
 -q::
 --quiet::
 	Pass --quiet to git-fetch-pack and silence any other internally
@@ -83,4 +82,3 @@ ifndef::git-pull[]
 -v::
 --verbose::
 	Be verbose.
-endif::git-pull[]
-- 
1.7.0.27.g5d71b
