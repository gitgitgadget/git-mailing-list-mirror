Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F04C20248
	for <e@80x24.org>; Tue,  2 Apr 2019 20:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDBUck (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 16:32:40 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:46141 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfDBUck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 16:32:40 -0400
Received: by mail-qk1-f172.google.com with SMTP id s81so8747151qke.13
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bY7TGFIrdeauG+9Tegwk+KGAFc+WELQ3LiBJU/1DaBk=;
        b=fQTcnTBk/7446mF5NxoH8n4DKttLeDUSuuEwvBo4nr3uXSkU25jL7lYmjGUYMH6Pi8
         PBs7kcgdI24s+o713bWGmYjuRDZWjPPqea8dRTv7g0X4eDrEMg9Dtich0DKC+nhMohwZ
         1T2GCe6WTC3GDbQEokJpZxFQTS85cvVhjfPtNODU1h/uL3QWKqbR9lu38+sCnPSOSWvc
         dqRcA+jexXKc000KvvoEtdwDElkW/mB0gFEEnq1een1OiZtG9kR2NxB9JVz9rKkZLk+v
         patuKJbVDJiPmGZieUYGVar7zPw5AjRSAcWWPVAdgHZFSdHB7+xusT5p5BpQinFkDXWI
         YIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bY7TGFIrdeauG+9Tegwk+KGAFc+WELQ3LiBJU/1DaBk=;
        b=IM51kTzfCe/2whink8on0UGQqERWGlCqwi8rK6ObCLCzAY+8GPP+Zbrj1SQ9t6dhq8
         HuuXEsy6792ay38+rOYRyQ4AIF22LFWxrLW1oTpBQh5WWoihGHj/kkrgtstRBWY21VyZ
         CoWtkLxspdAbGU9PPBPvmhOw4+cPX449P2A90xLxNNq/8rxrzjlN4SPTWlJxssNzMOel
         ZHu/yNtdtNbDAurioIcc9sCTcUcyp71qe/S8T9pOXg+FOVxYY/8ntzIkOGSXIppI+sE1
         vxiqPmWI/iOTnmVt7XgCjEfXn2CgWhs/54xIln7UTFzgw6QqR1Mp4sals6vbCzmnMjo4
         BUAA==
X-Gm-Message-State: APjAAAVD0z3ctggOAFz/TecbUw+awoavodSYXzLZHE2GlbeIO5R9nyTA
        zRQQJsHIPWT8He1BW6LUWSu4uJbNzA2QudmStbuPWb13x5M=
X-Google-Smtp-Source: APXvYqw8ID9Hb+glfNIvX4myR2B7Lbw2l/fLGxKMJL1x83VXMMit4hOl6trzzQjA94u7/brZrQkQ4QUWRepcEIo4XSU=
X-Received: by 2002:a05:620a:35c:: with SMTP id t28mr11715927qkm.24.1554237158455;
 Tue, 02 Apr 2019 13:32:38 -0700 (PDT)
MIME-Version: 1.0
From:   Khalid Ali <khalludi123@gmail.com>
Date:   Tue, 2 Apr 2019 16:32:26 -0400
Message-ID: <CAD8q83SifH-7mKOet-Uuf_KHCqvO2mkxiZgEyQhoNRhshFG_Lg@mail.gmail.com>
Subject: [GSoC][RFC] proposal: convert git-submodule to builtin script
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

My name is Khalid Ali and I am looking to convert the git-submodule to
a builtin C script. The link below contains my first proposal draft
[1] and my microproject is at [2]. My main concern is that my second
task is not verbose enough. I am not sure if I should add a specific
breakdown of large items within the submodule command.

Outside of the draft, I was wondering whether this should be
implemented through multiple patches to the master branch or through a
separate, long-running feature branch that will be merged at the end
of the GSoC timeline?

Feedback is greatly appreciated!

[1] https://docs.google.com/document/d/1olGG8eJxFoMNyGt-4uMiTD3LjRYx15pttg67AJYliu8/edit?usp=sharing
[2] https://public-inbox.org/git/20190402014115.22478-1-khalludi123@gmail.com/
