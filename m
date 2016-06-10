From: Peter Colberg <peter@colberg.org>
Subject: [PATCH v2] Fix spelling of "occurred"
Date: Fri, 10 Jun 2016 15:05:26 -0400
Message-ID: <1465585526-32187-1-git-send-email-peter@colberg.org>
References: <CAFZEwPMgYCau=LxdtjZ2WVJXp91mXYG5bc=0X0mo_eJ+eYqLHA@mail.gmail.com>
Cc: git@vger.kernel.org, Peter Colberg <peter@colberg.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 10 21:06:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBRlD-00053e-0n
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 21:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbcFJTGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 15:06:23 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:53379 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbcFJTGW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 15:06:22 -0400
Received: from [144.76.164.56] (helo=pleione.colberg.org)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <peter@colberg.org>)
	id 1bBRl4-0007PI-6V; Fri, 10 Jun 2016 21:06:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=colberg.org;
	s=20160215; t=1465585577;
	bh=amb0kpw4s5RNu1N53nYKN4SOE/ofqZD1oOzbddIIMfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:From:To:
	 Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	b=O1/MWDJ0NDL3xxNm5+3tALOkhvm7cUQJRpV6TdQ/tsIPa7pRMOoO55llB/3L7eScT
	 qid10FXPTvBcn9JG6/602tUzpCdr+T3q3G3FytUe+gmpe5O7ow30wb3rrGT1zcgmf4
	 sLN9bsqWVInW9uwrZ3Zjw1nk0Xi42wgrj08hj1Yu8a7GhPqQW+BzMi//NOki08Bllf
	 ModskFuBT/3JVLXJ96WjMuCtigy/GhtfU8LaY4rsTbvW/bXwJtqvI4aSGZcAGtKvqu
	 4L0lJYFhUUZaGTx5FPVjRzzV6FNj216WQ6jg546u/dU3zJ+lZwgMaG5CGEyW5ZZsy9
	 60ivkTEp6/8bA==
X-Mailer: git-send-email 2.8.1
In-Reply-To: <CAFZEwPMgYCau=LxdtjZ2WVJXp91mXYG5bc=0X0mo_eJ+eYqLHA@mail.gmail.com>
X-Df-Sender: MTAwMjE5OA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297018>

Signed-off-by: Peter Colberg <peter@colberg.org>
---
 config.c | 2 +-
 refs.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index f51c56b..d7ce34b 100644
--- a/config.c
+++ b/config.c
@@ -1281,7 +1281,7 @@ static void git_config_raw(config_fn_t fn, void *data)
 		 * something went really wrong and we should stop
 		 * immediately.
 		 */
-		die(_("unknown error occured while reading the configuration files"));
+		die(_("unknown error occurred while reading the configuration files"));
 }
 
 static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
diff --git a/refs.h b/refs.h
index 9230d47..56089d5 100644
--- a/refs.h
+++ b/refs.h
@@ -345,7 +345,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  *     msg -- a message describing the change (for the reflog).
  *
  *     err -- a strbuf for receiving a description of any error that
- *         might have occured.
+ *         might have occurred.
  *
  * The functions make internal copies of refname and msg, so the
  * caller retains ownership of these parameters.
-- 
2.8.1
