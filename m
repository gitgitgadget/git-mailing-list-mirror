Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247631F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 18:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbeKWEkj (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 23:40:39 -0500
Received: from mout.web.de ([212.227.15.14]:44901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbeKWEkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 23:40:39 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmLOE-1fq0DZ1pFS-00a0wC; Thu, 22
 Nov 2018 18:59:55 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     carenas@gmail.com, git@jeffhostetler.com, newren@gmail.com,
        pawelparuzel95@gmail.com, pclouds@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v1 1/1] t5601-99: Enable colliding file detection for MINGW
Date:   Thu, 22 Nov 2018 18:59:52 +0100
Message-Id: <20181122175952.25663-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
In-Reply-To: <20181120162853.22441-1-pclouds@gmail.com>
References: <20181120162853.22441-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FQ8yYqzLNCreqRbkzf4N2KCii+JEb/7FZKKkdTb30HKBkcIPMFE
 kwtIEV1jugtjcfbirZoQv3xDhyrJqg3i2yj5/LVPll45uSjbn3atNFZiuBPA2Cvgft0bo2x
 3VAdUWzUeGRH5iC07cmsn5GoJv26LPxQK617TVGTpymziR231iHrmCK9DwbLHO4lLsCXxjJ
 zh+kQCzXICUribB9kEdQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kspfqgQCKFs=:9YEDu/dEPHRDLxcjPUg83W
 OrFx1wQHwTOYUyvXUY53RCV95gyrdFPM5Adl/rhqUd0I14T2juYA/uYGmGEwNMGEJ56grKLlu
 ismplHRDXCQv6UnyTcRFKq/ohudvwrY/GDuZz1Ve/lGxb34toClOZHOCLTOypsVUa/LClV3P4
 gdBtct/Br6YWPU1u1EOLC3LQ/9wW6ozBfdXMV+T+ioiJGkgNCuvoNkleTvcz5Jd9P2V3+sBFy
 SBkuu9rijJBLIL5wdNiNRO00HZ1LC21bT42Fn8pVq4uWjXji5iYmlUnTQdO1pTLRyXB52nS1U
 AzHLJMKHXtsNnjuFeob0/OQkAfSrKCUdSq/525ty928ZvrAquuK2uQhXVbww4PNbAvxQNinMY
 ua81RQSyaiQk9j/na8hT4yvOQv4F0iLK6ZpJMSPisTX3T0Leq1T2mKPepE5esQmcXIm329QEp
 Ffo86OxE1dM5cP1bykvX95Zn7ZEs+aTv6Jy8A7avlJFuChSVnx7EBPLdflLSpThf5qoCBSuq5
 D+JctJ9eW2pwaY/KzBMtE2etH+3/64yaUkavD2yQZxGlnAsMjjZyxUb3NAWq0bchPOIQqwAch
 89ZF1dGJAHwKP52K31fj7PKAkosXZJYFH4UXDJ2o3RM4IDuvAFzrRmoeDVNyF72GNLG3H2fl3
 Gkhja7N+fEp6+aKKyC3PuwBTz8ghxBmNbybLeQGUosXGx6UkOGkD8PSrHofSbgxrpXEoQcG5/
 BuJxSyqi3g94T0ey7MvziI0TaD2e8sqW+PUXiGE88lBTg7UO4jvKyE4okufzoMTLwipjYm6vc
 XByebYskRCcz56HYYodURuQ0gLGa9O57Ibp8NqEoCPs3qfClMuvUzwyZdrV8/g1L8NIkAkhU/
 tUNxngqQhG5jDv7USYq038j31LEoIIWWP5QkyZohmvbPXIhJg7IUmqFybxfUWl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Commit b878579ae7 (clone: report duplicate entries on case-insensitive
filesystems - 2018-08-17) adds a warning to user when cloning a repo
with case-sensitive file names on a case-insensitive file system.

This test has never been enabled for MINGW.
It had been working since day 1, but I forget to report that to the
author.
Enable it after a re-test.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

The other day, I wanted to test Duys patch -
under MINGW - to see if the problem is catch(ed)
but hehe git am failed to apply - not a big desaster,
because is is already in master
Here is a follow-up, end we can end the match


 t/t5601-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index c28d51bd59..8bbc7068ac 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -628,7 +628,7 @@ test_expect_success 'clone on case-insensitive fs' '
 	)
 '
 
-test_expect_success !MINGW,CASE_INSENSITIVE_FS 'colliding file detection' '
+test_expect_success CASE_INSENSITIVE_FS 'colliding file detection' '
 	grep X icasefs/warning &&
 	grep x icasefs/warning &&
 	test_i18ngrep "the following paths have collided" icasefs/warning
-- 
2.19.0.271.gfe8321ec05

