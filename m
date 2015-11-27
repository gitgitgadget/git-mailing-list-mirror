From: larsxschneider@gmail.com
Subject: [PATCH v8] Add Travis CI support
Date: Fri, 27 Nov 2015 10:23:26 +0100
Message-ID: <1448616207-45035-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 10:23:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2FFj-0001aL-Gj
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 10:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbbK0JXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 04:23:34 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35137 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbbK0JXc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 04:23:32 -0500
Received: by wmuu63 with SMTP id u63so47885567wmu.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2015 01:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yGjGIZ6fRkPNVdRladrMih6D4KEbgf5KSHlC2fvtiyk=;
        b=Obukm8minVY9X6WtLSqnQfknwCbBgUxU++chOMKR4L2RRmba5jKBJnur92NA9DIleU
         wH/HcZZjTKu9i/SyQJmDCAaDUi6KQieQ/Z4nJwull5aYgyXEA8cURh91pgYaiRla9sgd
         gAcBMJiBcDeSKD5fjZqAMVRfRgEYXQFtxEH1gTayWkzBPPFkc+ViLWtVT6GyJW0Vl8r7
         SZRQkcCqNsuDMesxpspl8sHs9E8Z6Xzr/keD+XxcvzKccxDXkPRleWEvuGaqeGLe7bAi
         kNZYHej4mERT4tGCFmZS4n3vHitebS4KOgMWJqTKVBrxUGbZYM4i8P029h79yjXZGjn9
         8xjw==
X-Received: by 10.28.148.147 with SMTP id w141mr9687671wmd.14.1448616211471;
        Fri, 27 Nov 2015 01:23:31 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB75CD.dip0.t-ipconnect.de. [93.219.117.205])
        by smtp.gmail.com with ESMTPSA id q77sm6520832wmd.22.2015.11.27.01.23.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Nov 2015 01:23:30 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281771>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v7:
* remove NO_GETTEXT patch and install gettext on OS X to compile with
  no additional flags (thanks Torsten)
* fix P4 version (15.2 is the latest one available)

Thanks,
Lars

Lars Schneider (1):
  Add Travis CI support

 .travis.yml | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 .travis.yml

--
2.5.1
