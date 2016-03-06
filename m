From: Dinesh Polathula <dpdineshp2@gmail.com>
Subject: [PATCH] Allow "-" as a short-hand for "@{-1}" in "git branch -d @{-1}"
Date: Sun,  6 Mar 2016 18:18:13 +0530
Message-ID: <1457268494-8394-1-git-send-email-dpdineshp2@gmail.com>
Cc: Dinesh <dpdineshp2@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:48:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acY6m-0003j3-Db
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbcCFMsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:48:21 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34427 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbcCFMsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:48:20 -0500
Received: by mail-pa0-f50.google.com with SMTP id fy10so62063139pac.1
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9mCbbdZcmW2kyPuDjmrylBkDpnzkpyO2xjkJw5CT7P8=;
        b=Lrc7Zy3sO6dH7V/k+ZgnA8gBm67ckjVhw9pCrzF6PBUWlSdmR1ctEdEnipOsiSNEDC
         1BT7oGEm3uvX3ck+YRX3ByMC5zjbXwrbbB3YLS46ZeDtS2EmTmDhGh5OuYBAjiWaIT1W
         jxzO+RpRgYvNPCUiVUuh0hCfTHp6YAxx7stGRgc4Hk+JVqdy51KB8NXxnRdFuYCRcsXF
         C2wiE0sMe4mHSh/pChJd1awLdwhpNRi0AXOWbDKX/Iw7oC8he/RCLcvAdOqpU8M0Typc
         So4ELip3v5yLBuOKv3bnHA8WvT59+Jig+SVaUsA07nU1uOM5YTozkFOnmfPD/lGtCcQq
         UE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9mCbbdZcmW2kyPuDjmrylBkDpnzkpyO2xjkJw5CT7P8=;
        b=GCVkBlZtI2iIpdp5ZIgTP57oQqbABd0JQPozMBk90OhcH2DNHHpIy8Oz4elPIHwTf4
         mE9e6Neg+teOn10RV0fN8f79IBVlKvku8+GVPfa9ppFCNbr7TfjY0L3ogFztP5qKbu/n
         2bIgplCLkeos3LrhY7hPkaaH/KvPiKtnN9ekMmKlLcL2Dcd6mX6AoULS1v/OYj+HhqBU
         pBd69DsI8J+HmiWkqKQtzLlidfBMQqo8rzl+87/Of9HKnPnsl2tIiigkuGx36C4QOkYF
         HZS9tHJK/Fcjku5L+jRiJznMoArEUtSjhQxEp9AH21+zcCdGQfE8h7PRikn7f78rZYgk
         HL8A==
X-Gm-Message-State: AD7BkJITZjv/nnXCYcF/Y5KrNTmw6LDxSvrP7tZA4snUd8BoPl/3J4S2AqKoEtTe432N7A==
X-Received: by 10.66.131.69 with SMTP id ok5mr26004949pab.96.1457268499897;
        Sun, 06 Mar 2016 04:48:19 -0800 (PST)
Received: from dinesh-pc.local.lan ([61.3.12.28])
        by smtp.gmail.com with ESMTPSA id v7sm17691453pfa.80.2016.03.06.04.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:48:19 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288358>

From: Dinesh <dpdineshp2@gmail.com>

This patch allows the usage of "-" as a short-hand for "@{-1}" in 
"git branch -d  <at> {-1}".

Note : This is a microproject that is part of the Google Summer of 
Code application process.
I am interested in working on the git Beginner mode implementation as 
part of Google Summer of Code. The mentor details for this particular 
project are not available on the Ideas page. The mentors are likely on 
this mailing list, so I request the mentors to drop me a mail so I can 
get in contact with you to further discuss the git Beginner mode project.

Dinesh (1):
  Allow "-" as a short-hand for "@{-1}" in "git branch -d @{-1}"

 builtin/branch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.8.0.rc0
