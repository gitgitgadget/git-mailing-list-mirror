From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 01/10] Documentation/git-clone: mention progress in -v
Date: Wed, 24 Feb 2010 20:50:20 +0800
Message-ID: <1267015829-5344-2-git-send-email-rctay89@gmail.com>
References: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@googlemail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:50:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkGha-00058b-5l
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 13:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798Ab0BXMus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 07:50:48 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:64550 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0BXMuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 07:50:46 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so338835qyk.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=r4XfCn+UUIiWtRG2KFSwWUy9IQSGr03WRKlTYearGFk=;
        b=Rp4zAbOJ1qnyXd1wANqlhkqs6+yvFI6BcC3CIxtDS4xQca0lCyo+YpW3g5G85hcq/D
         Kbj0IxldLTupGN+7Q5N+kuTol+wIP9zExbLluhT/1e6x0nRETS+KtAqfI9yucR/u+XK/
         uJW6j8NClX6p0ULXrRMyLW2J7zbnpccvIt8RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vieQX6DWNn0ORuAErsip3SgaygKNW9gJrIi4OV3lrbUHNAIxO6/a0kgVuWB5tp/z99
         Fz3JYlzs1DbD3gB3Q1gLuNiub1/i+XhJSZ80+f8F7K+fxdXoCI59qtQJ22Mur1eR2WWD
         xQzPyEXIHPFzW2ouy0PhDHPqDRt8HYvKr41JQ=
Received: by 10.229.189.79 with SMTP id dd15mr477614qcb.3.1267015846447;
        Wed, 24 Feb 2010 04:50:46 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 23sm253680qyk.15.2010.02.24.04.50.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 04:50:46 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140930>

After 5a518ad (clone: use --progress to force progress reporting),
-v/--verbose did not affect whether progress status was reported to
stderr, and users accustomed to using -v to do so since 21188b1
(Implement git clone -v) may be confused.

Mitigate such risks by stating -v does not affect progress in the
documentation.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

New in v2.

This should have been done with 5a518ad (clone: use --progress to
force progress reporting), as per Miklos's suggestion
(<20091227012032.GE25474@genesis.frugalware.org>).

 Documentation/git-clone.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 88ea624..75b9848 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -102,7 +102,8 @@ objects from the source repository into a pack in the cloned repository.

 --verbose::
 -v::
-	Run verbosely.
+	Run verbosely. Does not affect the reporting of progress status
+	to the standard error stream.

 --progress::
 	Progress status is reported on the standard error stream
--
1.7.0.20.gcb44ed
