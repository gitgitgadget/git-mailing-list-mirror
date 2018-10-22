Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671991F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeJWGf0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:35:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43129 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeJWGfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:35:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id d8-v6so8443675pgv.10
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=9VIgKzUIy3Z8VNmYIKT8pekHoVzqKGzVI+dnCaILuVg=;
        b=U+KB6kzCGXos74HOcA+kk3BeVMIk/TRDqhI5TMKj1U93GWP6vLlzgwQ/vdkmjFpEnh
         zDDz/xoUi5yBmorP0kn5bLhd/GNytHDYEScAYXX5dyjKUG8UC/p4e1YS82LW2njet5AG
         2VQwUw+gy/+x9kJX+29wMOxWY4elQhFFBKapCIWLDKsjU5Np/j3sWVuQXu10OSmAYfIM
         TUVCR8HxG1L5oU7VMiLrh4HT1XtW1Vprh/dJefAIbgQtU7T0X+7Xog+fofLj4X+wxC8A
         f3JIfGAYQ98pqBNqoo5KABbS/kzr/BYZUx1fcSIxHnhZc1R+Ak2C2lwHu5+i/TM7pGWN
         2EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9VIgKzUIy3Z8VNmYIKT8pekHoVzqKGzVI+dnCaILuVg=;
        b=EzoctbdyNE7CGKl8KcNlGV7RGjGUWVQddOkPrgVT8LUgkCRyexgZ5OH+si+RLOzhNf
         ZqAgwcrqiOzVbXXpFDpM/XkGVCpVOppdIEjPC+vcVTz22VfQvOWfntpsJ8K262ronNEI
         16xVp5miug9XmjOtgCBsGttah65xq1ifpYqrZgnPEY+hAwhi5NmX2W2byhjEuLomQCar
         A/Ism13U51PLRYFAUVqgSC0QJQBSLVBA3twk/avkJk7S/WjbVQNcnlWQcL333MHxGPKs
         rTDrLQZdN0ELJzkUuLoIBNvvriOojgL7a8XZdoTm0/FdlJQ0gW9PsvGT0PN/o7X8d1bo
         umZg==
X-Gm-Message-State: ABuFfoiikk1aRHxF8Pv7PYfg5vGy/Y8C+GV9c15UoS/bvMXc8lXosoD5
        H6T5t5cpWZQoB9gEAmqKGVgnBKFI
X-Google-Smtp-Source: ACcGV614BPHH4znEZbndVbLErqsbW7zt4JtZsika+K1cEHDRTNAeP8ExfyOfhoI70wHn8d6ngUC2pg==
X-Received: by 2002:a63:5558:: with SMTP id f24-v6mr45690743pgm.37.1540246501447;
        Mon, 22 Oct 2018 15:15:01 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id k12-v6sm22591444pgr.81.2018.10.22.15.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:15:00 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:15:00 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Oct 2018 22:14:55 GMT
Message-Id: <pull.52.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.52.git.gitgitgadget@gmail.com>
References: <pull.52.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/3] Fix rebase autostash
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER Gabor <szeder.dev@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gábor reported in 
https://public-inbox.org/git/20181019124625.GB30222@szeder.dev/ that 
t5520-pull.sh fails from time to time, and Alban root-caused this to a bug
in the built-in rebase.

This patch series fixes that, and while at it also fixes an oversight of
yours truly when helping Pratik with his GSoC project, and it also adds a
change on top that makes really, really certain that git stash apply 
interprets the OID passed to it correctly (as opposed to an insanely large
number for the stash reflog).

Please note that I based these patches on top of next (they might be most
appropriately applied on top of rebase-in-c-6-final, though).

(Sorry for the v2, v1 did not send due to an UTF-8 character in the Cc:
list, a bug that still needs to be fixed in GitGitGadget.)

Johannes Schindelin (3):
  rebase (autostash): avoid duplicate call to state_dir_path()
  rebase (autostash): store the full OID in <state-dir>/autostash
  rebase (autostash): use an explicit OID to apply the stash

 builtin/rebase.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


base-commit: 500967bb5e73b67708a64a4360867cf2407ba880
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-52%2Fdscho%2Ffix-rebase-autostash-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-52/dscho/fix-rebase-autostash-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/52

Range-diff vs v1:

 1:  88241ad32 = 1:  88241ad32 rebase (autostash): avoid duplicate call to state_dir_path()
 2:  86107a6d0 = 2:  86107a6d0 rebase (autostash): store the full OID in <state-dir>/autostash
 3:  d3b47a4c1 = 3:  07140a71d rebase (autostash): use an explicit OID to apply the stash

-- 
gitgitgadget
