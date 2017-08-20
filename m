Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AC0208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 10:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbdHTKpa (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 06:45:30 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34769 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdHTKp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 06:45:29 -0400
Received: by mail-pf0-f179.google.com with SMTP id h75so3003488pfh.1
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nslwppvR3J2GucsqwDLA/eQFxEemGsUUaBsh8eoocK8=;
        b=aayGpLNdbCSAI9j4EB25XD4vkO2IgAB7Re8jQ/6yfn24U0hhxfKZ9GXTCPFws7hODr
         ivbpUctYPuaBxDDgKGgcmdyH5rrlESjcboQw9zYiKEPkQZRSpb+i4uv5/ne1Q7mJ3Vz5
         +K2EoQWWbrzQst+jecr6QTDyOsY6g58NKQDjl5iyf8T4goGavVUZNLqSn9XssJHXJXE1
         uOcVKDBTR2TOygO3lFp/ZeeAMG2xu9j4Vz7nhMnhqoVr5quS5xRs+XP0j0EhOGgYAhkS
         3BnwM1tqnFHITR3WL5AYUo5oDknrGjpl5hFff5r93R8A/7AotJWePP3/idy2Yz0GTZXy
         vNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nslwppvR3J2GucsqwDLA/eQFxEemGsUUaBsh8eoocK8=;
        b=S1Wja7g4BrE5Mk+aga2Nnu9uBKqCfDlR0z6I0aJGbMOjbR8iNxu1j3Cwrmqt8KN7nf
         OqFqAkNs+tVeCMc+AXQude4NDvQlRww0YLkM1BOiNfnpi73omZwFDa4Q9tVLqso40dzm
         J25n3XClZNTLDhBfvCQ3KKJ2ZgaBqcBdZzmFJ8jE/w4lHzeBDKTDppunJGdnvE++RVKa
         zHEd2aq1xmKxA62sCxQ1QciHMRKsAHOnWndEJcHgZZz9MHQVZ6/22dOxNDir6fxL/Fq7
         JZjK+t94L/HmOZlizjMa/B6Xa6ItEMoes+A0j9ZtvGFXUwYQV1NOYXNDJT4C3Nycden9
         IDrQ==
X-Gm-Message-State: AHYfb5hJJezGkw311rg1GN0EW0t7umLYSkDhIQNVbA5RnDliQgtXFHY9
        iH+Rdb7r/dc/YzPEyqb5EgTUYAvwTg==
X-Received: by 10.84.231.131 with SMTP id g3mr15390892plk.283.1503225928817;
 Sun, 20 Aug 2017 03:45:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Sun, 20 Aug 2017 03:45:27 -0700 (PDT)
In-Reply-To: <20170820100633.ehn2sc7gwmm6lftd@sigill.intra.peff.net>
References: <cover.1502780343.git.martin.agren@gmail.com> <20170820100633.ehn2sc7gwmm6lftd@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 20 Aug 2017 12:45:27 +0200
Message-ID: <CAN0heSpdi7wNqj50ZeAStvf=pY-HRy=6Zx5t_Wo7tTnGjws-ag@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/5] Some ThreadSanitizer-results
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 August 2017 at 12:06, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 15, 2017 at 02:53:00PM +0200, Martin =C3=85gren wrote:
>
>> I tried running the test suite on Git compiled with ThreadSanitizer
>> (SANITIZE=3Dthread). Maybe this series could be useful for someone else
>> trying to do the same. I needed the first patch to avoid warnings when
>> compiling, although it actually has nothing to do with threads.
>>
>> The last four patches are about avoiding some issues where
>> ThreadSanitizer complains for reasonable reasons, but which to the best
>> of my understanding are not real problems. These patches could be useful
>> to make "actual" problems stand out more. Of course, if no-one ever runs
>> ThreadSanitizer, they are of little to no (or even negative) value...
>
> I think it's a chicken-and-egg. I'd love to run the test suite with tsan
> from time to time, but there's no point if it turns up a bunch of false
> positives.
>
> The general direction here looks good to me (and I agree with the
> comments made so far, especially that we should stop writing to
> strbuf_slopbuf entirely).
>
>>   ThreadSanitizer: add suppressions
>
> This one is the most interesting because it really is just papering over
> the issues. I "solved" the transfer_debug one with actual code in:
>
>   https://public-inbox.org/git/20170710133040.yom65mjol3nmf2it@sigill.int=
ra.peff.net/

Hmm, I did search for related posts, but obviously not good enough.
Sorry that I missed this.

> but it just feels really dirty. I'd be inclined to go with suppressions
> for now until somebody can demonstrate or argue for an actual breakage
> (just because it makes the tool more useful for finding _real_
> problems).

I actually had a more intrusive version of my patch, but which I didn't
send, where I extracted transport_debug_enabled() exactly like that,
except I did it in order to minimize the scope of the suppression. In
the end, I figured the scope was already small enough.

The obvious risk of introducing any kind of "temporary" suppression is
that it remains forever... :-) I think I'll add a couple of NEEDSWORK in
the code to make it a bit more likely that someone stumbles over the
problem and addresses it.

Thanks.
