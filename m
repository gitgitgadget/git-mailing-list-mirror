From: larsxschneider@gmail.com
Subject: [PATCH v1 0/2] git-p4: Fix tests on OS X
Date: Mon, 12 Oct 2015 10:03:02 -0700
Message-ID: <1444669384-85419-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 19:03:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlgVG-0004hL-RW
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 19:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbbJLRDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 13:03:10 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33082 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbbJLRDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 13:03:09 -0400
Received: by wicge5 with SMTP id ge5so25697051wic.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=opLW2K04zzErUkyqhCqC3syJNPRtqAXZ6H13seNVDWs=;
        b=gpnWDF4z7nXNiI2UotEn39b35gNxiOSw7WDXM4KOb8XcbT79+g00RpzDML1PmNAyRo
         w2YF4WLpaQtafctbcHfmTcuCBuqSgB/HqglUNgIcEhpDnEx1tV351DVHpfTTmYdgUQY+
         clRrTL4Ju/Fj9Unl3W7GRbIe0DLctwrd2szdTgkEnOGWuanKjjwNb6dSwxUvhzW4OHVR
         ZvNYkrElN/NroLuNoyz9X7TSqzAPNOCekC6v9CjbB7Dj6Hioy0S43OJZiKkKLLbWSXPG
         x/V5r1NAvhX9HZn2b6rJ+vIcpq2OjoEAeTZuppvjKP/14iJ8Olam1kpr36PqmnYcNOR0
         36Rg==
X-Received: by 10.180.36.212 with SMTP id s20mr16083720wij.14.1444669388667;
        Mon, 12 Oct 2015 10:03:08 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsk-nat-ip12.autodesk.com. [132.188.71.12])
        by smtp.gmail.com with ESMTPSA id ka10sm20913697wjc.30.2015.10.12.10.03.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 10:03:08 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279383>

From: Lars Schneider <larsxschneider@gmail.com>

I extracted this patch series from "[PATCH v3 0/3] Add Travis CI support" as
suggested by Junio.

Thanks,
Lars

Lars Schneider (2):
  git-p4: Improve test case portability for t9815 git-p4-submit-fail
  git-p4: Skip t9819 test case on case insensitive file systems

 t/t9815-git-p4-submit-fail.sh  | 7 ++-----
 t/t9819-git-p4-case-folding.sh | 6 ++++++
 2 files changed, 8 insertions(+), 5 deletions(-)

--
2.5.1
