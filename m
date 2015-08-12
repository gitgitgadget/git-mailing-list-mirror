From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] Fixup hv/documentation
Date: Wed, 12 Aug 2015 12:13:57 -0700
Message-ID: <1439406838-6290-2-git-send-email-sbeller@google.com>
References: <1439406838-6290-1-git-send-email-sbeller@google.com>
Cc: hvoigt@hvoigt.net, git@vger.kernel.org, jens.lehmann@web.de,
	jrnieder@gmail.com, peff@peff.net, wking@tremily.us,
	sunshine@sunshineco.com, karsten.blees@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 12 21:14:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPbTY-0001tI-EH
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 21:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbbHLTOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 15:14:07 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33224 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbbHLTOF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 15:14:05 -0400
Received: by pabyb7 with SMTP id yb7so20360128pab.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BSBRz6FS5WAwM5ecudgl5k2xtRPQGxmBnrn6rA86m58=;
        b=R1Jy+pHe9D9MQUG1UiNIzefXUSdgZT0I+oEiDTM1poymFDgvmKHUG6lVWQHilyTF2Z
         yDSq/5WPgo/b/pLtzBMCzk+AaKy3i3OCpg1xC6tN0bTmCm/ERTFNdzVwdkYTne82DfDg
         Rx3862f6e5ehJOg261olcUtFIuppAZaFG2Wxi5svm1faQ8hjITU3qxLMLoSC3UYK5T9+
         R8uXz5bbF5aVh0+J+NuG+sIpDhiIVtC3FNMjHy4achwt9oipb8rNHQV2Z9K+XHXqBq7S
         JAUtiEjbaqOZC37B9qVUJsjO5D/92JKOh6dUPZcHXk6NBohsULHSFN+hroHWsUk4r368
         tULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BSBRz6FS5WAwM5ecudgl5k2xtRPQGxmBnrn6rA86m58=;
        b=hDXg+gvb/4Q2L9r14bOBNWZo2If8E0p92xnkF8c6WIUmnh56Fs8FFu1tdj2MrT6CJo
         eHgtTbrJx/bs3nnyUDeyF/gW7kwOXw0/u9sjlM+ITrAU8AV7x0ewarAYEFm7j/fZBRBM
         kDRSvUw+mHwckfxX4vLGuYzpqcMkb8OLf49+W1LO2YFuTyg26BQN8B0i4WVXtHaG3CBV
         YPVelFdOAXivClwLiTA3y0F5v1K55OQnWr613Kb0WOAzt5jEsjROsmj81OsvKDtTJF+H
         0OM052f6BvyBfWSWdxBD305L8RhwqEppOzoERj4im8c/I7jkjpbJgWj9Xije+UWayQmq
         7B7w==
X-Gm-Message-State: ALoCoQkjgAWeOkRf4H0W0gpbyr2dQFrrUefg6clVnnvLLBcEJnLRRmcWomRXunURbrIWqtfBH3yD
X-Received: by 10.68.218.136 with SMTP id pg8mr70417947pbc.169.1439406844660;
        Wed, 12 Aug 2015 12:14:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:d1d0:bd1:5138:d709])
        by smtp.gmail.com with ESMTPSA id fl6sm7380111pab.12.2015.08.12.12.14.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 12:14:04 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.234.gefc8a62
In-Reply-To: <1439406838-6290-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275799>

If you want to look up by name, use `submodule_from_name` instead.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-submodule-config.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 2ea520a..941fa17 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -49,8 +49,7 @@ Functions
 
 `const struct submodule *submodule_from_path(const unsigned char *commit_sha1, const char *path)`::
 
-	Lookup values for one submodule by its commit_sha1 and path or
-	name.
+	Lookup values for one submodule by its commit_sha1 and path.
 
 `const struct submodule *submodule_from_name(const unsigned char *commit_sha1, const char *name)`::
 
-- 
2.5.0.234.gefc8a62
