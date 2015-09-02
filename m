From: larsxschneider@gmail.com
Subject: [PATCH v4] git-p4: add config git-p4.pathEncoding
Date: Wed,  2 Sep 2015 16:57:32 +0200
Message-ID: <1441205853-52065-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: luke@diamand.org, gitster@pobox.com, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 16:57:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX9Tt-0003kK-E8
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 16:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbbIBO5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 10:57:41 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36005 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311AbbIBO5k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 10:57:40 -0400
Received: by wibz8 with SMTP id z8so69071170wib.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=bgKVWwuqVAGtBjY4oTnwoVNzJHrl/8DXFbcSOJDDGD0=;
        b=UV5nlYf4PV45G6teJQWXFNT8RmeDLgNI8RAn7Zd6CxDEzpF8SO3EG8hAPCg+DgTBhv
         uG0sn/8vnKjElwGNN2eKJtCYYGc4s+QalctvTa4sJS5GreCDN1zYtP/pOlgR+pywuAdh
         h6rb9FpYNlppcHsREZW3AFo40UKLaJsv3sMA2DtsXLdv2XEElV7Ej+EygKp9QkWcRpp3
         DWqC7vK62dx9HybcNKbkaLSLIKjQ/sZmCfR45v5eRI3gh65Z408jOz5dXii4IDnGxdMD
         SVGOLLqJCv4zzFRWl9B1qFnKrV7zWRMTcTsPLV2RroKdjKzG9lv+wUV2E+RthSbNdyzZ
         MaNQ==
X-Received: by 10.180.188.49 with SMTP id fx17mr4651516wic.74.1441205859507;
        Wed, 02 Sep 2015 07:57:39 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id ej6sm3990789wid.24.2015.09.02.07.57.36
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 07:57:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277091>

From: Lars Schneider <larsxschneider@gmail.com>

Diff to v3:
* add proper commit message
* remove command line option "--path-encoding" and add config "git-p4.pathEncoding"
* change TC number to 9822
* escape UTF-8 characters in TC
* change test encoding used in TC from cp1251 to ISO-8859-1
* use static ISO-8859-1 encoded string in TC
* check content of test file used in TC
* shorten core.quotepath usage

Thanks to Torsten and Junio for feedback!

Cheers,
Lars

Lars Schneider (1):
  git-p4: add config git-p4.pathEncoding

 Documentation/git-p4.txt        |  7 +++++
 git-p4.py                       |  3 ++
 t/t9822-git-p4-path-encoding.sh | 65 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100755 t/t9822-git-p4-path-encoding.sh

--
1.9.5 (Apple Git-50.3)
