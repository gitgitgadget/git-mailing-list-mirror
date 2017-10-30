Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6131F202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932599AbdJ3Rk3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:40:29 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:53149 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbdJ3Rk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:40:28 -0400
Received: by mail-qk0-f170.google.com with SMTP id b15so17143887qkg.9
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4ASdVnaVhlJ+xoO0E07XzdIIalY2DK1q7TukfsRviGY=;
        b=RnwTStPPi++WBGox4HbYzMaifXKplyLlrW2qYgKjopCPnUYNua+FcG8FrbmDk5Lowb
         gFcSfY8KKE59/Q5qcH6hXuXII6kX37zIn0cM/HEAZZT9uAE6O7fcN6u+efUnRYS/ZQqe
         SEVMHOOicwArCRJL+h9AR0j+9XmscxCkB752NhaaUyd1y0NrgVKTrzbm++8TBR197B6b
         X0la7Nqhhkg2C3WQgkmoGEg70PAhNYIYuSlUVvWqtTINOKbkZN8sjzMEAt4i4C3R+BIJ
         d/zG+oaCIawrpEAcHuIzImVK3uCsAL2+/ffIsUmvYpXVfg40wEs4tOVNWbW7Zj1Lig5F
         o4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4ASdVnaVhlJ+xoO0E07XzdIIalY2DK1q7TukfsRviGY=;
        b=S5H8aCLR0ap4nClpI/0MrAL5VenX0hgZvZPt7m5lG8kaNk3/EjBRPEN0QpIXGTxrcs
         36wwB9mem47At66nusPcnUA9EhooTJKhMw3sbVPqehOwvi5ofaXpJdWDO0h+ojEv7wnA
         OTpyJtc/qQ5xMrLKfHfEDWl1vo7VisUVQ4G5/yaDBy8/A5plJrLULbfe7/wn0cnP4xQx
         nwxNkiRpJH+TNa/NwjjxwkjRKmRMA6/TMzYtvuCZ3tG4e5/WhRuIfy8MAPsXGjMnCLiE
         K/RMmXf+QKGkHk8AdJ3mWWkqdqU3gT8NBTtp2sExK2MWKw+KYovG4bgz4RpCtc0TUpAI
         M5yg==
X-Gm-Message-State: AMCzsaUkpXJvcJliErRuHzIJrf9fs+9vp128QsuXdJD91fKq1SnKN9Oy
        9H0++KrSx065cVyG2pJEnFTK3im99ME+XvvWxIE=
X-Google-Smtp-Source: ABhQp+Rk2+HPnxJlv05odzlXl0u+VJN59fMMJoLUs2KknZ9yjARzIFdN+PjQO5UGy2qHB2+j4YYE95yJinTVgud9CgA=
X-Received: by 10.55.99.10 with SMTP id x10mr14855153qkb.112.1509385227623;
 Mon, 30 Oct 2017 10:40:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.20.162 with HTTP; Mon, 30 Oct 2017 10:40:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710301333420.6482@virtualbox>
References: <20171029211308.272673-1-sandals@crustytoothpaste.net>
 <20171029211308.272673-3-sandals@crustytoothpaste.net> <xmqqa8096yzu.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1710301333420.6482@virtualbox>
From:   Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Date:   Mon, 30 Oct 2017 18:40:07 +0100
Message-ID: <CAHVLzcnS6n_BODDo3wrBzNkpEPTYBLD0V51H4O10q82J=xYnqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: convert SubmittingPatches to AsciiDoc
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 30, 2017 at 1:35 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 30 Oct 2017, Junio C Hamano wrote:
>
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>> Thanks.  I personally prefer the plain-text original, but I do
>> understand the need to have a version with ids that you can tell
>> others to visit in their browsers.  Assuming that this goes in the
>> right direction, here are a few comments.
>
> If you want to go into the direction of the web, AsciiDoc is actually the
> wrong choice IMO, and Markdown would be the right choice. Basically
> everybody on the web is either supporting Markdown or being asked by users
> to do so.
>
> Assuming that *that* is something we want to pursue, I would also suggest
> to move the man pages away from AsciiDoc to Markdown (using e.g.
> [ronn](https://rtomayko.github.io/ronn/ronn.1.html)).

Nitpick, the right URL is: https://rtomayko.github.io/ronn/ronn.1.html
You put an extra ')' at the end and therefore I've got a scaring 404 error :-)

Ciao,
-- 
Paolo
