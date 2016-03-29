From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/6] t7407: make expectation as clear as possible
Date: Tue, 29 Mar 2016 16:02:38 -0700
Message-ID: <1459292558-5840-7-git-send-email-sbeller@google.com>
References: <1459292558-5840-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 01:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al2f7-0000Wh-7v
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758325AbcC2XCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:02:54 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33497 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758249AbcC2XCw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:02:52 -0400
Received: by mail-pa0-f42.google.com with SMTP id zm5so25059003pac.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 16:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5WlY4YMfirRtBJVhZcdmoCO6m4fDW+LOi4REHzC8Ukw=;
        b=b9vg1FJrygmU+NaR0boSjFXynAop/TTVvkrnt2J+mH79HHtdOOB65pwrLitGtnNLX+
         pcXtRNFjinkq8lyZ1uidtGHatBzBO91hjU9dGIY3NZ437hRd5Ni/BFkKzxN1tdYJ4CS/
         x6SGw3LbMKPxE9qBD2ahjrNEYh1c/hsLLyZ5c75uhFbjGUWFPlHG3kQvanc/EH6GRfhD
         6IrEYxR7DzBi4hY3RjC3bbQbEenP7S2bswvCL4jFf/iG7rYjbkcmncb322yRn3IjBtIT
         eAJTAwXx63Ij/BS0s3yqlAmcuMsmxVSL44JNF6F6eYlMFhlAcOunUQZaVm01175ZD1IT
         X3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5WlY4YMfirRtBJVhZcdmoCO6m4fDW+LOi4REHzC8Ukw=;
        b=L4hg6lPdTG2mswuMQ+AtmhDBh1aO7RFMZlunmqNa8uNXnkTZ3irxxdsEiOfr7jzjoF
         7//44+DP6pMLlJKCsx/9s66+/VrMUexwR7B8hIcfR7izZf4RBZ9+Lb1wzpwkEfWU4IkH
         GQEc4S5kzBiueQng34ZN8Py7gcfRtKtjKBS0pjb6ggRhi+L25+NFqMXOqB1ByaILslDT
         lo38CU+Gn5/n+ovuTpDU4FWa9rL6+UNE5RLstv/tTbAjwvU8Og5UbGx6/MsdCVQ9GQH7
         i6v+sjqHH3gppSLJGtdmJBsi414YFxYDV5AniP0peyZX92tKqWS/ME+Dm47LNlVnUPAG
         yEPw==
X-Gm-Message-State: AD7BkJK+Yga4SuwBxftqHvaaHaoFac7HypjR/QBZlU4OHkdQyk51Jh9qtwXcg1TZApE6diiO
X-Received: by 10.66.55.39 with SMTP id o7mr7451217pap.13.1459292571970;
        Tue, 29 Mar 2016 16:02:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id u21sm747706pfa.60.2016.03.29.16.02.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 16:02:51 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g3d0b0ba
In-Reply-To: <1459292558-5840-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290216>

Not everyone (including me) grasps the sed expression in a split second as
they would grasp the 4 lines printed as is.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7407-submodule-foreach.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 4b35e12..6ba5daf 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -262,8 +262,12 @@ test_expect_success 'test "status --recursive"' '
 	test_cmp expect actual
 '
 
-sed -e "/nested2 /s/.*/+$nested2sha1 nested1\/nested2 (file2~1)/;/sub[1-3]/d" < expect > expect2
-mv -f expect2 expect
+cat > expect <<EOF
+ $nested1sha1 nested1 (heads/master)
++$nested2sha1 nested1/nested2 (file2~1)
+ $nested3sha1 nested1/nested2/nested3 (heads/master)
+ $submodulesha1 nested1/nested2/nested3/submodule (heads/master)
+EOF
 
 test_expect_success 'ensure "status --cached --recursive" preserves the --cached flag' '
 	(
-- 
2.8.0.6.g3d0b0ba
