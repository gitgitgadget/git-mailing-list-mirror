Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0351D1F404
	for <e@80x24.org>; Sun, 18 Feb 2018 22:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeBRWul (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Feb 2018 17:50:41 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:46477 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeBRWuj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Feb 2018 17:50:39 -0500
Received: by mail-io0-f179.google.com with SMTP id p78so9465842iod.13
        for <git@vger.kernel.org>; Sun, 18 Feb 2018 14:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=S1si9NpBEJ7RkNxt93YMsWqC/sltfDz+g/qsX7uwHEk=;
        b=Lvka5TVI/Hvh0JkCikSq+qfluVJhRWq6iDtm0Cjqgs1snTYQhJGU+o3ZEwcKeqx9Gu
         13ODU+Dq97rWFdtRzkgNzmZxYwBnMJeYh3pJrUGdRBHL7Hf0ml1OOfkxbRi/BPdWIhvg
         bgfX5aam2CeafoT2N63a9RdKsbjfXFuLRC6wrBdpYjl0GXxCMxBDwIO/df6kSnQOXJEp
         Dn9lOPBhLXImkHTMTNFOwxF7pUpWNA8/1qxh2Ny0MNmAiOb9CNOKuZDGvRHv4zZAiLQ8
         1kQq10mWCFH35HJzu35cwwzBnlz3WebBUloiEEJP4Hb8SThsxJVP5Se11Dd/QnNiaphu
         K6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=S1si9NpBEJ7RkNxt93YMsWqC/sltfDz+g/qsX7uwHEk=;
        b=GvBTm8MWWyo4X5eBgPGLTkN7+ZdQEcggbnQQxovFpS/jrehVrEwmRKWo+LpVvAz49E
         QH6gmj1jqccQMF1025fZ/gye5Bj33RyCop9Izy4zp936cFW9YvBHMtuJHf5o2G7ym0t4
         0GuoWoRhFK6QZ6pW4Ie1r32R/VEcfy0oU45ITaPADQk1sNMWIa6MZFfXIguZcOUBWafd
         qjNYv2y3YgEakXYJrQXvK4uSkL+5h0emBnuW5ENEx98yqTHmZm6q7g4X9XjHGUOYFx3g
         aH2oq7ddpf0pxWbQ2PjljVwcoX3rEieKeao0lbgC7w+qmVdjAbRl8N1csSqcYevk86Ub
         xciQ==
X-Gm-Message-State: APf1xPDSW6EUwVPcnmp71GRnz+s6qDb4nH8Dhgg9l6BggUhEUCeGXpLY
        omvq2NruezimWAmYG6v15elhpa73xfPJ/1SuogQkzt7I
X-Google-Smtp-Source: AH8x227IIUFPh2T0glt9CD/sN8QTTXpHPm0mSWC5rJB1VmO1vrUavkoqpW0FxGHUmbGhO0e770ypJbozfNh2LA6kUBU=
X-Received: by 10.107.166.140 with SMTP id p134mr16955207ioe.272.1518994238596;
 Sun, 18 Feb 2018 14:50:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.150.157 with HTTP; Sun, 18 Feb 2018 14:50:38 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 18 Feb 2018 23:50:38 +0100
Message-ID: <CAP8UFD1HPruE3N_0k8_TFreBML9V8K=SS8LqD-XkeEuheSmGvw@mail.gmail.com>
Subject: Draft of Git Rev News edition 36
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ed Thomson <ethomson@edwardthomson.com>,
        Chris DiBona <chris@dibona.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-36.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/274

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday February 21st.

Thanks,
Christian.
