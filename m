From: larsxschneider@gmail.com
Subject: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue,  1 Sep 2015 00:10:25 +0200
Message-ID: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, gitster@pobox.com, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 00:10:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWXHh-00067D-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 00:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbbHaWKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 18:10:32 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38830 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbbHaWKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 18:10:31 -0400
Received: by wiclp12 with SMTP id lp12so12087998wic.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3jYLXwbE/8kcyM5nWM0M45NcyO7YHdUeB605w9hkZU8=;
        b=CZXrWrLO4aBjGkOxw3941M8hC3lKsPfjb0jHE7HbAa4f1NbaRAcXHSCofISn0iaczV
         MnaLpViG/JNml/J8dxbYYRdT3MH21cfIoL2dkMynMIkUqRTQlnslD4MdgzaD6dhTp8gW
         7omyBrK4UBBMnD1B2yK9iSLnoAujF5zcqwkA3MUWJkKPX+1b5Hjy3R1ojXHkJFz4CPLK
         CEV0p0FqtNrROi0/73gWmjsR43Lvd9R3YHPQMQUuzw9uYvs0nkM4VbmjkWNuLwczxHuD
         dnZt2C4XMep3C/CCz+E9DSaNiaP9AVAOhEp1tiJvBGcqj3bi2D/KYrOdKUBOTQc5T5gj
         AGYA==
X-Received: by 10.194.90.70 with SMTP id bu6mr29816365wjb.149.1441059030686;
        Mon, 31 Aug 2015 15:10:30 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id x6sm719903wiy.6.2015.08.31.15.10.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2015 15:10:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276950>

From: Lars Schneider <larsxschneider@gmail.com>

Diff to v2:
* remove comment
* use "core.quotepath false" to simplify test case

Unit test passed on OS X and Linux. The unit test did also pass on v2 as "printf $(git ls-files) >actual" removes the LF.

Cheers,
Lars

Lars Schneider (1):
  git-p4: add "--path-encoding" option

 Documentation/git-p4.txt        |  5 +++++
 git-p4.py                       |  6 ++++++
 t/t9821-git-p4-path-encoding.sh | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 t/t9821-git-p4-path-encoding.sh

--
1.9.5 (Apple Git-50.3)
