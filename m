Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C846B201A7
	for <e@80x24.org>; Tue, 16 May 2017 02:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbdEPCRf (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 22:17:35 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33160 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdEPCRf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 22:17:35 -0400
Received: by mail-oi0-f52.google.com with SMTP id w10so9212711oif.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 19:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=h6QsvCLYsP9s26jD6IhKo1aWNT9gQjUdG+1+VfwYKOI=;
        b=l7XupBiSbMmHyFaavb5hKmM6YrOYQCfHdPA1pAL7q9BSJvKozXRASRpmzpwJ3AWZYt
         CEnnUxRPqdpG2n1yRlgNSlGD33dt6aPgDLa4BlbiI9Hw+JjAWOET7kLghz2ninij60TY
         dtBm8dcHK2Jm5RHukeIrZVuYLtkNxWHsNOUvN5WOvEiSoVCzleePusZZWfeSkaLQjtG+
         dpw25d2f+DJxRsjJzN4NxSrBhj+VHQfim+agoI7Qj27Tw301BY7x+8eT5togQ55KVtWd
         Zwjd4/txuzAjkAy98C6FRLvTq/S/nbWb2hDMTUj3Piy5HKMrKo9MweIQOtuq9Dy8C5xi
         ItGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=h6QsvCLYsP9s26jD6IhKo1aWNT9gQjUdG+1+VfwYKOI=;
        b=bXMc5H286bhnF66KGtHrd6EG2st0VOKQj0UbliqHiyh9Wrn4iYDOM9+8kfw8gN4I2n
         0mt/hrp0cwCMUgtdMDX9jvJmCJ12glDbjJu0gy7ixMZij3nq1GYzkeqSX0vwn704IkVV
         3DqLKpa1UP1uDlJF+0MMifFFP2nQgCGEpV88Onct0TWsMAof2ldtR58UX6UsVgo+kli9
         zjovUd0yu1hMoxG5kMLVmbZWXgQiYQ1TpNCycWfCABnrPZs2air4G/NFVpnA3HPfr/TA
         qENXOCyB0Jpm595NGh30Gw4Cp4cvjl61SxzMM+SNMdToKIplqcpiwuRunwKWiz/XYNnh
         oIpA==
X-Gm-Message-State: AODbwcC7/ATOrx/2VhWfTFKjLuz8sdoi9biKgXLH2xPA3maQyjRCO0DK
        ARi7IFAjGVfTuIK+teMnknmZIPUcr0k3xrY=
X-Received: by 10.202.81.77 with SMTP id f74mr599875oib.141.1494901054310;
 Mon, 15 May 2017 19:17:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.22.199 with HTTP; Mon, 15 May 2017 19:17:33 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 15 May 2017 22:17:33 -0400
Message-ID: <CAH8yC8k8sTGDA=C8vLCE090Y1B4TK86bOnZMNjj13C-JXVEBHQ@mail.gmail.com>
Subject: How to force a pull to succeed?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I scp'd a file to another machine for testing. The change tested OK,
so I checked it in on the original machine.

I'm now on the remote machine, and I'm trying to pull the same exact
file that exists on both local and remote. Git won't allow me to do
it, even with -f.

I'd really like -f (or another switch) to work as expected. I don't
like issuing extra command or extra typing.

How do I force the pull to succeed?

Thanks in adavnce.

**************

qotom:cryptopp$ git pull
Updating 30ac06d..30ac53f
error: Your local changes to the following files would be overwritten by merge:
        datatest.cpp
Please commit your changes or stash them before you merge.
Aborting
qotom:cryptopp$ git pull -f
Updating 30ac06d..30ac53f
error: Your local changes to the following files would be overwritten by merge:
        datatest.cpp
Please commit your changes or stash them before you merge.
