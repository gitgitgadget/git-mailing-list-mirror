From: larsxschneider@gmail.com
Subject: [PATCH v7] git-p4: add config git-p4.pathEncoding
Date: Mon, 14 Sep 2015 19:10:39 +0200
Message-ID: <1442250640-93838-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 19:10:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXHF-0000nx-EI
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbbINRKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 13:10:44 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34558 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbbINRKo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:10:44 -0400
Received: by wicfx3 with SMTP id fx3so149233100wic.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2t9ns6x7yMBDb/uCO9ujcgm28LQZSgMgx8DBVSGg/ew=;
        b=ADJZlBSVWDAepy4neqWKWL2/oEUGC31P5tfzY7yhklpOk77HY4aUCSFDO2XEOu+Cx7
         6A5gBbBRNlG0v3P9RWxeKHmCLcn9jK0vv03HqBf8TePaMB/6HdN59KFpa2we0Aqyg9/3
         cdLJj2Wgbg3WuK/P3qxKukScijvUpGOPpQHeN8tLLalSDzju67TzuKA7qZ6dzncNJJr/
         2UlMC82e35sW0KQTo5wFwUNZjIfGNJX5q0jw4hqDKu3ZrOkBEzvDUcCMWveHSGIfOKZk
         I5ZL1gGV1oo7Tb7RS6A5HbrHAqo1SCV2I80VmDoxOIeGbCx8K7qaVVCbOZEb7Z2X/sfj
         f6EQ==
X-Received: by 10.180.85.74 with SMTP id f10mr27492818wiz.45.1442250642885;
        Mon, 14 Sep 2015 10:10:42 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qc4sm2276533wjc.33.2015.09.14.10.10.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Sep 2015 10:10:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277841>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v6:
* Always print the encoded path in verbose mode.

v6 is already on next (a9e383). This patch must be applied on next.
Is this the right way to handle this situation?

Thanks,
Lars

Lars Schneider (1):
  git-p4: improve path encoding verbose output

 git-p4.py | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--
2.5.1
