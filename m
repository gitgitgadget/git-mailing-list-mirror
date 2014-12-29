From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] Documentation/SubmittingPatches: Explain the rationale of git notes
Date: Mon, 29 Dec 2014 09:42:22 -0800
Message-ID: <1419874942-9901-1-git-send-email-sbeller@google.com>
References: <xmqqwq5ja7s2.fsf@gitster.dls.corp.google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 18:42:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5eKu-0003cZ-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 18:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbaL2Rm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 12:42:27 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35900 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbaL2Rm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 12:42:26 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so12492274iec.33
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aqbn4NqEcdiESNcDYUrUoqCzrp2CKehiROO0hFYKaFs=;
        b=dEWnVaVIiDLOiS5PDSfI2MgNGh0PX20+aX1vnPDa6bK8yM49TY7cb3KVd1kbdE6PkA
         DPEBvANFJUNV3OHM40R+ErMzlO2R1u+OINX+id8JiM6ftHdI6qHANY8QL8cSU5EIo7DR
         ZLIG5iogDttbjHF7KUwTJuUwE8jCKRr3ZxUx23joW8K4P0DUQEioQynEyKnK/mgJpjO4
         zJv7+piwxxD4ucuyUwqgKAAHRSWVo7NTtfrvVGquMa2RR0wrRyB7PLXUiq8odnrhAvAl
         aj2NNz+CIv1DmyGy7KFL84lCMY2udl99bKCgh8kVbgLg01V6bNOz/aT72cctcmw7X0Of
         LQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aqbn4NqEcdiESNcDYUrUoqCzrp2CKehiROO0hFYKaFs=;
        b=dRyf8ypwDGfvvzLhUEyAm5bTqfsXMdqh8YZXrruq7/YytcAEROQ+fu+wZYwZ3GVLYS
         F6mzruWtBtE8bu3VbCmfVPkOPcob2xYMpUiQXA28hQ1kld/FsiQZ4Tz9Sw78ccfiWPyB
         yJD86ju6wAcd1Rd95du1SI2Oi2TswqZ6N5sWJeyRY4feSuXb8HyF1r6jWh3vx2yvULlG
         vJ3PvraO3oznYC4k3kbCtMuSB6kpf4pua8T+7WXIfmTa76RgMTJLthgjOp01Ewza4GrK
         GDeZqlfIVuJhx0OOzoxGPE8q8ceRV5UVgPzHIWtW3piRh1yI7A9eVlH7Csjw8WQFuQgS
         55Dw==
X-Gm-Message-State: ALoCoQmsU3NFkL0bNtv5tZYPIyGG6nTfsCvuURbSbH3BawY6BetFM8sgI/tI4fRcJuQNSQVKCJh+
X-Received: by 10.43.75.69 with SMTP id yz5mr43340716icb.90.1419874945843;
        Mon, 29 Dec 2014 09:42:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id f1sm15397474iga.1.2014.12.29.09.42.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 09:42:25 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <xmqqwq5ja7s2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261867>

This adds more explanation of why you want to have the --notes option
given to git format-patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Changes v2:
     * s/you are encouraged to/you may want to/
     * a stronger hint to use the git notes and then
       --notes for format-patch.

 Documentation/SubmittingPatches | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e3c942e..f42c607 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -177,7 +177,12 @@ message starts, you can put a "From: " line to name that person.
 You often want to add additional explanation about the patch,
 other than the commit message itself.  Place such "cover letter"
 material between the three dash lines and the diffstat. Git-notes
-can also be inserted using the `--notes` option.
+can also be inserted using the `--notes` option. If you are one
+of those developers who cannot write perfect code the first time
+and need multiple iterations of review and discussion, you may
+want to keep track of the changes between different versions of
+a patch using notes and then also use the `--notes` option when
+preparing the patch for submission.
 
 Do not attach the patch as a MIME attachment, compressed or not.
 Do not let your e-mail client send quoted-printable.  Do not let
-- 
2.2.1.62.g3f15098
