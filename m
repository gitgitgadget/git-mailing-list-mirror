Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30EBF20281
	for <e@80x24.org>; Sat, 16 Sep 2017 05:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbdIPFAx (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 01:00:53 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:49255 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdIPFAw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 01:00:52 -0400
Received: by mail-pf0-f169.google.com with SMTP id l188so2416104pfc.6
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 22:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=URhzLBNC/huUOSdjfW4UHcZZR7frE2wPUyuM2rfTBtE=;
        b=UjyD+AZJFSFycDDuE80F/oG651sDcHSlXadju3ZnGMOSYV6vbiOOPv/fDhR/DsY7wx
         xewo55ftM8jSlTHPWDWpoQNjm9cnEz4uL4KNdIw+S8g0wv6KPyP9es1PkjZsQhc+o7nE
         XkVtsO6qORsnMSPcFuo1kv7VtejPHh7OS1Dmrm0dtQHDmP5i7pmrtSdgya0Si3yBqoUF
         0EQSt9PrSpzVp5Vo0BCk1sSEWCQT1GQDqOK44e2spdcImNG8mmVbhc3x6/GcIkE/RJc1
         YwtRzlyWAANHR8xgVZl2gMo64cmPMoRgGiJAn9DoJ+oaU0XgBAr+T60voZ92nO3ALqjz
         kaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=URhzLBNC/huUOSdjfW4UHcZZR7frE2wPUyuM2rfTBtE=;
        b=uATAn8IY0b+ex262pNACvLrqd7GYJO7GsOM8d0IrSrGN3DQp/c5fvkB7KxfegSZIKx
         TVNbpl4Ej140FHZUSODWYZZEGOoHd0NLwkrKmRj2jU66htpboQ4c8FsoJUg+vRGhhxbW
         91tM2Ym0ypNTdA3YzxyxDo7sbDMnlkDb23u3Wp3e5FeTdggZenHPUe1NzqSaAk6bIAWX
         jKk3K2pvll0Qqa0gO5gMl/GQRwPcyOqvSJ/8YyrVUbeZ2sufBzk9OpshDg0hzhkxEX9/
         4jp+2qjulB9Nl4NApGkMzPVngT9XsnMSKwaKV1BXoW6UOFRt6jHpJR9B34nt+VvVZfo2
         Oujw==
X-Gm-Message-State: AHPjjUiV2t4Pjbju0FQ+X8DBMM+m7Um8hTHbfPtsHUxS5HxW6timqGzn
        61km0i6KgFbvByi5PQo=
X-Google-Smtp-Source: ADKCNb4F1IiOlz+8W0EXYRlOK15NB8p3m1NGFbrNT9chSCsw5rTHK+vgQpoxfDFfSSoa0aXcKFXeFQ==
X-Received: by 10.99.186.3 with SMTP id k3mr26381026pgf.149.1505538051698;
        Fri, 15 Sep 2017 22:00:51 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id q73sm5306367pfl.147.2017.09.15.22.00.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Sep 2017 22:00:51 -0700 (PDT)
Message-ID: <1505538043.21890.4.camel@gmail.com>
Subject: Are the 'How to' documents present as man pages?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 16 Sep 2017 10:30:43 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was reading the 'git revert' documentation and found the following
line in it,


    -m parent-number
    --mainline parent-number

        ...

        See the revert-a-faulty-merge How-To[1] for more details.


It says that the 'How-To' is present in the first section of the man
page. I tried to access it to get this,


    $ man 1 revert-a-faulty-merge How-To
    No manual entry for revert-a-faulty-merge in section 1
    No manual entry for How-To in section 1


That made me wonder whether the 'How-To' documents were present as man
pages and were installed when git is installed.

In case they are, how should I be accessing them? In case they aren't
doesn't the above seem misleading?


    -- 
    Kaartic
