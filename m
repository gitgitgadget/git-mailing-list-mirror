Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BAEC1F453
	for <e@80x24.org>; Sat,  9 Feb 2019 18:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfBIS7r (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 13:59:47 -0500
Received: from sonic307-6.consmr.mail.bf2.yahoo.com ([74.6.134.45]:42656 "EHLO
        sonic307-6.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbfBIS7q (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Feb 2019 13:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549738785; bh=6y2XNLXt7pA+Gu51VECKOpzzvk0RanG28MKOg0j6EDs=; h=From:To:Cc:Subject:Date:From:Subject; b=fNdP+LWojrg1hsoIgEAZL2YTDMLaE9khQKkwzLZReASEwE9XLt742utuoABxe3q8Es4P+Le0t9itXu/zSc57rErdaZxYdivTRsSx1D5UoW9bdtTY3VO5MtQXjxF+W9K200mf02/eJbOWXC4PvLpZejvGLZ7l+0ta2WILmBGTqNQ4KxhCJbW/xc2y1QC1xVnF0IOj98kSL74r6VeE9YJOriRatpfY3nI+zSabolXJhUfSBzF4bAicrR4Ejwpe9brXXE9bXsD4n882ZIPUfXTH2xgwjlRbHaY2zKL1Vr7EKRonchb/1UpaDRjOWrARuMNyZTQuIinJtMB2cAjsNpXxNw==
X-YMail-OSG: Ys6EptAVM1nN.Rh_FuSG9yB4Zr2g5giCxvXz1Hu.gOIQLhyjSBweO0vbpBBjK8x
 VWW2Iv3ByQ8DrSqx7yRddfUGwqNJ_U9rjMSYQ4gITJz1BMf6Wcv2yCMFYQRei_qweZUhrk5sV3xt
 aq2yjsmUWB08lg0ngyqByu_xKoUkhP9CpqOGYMJwjZ4Cg.yi_OJBITY6VJW5hiIHGytn9yJooVu4
 ICuheEVpnGbXGTNPR136H.v0M3e8oSCxV_Iyg_5ZVhG2v1Tn_eiaDAyubh7zYUdYbw1m80CGbj5Y
 oGjMDKq47hegt3MGymVJdu1pWQ84uXS8WRYxAknITX7qOc2uq7KDiAMKSgF9KLrVBtJrmhM0Zz74
 F3GVgo1iw2SiIasXmSdqgILNNdig8z1_nYSgFyDOJmlkZbDk6TwWkE4f7.va7uYerGXeqODC3QoB
 z.bbcusZBlcF3wi4F9rjw.44NDBKHs4gpzynVDoYrjhXMOsRLwxzwo9NwGh2UfGW97UZv_5T2AUL
 1o51Acz9w2jpu.OzuxeG2dAP4EKnpMUN3qpXEPHVJNbDssh4jss27nJiyS4fL9T77wJ6_perSkhT
 uTfH9mIZU1fh1At1FG4bvuCqH4k2lFFfBi3G2xQUUmQ9Nyrx_yqfSH8OLdvBdarUrjzxr4ZNlu4k
 oUkcv7kYsEdEU7_c.0SrGNX_LToE7okgO_.kK_Wt18aa7TqalWQd2n_gCXfPqJYUVCcGZhQ2ilKL
 E82GjgdfXkdVAA0aQvELIfL8mEEGQFRDEM0jXW4M13EmFPzuChvMRsUZQkSdhQCPkg5Wqas4aOBB
 47UeK5BN6aoIG3d9pqUZWZdTX.WFxMUIUQJreZvKfQ27ZIh0lGeCITDjnYaOsdOI.bkeWtaH1.kV
 dYJdOB8C0M6afncOjRxqxD5iZCiUX5qvo6EKKCBdNf_lubh3v5ruRt3QFnu4CJ1.iTfsUYCHNt_A
 tlxCQ6CsDLjgzBQgGlABTgC9M5N4nFuuV7BS0Q0JyespEWLmoOJ2KFY_jdyh4E7vgF0ppFFa68r9
 .fI4Jp9sLDrlJQsZcltXpXJhNAD5Mdf2fQaSKMJ4yCV9tIeN4LqiM9wb9h33M9sUjNujEP38DmZm
 CGt2QwbQ2gqQ_eg3y5uo9vsV_qQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Sat, 9 Feb 2019 18:59:45 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 84a16d171cb60baba1591047a4493b27;
          Sat, 09 Feb 2019 18:59:42 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: [Patch v1 0/3] 2.21.0-rc0 test fixes resulting from use of /dev/zero
Date:   Sat,  9 Feb 2019 13:59:27 -0500
Message-Id: <20190209185930.5256-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <randall.becker@nexbridge.ca>

This is a candidate packages of fixes to remove dependence on /dev/zero
and replaces it with the generate_zero_bytes function in test-lib-functions.sh

Randall S. Becker (3):
  test-lib-functions.sh: add generate_zero_bytes function
  t5318: replace use of /dev/zero with generate_zero_bytes
  t5562: replace /dev/zero with a pipe from generate_zero_bytes

 t/t5318-commit-graph.sh                |  2 +-
 t/t5562-http-backend-content-length.sh |  4 ++--
 t/test-lib-functions.sh                | 13 +++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.12.3

