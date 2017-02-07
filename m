Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4461FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 23:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755576AbdBGXMT (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 18:12:19 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35444 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753909AbdBGXMR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 18:12:17 -0500
Received: by mail-qt0-f178.google.com with SMTP id x49so149736493qtc.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 15:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucar-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=r6DEfxj+EywW1HNp0FqFboiNo2KjsVlR+/XqxmhVbig=;
        b=FQ8pducFx7jm23P+o5IA7nfH6I+ecG/EaztJzr64R0djCUkUSr+xi6yknt/SlgHqh+
         g9qNfJYmRRdXWRpioBx/WUlO4ypHp6aZuEEkxmgoggFZjQGrzCJL4m6lAGmAq/uEXEvb
         0+jRV3jmj6vjmRD8md8gHuSmYdxABPUwuB1MlT8lyio43Zfc7sVkV8H//Dd8Or1x5saC
         yeQStq5jhDFN/NpU0EEQVEXjDvNxbtRXGYI4e2gG8xqlhoRckcUTf5e+v8K/eY/oYR7U
         CD9XT1rzGZqOEVgdBrrgP1eiOjEt9mE7dyxGIaHVZFACMg37vVdSNpgtXloTXzhBGI6v
         AaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=r6DEfxj+EywW1HNp0FqFboiNo2KjsVlR+/XqxmhVbig=;
        b=UgyIBQmBZqxmHKU+WsO88IEwjoP3Qw2VMjkno4XTrilB8TnmN4H1k/snfAQ3Kqdk4M
         v840dneU/7TFmTQ7UL14WmZCUTkP2y+jcFknpPmvAqzbY3PYjeFJ/ZgZjlH9c3MtEwy2
         1sPHVYm/EP/HfHw23mC85cSFLu07GcfAyxTateE1eOfAWaI5fRzDWFWKXd9msP/m/dlr
         XchOCAyf4xrHpwnmO60Wr9MG1SwcAeWylZy3byNHrMBXnpd2O7FqxbilXp8RINpZ2AGv
         kC8RjGpNZEHo6tSBgl4chgR+Bh9l5YYKcv7nHwUtzY+cFeGK5Hi0rU6fKXnhget1iRzs
         3S+Q==
X-Gm-Message-State: AMke39lkrXi4gd/So3iPLJZmOpmOMZtl01y4DxUghEFfmP8Y8ViGlZMaVO4ud9BPnwq0/zoplpqhfWH/uHMW45PG
X-Received: by 10.200.55.112 with SMTP id p45mr18631876qtb.278.1486509136516;
 Tue, 07 Feb 2017 15:12:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.156.130 with HTTP; Tue, 7 Feb 2017 15:11:35 -0800 (PST)
From:   Davide Del Vento <ddvento@ucar.edu>
Date:   Tue, 7 Feb 2017 16:11:35 -0700
Message-ID: <CAMh-zaPdSGaDvQSiWx0p7zUmfDAFDWUyHkY4BTs=j85Ue65XnA@mail.gmail.com>
Subject: The --name-only option for git log does not play nicely with --graph
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git log --graph  --name-only` works fine, but the name is not
properly indented as it is for `git log --graph  --name-status`

I tested this in git v1.9.1 the only one I have access at the moment

Regards,
Davide Del Vento,
NCAR Computational & Information Services Laboratory
