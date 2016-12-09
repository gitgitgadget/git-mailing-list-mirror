Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618BB2093C
	for <e@80x24.org>; Fri,  9 Dec 2016 07:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbcLIH6A (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 02:58:00 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:34980 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbcLIH57 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 02:57:59 -0500
Received: by mail-io0-f180.google.com with SMTP id h30so43968611iod.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 23:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=G/7mJk1HJUHRnN7x/wno/IoUzrnQjh4XKIoDx/b3brQ=;
        b=YHBwbArsimjpEtpzl4KqmqX0OKtfTd2p3o8zPl3FMqhoIKkpH9NqYbTXqlLCJkoahW
         suh97AXQx8gRCKqtlqkIy+MW3dOx3K1XHuUyV427QSMtoeFzMZ8nBKW7QChBXcNrsRng
         bOrbZd1t6eeKr59/HcTgt+IhhOI1z2puSc0f+cF5vH5+S1j9kbdzMK+SBNF4dsU1WAfl
         zPPQ4C4bprpeMUV/tqUYJsMcn/mxKho8RgFwsaGEaKsEQxtd8U56RTEGL1esyecYmfUT
         EhDIfQO3exTUnI73yO43gprPVxbUrKsLIopGTxQ1LTosps/DDduILuDCFAqbbmWpNudV
         tEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=G/7mJk1HJUHRnN7x/wno/IoUzrnQjh4XKIoDx/b3brQ=;
        b=gWtf0JKcsjfd9kd2X6mkMMehXf/Vma0l/mg/iHeK82fWD7ojImeC8crXGIFlQH/Be9
         BpATCxF/TducmaA/h10s8RvO2osn5ji0dQ6Yb8Q+CTsGwZXtEtpbtNsn+fIHmDq8P79Q
         nud5hsjNct23pZ6bVUqKlMOPrxf12tt6x5eatgbfgrelUa8b1lS09LdNltEo9Oh9+971
         R3uDAgbtceAJORAQQCdNOuslt0ICo9QgWv6K8JsRsDRV6FF482nrKgasnq+PgQsZ4TVo
         yDO3DlVqSFMFrrlkHx5DQCMicBFS+CVdM4zaQH06cFC1qEs/hg+b/he/M3/G7OYYH/d1
         YtJw==
X-Gm-Message-State: AKaTC00Amw44WIfbiSYHeFVkQOQR519vGSGxHb3wexPkfCoMe8Wt2fXm5+RTtZagQzamlUo/KUh554rWSZAObw==
X-Received: by 10.36.125.198 with SMTP id b189mr5530518itc.88.1481270278500;
 Thu, 08 Dec 2016 23:57:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.157.152 with HTTP; Thu, 8 Dec 2016 23:57:58 -0800 (PST)
From:   Chris Packham <judge.packham@gmail.com>
Date:   Fri, 9 Dec 2016 20:57:58 +1300
Message-ID: <CAFOYHZDs5rBt5+4D_ViMYfV04foq3h_UrsSMA3FfyMzLh9QdwA@mail.gmail.com>
Subject: Any interest in 'git merge --continue' as a command
To:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I hit this at $dayjob recently.

A developer had got themselves into a confused state when needing to
resolve a merge conflict.

They knew about git rebase --continue (and git am and git cherry-pick)
but they were unsure how to "continue" a merge (it didn't help that
the advice saying to use 'git commit' was scrolling off the top of the
terminal). I know that using 'git commit' has been the standard way to
complete a merge but given other commands have a --continue should
merge have it as well?
