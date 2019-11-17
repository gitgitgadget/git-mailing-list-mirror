Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 314A41F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 00:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKQAzW (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 19:55:22 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45858 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKQAzW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 19:55:22 -0500
Received: by mail-wr1-f52.google.com with SMTP id z10so15295608wrs.12
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 16:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KBtFcgJTam6w7I13Dtf3kIZZxEh43M51mPh+owBn5nI=;
        b=mXryWmoOpl2M7ynSZxdBcnyb4E9N4cOgMkWdAqoesgK11ac0U86DC91fpBrIN2EiH7
         hny6BcFKE2a5hpETP2mCY9Vl2IRRLHYgeI4FmMumZ//LCJakLGE76Jxvcyzy0hdB6B0y
         YiHBi/+X/opNlyqkGr34lRhujAUgL32egceTH+qCpj1FBWj8mZL10q0EEfBMPUFdt/z6
         fpvmGqi2HV4QBgiPuE+4wAVvSmA1AAyggHHX5cwDrlI7UTZPMaXTNxRzbfW+3vwEwSa7
         CFrvdmKPlCnYT0NZ3iNgLmtura5d6Ws0f6oSzhhFnGdgE3toDcQPZxFb+g2l0lhqG/U5
         sL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KBtFcgJTam6w7I13Dtf3kIZZxEh43M51mPh+owBn5nI=;
        b=St6lBm11DIsGQMOM93k4oB7w2RvRMq9zhRwEZAnl+kQ2WVfqHZGnuFxPzsVMaf/KFM
         4rfRCA73/b8vGoVsQukc8aiJBD1vhFrYtEUGxpNcaMdAse0YhknyeJJoWKv/hcqWhh1h
         8438YCyoo76LVr4/nyEcT8X0h8kLHC07PQdKP4rC2nmHpkEb/rpB/GWSE0KkD67OUpLR
         zsHJK6Yy3QB0bMu1n1lgcbWuwLsuqHm2jV/6S9i6Ww1tolMv+JVwOnTP34YSrSMSRNLb
         nTFSnEBICS9vuA3IAWMaI+B1lAACcNwWdxn5J1IK5D8phY4fQe+E8rEkYj+dG1xVaHBV
         6WEg==
X-Gm-Message-State: APjAAAXxjIEUjCahcPfWw+KaIu/xvjH5C5G1V+FHvESC3KvczgEVY0RW
        Dq9CfQhzWhrCszeBsutVy/gMj6X44YGZo03J7I2F5AVV
X-Google-Smtp-Source: APXvYqwf/IGzCLpXi4dARxiDks7YFaOGEUXwfD475Rm1hwHpeVcgF4pld5lDi+sZ4ru0wUvF5rAZ9vhzHNU7+D7/Yc8=
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr9958196wrv.216.1573952120285;
 Sat, 16 Nov 2019 16:55:20 -0800 (PST)
MIME-Version: 1.0
From:   Sivanandan Srilakshmanan <ssrilaks@gmail.com>
Date:   Sun, 17 Nov 2019 11:55:09 +1100
Message-ID: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
Subject: working directory status
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am new to git. I have been reading the documentation on Pro Git.

I have checked out two working directory (test1 & test2) using the
"git worktree add --checkout" command.

When I run the "git status" in either (test1 or test2) on the checked
out folder, the "On branch <branch name>" displays the branch name
from the latest checkout (ie branch associated with  test2).

Could you please provide the correct syntax to display the branch name
associated with the respective folder.

Any assistance is greatly appreciated.

Thanks
Lakshman
