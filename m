Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A57B11F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 21:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfACVEH (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 16:04:07 -0500
Received: from sonic316-24.consmr.mail.ne1.yahoo.com ([66.163.187.150]:39684
        "EHLO sonic316-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726356AbfACVEH (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Jan 2019 16:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1546549446; bh=c+QeGzkLqDfwUqtnnTEMPflRgldDJsHsKRau1jYPqSw=; h=From:To:Cc:Subject:Date:From:Subject; b=EWRQviULrIS/5bdBSbPLMyuBuTgA01O6u40gxF/iRNO+ARW7EeoXVNMPqZjw0/incQfUbLsNk3hgWWKO1zDqGmtuRMVKyRxuIuGvql61FWBgaD3J9TMusb4l9269N7dUIdJOfcEVnYVgYtQl/Qiw0ZHW/Insrhl+LXRts0UkoZ1lMQRkvRhuVLwLyy/yDSCpBeebYyDQb4Fp9NUidl6HPUzKNTRpA1tESLnVN6l5oJLvDbUEOzclSzxVIy4PbJaFqjBWD+V3/CsMMmd1EEXE5YhA+u7vbsjBFMA/mKOsPdkoQo/bmgnhg/jIob5Uu+Aw8PvEhQ8IIO/maPB25wnyYA==
X-YMail-OSG: BlNMZ7MVM1mj3eGsEEtL1LwO8dZWJUZSynscLChwNvMJEowXF0SAIccKPLx5vhm
 iUimhhbIChfWa6UEvEjvKZh2UjWl1fXDkXH.M_QCWbefC.AGKZkDy6d6LHCpstESDMByfevzX83Q
 uRrcqPAggM6sKL4GmDmUxqSRwqo5KphgmYmnYZTCX6ZAAGFQYerpW61pnUX7f9NJAOqiW.NMeZ9r
 XG0KCQH8taqYaq2DyNtX06jM3ufvTTB_nPp6CinjNZrv.QzDySdVVXDHBFebGm1LwwtRHhZwJ8Q7
 EoskpIsuMQNBFajGKJiOzAaLYWGe2qoaADLT8fSBofgqpftvWfhefykQtwzMq0APWVfMsalldiUa
 b4iPbfzJbr3p2WBQntSyork01USRdNAhI4yH3._VAEPpOaYwUJJqtZmvAr9nJcEHEoC1AESYMqMD
 bJDlkRlV2TO5h4Ecfn3P0fSl6xSPfHZSk9lhl7EVypMU5IoLdvBCkZTLiLEsaO0X.VO_fngb9CMo
 3N4LQnzFPZAjmnemx0.Swc_1FGcfxu2ZeAqoSEPUJScHhkiO5z8KJ5O0iT1h3Bi6OxV8FZIFwQLj
 ihojs5Q3uyXX859piIcgBje28Xd584anMDwCt.Bits_6FaHcNbFg2HxYZdCQbJF2r1YHiE795RfG
 XzT9.JaJPUaZ8gDHxWzwBEKbACW1ou55bWGeUlRb2rogUZSMY_f6UsDkG7JIkkQVF.d5EN4XUbBZ
 NiuXquRGf0HTZj.csol4RVBIGh387Tf8B.pVrrJzfRl.xhF9I3ZK8qlLW1Q5fLDrxKCBjUMKgqXq
 qJwLTbFxBeZ5yy1y.Xy1uADIae8pEeBWuBpKavUJe59F7Ib1RFiqVnX1NlnfU_wCyoZzRsLuwP0W
 M5BLgSIbA43W5o0r3Bauv0pS_RksdFEwbVPXcuQD3uqDfSAq4IOWkrNtnyx7vVk6V5doDDnz1iZC
 jPXs9wCRoS5940qwXvm_8RnvrCbXf3xuRhzrGsloOZ7t8XB0Cov_OIyrwAW_innTOWiRvHShM_a2
 yZdKk7JeT7kbhxaI0g4QXV82siGcCeCZ9PoXXZzhec8Hz3_I7EIoa1qe8dxAtjw3Qg.069.XJqew
 FIJAhjwO7l9xrYs0ouGEfsH.jw8UuqCEo
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Jan 2019 21:04:06 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID be612531d29230a92e273a46c8c0f700;
          Thu, 03 Jan 2019 21:04:04 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: [Patch v5 0/4] HPE NonStop Port Commits
Date:   Thu,  3 Jan 2019 16:03:47 -0500
Message-Id: <20190103210351.13920-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <randall.becker@nexbridge.ca>

This set of patches is a distilled version of the minimal
set of changes to git that will allow it to run as client
and server on HPE NonStop NSE and NSX systems. NSR systems
are no longer under support so references to them have
been removed. Each patch in this set is independent but
required for correctness.

Randall S. Becker (4):
  transport-helper: use xread instead of read
  config.mak.uname: support for modern HPE NonStop config.
  git-compat-util.h: add FLOSS headers for HPE NonStop
  compat/regex/regcomp.c: define intptr_t and uintptr_t on NonStop

 compat/regex/regcomp.c |  8 ++++++++
 config.mak.uname       | 29 +++++++++++++++++++++++------
 git-compat-util.h      | 11 +++++++++++
 transport-helper.c     |  5 ++---
 4 files changed, 44 insertions(+), 9 deletions(-)

-- 
2.12.3

