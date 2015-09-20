From: larsxschneider@gmail.com
Subject: [PATCH v3 0/2] git-p4: handle "Translation of file content failed"
Date: Sun, 20 Sep 2015 18:22:09 +0200
Message-ID: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 18:22:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdhNb-0000Zt-Rt
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 18:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbbITQWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 12:22:15 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33276 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbbITQWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 12:22:14 -0400
Received: by wiclk2 with SMTP id lk2so117491848wic.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eOW5+0mPA36qRPO8bPmt73mLqrQStORKE5dY09+aag0=;
        b=swFWCH/CfecTI/tClzfQQG3EEsArj5nIDVEY3YvXEx+ZMuZOUbAfA/4iEYLcU7aTD4
         rtghbnVNDEYTBlVjNpYPEDhaiU9VC+XIfq2ialBT3yryQ/Zz9/KFOUD7lvT+FTTV3WAY
         v4/PfLMgFBXiY+ezzODQjzna62FcOQCYUB8S+mclsfozXg0pdPpcrXINdq6GXlV9Ovws
         w9fNn7eQ7HaF/XDgiucJ3D6nZWKD1sLStmmoP6T3QA/6jYQSn5IrrnEdqojkd+hbKw34
         AhOfTnoKhWKJocRT7eW4/u3pj+LcOagyHKD12KGi+UYLzq2Ik6RSZUa657YwF9uu1zsM
         mAUQ==
X-Received: by 10.180.86.136 with SMTP id p8mr8632852wiz.52.1442766133451;
        Sun, 20 Sep 2015 09:22:13 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-188-106-098-135.188.106.pools.vodafone-ip.de. [188.106.98.135])
        by smtp.gmail.com with ESMTPSA id nf15sm9018570wic.22.2015.09.20.09.22.12
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 09:22:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278245>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v2:
* remove Perl calls for printing characters (Thanks Torsten!)
* remove whitespaces after ">" (Thanks Torsten!)
* add test case to show that the fix is not working for non "--verbose" mode (Thanks Luke!)
* add P4 knowledge base link with detailed error description to commit message (Thanks Luke!)
* remove unnecessary .gitattributes file in test data

Cheers,
Lars

Lars Schneider (2):
  git-p4: add test case for "Translation of file content failed" error
  git-p4: handle "Translation of file content failed"

 git-p4.py                                  | 27 +++++++++-------
 t/t9824-git-p4-handle-utf16-without-bom.sh | 49 ++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 11 deletions(-)
 create mode 100755 t/t9824-git-p4-handle-utf16-without-bom.sh

--
2.5.1
