Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDEBC64ED6
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 01:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBXBg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 20:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBXBg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 20:36:57 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 085F43B229
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 17:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yzGoY
        X8aGnZtDofS+6dTix6zv6tdxD1/A3vnYgqLApg=; b=Hhius7c/Z63IZ7gHBGxGL
        L9hlD65YdsRP0n7LlMTtEe6zd4ElOyu9RkNTG8NLo4xf0Py4YNdpefUhSaViehQ2
        xdFW52uqCuKxPtmOeuwQs8xxWZiZBR6GlDKeUKPcghnUWnAZ48P1gGlJ061pvoZ7
        FFYpaVpDOvCz/ZXZd8+Gxg=
Received: from zy-X550VX.. (unknown [183.255.48.209])
        by smtp19 (Coremail) with SMTP id R9xpCgB3LvuyFPhj_w4HFQ--.50957S4;
        Fri, 24 Feb 2023 09:36:52 +0800 (CST)
From:   Zhang Yi <18994118902@163.com>
To:     git@vger.kernel.org
Cc:     v.garg.work@gmail.com, Zhang Yi <18994118902@163.com>
Subject: [GSOC] [PATCH v2 0/3] t9700:moderizen test scripts
Date:   Fri, 24 Feb 2023 09:34:10 +0800
Message-Id: <20230224013413.1969003-1-18994118902@163.com>
X-Mailer: git-send-email 2.29.0-rc0
In-Reply-To: <CADupsJPpZnjA=Pu_RZZZXy7Titj3UD7ppww48KvcHHHbrGx=rw@mail.gmail.com>
References: <CADupsJPpZnjA=Pu_RZZZXy7Titj3UD7ppww48KvcHHHbrGx=rw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: R9xpCgB3LvuyFPhj_w4HFQ--.50957S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw48tryUCw1UCFW7KF4DJwb_yoWxCrb_Ga
        97tFyDCrWUJF18tFyfCrs0qFWUJ3yDCFy7JF1Utw4UZ34fXF1rCFyDGrWfZF10qF1kZ34F
        yw1kAr18JwsYqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUbzuWDUUUUU==
X-Originating-IP: [183.255.48.209]
X-CM-SenderInfo: zprymmqurrmmmqsbiqqrwthudrp/1tbiYxQg-laEN1oiyQAAs9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The style of t9700-perl-git.sh is old.There are 3 things need improve:
* A title is not on the same line with test_expect_success command.Need to combine them.
* A test body is indented by whitespaces.Need to replace whitespaces by TAB
* There are whitespaces after redirect operators.Need to delete whitespaces.

---
Thanks for all suggestions.Here are so many interesting things to learn.

Zhang Yi (3):
  t9700:fix title style
  t9700:change indents to TAB
  t9700:delete whitespaces after redirect operators

 t/t9700-perl-git.sh | 61 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

-- 
2.29.0-rc0

