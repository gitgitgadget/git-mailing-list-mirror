Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710F31F428
	for <e@80x24.org>; Sat,  8 Sep 2018 20:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIIA76 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 20:59:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36675 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727608AbeIIA76 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Sep 2018 20:59:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 91AD121175;
        Sat,  8 Sep 2018 16:13:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 08 Sep 2018 16:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=bWhCfFlzMC6Z8U0iWubrR+citDs8Y
        uwxFZxn50I/g24=; b=ryAsXF6+5NKOW+Zl+C981PrEDMWhUQpMgAg7DSqKrB5yj
        jUqYLXsyO1KwduFJ2nC491yA2zboJCEkr5k1OarunHQ7dkRb/gNslnsmXhS7rl4g
        LP9Ah9/9vDIYV/OMS+8ME7V5AdB25QuI8uZOAou/v5TaA9jH6sa6qG/Gc8Uh3UUf
        bh9WL/MA2I3UGY+8IWxOpljCgBB/mumoTc6kyCErY14m8DbDxJgEDy2gUOJju81o
        P2CVCiaPikYIEWdHBkKH2oWg6ZiSgL2Gzwq69Uj0ZD8OCSwwWNm5fPaPG07bTWbM
        Qwt/nOyb5jWGCxHI5A64ndIJSX5YpPwuZQSxG//aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bWhCfF
        lzMC6Z8U0iWubrR+citDs8YuwxFZxn50I/g24=; b=IcnZTxi7HyNvR5HbnsPVsW
        RzHHiFUd+5IL/0Il7ZGiHYLIvfpseWD07y/f6pNvUmN1pGazLXOdnRtJh2Ny1Bop
        gXSivL/zZAzyg++VhYuJTkIA14phA2PH0+TpdaFiGYuWxYHQ64JSAmVZ38cg9795
        34xlEK54rpbiqw9BZ3DL7tydENkGrdO9ExRFFVNG2iahtFqwEIBaH7EOkswZCEHv
        hS8UKa3QbFORas3FypPP4LNc46hwp+4hb4E1MzN6aIdzoCrKMc1QMl5Nis3+BQy0
        cImrOU1pNuyDTCndQ1lwIX+uUJYs9M4MYXcaZadJWtDkuvcejzXXM3SeiZeTr7kQ
        ==
X-ME-Proxy: <xmx:Ti2UW0fxQxtX0UoCBb8YNvXxwwjLZCV3XHQ9IgqxFwvycnd02-Hqng>
    <xmx:Ti2UWxrTvfRuv4EsVcE_PzIvQnfhAY9lj75PlNUDBYWAO92WySyxkw>
    <xmx:Ti2UW5BRX3CHdIBQFlITuxPBHQu23Fm5Wm_W84bllb-p5H_QeQbWGA>
    <xmx:Ti2UW-YAyqfPtF3hynwftILdrLyAWc4fGrld0VrXB3YNNHP717AafQ>
    <xmx:Ti2UW86Y69i-NTHSYTtYTnm2cvLIWnt0d7Swph0rDkODRLWzlhMZug>
    <xmx:Ti2UW1DlpEuKOHP7eBpmNIa5khMfEBV-9BDjwGykV3RmBfiKyFewXw>
X-ME-Sender: <xms:Ti2UW9ad99jFOGr-Hwp_cuArmIcUjgFFhe9tWPmIJP4DIo4pR2qsQw>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 854BE10297;
        Sat,  8 Sep 2018 16:13:01 -0400 (EDT)
Subject: Re: git silently ignores include directive with single quotes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
 <a76c94c6-9fd7-4ed0-be2d-6fc1d021f476@stason.org>
 <87a7orrc3w.fsf@evledraar.gmail.com>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <acf93aef-f1f8-1aab-a16d-9655402d445f@stason.org>
Date:   Sat, 8 Sep 2018 13:13:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87a7orrc3w.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-08 01:02 PM, Ævar Arnfjörð Bjarmason wrote:

> Aside from other issues here, in the "wold of unix" (not that we only
> use the git config syntax on those sort of systems) you can't assume
> that just because some quoting construct works in the shell, that it
> works the same way in some random config format. If you look in your
> /etc/ you'll find plenty of config formats where you can't use single,
> double and no quotes interchangeably, so I don't see what hte confusion
> is with that particular aspect of this.
> 
> Although as I mentioned in <87bm97rcih.fsf@evledraar.gmail.com> the fact
> that we ignore missing includes definitely needs to be documented, but
> that our quoting constructs in our config format behave like they do in
> POSIX shells I see as a non-issue.

I agree that I should make no such assumptions. Thank you. But it is a
cross-platform problem. I remind that the original problem came from a
simple command:

 git config --local include.path '../.gitconfig'

Which on linux removed the quotes and all was fine, and on windows the
same command kept the quotes and the user was tearing his hair out
trying to understand why the custom config was ignored.

So you can say, don't use the quotes in first place. But what if you have:

 git config --local include.path 'somewhere on the system/.gitconfig'

you have to use single or double quotes inside the shell to keep it as a
single argument, yet on some windows set ups it'll result in git
ignoring this configuration directive, as the quotes will end up in git
config file.

I'd say at the very least 'git config' could have an option
--verify-path or something similar and for it to validate that the path
is there exactly as it adds it to .git/config at the time of running
this command to help the user debug the situation. Of course this won't
help if .git/config is modified manually. But it's a step towards
supporting users.

I hope this clarifies the situation.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
