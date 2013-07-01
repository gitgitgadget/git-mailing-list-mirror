From: Andrew Pimlott <andrew@pimlott.net>
Subject: [PATCH] t7500: fix flipped actual/expect
Date: Mon,  1 Jul 2013 09:20:36 -0700
Message-ID: <1372695636-10768-2-git-send-email-andrew@pimlott.net>
References: <1372695636-10768-1-git-send-email-andrew@pimlott.net>
Cc: Andrew Pimlott <andrew@pimlott.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 01 18:21:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utgqs-0002gG-QJ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 18:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab3GAQVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 12:21:14 -0400
Received: from pimlott.net ([72.249.23.100]:52920 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753455Ab3GAQVN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 12:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=dS0eKjw/2nbDmzkJZpREO5aFeHpq7dPiKjWe/1jwpFc=;
	b=Ip9MXLDp2bnLiUoAF6m1/n9VdWhTplQhFsXa2Lkdr5fWdBEFXeZ08EbnOrZO9zXitV2IcrPrBNtOvvQ6BNrbz4yvUVzlCj1SdAzAenpgaLQ90rTGNvdBU2G68U5P64QVCopLm9jGXYh3cLy5qYR5ayuJakZP4o87I3BmwVuP0RY=;
Received: from c-71-198-212-229.hsd1.ca.comcast.net ([71.198.212.229] helo=oinkpad.pimlott.net)
	by fugue.pimlott.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1Utgqm-0004Gw-HP; Mon, 01 Jul 2013 09:21:12 -0700
Received: from andrew by oinkpad.pimlott.net with local (Exim 4.80)
	(envelope-from <andrew@pimlott.net>)
	id 1Utgqg-0002oP-9N; Mon, 01 Jul 2013 16:21:06 +0000
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1372695636-10768-1-git-send-email-andrew@pimlott.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229306>


Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
---
 t/t7500-commit.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 436b7b6..e166ac8 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -13,8 +13,8 @@ commit_msg_is () {
 	expect=commit_msg_is.expect
 	actual=commit_msg_is.actual
 
-	printf "%s" "$(git log --pretty=format:%s%b -1)" >$expect &&
-	printf "%s" "$1" >$actual &&
+	printf "%s" "$(git log --pretty=format:%s%b -1)" >$actual &&
+	printf "%s" "$1" >$expect &&
 	test_i18ncmp $expect $actual
 }
 
-- 
1.7.10.4
