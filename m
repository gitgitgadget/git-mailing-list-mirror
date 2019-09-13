Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5701F463
	for <e@80x24.org>; Fri, 13 Sep 2019 02:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfIMCyX (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 22:54:23 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:40531 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfIMCyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 22:54:23 -0400
Received: by mail-qt1-f180.google.com with SMTP id x5so456243qtr.7
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 19:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XlWqm7saSbHKbFACtJIuroEcZik7hvB6K7c5YL1JL6U=;
        b=QS2O4HPYlcwSokT+673c5czny2kx+uaqu/Tl4u8yD+bGtGG1Qyn2mhgLAV/O/T6M76
         HNtghq2hYalPe4DPXptRJjYARI4jl6OjL7tI5yaFCL1t6X3pOkXUYptsXXy1VNKk7FPn
         /43d85s9ip+kU4BfEyGbjFQqEC+E0drtsi4wNEODEPCQzt19xa6UA7ikTtnrb2QdKkIl
         0GxGWI1I+nyFTX1qzu3JFhb9doQV1sOF0FZ0bIf5HjXR2ZzLF3I+7wtgFVzAAlhSqIeE
         upcBuVUeMn4ZbFXBAjDXkr2gGdUDuz5VgRe+VPaPwMolvvaCGzhuWOnTe9DMetkcNGTh
         rPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XlWqm7saSbHKbFACtJIuroEcZik7hvB6K7c5YL1JL6U=;
        b=mpUWiXXBeC9nzEt1yj2jKqMB7iEXc40MDpjp2btTb2gbkT48/zLxTSB+RbNNFa5SFh
         e2ni/Y/Ta3HG5gd4QFNgzbx3iQ/Kabcbdv5PmWK0CGzr2XV4m/voUYIxE1G/JbBfgYxK
         kGcu/NjfUvQpxGhUJX87s8BSCFiF85oRZzRvCjUi/YwElDaV/gBW2oAyX+7zwakoKeD+
         BnzxEpnmrRv3LPKFyvWO/ZjCBADhgykHyXfC5shxvIZH3FewYHeVeok95jWYukdJIiSU
         dVV7HcG8MeEk6kVo6v77l/gRwttXsW3ldKVo+ul5hVgrJMjo/mwS2ki+T83W77SI54lN
         jM8w==
X-Gm-Message-State: APjAAAWrydjOiGEefX5ncWurDxKtNtgvPnrPNAXbkiqrKIU3YDE4/9IQ
        2oBUk3S21DDFD55elBFP8eQ40x5RggzLHgvnaGoKQpc3
X-Google-Smtp-Source: APXvYqxhXVJc3FiPIWO7e1CqD291Cq3Ay21iCuJY8/ms6IuT2q6AjaNmbyJVwoGTMP2kTuM5kqYzAaEaQL0QfsWlDJI=
X-Received: by 2002:a0c:8aa1:: with SMTP id 30mr1787242qvv.93.1568343261631;
 Thu, 12 Sep 2019 19:54:21 -0700 (PDT)
MIME-Version: 1.0
From:   Allan Ford <allan.ford17@gmail.com>
Date:   Fri, 13 Sep 2019 12:24:10 +0930
Message-ID: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
Subject: =?UTF-8?Q?Git_Gui_=2D_enhancement_suggestion_=2D_Can_a_double_clic?=
        =?UTF-8?Q?k_on_the_file_name_in_the_=E2=80=9Cunstaged=E2=80=9D_area_move_the_item_?=
        =?UTF-8?Q?to_=E2=80=9Cstaged_changes=E2=80=9D?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Authors,



Not a bug, but a suggestion consideration for =E2=80=9CGit Gui=E2=80=9D


Can a double click on the file name in the =E2=80=9Cunstaged=E2=80=9D area =
move the
item to =E2=80=9Cstaged changes=E2=80=9D .. (rather than having to click on=
 the small
icon to the left of the file name?)


cheers, Allan
