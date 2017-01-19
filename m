Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C9120A17
	for <e@80x24.org>; Thu, 19 Jan 2017 23:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbdASXnC (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 18:43:02 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34685 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbdASXnB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 18:43:01 -0500
Received: by mail-lf0-f67.google.com with SMTP id q89so6932924lfi.1;
        Thu, 19 Jan 2017 15:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AKGrcVKN5+hgFNDckRVe3RWKtHMSdp8X58mgza4pBng=;
        b=QlHbFhXXYnQ3HE9951cnoHbiFNISHyLkFEnFG2fQtp4U/1plHxsvNlafeR9DVEEnjZ
         AayV5FscXCpqdau0OP73WAZUgOHnJPpiybsyvx5iHFc7drHt8mUjcoXeqNYw4FGER9u2
         psAARbQkaqNvacGrc8Wnct5/VDBSS9UXZi9NoUZqWb4tX361aPrTVWAYdSu+V7aXDO3X
         TZ5mZGH9j2idsr2E4wQunYIIrTps7Y89BQjo6x7bMewXqSVBkA1z5B3+th9LGCfVm8Fo
         HCw9XethEQZjbVarhF40vmOC3Dh90d9KZjyXZNT5CBUlMf+Viq/GU9Gf1HB2xpzAPKwE
         mrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AKGrcVKN5+hgFNDckRVe3RWKtHMSdp8X58mgza4pBng=;
        b=eXU8EtH0oEU6pOYwU9nXLQiZA9G1pkfyQLH2PyKv1D5QRK+p0jdm9V58wVb+3PeVVj
         3vfct78K3VUKQV+wh/Kgydw7ndqaoBhJQowjyQq/+4KLkK+dEspIPD4uZ03kdrdanEQK
         f6BDtG6DCZJ0SSrEMMsUSVcnj6JG6QiDEUql7TB0wgG3FxufG2FZ4SJ85Kgo9huadFtq
         2sdz/UjviCEbkSKw8xcQ12x5NjEnxDawSIMlwJ/GW6OElbRM38lfy/jAUokKwchMME9V
         e/CBSAKovExInJvnTyKFx5QlmdVOuDzpuBBEGSFYY10oNw3i163rzTBHjRvdwubES8oG
         ycrA==
X-Gm-Message-State: AIkVDXLCFyC+OOv60je1jTGpaBQmBBC2+LpbyMto901VIRZwTyqOmCIGBhwHYR/j7DEm7Dgli2M43bZ/yBMcgw==
X-Received: by 10.25.74.72 with SMTP id x69mr3785819lfa.66.1484869354747; Thu,
 19 Jan 2017 15:42:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 19 Jan 2017 15:42:14 -0800 (PST)
In-Reply-To: <20170119212039.3gixsrk7qco45wjo@sigill.intra.peff.net>
References: <20170115183051.3565-1-wsa@the-dreams.de> <xmqqlgubc04z.fsf@gitster.mtv.corp.google.com>
 <20170119204343.xtotmjddhbum2mvr@ninjato> <20170119212039.3gixsrk7qco45wjo@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 19 Jan 2017 15:42:14 -0800
Message-ID: <CA+P7+xo5N66a8-PeNRLBgwRN3rJZRbQuDnx8wCnW7L-0tz10Fg@mail.gmail.com>
Subject: Re: [RFC for GIT] pull-request: add praise to people doing QA
To:     Jeff King <peff@peff.net>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 1:20 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 19, 2017 at 09:43:45PM +0100, Wolfram Sang wrote:
>
>> > As to the implementation, I am wondering if we can make this somehow
>> > work well with the "trailers" code we already have, instead of
>> > inventing yet another parser of trailers.
>> >
>> > In its current shape, "interpret-trailers" focuses on "editing" an
>> > existing commit log message to tweak the trailer lines.  That mode
>> > of operation would help amending and rebasing, and to do that it
>> > needs to parse the commit log message, identify trailer blocks,
>> > parse out each trailer lines, etc.
>> >
>> > There is no fundamental reason why its output must be an edited
>> > original commit log message---it should be usable as a filter that
>> > picks trailer lines of the selected trailer type, like "Tested-By",
>> > etc.
>>
>> I didn't know about trailers before. As I undestand it, I could use
>> "Tested-by" as the key, and the commit subject as the value. This list
>> then could be parsed and brought into proper output shape. It would
>> simplify the subject parsing, but most things my AWK script currently
>> does would still need to stay or to be reimplemented (extracting names
>> from tags, creating arrays of tags given by $name). Am I correct?
>>
>> All under the assumption that trailers work on a range of commits. I
>> have to admit that adding this to git is beyond my scope.
>
> This sounds a lot like the shortlog-trailers work I did about a year
> ago:
>
>   http://public-inbox.org/git/20151229073832.GN8842@sigill.intra.peff.net/
>
>   http://public-inbox.org/git/20151229075013.GA9191@sigill.intra.peff.net/
>
> Nobody seemed to really find it useful, so I didn't pursue it.
>
> Some of the preparatory patches in that series bit-rotted in the
> meantime, but you can play with a version based on v2.7.0 by fetching
> the "shortlog-trailers-historical" branch from
> https://github.com/peff/git.git.
>
> And then things like:
>
>   git shortlog --ident=tested-by --format='...tested a patch by %an'
>
> work (and you can put whatever commit items you want into the --format,
> including just dumping the hash if you want to do more analysis).
>
> -Peff

This sounds interesting to me! When I have some more time to take a
look at this i might see if I can revive it.

Thanks,
Jake
