Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28CC7200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeECX1M (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:27:12 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:47721 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbeECX1L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:27:11 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id ENcvfgq2NgCgnENcvf6JTS; Fri, 04 May 2018 00:27:09 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=FNM1Odgs c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=d-mH9-6W5xbN2u8A67cA:9 a=QEXdDO2ut3YA:10
Message-ID: <8DBB15A6A2AB48C7A9914B5B419E001F@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        <git@vger.kernel.org>
Cc:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Thomas Rast" <tr@thomasrast.ch>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Thomas Gummerer" <t.gummerer@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <fe12b99a0b4f78ab75fcfbcf51c5edffb190c4e8.1525361419.git.johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/18] branch-diff: add tests
Date:   Fri, 4 May 2018 00:27:04 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180503-4, 03/05/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfAhcStYQbzVVWlVgtks4m3paEb/O+QYEKBuZcNWXERj+XRqCizZ4VL4zXCF42MuuwRyMuFcocjtIA/BbG77RMpfV/MrO52gTFQnG/dT4GNm9ijhDCEqh
 ywoNpgT0VALpGI+VECXJTD/1bEJMvHCAVQhiv4bfnpARieRPSEZ6SCiWteOBW5KUsUhv2AsdZIzw875XC2uYOHLXyrvuvTZL0NuycqNgM0kadcXc+tJsjqjy
 0+y3I22uPxxuOYXcajFXDU28bSQ5MQWY6ylad/Me5vR7ZZyOuBUWBAgrnqSZIqBPO5Lz6gDlp+MATr6wuCgSJyw/kwdp8ZOoLRBINKJi18/+pjrVRA0tz5p+
 tBuKHEgR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> From: Thomas Rast <tr@thomasrast.ch>
> 
> These are essentially lifted from https://github.com/trast/tbdiff, with
> light touch-ups to account for the new command name.
> 
> Apart from renaming `tbdiff` to `branch-diff`, only one test case needed
> to be adjusted: 11 - 'changed message'.
> 
> The underlying reason it had to be adjusted is that diff generation is
> sometimes ambiguous. In this case, a comment line and an empty line are
> added, but it is ambiguous whether they were added after the existing
> empty line, or whether an empty line and the comment line are added
> *before* the existing emtpy line. And apparently xdiff picks a different

s/emtpy/empty/

> option here than Python's difflib.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[...]
Philip
