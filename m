Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2313A1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 18:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934598AbcLTSzA (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 13:55:00 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:17842 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932658AbcLTSy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 13:54:59 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tjn5t0FCpz5tlF;
        Tue, 20 Dec 2016 19:54:58 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C2F5D2222;
        Tue, 20 Dec 2016 19:54:57 +0100 (CET)
Subject: Re: [PATCHv4 3/5] run-command: add {run,start,finish}_command_or_die
To:     Stefan Beller <sbeller@google.com>
References: <20161219232828.5075-1-sbeller@google.com>
 <20161219232828.5075-4-sbeller@google.com>
 <aad0af97-7588-632d-a113-5d8372b8b7a8@kdbg.org>
Cc:     gitster@pobox.com, git@vger.kernel.org, bmwill@google.com,
        sandals@crustytoothpaste.net, David.Turner@twosigma.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8a75de4b-76aa-c111-6946-91a709d890f7@kdbg.org>
Date:   Tue, 20 Dec 2016 19:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <aad0af97-7588-632d-a113-5d8372b8b7a8@kdbg.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.12.2016 um 19:33 schrieb Johannes Sixt:
> Am 20.12.2016 um 00:28 schrieb Stefan Beller:
>> +void run_command_or_die(struct child_process *cmd)
>> +{
>> +    if (finish_command(cmd))
>> +        report_and_die(cmd, "run");
>
> And here as well.

Oh, and BTW, this one wraps only finish_command, not run_command.

-- Hannes

