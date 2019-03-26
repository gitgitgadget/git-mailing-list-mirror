Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 686B020248
	for <e@80x24.org>; Tue, 26 Mar 2019 14:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfCZOic (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 10:38:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:34795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731839AbfCZOib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 10:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553611105;
        bh=76G/3dYo6ZdS4QlpDPERXVZRk9FCsaXt2xjsiP2b0x4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GbkKLJ2QJX6M8fkeERt8rStGqoN2B2/6UbN1Tcmw2E7LVf82cjHawWKzDRY7JLHm1
         ykZbsfzjERbiGzw/v/bP8Wmj8gak2jdaPcH/u0dLrRZ5hrWUeKnIm9vFr/jqPzO2cY
         cjID0+7glteFFmfvQX14XSJipy93ze6V9qkRXklo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.144.175] ([95.208.59.108]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhSfM-1ge56929RI-00maYn; Tue, 26
 Mar 2019 15:38:25 +0100
Date:   Tue, 26 Mar 2019 15:38:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] Fix make check-docs on Windows
In-Reply-To: <pull.162.v2.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903261509080.41@tvgsbejvaqbjf.bet>
References: <pull.162.git.gitgitgadget@gmail.com> <pull.162.v2.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PIdrH5bIAWyEVDA4WhoiaLpPr+ESwU979+AmvAgg0VDEurD4pDa
 0qMPhhqx+er6RCHFlB/L2PslruQcgbAb6cTM9wUNLaeXxX2IKOF11U36J9yuNHOHtpdCMDf
 CSIakTKb3mLr6bK3bXmyZfWGAsYtpDSsaHEjqigBvfgKlA6vWVqbFJ5AbqOLb7ZOspswuyv
 fo7B3PH98lscRkTPkCxag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E66iWdKoXG8=:arEZH6/0Y2XthBO2kRudjU
 CQdNL/uPLH8Fv7/tmaq6Bkp47PGHqOrg/DZCswrAnKi7EZ5TtJ8P52Fc6mW0gv2rbd5CVguzc
 Q+8UdbhbDUUlsHGe/3fSF6KdHbS+oTkRR2b/gN2DkmYMpXYBAqf0kjeMRxR4PYvvMkt+GVuU7
 BDwKuTMaom9Fa7BlBzZF6whMzLRABbY0VZ35TNUX99Va+3GD9nd98RJ06hb+kWJu1C7FvD47k
 TAgfvaCaC+1FVvB8RCeo27AeZ4cSyM9wjXm6Ug+cAY/Akd8Ny8vY/jS/THvLqve340h138JOx
 5Sye9tsWWQVPWH3rUJCiNiNt9n5+7Kz+CBVvu5r1GFY8FE8V3Gtnl7ea+q5/VlyLoIHJNIQCf
 0F8Bh27DVu3EvO3+SQHLk7ljKgLMg+1wxsqnwF2sbg9fGEIdIFdP6HBChkptXCd631k/ho+DH
 7if9Hcrf6Vl26pstHAH/imDlPVMfWb0PeHVPrFoEUQXyy6P232pC5mjzRFiLy2h+wFQ+0Wt6d
 va5oJKbiZyoZ7s9rQLL0ASKXD+7cCIe80q3OEdr91ZqgYbMw47AQpslRQ4QegQD/zsk1fs8hL
 bK5ICTGvQaHfIkd4WRXfXY7KWACtjrFOO9kWLywNl91eUtPmU2EIT/+5pColTLysAXOXvXxzL
 yjIs6A6+wzHJxeQ8vUPB3OqpJeQXWnkWgVt+1rtBMJNF1FKsjxfgiy6kNqyyH2XqWTUpE9mk5
 s26fVma0E+lfk7I/Z02S4Es5gUzpmlTbhNyvCD9LmWjb9HM4RUDQSrgZ+VYQiXJgnWq+z5xUY
 S4aW1fmX/b4mIgBsODQp7eFZ3ffgDaw88VOEzTUGWHVTdh79J2xtp2czd2S+pGO/+//cIUNrZ
 mQg6WmSmMEwfFDaIfhB8huGKeIIlBqBYEm9WNuZppsSzerajmoX5iyeJE+eNiZ6UqkuIShmpV
 bm9QkY1iRjw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 25 Mar 2019, Johannes Schindelin via GitGitGadget wrote:

> Johannes Schindelin (5):
>   docs: move gitremote-helpers into section 7
>   docs: do not document the `git remote-testgit` command
>   check-docs: really look at the documented commands again
>   check-docs: do not expect guide pages to correspond to commands
>   check-docs: fix for setups where executables have an extension

FWIW I am also working on a follow-up patch series [*1*] that resolves all
issues reported by `make check-docs` on Windows, but I do not want to make
this here patch series even bigger (from an initial single, relatively
small patch).

Ciao,
Johannes

Foontote *1*: Tracked here: https://github.com/gitgitgadget/git/pull/168
