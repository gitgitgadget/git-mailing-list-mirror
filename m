Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D4720954
	for <e@80x24.org>; Tue, 21 Nov 2017 11:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbdKULEy (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 06:04:54 -0500
Received: from avasout01.plus.net ([84.93.230.227]:51686 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbdKULEy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 06:04:54 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id H6MFeV8vpVlc3H6MGeeZaH; Tue, 21 Nov 2017 11:04:53 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GJx4KqFK c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=ae1XFxYb7XRSlvxsiVQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] list-objects-filter-options: fix up some sparse warnings
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <b1037774-6ae6-630b-f330-e95b1c3d681d@ramsayjones.plus.com>
 <20171121011634.dw6tdgp2s7lpl2lm@aiede.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b5a6ddb1-0971-92d1-4cfb-94366d8f14c3@ramsayjones.plus.com>
Date:   Tue, 21 Nov 2017 11:04:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171121011634.dw6tdgp2s7lpl2lm@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLjdNs/4sYOm/Y8EJ83WaYHlECDqQZKsOBFAtgTLRNskG9JDTsrJfwNddky8v5sU2SrjHRbCOa6bDkxmYih9PyaD9QAFy3MJY0DfnEIOkycP3cOCTLAR
 9AJlIVSdBdDa5jSPsL73UDgoGVl2kmBrvGI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21/11/17 01:16, Jonathan Nieder wrote:
> Hi,
> 
> Ramsay Jones wrote:
> 
>> If you need to re-roll your 'jh/object-filtering' branch, could you
>> please squash this (or something like it) into the relevant patch
>> (commit bf0aedcbe1, "list-objects: filter objects in traverse_commit_list",
>> 16-11-2017).
> 
> Micronit: can these messages use the ISO 8601 order 2017-11-16?

Hmm, I suppose I could try and train my fingers to use this unnatural
order ... ;-)

[It would probably be easier if I used git to output this for me, rather
than typing it into my email client!]

ATB,
Ramsay Jones

