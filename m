Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCFE20D0A
	for <e@80x24.org>; Mon, 29 May 2017 20:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdE2UlR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 16:41:17 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34590 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdE2UlR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 16:41:17 -0400
Received: by mail-ua0-f178.google.com with SMTP id u10so41054243uaf.1
        for <git@vger.kernel.org>; Mon, 29 May 2017 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SOZKjgm31p1WlLxOPeRfyTX8wjLijYAuZLEL0qFSAsE=;
        b=DMPbk8FJSOwhMSrxstNYtMd29ynmDTlaIu58PkvfZ5yRZD7LCPghqym2G9fPt1K8VR
         8nNf/7fABHdEPUWbLOLPwSZtDMmh1a4FeofjPZP1HYkqaH0UDqG4WhrZqm+6eAa1Cd1B
         5ThTkKEDlIzGufL8nIJ3Ta3dhh/T+KIlwQY1w258nUzYOHtI2ILFVAvYzAILMk+b+LDR
         OB2W1wUngokZyLmGWHbX+93jB0L4xzaQXSFiZuAh8q19OJVzfQ28fhfpwIPTxm9vVHBk
         o1CaBJ+70jMAbzU7Hsk6axUXXzF1LyHxBGpHk5HvQW6eNwcvDhTdaNARX0wYMMIL4BWV
         rhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SOZKjgm31p1WlLxOPeRfyTX8wjLijYAuZLEL0qFSAsE=;
        b=kE//kZFWsbbS8V+A9X1+TUjDvxokUxyzkHtp4bUqd8pygARezKdCD04m5HRwrfDDmv
         Kz5T5UB5ou6RMsKbLVepYEjCjPgO4TMXEaJZQy6cjHcs9MkLHy87luvNlu86pHkxk1SP
         8EugsmE2eQVopKItRStRLGaZfiqD4fNprKaGPy7baZ/M0xqudGlSLvCvygkBfFDbKWnF
         Wr0sv8T6nktHQDRD1FSFRTsIiexb+ypLs9HdVlmmZycXD7xyLedd0+YqeYya2CDh5ksB
         xndOkxSA6YsJa3bhQDoJNBFQ/x5Zq3hEnKU5/yGwIbSJzsEo2mEsrUEv4oR5UUelMZw/
         Gaiw==
X-Gm-Message-State: AODbwcAHrzU62/2FbK3Pm9hojJ94TfMIZeRUdHW9WvPYZNAJTaUBaLex
        GSZfvISc50ZDd/jhTZ17SNmrX88LMsmY
X-Received: by 10.176.5.100 with SMTP id 91mr8722097uax.132.1496090475860;
 Mon, 29 May 2017 13:41:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.38.44 with HTTP; Mon, 29 May 2017 13:41:15 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 30 May 2017 02:11:15 +0530
Message-ID: <CAME+mvXHHMfwv_aJ-0qYjvqCtNJ3_N-JFjLDV34gr_YP6bcErQ@mail.gmail.com>
Subject: [GSoC] Update: Week 2
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SUMMARY OF MY PROJECT:

Git submodule subcommands are currently implemented by using shell script
'git-submodule.sh'. There are several reasons why we'll prefer not to
use the shell script. My project intends to convert the subcommands into
C code, thus making them builtins. This will increase Git's portability
and hence the efficiency of working with the git-submodule commands.
Link to the complete proposal: [1]

Mentors:
Stefan Beller <sbeller@google.com>
Christian Couder <christian.couder@gmail.com>

UPDATES:

As planned for the second week, I continued working on completing the porting
of submodule subcommand foreach[2][3][4] and status.[5][6] An updated version
of these was added to the mailing list as well.

For the submodule-status, I have implemented the suggestions received on the
previous patch. But for submodule-foreach, still, some issues are left to be
solved.

Apart from this, in this week, porting of submodule subcommand sync was  also
carried out. But instead of adding anymore floating patches on the  mailing
list, I have started discussing the patch with my mentors itself, so that on
the mailing list, the focus would remain with the ported submodule subcommands
status and foreach patches.

I have also taken up with the submodule subcommand summary for porting.

PLAN FOR WEEK-3 (30 May 2017 to 5 June 2017):

As suggested by my mentors, in this week, instead of adding more floating
patches to the mailing list and porting more submodule subcommand, I would
like to polish the existing patches and try to resolve the issues they
currently have, eventually aiming for getting them merged.

Also, since I have also completed porting of submodule subcommand sync, after
reviewing the patches with mentors I'll soon be posting it on the  mailing
list.

Additionally, I will also try to complete porting of submodule-subcommand
summary in this week itself.

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/
[2]: https://public-inbox.org/git/20170526151713.10974-1-pc44800@gmail.com/
[3]: https://public-inbox.org/git/20170526151713.10974-2-pc44800@gmail.com/
[4]: https://public-inbox.org/git/20170526151713.10974-3-pc44800@gmail.com/
[5]: https://public-inbox.org/git/20170521122711.22021-1-pc44800@gmail.com/
[6]: https://public-inbox.org/git/20170521122711.22021-2-pc44800@gmail.com/
