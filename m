From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 6/6] builtin/fetch.c: reduce scope of variable
Date: Wed, 29 Jan 2014 08:54:16 -0800
Message-ID: <1391014456-12493-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 17:54:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8YPB-0000dW-R4
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 17:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbaA2QyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 11:54:21 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:41364 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbaA2QyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 11:54:21 -0500
Received: by mail-pb0-f53.google.com with SMTP id md12so1950477pbc.26
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 08:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=y+wwMmKKDqWKlz6QidW9LWklJi5sJIrSqHCh6qVwMhg=;
        b=Ru+7ozFgbGgMxwDkbNVErKJpBPJPh4W2qG7h/gDQzGymNIsj6AN9noyCDWJcQUpnFP
         eIJ23CCbS1GMjbNVyCGa149CK8IHuvKPSjm+DXgcmToSs6io/phdSi0hhbGhECwrnObt
         R9/Z8IjJ/qgNCA8le4/OsHYpfkiLf3TjFq+o6etJXm2qvU+Oey/IGLnf1KXwnY48BwQP
         6+l1YZMo+CWV9rHFzd4wtpyuO9n6fdbTe5PrVbyx8ENe5cxKnaNjLqkSo8VhsMU2qk7h
         8DEohpPzuSBaDh8rR0GeeZEh4ffe2yahLVTohog0QDumeYvtS00O/6R2M4R3hxzGYUoB
         rlBw==
X-Received: by 10.67.5.131 with SMTP id cm3mr9102572pad.92.1391014460676;
        Wed, 29 Jan 2014 08:54:20 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id qq5sm8823465pbb.24.2014.01.29.08.54.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 08:54:20 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241214>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/fetch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 025bc3e..55f457c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1026,7 +1026,6 @@ static int fetch_multiple(struct string_list *list)
 
 static int fetch_one(struct remote *remote, int argc, const char **argv)
 {
-	int i;
 	static const char **refs = NULL;
 	struct refspec *refspec;
 	int ref_nr = 0;
@@ -1050,6 +1049,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 
 	if (argc > 0) {
 		int j = 0;
+		int i;
 		refs = xcalloc(argc + 1, sizeof(const char *));
 		for (i = 0; i < argc; i++) {
 			if (!strcmp(argv[i], "tag")) {
-- 
1.7.10.4
