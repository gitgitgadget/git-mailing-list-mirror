Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D573B1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 08:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfBKIuJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 03:50:09 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:48328 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfBKIuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 03:50:09 -0500
Received: from [192.168.3.76] (unknown [146.247.95.34])
        (Authenticated sender: jn.avila)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id BF46B20042E;
        Mon, 11 Feb 2019 09:50:02 +0100 (CET)
Subject: Re: [PATCH] Fix typos in translatable strings for v2.21.0
To:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <20190209213044.29539-1-jn.avila@free.fr>
 <20190211064453.5205-1-jn.avila@free.fr>
 <CANYiYbHoNV+6yi6a75oh2nPpihsqEu0Fq+8R_G6O+XOD5JogoQ@mail.gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <1517c545-0028-56e4-fc58-fb3c6d3551fe@free.fr>
Date:   Mon, 11 Feb 2019 09:50:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CANYiYbHoNV+6yi6a75oh2nPpihsqEu0Fq+8R_G6O+XOD5JogoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 février 2019, Jiang Xin wrote:

> Jean-Noël Avila <jn.avila@free.fr> 于2019年2月11日周一 下午2:48写道：
>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>> ---
>>  builtin/bisect--helper.c | 4 ++--
>>  builtin/fetch.c          | 2 +-
>>  builtin/rebase.c         | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
> This re-roll is v2 (forgot suffix v2 in subject), and LGTM.
> Difference between v1 and v2:
>
>      -              die(_("--reschedule-failed-exec requires an
> interactive rebase"));
>     -+              die(_("%s requires an interactive rebase",
> "--reschedule-failed-exec"));
>     ++              die(_("%s requires an interactive rebase"),
> "--reschedule-failed-exec");
Thanks for reviewing. The first submission was too hasty and did not
even compile.
