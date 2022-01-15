Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4698DC433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 09:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiAOJED (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 04:04:03 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:61335 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbiAOJEC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 04:04:02 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4JbXKD334Tz5tl9;
        Sat, 15 Jan 2022 10:04:00 +0100 (CET)
Message-ID: <5f6f1dba-a923-4bb9-70a7-4936566f46e0@kdbg.org>
Date:   Sat, 15 Jan 2022 10:03:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: A new feature command request `cmd_ignore`
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>
References: <11860e44-beff-39e6-2efc-53324223caee@gmail.com>
 <CABPp-BFY2issEqOj1Oj71k=494vc8E563CndxPZfXYrteFoNhw@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CABPp-BFY2issEqOj1Oj71k=494vc8E563CndxPZfXYrteFoNhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.01.22 um 06:17 schrieb Elijah Newren:
> On Fri, Jan 14, 2022 at 3:03 PM Jaydeep Das <jaydeepjd.8914@gmail.com> wrote:
>> and other parameters like `--force`
>> could be added which would delete that file cache if that
>> file was already committed.
> 
> I don't understand what you mean by this.

I think that is a paraphrase of the suggestion to

   git rm --cached settings
   echo settings >> .gitignore

when changes to a file 'settings' that was already tracked (and often
contains user-specific settings) should be ignored. This misguided and
short-sighted "solution" is repeated numerous times on Stackoverflow.
Not something that we should encourage.

-- Hannes
