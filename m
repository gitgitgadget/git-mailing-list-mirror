Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B911F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeAXVPs (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:15:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:62456 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932238AbeAXVPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:15:47 -0500
Received: from [192.168.178.43] ([88.70.141.243]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3vCA-1ewOia0dTW-00rWPQ; Wed, 24
 Jan 2018 22:15:42 +0100
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Isaac Hier <isaachier@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180123001648.24260-1-isaachier@gmail.com>
 <CAG6xkCZn6m2n0rDvpN6MmZcOr2hJBRCfhrppC37f-DUj3_JZsw@mail.gmail.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <c5d21b22-e4cd-e338-c953-90a81981e23c@gmx.net>
Date:   Wed, 24 Jan 2018 22:15:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAG6xkCZn6m2n0rDvpN6MmZcOr2hJBRCfhrppC37f-DUj3_JZsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:E2OcanPN+h30h525P8+f9du2BAcCpJ/0cRI4CuZcJAoE4vneOqE
 OEArxag0imNdqDqO3XcKwbsf+PO5m9wi0+spisTjWMJQ6KiAkAsqlBJdVnVs3jgtGWDswuf
 74zT/MZgVuAkEezlhY+Z5tbHM6UFa5cZeB3AKTmxDasWWr9HW6I8uFn2EknxL+9/KG0NPgb
 NjoMC6fF1ReTUVd1wqjTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GLNyv+NyDhs=:LoEnxxINK5y+UM0diYKZhb
 gSNMDEcPizrJ/xZvDrxzvQH5gpV9mKk8S6hydZOPl37AgBKqg9qrDqOP33ZKWg1nFBkULRFVK
 4Cl2GWgL3cypa5Zr3HuMke/2jxkig/ttQAP/8mwxCiRwWs+affOa/oRQzzREhz7EympZufqgV
 76ZNOWVV6txLCyIPe8gfPGn+f8WDDu5/GJ8r9yvuEyaIR/w7GUSPjLO5AmtvhDeBqleXf+PW6
 pxMeAn/dyzwpLOMWbwG55QaWexyg7ZAXxDw/lYKvOGaLrGtSM8pKtThkoLMRMq1t87cJQtXDh
 DeLIw3MUif89q+DWmR1dhDTmuASTpTQDq5sBbt3JcCSbPtU+aqmtErkZAfqW15q5y1b/cB47c
 BaIGqzQVR78ANDwd72Jo1HnpGONDQnsEoudGf8DLho2Jy4tUqBLjuHjF6y1O8K4q8DkkkZ49F
 tDIQtysh72OfIO+ftEAKd+qAb9kfkX+2bPmRuIv4sNUuJfPdbKnG+ukFjoZmVHFEyLCxeXSRX
 sfUS1xa+sf6MFOgVmX4QaImkmSa6mHUGkEjrgxRXEosO6XWOpHOam6OTjdqH0GKAXDvI8/2yt
 FTIAy8/7Kiobci4KclUsJggOjYF80E5bc1ePyn0qPKQ7cNwFOpfCVMm0uOjy2gSE9hhBrfXCn
 YW+MJ3xjGMRfxBpAwxX2sdnEEtTxm3ITjqu7Ko9MgNp4j3sqw1v+zEaZDIde955zjdvObKlfq
 ur991DMRgs0HQ90wmcyUtfH9zcRNJrm1QoqM3LIXVCU/h+Y7y0viQerOQ7dTs/YLiMAcxVbHl
 tJ/bzHHbmNGguXXdipaQrtorvQLkWPVdgrv4A1qcy7QEkdZsxY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Isaac,

On 01/24/2018 02:45 PM, Isaac Hier wrote:
> I realize this is a huge patch, but does anyone have feedback for the
> general idea?

Thank you very much. I am *personally* interested in this due to several
reasons (which are mostly that I am used to CMake and when I do
something on the Git codebase, I always end up that its build system
recompiles everything ...which drives me crazy as hell. Using CMake, I
could simply use out-of-source builds and be happy).

I am not sure if it should go into the main Git repo. I'd already be
happy if I could pull it from somewhere (github for example) and rebase
it to use for my local branches.

~Stephan
