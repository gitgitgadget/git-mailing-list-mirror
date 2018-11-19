Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A540F1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 09:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeKST4R (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 14:56:17 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:56166 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeKST4R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 14:56:17 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so7183959itg.5
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 01:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kNgquqGDtOlCdqlJ8rXbdIsll8LTwaCed8TeYb40Xqc=;
        b=Jcb6i4nsJqaZ7gv7swfC9Eq2oQz5Jo9XpnS6IKCPA7dxrolgC0t7+C1j0SNAIRZcVf
         tni/0pJKqA7g6DU/vaFLU9UXSQK78uYU9vGD1uA0N2lqolmb9KVl70aqB8AJ5ieFz0UI
         pRXEXl1+ucSa3MJKxorvEOpxxOCLlH0MNz0LlMpoHuCKrmrPwECI15WFTo1KMDXyk5C6
         FBOETthEGBmtvmzU2c1ddlHsPtroZBIeqKxJ6s8boIhgfPNn1cfbUZCtnARrbl4SSg1V
         tnVO7h1hrSzh3A4VZC5Cbm+V/vUqN4Yh/R5pw/WREvRWjYftjODTSjKzeGohtMd2kVse
         tLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kNgquqGDtOlCdqlJ8rXbdIsll8LTwaCed8TeYb40Xqc=;
        b=bIbcQ4hhLPpye0FgTE4F0zrAzxG0zTSJwNyNauKY4wA3Vfdzvg+zW/eDGUPdgGoEcW
         bnIavBueO0ZUWmu9L63J10Vn74WUWSv4JQ8MIcj6lyS6nXZ9EtF/WFcswO6YEnwjI6EY
         LnFRDredOYbw9cEaeBAqOCZxFTX9v7ryNK86Hc8G4dyXG44l46f42qRYLoaxDXlgTdGc
         AaKCSWXgKW8gu1BHFHcn2NdKMEO4A+JPNvvxlcEs5c+ua8vfa+cHtp+l689Rqmu92BfN
         ybI3hQvEnzt5+Lqd/IyTpq12XXP05Nk8O3IOMgwrc3JGgGQRHUc7e1KSkZivwJc5VXa3
         Bw/g==
X-Gm-Message-State: AGRZ1gL2OOiyCBt/8k9GpHa4Q6WUarvDMM4ba8A/bFYWYyngZTJ8tvXL
        vCH4EE370CMX0PFsqWerzS8miqcGOGnopnz9HBUs3jjp
X-Google-Smtp-Source: AFSGD/XOGTUDEBkoeKwmlCIZ5l9tsbSeKTHs1cQR865hmqNsEZ0qAvZg5gtpIIeIJWMrPzSe+ZxjLj/tPPnsJEpERzE=
X-Received: by 2002:a24:dd3:: with SMTP id 202-v6mr8022543itx.54.1542619992359;
 Mon, 19 Nov 2018 01:33:12 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 19 Nov 2018 10:33:00 +0100
Message-ID: <CAP8UFD3pifqAEnB0RR+d2ktRAMujt4J1roAC2KuN0PXW6wem4A@mail.gmail.com>
Subject: Draft of Git Rev News edition 45
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Slavica <slawica92@hotmail.com>, slavicadj.ip2018@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-45.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/314

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday November 21st.

Thanks,
Christian.
