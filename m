Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39291F51C
	for <e@80x24.org>; Mon, 21 May 2018 23:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbeEUX4X (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 19:56:23 -0400
Received: from avasout01.plus.net ([84.93.230.227]:56531 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeEUX4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 19:56:23 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id Kuf7fUs0vV3GyKuf8fvswZ; Tue, 22 May 2018 00:56:22 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=EIQoLWRC c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=fS0KY3Obw_cdoUW0ZJEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     martin.agren@gmail.com
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: symbol string_list_appendf() unused
Cc:     GIT Mailing-list <git@vger.kernel.org>
Message-ID: <d203f6ef-f684-cf6b-07b0-553b6b79e189@ramsayjones.plus.com>
Date:   Tue, 22 May 2018 00:56:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHwEk74or5OYfE/aK5mYnmHEBLUbqIPr9lvOCh11rsgSV5XEodQVD/boNhw9xPWwSG192h7g4jLva6PkrsWmhBPItCB08OMFfpyO3ZMZstb8MmoU7ekc
 MhYHkliBTdrsPWEwRLA9ciHE7bTNkjvqnNSq6aLklA46xQYGa1LnpQcGB46WUXzI1dnZ+j5rUpEifg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

I strongly suspect that I haven't followed the discussion on
the list closely enough, but your 'ma/unpack-trees-free-msgs'
branch in 'pu', seems to define string_list_appendf() but then
never call it. This is despite commit 40ebd6c7b0 ("string-list:
provide `string_list_appendf()`", 2018-05-20) claiming that:
'The next commit will add a user'. ;-)

Have I missed something?

ATB,
Ramsay Jones

