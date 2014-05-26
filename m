From: Caleb Thompson <cjaysson@gmail.com>
Subject: [PATCH v3 2/5] commit test: Change $PWD to $(pwd)
Date: Mon, 26 May 2014 13:56:23 -0500
Message-ID: <1401130586-93105-3-git-send-email-caleb@calebthompson.io>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 20:57:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp04w-0001UC-5h
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 20:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbaEZS4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 14:56:44 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63509 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbaEZS4m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 14:56:42 -0400
Received: by mail-ie0-f179.google.com with SMTP id rd18so7722352iec.24
        for <git@vger.kernel.org>; Mon, 26 May 2014 11:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kv8M0QAp6mjUaw7w/nw73sIWB7yzAccQhqDmZ2gsSpo=;
        b=E0s/IeFCWvjRfwIc+2480D4PbfhCZRBTW0Jpp10bcbAs9JTLVh1PxPZl0QEfrd4Net
         46waFQ1KsB5fDewhLrZE4sH2PaKaZzoaWzJwf2N8Z67e6nSCK7SdTNYdlBZ46JwF/uaY
         2ml8UuNrkTE+XaorGI31a/r+95lsB+uj2wsIoirszCnZzUNffC+noGBWStmRzIc7nQtG
         4KA3RQ4klEqu2doeJwRvcaDCId1yefMDTKl0V5AgGy7hKTYV2AR7k/FgPHTLgxQ4gvOb
         OTUwWQmaOhMMXfdxLWmieOcSCwjguzBdUJjYJwtbUCNgNfcJN3aCcT80Iko+Se0izsUn
         482w==
X-Received: by 10.42.119.1 with SMTP id z1mr13315530icq.16.1401130601994;
        Mon, 26 May 2014 11:56:41 -0700 (PDT)
Received: from sirius.att.net (107-216-44-113.lightspeed.austtx.sbcglobal.net. [107.216.44.113])
        by mx.google.com with ESMTPSA id ql7sm1708857igc.19.2014.05.26.11.56.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 11:56:41 -0700 (PDT)
X-Google-Original-From: Caleb Thompson <caleb@calebthompson.io>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250113>

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 t/t7507-commit-verbose.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 6d778ed..3b06d73 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -8,7 +8,7 @@ cat >check-for-diff <<EOF
 exec grep '^diff --git' "\$1"
 EOF
 chmod +x check-for-diff
-test_set_editor "$PWD/check-for-diff"
+test_set_editor "$(pwd)/check-for-diff"
 
 cat >message <<'EOF'
 subject
-- 
1.9.3
