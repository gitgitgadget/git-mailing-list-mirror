Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5ED91F406
	for <e@80x24.org>; Thu, 28 Dec 2017 15:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbdL1PwA (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 10:52:00 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:46712 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdL1Pv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 10:51:59 -0500
Received: by mail-io0-f173.google.com with SMTP id x129so38712817iod.13
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 07:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kamit-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7EO3bq4dYmkwmas9I68rLudxKbyoVbH2N5/qQ4BCL4A=;
        b=08LaGnD/OfvyWU6DVLYTtmKpYC3mo/Ew/TgrT3osKzye9IKdT4lPyki89q/UNE1qNh
         QvLlnB9RHDJ735w2Vh+Iawv5la+6gwqldxzKPhMDm7VPNdxnNefEDhQ4zYc/TdDRBP2c
         XTRvbctvAv0UMZcpVF8fyx/yy3A3E5XcqDXFGnrI4CNgHNB2uzSdpElTvx0fWGF6idjk
         rNBLV7QyJfEs0yANOToEAKirbG/SESr4BOBWWYlgKh86gxgyCLcFElcViNH5Aggc0C8C
         wxgRjCeEXY97ub2uxoXFgvi7ZIr8YKhoNB5okrxejH+PtB+kAKqr8xGQoGmDvBcmrqjc
         nvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7EO3bq4dYmkwmas9I68rLudxKbyoVbH2N5/qQ4BCL4A=;
        b=DQGBoKQPYRfAPOdVDBsDdtCAhdVL5M28ELnIA7GqqM3CsYWWYGAVeP1IJa+Odj/IFy
         MnFedJe8Xynkpg587EFBWeD8Vc/9gASQfkBvnu0q0FTJdrwqncGxCUW18Zux0Ye4Doa9
         pMH4cYxXvikirVnns3U4FnlW0+utDjcICQQx++fILQPn7vM3vvEUSBHwYdrd7Dqzgv2X
         yjbcpx3vDB29QlHWK5nGLB0WhQASWMDVFCijPrrujHEC1g3eqBZCElWSuF4PwhA7EJFA
         BCGTGPY06IibxGyhwhyCm6w7qSYDLnzcNRubrW1KhRXDqHMxmAKFo8Bmn0TrigauA5I8
         7Pig==
X-Gm-Message-State: AKGB3mISeLrL51iV6loA+cEfa6d05nnVYpAcVpA1JHo6nMh8UQ9yI0UV
        LiprD+J1jIPTVrOOiCJO7eOZxeEmKXmMMAExBrNuXtZF1xM=
X-Google-Smtp-Source: ACJfBos9xW7wcNK1QED7XGqtAJUT1ZGc9umwsQKx4eWiBp4ZjjeAcmnMUXx9KDCY3SCLM7p6ILvK40e8Awc1meF8nmU=
X-Received: by 10.107.59.12 with SMTP id i12mr20977121ioa.67.1514476318500;
 Thu, 28 Dec 2017 07:51:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.17.227 with HTTP; Thu, 28 Dec 2017 07:51:58 -0800 (PST)
From:   "Kevin A. Mitchell" <kam@kamit.com>
Date:   Thu, 28 Dec 2017 09:51:58 -0600
Message-ID: <CAF1p0HimkxVydxL3cfRXX0=oaBrmARzYqCbqiarWn1yvh+H-EA@mail.gmail.com>
Subject: =?UTF-8?Q?Bug=2Ffeature_request=3A_Can=E2=80=99t_disable_fsck_warnings_d?=
        =?UTF-8?Q?uring_clone?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I=E2=80=99ve set transfer.fsckObjects to true globally, for safety.
Unfortunately, this messed up my Spacevim install.

Doing some digging, I found that some of the repos had a warning. I
can turn the warning off, but that only affects git fsck, not git
clone. Turning off transfer.fsckObjects also fixes the problem. I=E2=80=99d
rather have it on for my development work.

Tested with the =E2=80=9Cnext=E2=80=9D branch as well.

$ git -c transfer.fsckObjects=3Dtrue -c fsck.zeroPaddedFilemode=3Dignore
clone https://github.com/albfan/ag.vim
Cloning into 'ag.vim'...
remote: Counting objects: 1879, done.
error: object 65e1a0027644b6625b32d30ba5ccf1c4d483480a:
zeroPaddedFilemode: contains zero-padded file modes
fatal: Error in object
fatal: index-pack failed
$ git =E2=80=94version
git version 2.15.1.501.g29533fb16

but this works as expected:

$ git clone https://github.com/albfan/ag.vim
Cloning into 'ag.vim'...
remote: Counting objects: 1879, done.
remote: Total 1879 (delta 0), reused 0 (delta 0), pack-reused 1879
Receiving objects: 100% (1879/1879), 1.23 MiB | 2.76 MiB/s, done.
Resolving deltas: 100% (938/938), done.
$ cd ag.vim
$ git -c transfer.fsckObjects=3Dtrue -c fsck.zeroPaddedFilemode=3Dignore fs=
ck
Checking object directories: 100% (256/256), done.
Checking objects: 100% (1879/1879), done.
$ git -c transfer.fsckObjects=3Dtrue fsck
Checking object directories: 100% (256/256), done.
warning in tree 65e1a0027644b6625b32d30ba5ccf1c4d483480a:
zeroPaddedFilemode: contains zero-padded file modes
Checking objects: 100% (1879/1879), done.

It would be useful to be able to turn off individual warnings during
cloning. Is there something I=E2=80=99m missing in the config? Or, is this
something that could be fixed?

Thanks,

Kevin

--=20
Kevin A. Mitchell
http://www.kamit.com/
