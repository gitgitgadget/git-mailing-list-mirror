From: David Turner <dturner@twopensource.com>
Subject: [PATCH] Document RUN_SETUP_GENTLY
Date: Tue, 29 Apr 2014 01:04:11 -0400
Message-ID: <CAE+yK_nZ0tVbqvH00vqaAL2mUz4s6CQS5kCfGsayv-40b0yejQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 07:04:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf0DJ-00070o-V9
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 07:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbaD2FEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 01:04:14 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:32842 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbaD2FEN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 01:04:13 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so7351158wes.29
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 22:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ZYUjAU9egROl5MRGZUsOzBRDZi0DF9cHjO4YZ6Mk8Ts=;
        b=NyTkqyjf7OIeaXNaJODHiPtVlqBtA9ITc5ul0YJ4HqlP5FRPRaI+ssK7XSMDDGqGaF
         HZelc88Lo+ZJqYzk0K35xHma0/WX+zLOtuT74jQOvpbEtkfpIgLN7DsfwIaYsPeKgOOr
         O7W/2AoKyEwdZ/vKKgwIRLslubHggy5DQY2v77Z92zfdkDPWCivCtodiroH4nsLNrlSD
         C1OfbJ1tQYobOvambR+TjtQuXApiXjzyMApdb0WE4ad74SQ4Sgvr+ols+FTb2ZbLb+oY
         o/3Lm2gOAWmPL8FaNwx+oFT3BBY5AzZuMLuOgf/eHcmSUqydlFrtaoREdkwO5feUcLRI
         IW2A==
X-Gm-Message-State: ALoCoQkI6TWTnvxYsk8fK5VeuWE2HNM5EuD0U7a2fvnuoocYt92bUoe0n4dNb9kks2IgeWNP/LW9
X-Received: by 10.180.103.5 with SMTP id fs5mr18339711wib.33.1398747852050;
 Mon, 28 Apr 2014 22:04:12 -0700 (PDT)
Received: by 10.180.18.104 with HTTP; Mon, 28 Apr 2014 22:04:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247521>

Document RUN_SETUP_GENTLY

Signed-off-by: David Turner <dturner@twitter.com>
---
 Documentation/technical/api-builtin.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/technical/api-builtin.txt
b/Documentation/technical/api-builtin.txt
index e3d6e7a..1bbeda2 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -28,6 +28,11 @@ where options is the bitwise-or of:
  in a subdirectory.  If there is no work tree, no chdir() is
  done.

+`RUN_SETUP_GENTLY`::
+
+ If there is a Git directory, chdir as per RUN_SETUP, otherwise,
+ don't create one and don't chdir.
+
 `USE_PAGER`::

  If the standard output is connected to a tty, spawn a pager and
--
