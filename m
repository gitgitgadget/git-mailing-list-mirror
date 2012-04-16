From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v3 7/7] t4052: Adjust --stat output for minimum graph_width
Date: Mon, 16 Apr 2012 03:44:55 -0700
Message-ID: <1334573095-32286-8-git-send-email-lucian.poston@gmail.com>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 12:48:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjTY-000100-Ps
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab2DPKrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 06:47:49 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:36457 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab2DPKrs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 06:47:48 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so6755901dak.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8MiNGsFEksxslojSdYvlf2MmfT1OWRRgtkEWZ4K200Q=;
        b=tZLvE7Pz4UGy9RVInh0uzMKgaiCgsaO6uqo6xy5f/Jyyaj3sHw59StV/Z0a3mgGRT+
         mndib4me6sQB8SgO/AXMr3iBMJbq/KyjzL8aN8VfA6Qh7bhRdWSXff5DTnC8/E8jv5gv
         Zp5pb4jJ9fbEBTvNP5CZzF9RB36ijcwTfaUxZ5Kl8vwY+39nrbuB8O9PCgf+tylP4AH8
         HBFFT0ASKeOZcGNftmThJmW03D7uVOM1zPPOoRL2JGsCiMvRYz4NDFN0/Q7cDlamPPB4
         3UE1X8dLK7Et6LDLG0WZmopzRBd60dgc/IVTP4HRgcnm3xUdypoqkNfnSXcVfnbUKoPn
         H9qA==
Received: by 10.68.221.136 with SMTP id qe8mr27505353pbc.108.1334573267957;
        Mon, 16 Apr 2012 03:47:47 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id oh2sm10793051pbb.45.2012.04.16.03.47.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 03:47:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195618>


Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 t/t4052-stat-output.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 6cac95b..ced32db 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -285,10 +285,10 @@ respects expect200 log -1 --stat
 EOF
 
 cat >expect1 <<'EOF'
- ...aaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ ...aaaaaaa | 1000 ++++++
 EOF
 cat >expect1-graph <<'EOF'
-|  ...aaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+|  ...aaaaaaa | 1000 ++++++
 EOF
 while read verb expect cmd args
 do
-- 
1.7.3.4
