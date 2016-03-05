From: Dinesh Polathula <dpdineshp2@gmail.com>
Subject: [PATCH] Allow "-" as a short-hand for "@{-1}" for branch deletion
Date: Sat,  5 Mar 2016 13:09:05 +0530
Message-ID: <1457163546-11970-1-git-send-email-dpdineshp2@gmail.com>
Cc: Dinesh <dpdineshp2@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 08:39:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac6o8-0003Zy-HE
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 08:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbcCEHjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 02:39:19 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35330 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbcCEHjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 02:39:18 -0500
Received: by mail-pa0-f45.google.com with SMTP id bj10so47866980pad.2
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 23:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vMc6p+3CTe+DJit/QQ5IWFzK1xrpYeX1jZmeLcYccoM=;
        b=avbH9Da2WDedY01fNcpfue8Rqywll5CN3wsVyU8aYW90Am7XioKg1Aslez3QxT0BMZ
         v4jCEZ9swtZc4W2fr9AArcQpOpNXs8OEnpI7zv/ijqx/9/8qr17evvNjq/iSxPLeBha8
         Jxz10L4Gx7n58SCzcYn9kYbKVj9J1bxb121KoPobXKCA6Eh/XO/xXun8+4JemEXT4Hw0
         oirhXHPgQJMYnbCllyBqyIrnPMgp73LcAn2DuB/PdOLArfs9XPUU4NxBP5oZj0muhrNJ
         6+iadUz/6coi1SSJO38Lyi+Zp4fT8oGKcWSaA67C4Tki3OyRMtcJIdeaPzqhKWo/Qe7Q
         DNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vMc6p+3CTe+DJit/QQ5IWFzK1xrpYeX1jZmeLcYccoM=;
        b=extVqqdUXXoOiitwEKgSWAN3JWWZJSVXHEJEtgxLu2+tolfI8hHcHX8AkBiGsQ1knK
         1/Ucfwm5aM/weKzzJIEczvfHeYCZeVviYt2MDXuu7XeSYn40PH/x6SH+eziTrk+Jifnb
         W7Y2S+pmdU+LZwWXahPLybxTl+DB/BeUSlMBnYgxwkGITW9fCFw1yi5Z7zf0qqWlCsjp
         /pdIyfrq/oMGnPT3DQ91c51FrlMWQWF8vTRzmuMD1lI4q6k5BKHzTli41qPsEtXLw7Mh
         e9EnyX2mNiTjP/RUCUDbBE3wKbHaz3KzspG3l83SvnXIP7qbc3qPmLubzv8bOe3xKphJ
         H3CA==
X-Gm-Message-State: AD7BkJK0DwxcCNO7OR9sKpwYvGHIuOeN6/l+NAHtYYfBOxSddL44t5IDRviLy+HjQb0y4A==
X-Received: by 10.66.150.170 with SMTP id uj10mr17924305pab.91.1457163557952;
        Fri, 04 Mar 2016 23:39:17 -0800 (PST)
Received: from dinesh-pc.local.lan ([175.111.137.132])
        by smtp.gmail.com with ESMTPSA id fk9sm10225772pad.9.2016.03.04.23.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 23:39:17 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288300>

From: Dinesh <dpdineshp2@gmail.com>

***
This patch allows the usage of "-" as a short-hand for "@{-1}" in "git branch -d @{-1}".

Note : This is a microproject that is part of the Google Summer of Code application process.
I am interested in working on the git Beginner mode implementation as part of Google Summer of Code. The mentor details for this particular project are not available on the Ideas page. The mentors are likely on this mailing list, so I request the mentors to drop me a mail so I can get in contact with you to further discuss the git Beginner mode project.
***

Dinesh (1):
  branch.c: Allow "-" as a short-hand for "@{-1}" in "git branch -d
    @{-1}"

 builtin/branch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.8.0.rc0
