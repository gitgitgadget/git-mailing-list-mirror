From: larsxschneider@gmail.com
Subject: [PATCH v1] git-p4: ignore P4 changelists that only touch files
Date: Sun, 20 Dec 2015 15:59:38 +0100
Message-ID: <1450623579-17013-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 15:59:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAfSi-0007Nh-Pm
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 15:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbbLTO7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 09:59:46 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36455 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbbLTO7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 09:59:43 -0500
Received: by mail-wm0-f47.google.com with SMTP id p187so40249148wmp.1
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 06:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JRHGGHRcLVfVMkWujokJ4LRMljOd+vLGgsqlXFsY0mE=;
        b=TfPrUNANbhJA/fhyfqYrleafD9yszEM7LV2yumNGa0L1YnUs22mMNkEGXunOyCm0HU
         JQvfSvlC8XRsf7HoKpDftxdoOmZSKyHkKSzEzCCy8NUEFtEJX1gqX6g+7h7mfTNrLhKe
         xOaLfrmxGxcxfORFwRVJR9s6ekTBU9vxRdNs4TKTFvy/YK/MUZvX17qclZyzIrBk3IgP
         yU7Wxe+ao4vVHXHP7ECVEw9AQZatxWlie5+6ddoEr0YB3TAaVzyBFdirOHSEvl6DTa2J
         iQV2QviZ4UBIBkej0KOWI8DGvxN7DmrMjcuDHY52iMLM8UOVDx2MNaRKi3YaIjyvvujL
         3jeA==
X-Received: by 10.28.49.65 with SMTP id x62mr15076121wmx.49.1450623582188;
        Sun, 20 Dec 2015 06:59:42 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA24E.dip0.t-ipconnect.de. [80.139.162.78])
        by smtp.gmail.com with ESMTPSA id xs9sm23830722wjc.43.2015.12.20.06.59.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Dec 2015 06:59:41 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282769>

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

this patch improves "git-p4: add option to keep empty commits" (4ae048e)
and therefore should be applied on master.

Thanks,
Lars

Lars Schneider (1):
  git-p4: ignore P4 changelists that only touch files

 git-p4.py                            | 54 ++++++++++++++++++++++++++++++++++--
 t/t9826-git-p4-keep-empty-commits.sh | 48 ++++++++++++++++++++++++++++++--
 2 files changed, 97 insertions(+), 5 deletions(-)

--
2.5.1
