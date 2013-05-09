From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] transport-helper: trivial style cleanup
Date: Wed,  8 May 2013 20:16:56 -0500
Message-ID: <1368062218-22440-3-git-send-email-felipe.contreras@gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:18:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFVN-0000py-I5
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab3EIBSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:18:39 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:60747 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab3EIBSd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:18:33 -0400
Received: by mail-ob0-f169.google.com with SMTP id tb18so2428224obb.0
        for <git@vger.kernel.org>; Wed, 08 May 2013 18:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=tuhvR4NLQ7HeS3Ovc8ceSEc+lJ2vWGdyWzPuU5wrpOQ=;
        b=Xa5K4dbWYc6OO3oUSFsfclwDxggQ0CMA0I0FGafq89p45wWE/FJhxTuVuO11hfYAE3
         6RQ1kLbnD+s7AYuwLUT0ZYS2Hyy4bbP3Y7N+IeyhIv6tYdPMttbh7L+xVPpOZ31PJXsd
         WDsn+xTS2TafQgLMlpSS/0JYyRKxcygVzcUaIRMoCEoXZjsR0B4zQt3mEyd/wFmIKo9z
         JMeMW275Ptgo8wU1HcCqNJfBHHKz8mYkHFsG4XaZcrjWYR+sV4Ou/d6IeTKo+eW58yU2
         mrlTBLDSKOgq3pM8PvpxtxeK0ywnSyS3H0fV9E6EsEAg9wef1K4jTmpjMhKmKPzTTN0s
         D/1A==
X-Received: by 10.182.47.196 with SMTP id f4mr3090220obn.31.1368062310890;
        Wed, 08 May 2013 18:18:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ri8sm1164605oeb.0.2013.05.08.18.18.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 18:18:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
In-Reply-To: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223696>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 835815f..522d791 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -214,9 +214,8 @@ static struct child_process *get_helper(struct transport *transport)
 		int i;
 		data->refspec_nr = refspec_nr;
 		data->refspecs = parse_fetch_refspec(refspec_nr, refspecs);
-		for (i = 0; i < refspec_nr; i++) {
+		for (i = 0; i < refspec_nr; i++)
 			free((char *)refspecs[i]);
-		}
 		free(refspecs);
 	}
 	strbuf_release(&buf);
-- 
1.8.3.rc1.553.gac13664
