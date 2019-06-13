Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3F71F462
	for <e@80x24.org>; Thu, 13 Jun 2019 18:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfFMSx3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 14:53:29 -0400
Received: from sonic301-35.consmr.mail.ne1.yahoo.com ([66.163.184.204]:38322
        "EHLO sonic301-35.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727224AbfFMSx3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jun 2019 14:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1560452008; bh=NuUrHl7AtUCqqq1w2+ev6fOsuItU2bE1OFPEtuqa7kw=; h=From:To:Cc:Subject:Date:From:Subject; b=nvyE9svxbzaAG1s75Iaobv8haydqw3xVsXqWsYR7yYxLlUdFpT5AUreZxUwfbOzoMXn7/RqPK4Sh6cZxU3dWSTMA1JQ49P6iHJseVGWahOzc+2ut/5O078UFtXwgxWHGUo4glKRlyGw8SbED8SCd8DNhh09hD2DdN1FCU2XY0HQ1/mqU4etrfyd/T1c5MjPPFm5DgUvByTh+VGpllUO3rYfIyIaok3ZGNsUMTSJDyXozwgRkTNvGRoKxyDuhzEJEmH9J0tCUnKnlC5yvBry2Dmr90VkABxyd/pAx3jNwtLKAZlUqFx1AHfmrRYnf3BQ5qUAIogWz+IAzYALgIVVA+w==
X-YMail-OSG: k6iXi4EVM1noibW70ot0sPozuR6QMZbbSyCPyj9962j.2s_FaDTCE05pCyESlyn
 AHM4OJDoUYUHcCd.OoAVmJ2gpqdG2t2higIj.BknJuBVi3InfLDNLakVTEDZbHLsYv.OCu9LI3SH
 JocUpIBEyBCI.ZqxMPmDqYJnu9ZBRUeXqTvWIivvYpu7Xc._Oh8GVJQ9Nm5sCzlx5Wt9W_jfnjqs
 yX6lou9vK_C5qzv1YEn3ywSsDxo_XTZolcXnKUJLv2oEsE0xNshCyxSRsW6o8c8DBPadvBzMjYmf
 vtthMVOkkREKtECXILsIN2kfIqItOIGhTnp3SHTuXKx_F2gVUpUArHjnLdMU1_s3G8JJSlRLioSj
 rC0GSOaQ80gr4aZRFBCAHfmd0riYMYkQXXJV2bJY7HZsjOLD8xG7w_yzm9NbM6FiXte_KAYAdU2k
 FT9t8d.R_fFPvq5pFFtK9uHQHJug8Ph92BsT1pKM0PFVYByNSkK1L6zDs2OZ1y_o_WfdUbpjoS0f
 _BUexRRbmV81pxwAJrhRyCjNcqjNblDq6Z4OBLCKPgmZmJ5Mz1wU77alcjL19VcgzLVvd7YVzNPb
 rNzEdOyQtuOfp0PRwbTBJbhkBD2oB2sf_zKw1gCaqOtqAXAmBypDBG_zVuCbZzmhtsUtFGSKEhsn
 4W_DJF15nwrMBuvcC1T4KnNNbrUoqXZCa4JPhA46_ZSeP4HJElVgDeRmRAsZ9j3gh77VMlOwxjJk
 IPKur5UBPZgiUDTPytDEb7bS.FbU83uGdRZ8irIEO0IIY0dEGbw2SxJ4Adv9uFVqoQwYcySv5_tC
 KecImFJPElGWjD1lib4IAP79._PBPpjD8MZ2wdH742pobQWYlg_pO9267_HHhM73L6DSvMnZH5qM
 DoU1SKhVG0YgKcNvdEbWAouJbwueFAVFjkHoiaVqmgq6OTA9UBano3NlTBF868_bvA6Ft8uPO3pp
 ZgXG1GO1aFgG._t5w6EXuQG6oaoJ_bT8dhuQ9sgHFajaQJcHqCDWNvR_5og51AV8gXq99JuFTcEI
 AIAfT4F6th358uTCkXV1knamQ6tS6C.JX1ZAHamwfFyhInrjlVNtKDvTUYYXB93bJ8Eq3b_LNOX1
 TEzwInPWKxFoBGelAxtvVft6WIJGcA_4CLXglWy5JQAGoPcFPJ2Whvjxn4yA.WuO_jJ86v90NKRG
 8mhddzeGvsWf9L.9k8Bl4CyPUN96u7aWChUldoggcY.llWHitddROt8wpaqmcLYP2cy95XkybPLe
 d2RUXozFODjXdU2KHwo55DNrzC1zy2nIgWBU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Jun 2019 18:53:28 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0df5561e6e714d6e0f0f0c310b112dc6;
          Thu, 13 Jun 2019 18:53:25 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 0/5] Add exclusions for tests requiring cvs where cvs is not installed
Date:   Thu, 13 Jun 2019 14:53:08 -0400
Message-Id: <20190613185313.16120-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

t9600 to t9604 currently depend on cvs to function correctly, otherwise
all of those tests fail. This patch follows an existing pattern of
from the t9400 series by attempting to run cvs without arguments,
which succeeds if installed, and skipping the test if the command
fails.

Randall S. Becker (5):
  t9600-cvsimport: exclude test if cvs is not installed
  t9601-cvsimport-vendor-branch: exclude test if cvs is not installed
  t9602-cvsimport-branches-tags: exclude test if cvs is not installed
  t9603-cvsimport-patchsets: exclude test if cvs is not installed
  t9604-cvsimport-timestamps: exclude test if cvs is not installed

 t/t9600-cvsimport.sh               | 7 +++++++
 t/t9601-cvsimport-vendor-branch.sh | 8 ++++++++
 t/t9602-cvsimport-branches-tags.sh | 7 +++++++
 t/t9603-cvsimport-patchsets.sh     | 7 +++++++
 t/t9604-cvsimport-timestamps.sh    | 7 +++++++
 5 files changed, 36 insertions(+)

-- 
2.22.0

