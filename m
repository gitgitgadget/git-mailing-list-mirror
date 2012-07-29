From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 0/3] Small log simplifications
Date: Sun, 29 Jul 2012 16:25:33 -0700
Message-ID: <1343604336-7966-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 01:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvcsT-00047j-Rh
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 01:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab2G2XZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 19:25:57 -0400
Received: from mail-we0-f202.google.com ([74.125.82.202]:38273 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab2G2XZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 19:25:43 -0400
Received: by weyr1 with SMTP id r1so194631wey.1
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=YkphVkrcU63CEyjvOaujxC3tB4+tMVy2Sl/kxSXpMC4=;
        b=WhdE7NzQEFOJnZTDaPeQFM7bLPHCXvFT+LsFo4Jtd5zodG9RTFCdTA1mI4bG3Aj+43
         QBtBcpZ0ot/hicmpzumS3shB3jjwg1VhIoTAdD9EeqA6ALg0jjU5YuXAOUWNB1lJpgjf
         +J5qtROj9PiaC0tdPz0aaFmq2xK9Zo6Uh7tNTmF3UH7AQD/xSSreu9Yf1iB2QWg3/c75
         hMSGsQuVq6oi/WuCWLiWD6dLog5u1iCd5De+JDMSS1OZEzy1Sze58YnlIxvJDBIcjwjd
         a3oU3SChLoQhYogM+FZLB5S2jLUf32fJZPHvfvVG4zyDjzeCDfy+iPaliuktZ+Lproge
         3mEQ==
Received: by 10.14.211.196 with SMTP id w44mr7437478eeo.0.1343604342141;
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: by 10.14.211.196 with SMTP id w44mr7437475eeo.0.1343604342087;
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id 46si12593645eed.1.2012.07.29.16.25.42
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id E042820004E;
	Sun, 29 Jul 2012 16:25:41 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 09225C1A30; Sun, 29 Jul 2012 16:25:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
X-Gm-Message-State: ALoCoQltIDk1wq4KmES12nW6JLJEBuSn1jepegQ2NQ2FIubVHMrFJ8sTHdkr7iqvoiUtAFu9zyw/h/1dDXFx+LVCGEVubcQqDaRfVpWmAi3DV5ef25uB+LAr07ZR4UwkgKRzHuSadkWja8RdKALOVdwYzsAeNoVPTKWl0OtZGpswKmVgV0uGGFPsmOEh43BKU6CgT+fs3Sxe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202508>

Separated out the removal of the unused diff options into patch 2/3
and added the necessary max_parents=1 in patch 3/3.

Martin von Zweigbergk (3):
  remove unnecessary parameter from get_patch_ids()
  cherry: don't set ignored rev_info options
  log: remove redundant check for merge commit

 builtin/log.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

-- 
1.7.11.1.104.ge7b44f1
