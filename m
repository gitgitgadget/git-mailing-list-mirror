Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE11EC433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 20:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B769661053
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 20:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbhIBUHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 16:07:08 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:50652 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344861AbhIBUHH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 16:07:07 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4H0sPV1cDnz5tlC;
        Thu,  2 Sep 2021 22:06:05 +0200 (CEST)
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <xmqqk0k0ndbq.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2109021616300.55@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4e998676-4975-8ac2-35a0-34416938b62e@kdbg.org>
Date:   Thu, 2 Sep 2021 22:06:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2109021616300.55@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.09.21 um 16:18 schrieb Johannes Schindelin:
> On Wed, 1 Sep 2021, Junio C Hamano wrote:
>> A good goal.  There is no remaining use case where (a fictitious and
>> properly working version of) "--preserve-merges" option cannot be
>> replaced by "--rebase-merges", is it?  I somehow had a feeling that
>> the other Johannes (sorry if it weren't you, j6t) had cases that the
>> former worked better, but perhaps I am mis-remembering things.
> 
> I think that I managed to address whatever concerns there were about the
> `--rebase-merges` backend in the meantime.

That was either my suggestion/desire to make no-rebase-cousins the
default. That has been settled.

Or my wish not to redo the merge, but to replay the first-parent
difference. The idea never got traction, and I've long since abandoned
my implementation of it.

> To be honest, I developed one (minor) concern in the meantime... Should we
> maybe try to be nicer to our users and keep handling the
> `--preserve-merges` option by explicitly erroring out with the suggestion
> to use `--rebase-merges` instead? Not everybody reads release notes, after
> all. In fact, it is my experience that preciously few users have the time
> to even skim release notes...

A valid concern, I would think.

-- Hannes
