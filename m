From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/5] remote: trivial style cleanup
Date: Tue, 28 May 2013 07:54:27 -0500
Message-ID: <1369745671-22418-2-git-send-email-felipe.contreras@gmail.com>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 14:56:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJRy-00014X-QY
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 14:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933928Ab3E1M4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 08:56:18 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:62978 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933886Ab3E1M4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 08:56:17 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so9056503obc.12
        for <git@vger.kernel.org>; Tue, 28 May 2013 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gJJESPcStu1gP0CJCdg9FT/xk1QflElW/ilISrPhXGs=;
        b=dcaMVvzWsWtZ7Hu6iS2Ywi3sV0wAECGsW30Fi7dM4LCCVD0g4I85sz4GL1TEqTeyCP
         qFq6OkfKB16Velm6b9KtmA/JmUzX2fGKBBFe1EF7vzzIW4QWnuPbWvR9YqvWZCgRFBdH
         BK2SJqZ063tdjpIsmJgop+ag2TgMd6RHPaEx+aJnxlM1xLADgLbw/g4c+wF5qLmBKgjX
         QCBv6d1utAUbanxqu3jjrXYIYMbnfFS7yVBoN/sxfQEXEll8CJ6A5nMeY2IAEMf29CoP
         l0ERnwp5eXxAoNXvPGMXzICOtcIwLRl5Y2uH79boVy8dleLoHRRPbt0mqZK0hoxK3lXR
         ikig==
X-Received: by 10.182.105.101 with SMTP id gl5mr2455315obb.15.1369745776908;
        Tue, 28 May 2013 05:56:16 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zn5sm34462833obc.10.2013.05.28.05.56.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 05:56:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225634>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 remote.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 68eb99b..e71f66d 100644
--- a/remote.c
+++ b/remote.c
@@ -1474,8 +1474,7 @@ struct branch *branch_get(const char *name)
 		ret->remote = remote_get(ret->remote_name);
 		if (ret->merge_nr) {
 			int i;
-			ret->merge = xcalloc(sizeof(*ret->merge),
-					     ret->merge_nr);
+			ret->merge = xcalloc(ret->merge_nr, sizeof(*ret->merge));
 			for (i = 0; i < ret->merge_nr; i++) {
 				ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
 				ret->merge[i]->src = xstrdup(ret->merge_name[i]);
-- 
1.8.3.rc3.312.g47657de
