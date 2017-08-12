Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B23F1F667
	for <e@80x24.org>; Sat, 12 Aug 2017 08:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750802AbdHLIam (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 04:30:42 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33428 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbdHLIal (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 04:30:41 -0400
Received: by mail-io0-f180.google.com with SMTP id j32so26963424iod.0
        for <git@vger.kernel.org>; Sat, 12 Aug 2017 01:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kg2PXmKmdnr4fbeEWjQ9FSwi1cpL7WxN877k+4NKw+0=;
        b=UWQjfjIzg3RcDSBxPr/apalnspHzKMGQ0hFeFr2O/Q3ZM5LTq4V/1wdxEB+Hjb1t7s
         RK0ugLEyh36Gr4woxYFIOY4M3Tdtzo8mKNx5ZKBtwUyYbYTqt4oxKweRa5u0JMgViq5M
         cnWURB+N7ywLIRme9aVvD2UOODxNn/1j1tMfw/ZUGR1a1SOaTfVFgtVBXrgzhkrdXJag
         ELibVELTdoLduPct4CoqTkQE05d84zP9SyVq9t0XaTwe9fWJWuxAZstwEKzVWBl/vjED
         QW1tNePHwsmRMjeTmyK7CWkNLC3WiNk8TeDiFEfzcCxadVw7bXLYOTq/Hy4Igt8scNsL
         Zyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kg2PXmKmdnr4fbeEWjQ9FSwi1cpL7WxN877k+4NKw+0=;
        b=mLVS3x8f18RKhIUlmcwn2wq0mkKfv7vKVtaE2uLWLKZSKGhj/LuXxqeHexF237/TEF
         Vs0nA/xQcZeCFce3td0o14KHte5aV6eBE4b6mOKvGbBkBJAYYdVTbPxOkUw8fkFKClxc
         TaQ1ohFaRRO3s7g9Y5kJ0dlIFBK4AcbY2qmOcqIToaYK3Pr5FGOLYw7s7NAlgIQhiC/Q
         teH4Ob3awU4R/POW3VZq1XHWTiK6eEF+hEFGiwUOBfxo7JiM4SvcVqLSBvCr3cevoUgn
         STpidcXMgVuSVpILrOT+UT2rh+uXfyOgTNH56JI3w/icRYRYckDB7lta7HVC3aMUCVfy
         rlIA==
X-Gm-Message-State: AHYfb5jq/+lTrGZOivt9MethlzK/oEgI6PC6GmzKuuqvAVRTjqdQOXCC
        NxT84RIplrpe5s8nIIuza583xbeDChY3
X-Received: by 10.107.19.132 with SMTP id 4mr14906953iot.311.1502526641074;
 Sat, 12 Aug 2017 01:30:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.34 with HTTP; Sat, 12 Aug 2017 01:30:40 -0700 (PDT)
From:   Kazuki Tsunemi <ksilverknowledge@gmail.com>
Date:   Sat, 12 Aug 2017 17:30:40 +0900
Message-ID: <CAJ7dDEdM=e76qhGStH8X6AJ9vkbVCh8gREj6Xnzux3FJ5XEb_Q@mail.gmail.com>
Subject: description about necessary libs on INSTALL
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

I have an idea about document.
I installed git with INSTALL. I executed 'make install' but got some
errors while building. I found necessary libs written in INSTALL after
all build errors have solved.
How about write about libs before install command ? I think it is better :)

---
Kazuki Tsunemi
