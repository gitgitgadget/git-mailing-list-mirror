From: =?UTF-8?q?Mihai=20Capot=C4=83?= <mihai@mihaic.ro>
Subject: [PATCH v2] Fixed typo in git-pull manual
Date: Wed, 27 Mar 2013 18:05:56 +0100
Message-ID: <1364403956-20443-1-git-send-email-mihai@mihaic.ro>
References: <7vmwtoomav.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 18:06:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKto4-00043J-1B
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab3C0RGH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Mar 2013 13:06:07 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:39279 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab3C0RGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:06:06 -0400
Received: by mail-we0-f177.google.com with SMTP id o45so2585309wer.8
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 10:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=TAHYPE6YzD5X/46TSrF9mmQtrk3VbPTU6vArYSE86CE=;
        b=BTqjNTd1LhuLwAGfLh3f4G3+fODqq3y3RbsWX1YTrI8xmQKRoOZcVL2IMfJKpnshAE
         rwMJcO7rC48rq0snwFfym6GgCq1YpsZEnLZXN7yWIfZc47qkpqCS4ayTp0ikEaMuQE8L
         xICFc7783eZKfc5d9NJb6gTymhoOjE6/cKSLckmXn1Q8Xw6zhfh13Y/WJhIIKeqltRPp
         3ZRofM6PXV0DCyoWJtC3bfyihHeIkhXuDzx9k5wKkro0Hh4+IFG9BoZBKMJpMs/JUg4h
         lJVjKxPYWXcunYF2BAN72Xf5f2LkCnsHrG/edLdAZ/Q8tZJfJYk8A9Sn8tYu2xGjGLF7
         p17w==
X-Received: by 10.180.79.6 with SMTP id f6mr10998735wix.26.1364403964171;
        Wed, 27 Mar 2013 10:06:04 -0700 (PDT)
Received: from dutier.st.ewi.tudelft.nl (dutier.st.ewi.tudelft.nl. [130.161.159.51])
        by mx.google.com with ESMTPS id f1sm10901769wib.0.2013.03.27.10.06.02
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 10:06:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vmwtoomav.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmU2POTQ9bBRaeq9QL/MPbYOQNQbXqzk0jaAeHPF7tMiDzuLjwOYn25hoH56fvVaEAJSvt/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219279>

Signed-off-by: Mihai Capot=C4=83 <mihai@mihaic.ro>
---
 Documentation/git-pull.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c975743..24ab07a 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -218,7 +218,7 @@ $ git merge origin/next
 ------------------------------------------------
=20
=20
-If you tried a pull which resulted in a complex conflicts and
+If you tried a pull which resulted in complex conflicts and
 would want to start over, you can recover with 'git reset'.
=20
=20
--=20
1.7.9.5
