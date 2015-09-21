From: larsxschneider@gmail.com
Subject: [PATCH v3] git-p4: use replacement character for non UTF-8 characters in paths
Date: Mon, 21 Sep 2015 10:49:17 +0200
Message-ID: <1442825358-90294-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 10:49:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdwms-0003hm-1z
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 10:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756197AbbIUItV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 04:49:21 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36604 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171AbbIUItV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 04:49:21 -0400
Received: by wicgb1 with SMTP id gb1so104467986wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=GBEeJ21ZwzQLvlmapJJejPhREQsJoCtgcLEVoG/t3Vc=;
        b=Q5cBXZTJdAPi5p7RbnEE8YX7wNIZ0fk6yUh9uos3n3g/2Rd8QaCoDDnVjGSKJmzV8G
         nMuRie76aRg3ND8VNLzrpdv45d8q6yo0dH/Ka2VwtVpHBCG63T/NHPqd6YjXmVjUsbo3
         TAEVlHJviuYnDuTCnwuitzfqNL9WlEw5gENHslRO8dpxQKUIHXzwy/tvuHZ300ulWlzf
         92s5eJmnLGDCBc9QiAYcvcLjN4gdlNXq8DT6l/nqy2FdOOz0p5rQ+Gu3YaTRsTeu8C5o
         uTxP4Ef0jm+enO1SKvzll4dug/nNTc6UaqCGbJnaPlYy21D2ivGoX/3+trrmDGB58emS
         j4mw==
X-Received: by 10.180.107.195 with SMTP id he3mr12490343wib.35.1442825360191;
        Mon, 21 Sep 2015 01:49:20 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id gt4sm12280148wib.21.2015.09.21.01.49.19
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 01:49:19 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278288>

From: Lars Schneider <larsxschneider@gmail.com>

I broke a test in "[PATCH v2] git-p4: improve path encoding verbose output" on the next branch.
This patch on top of next (3dd15c0) fixes the issue.

Thanks to Luke for finding the issue!

Cheers,
Lars

Lars Schneider (1):
  git-p4: use replacement character for non UTF-8 characters in paths

 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.5.1
