Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CBD020A40
	for <e@80x24.org>; Mon,  4 Dec 2017 09:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbdLDJKl (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 04:10:41 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:41391 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753551AbdLDJKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 04:10:37 -0500
Received: by mail-it0-f42.google.com with SMTP id x28so11072026ita.0
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 01:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MQn32LVcX2xd+Ll383b9ULxCNSfc6zWNimNBxZchx04=;
        b=PZnxIBhtMOeQLhWiEEMVv2YnbhoqLjsch6lgmpzXdGa8Pdj+QPeiwKo1rHdGNl1Qob
         3WLAMBb4hYuiryJFahSALmX2gRxu7W/LMqlYW6T1AqejJO6ytNmnnWdXKDmkwvJQloYj
         3aRqj0svdoQtR27suFcIJJuQJxs7F0jX1Y8QCNuvamGPjUwjutB/AMyJExig8iz5WivA
         DtjDSI9H/3InST+RoVmbNC9GbR+H1mqDwUZM/v0PNZs1BOt0KK3O7kOtAhwocJcB5V0X
         6cuCmCbfJwXA87jc668Tq4KwOOddWQF/mBFQOFA9OBZ/M2xuNaG9bxEsv1Qx89poAUYj
         JHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MQn32LVcX2xd+Ll383b9ULxCNSfc6zWNimNBxZchx04=;
        b=ODlphaZqKXtWBNFkmGIu8CcrorciB/e9SdWRsV3ulzK9M0UaFKJ1incdSdRY260jvY
         5x0mWnxRC6H7euO/6M7Ij4NV+w8aBQFI0YBMrc7Wy6LGrlUq6kK5+rdkXhzkCC5GaQQa
         9s63YLep87SrLQeNsX029rGPioY0JIRucLzMIpnGyhNg0FtE0Mgx22iYrjYAPqNp/wF/
         vIRdLehyvTQZlmtRbp20Qzjdxx1KW0iy+OTxhxdDCuDcbZivYS2gNgnZGrw5Xl19dBgO
         ei4atXcxJ4lwtSxQkSM89S7KPU8w28y8tsU0bE6SEkK7C3lzlW1rnYixXc1TRLI1vTWP
         AVpA==
X-Gm-Message-State: AKGB3mL1/4/fHoyBIPgRM1AKuXF8gtA3VpOm/0QrzQtDX3SkxxGacsXI
        Jev3aRcKXkyDMOVuipiqqOKd3nuc1M0u4CoDyNysMA==
X-Google-Smtp-Source: AGs4zMbUwiRQ0SLP+yY8lJIygd0g6AM1NwRigkmGVnxLnQVJGvI4GAxWWnywPspvW2J8YA50xSGRAitPHblZlhU7NMM=
X-Received: by 10.107.12.81 with SMTP id w78mr1689111ioi.148.1512378636832;
 Mon, 04 Dec 2017 01:10:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.119.11 with HTTP; Mon, 4 Dec 2017 01:10:16 -0800 (PST)
From:   Amandeep Gautam <amandeepgautam5@gmail.com>
Date:   Mon, 4 Dec 2017 01:10:16 -0800
Message-ID: <CAEZzL1CfXn-XXMG-CFNpZL0B-Rq2r1JoD9gWxHOUR25z_zt+VA@mail.gmail.com>
Subject: git-completion.bash: Show list of local branches instead of refs for
 git checkout
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
    I am using git-completion.bash and when I try to checkout a branch
by typing git checkout on the prompt, I get the following:

FETCH_HEAD FETCH ORIG_FETCH

Will it not be more useful if the list of local branches is populated?
If it seems like a good idea I will be willing to submit a patch.

Regards,
Aman
