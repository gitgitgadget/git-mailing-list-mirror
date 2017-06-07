Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941901F8CF
	for <e@80x24.org>; Wed,  7 Jun 2017 05:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbdFGFrk (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 01:47:40 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:32886 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdFGFrk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 01:47:40 -0400
Received: by mail-it0-f45.google.com with SMTP id x129so13441383ite.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 22:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=CiIinduxWMwNQd1zzoYetuNU0wpI+cnDmto1bhQ9/GE=;
        b=qAphnhsFQBVX3BRpuF+dv8S2rcx1IyXyDF2FT+doU2IS0pg5qYk8hbVjIAIcqQ1XyC
         r5hElha30GYSuJTk/HTVln5KuvoFCiQQFu/XDufzv9kJSrEsLICZD5Xjsan0FzeUsyXq
         yuaumi3cH+4kHT0Sd3Wf6ofe6OjqzkyvYFHyshTiu1lddCAe/eEdVGEJGe2pEXFYrrSe
         gaYvR/Ypaj1k88rQPV2Adh87hKhBoCJ1kbqJerhQMc+6Qlc3obV73mSZkBRkCdIh7Lrr
         kVVm6jd9jd07D/C2MQ/2faVVlqEmrTrXtAE1xJoTFLEzHIb8TqEN4+5E0EQVg6H9g4LQ
         83Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=CiIinduxWMwNQd1zzoYetuNU0wpI+cnDmto1bhQ9/GE=;
        b=ix/aq8lro+GEMSi/Fb2x5s7IRGUIXrW6KyZxU54oKKNrOYPSV2/h6tmZ1pKZmrbuAo
         MM8EwAXkLmByWvwrFzWIoLbF2SsgCWoPdCBAEcYGKNERFZOh9xYTVqZ7m25pU+IKZArJ
         KWcKBRkxPM0hHJzp+4HiuoZAtDDyh5oBwoZFNVWrPMk4EwZ0ILU0BjOw9d3QG8wfh8wc
         ufzUH2Vk0rZ6SX8VgUafFvvAC0Bj9jbMJtKkakc9hGxojDm5OXjaRSOjusWsG7uXDdsr
         lsee10PgXRosC40ZQWZfQjhsHDhSeFgzi61RuRsfWEzuu09HwM8Jrk8RoBgaI7PDZuSk
         rRMw==
X-Gm-Message-State: AODbwcD9pPMj75+4fPGCQaci557/JpVBdS4kWHYdlR8WhxssL+xszgDY
        7QnUVMbY7dfjp4hJqau0w5Ib/Qa6PhwAoRY=
X-Received: by 10.36.120.78 with SMTP id p75mr63762itc.87.1496814459175; Tue,
 06 Jun 2017 22:47:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.135.7 with HTTP; Tue, 6 Jun 2017 22:47:38 -0700 (PDT)
From:   Liam Breck <liam@networkimprov.net>
Date:   Tue, 6 Jun 2017 22:47:38 -0700
X-Google-Sender-Auth: iATnpIzYDnPnb9LP_0cbhU-z50Q
Message-ID: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
Subject: send-email: Net::SMTP::SSL failure
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is configured to send via a gmail account
git send-email --to-cover --cc-cover <patch-list>

I See
Attempt to reload IO/Socket/SSL.pm aborted.
Compilation failed in require at
/usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
BEGIN failed--compilation aborted at
/usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
Compilation failed in require at /usr/lib/git-core/git-send-email line 1386.
fatal: 'send-email' appears to be a git command, but we were not
able to execute it. Maybe git-send-email is broken?

Net/SMTP/SSL.pm v1.04

perl v5.26.0

Seen in git 2.11.1, 2.12.2, 2.13.0, 2.13.1 on Arch Linux
