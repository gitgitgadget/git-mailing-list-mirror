Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3575020988
	for <e@80x24.org>; Sat, 15 Oct 2016 21:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbcJOVCI (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 17:02:08 -0400
Received: from avasout03.plus.net ([84.93.230.244]:54317 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753478AbcJOVCH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 17:02:07 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id vx1y1t0030zhorE01x1zjL; Sat, 15 Oct 2016 22:01:59 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=N659UExz7-8A:10 a=EBOSESyhAAAA:8 a=tMeC1flY89oR8NJ0mNQA:9 a=pILNOxqGKmIA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] convert: mark a file-local symbol static
To:     Lars Schneider <larsxschneider@gmail.com>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
 <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
Date:   Sat, 15 Oct 2016 22:01:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/10/16 16:05, Lars Schneider wrote:
>> On 11 Oct 2016, at 16:46, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
[snip]
>> -void stop_multi_file_filter(struct child_process *process)
>> +static void stop_multi_file_filter(struct child_process *process)
> 
> Done! Do you have some kind of script to detect these things
> automatically or do you read the code that carefully?

Heh, I'm _far_ too lazy to read the code that carefully. :-D

A combination of 'make sparse' and a perl script (originally
posted to the list by Junio) find all of these for me.

ATB,
Ramsay Jones


