Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3CA21F403
	for <e@80x24.org>; Sun,  3 Jun 2018 12:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeFCM7a (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 08:59:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39575 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeFCM73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 08:59:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so9312566wmc.4
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 05:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MnKpBaoEjFwZuQPXcdRt0ySy2bML7YBb7RU2LVFdyds=;
        b=u487DtMJ6dnkCwJjS//pCEaB6GccwURS9y4eRDyt4uzEWUQVDUaRppg2nuICUTx5/B
         4TtsQdeEiBi0CW2+cOT79K/gDrB/nidxyBBWLA/cd51aKGoSgC5DkC6r9UtTgarikSwm
         9v0VPbLdEAFkIiUu+PKFGim1ldz9EHHbCs8FeT7y+lrekjhmCtoa2PD3OAPaE36k/L82
         ziySNHKrRjqAFeE6CNVxxzIrq7TceA1R/OPXbZb3sGNMxNGexbewV654xtqdKvdYSZj2
         v9hjFshZYExIC9M0J5HFSbdZnJqBcqR57UuOT0w7OX8aMzSpzxPe4L5zfNugpJGaAN1B
         Qj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=MnKpBaoEjFwZuQPXcdRt0ySy2bML7YBb7RU2LVFdyds=;
        b=rHFDaw3Cs37CG9iXRLK84lxlirv0HWraN90CYex5+gYRFnlfZT6RpGzl0KVv9phiei
         vgL9D08wR7ouyA9rlE0GVak/96mwnImmkbKi7xNfi32Na4KxNAzUXrMhg5g1JStbPonp
         TpAhROO5WV2tQ/+MGt4FoNIk4KyGXYBCDknX95Pt1+vQWzxCFXvpwjQyf9MfY96YHYGc
         whFF65C29PHgAY9/LdDaBE8paaN73uo7ySH9sD1wy9piMguv8ncw8tk7qGXXUcAPcfe9
         OYsQyd5h5ag9QE5Dmir2dZ+ggGzw+yDH5N7YtFi4B8x516BIY+IYV0lq0RyCPuolzLIe
         BMtQ==
X-Gm-Message-State: ALKqPwfueQuXRI7U2jiElgd9uajTR5RFlBxY8RMiI+C2HNCoihzFTGCW
        RQG+tZLPTQusXPTL3QztYKR5AiZD
X-Google-Smtp-Source: ADUXVKKZbKPqgaznuv0LCx2YsxdBhZc8fiG1vJh+GDjBcRPQFx2KEEUv8vzzpk/tF6kLMeZwlwe6nQ==
X-Received: by 2002:a50:b2e4:: with SMTP id p91-v6mr19834866edd.84.1528030768412;
        Sun, 03 Jun 2018 05:59:28 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id c24-v6sm26661156ede.3.2018.06.03.05.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 05:59:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
        <87y3hlecod.fsf@evledraar.gmail.com>
        <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
        <87vab087y2.fsf@evledraar.gmail.com>
        <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
Date:   Sun, 03 Jun 2018 14:59:26 +0200
Message-ID: <87tvqk81qp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 03 2018, Peter Backes wrote:

> On Sun, Jun 03, 2018 at 12:45:25PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> protection". I.e. regulators / prosecutors are much likely to go after
>> some advertising company than some project using a Git repo.
>
> Well, it is indeed rather unlikely that one particular git repo project
> will be targeted, but I guess it is basically certain that at least
> some of them will be.
>
> It is the same as a lottery, it's very unlikely you win the jackpot,
> yet someone wins it every few months. We should care about the entire
> community, not be too selfish.

I'm not trying to be selfish, I'm just trying to counter your literal
reading of the law with a comment of "it'll depend".

Just like there's a law against public urination in many places, but
this is applied very differently to someone taking a piss in front of
parliament v.s. someone taking a piss in the forest on a hike, even
though the law itself usually makes no distinction about the two.

>> Since the Author is free-form this sort of thing doesn't need to be part
>> of the git data format. You can just generate a UUID like
>> "5c679eda-b4e5-4f35-b691-8e13862d4f79" and then set user.name to
>> "refval:5c679eda-b4e5-4f35-b691-8e13862d4f79" and user.email to
>> "refval:5c679eda-b4e5-4f35-b691-8e13862d4f79".
>
> Well, this is merely pseudonymization, not anonymization. Note that the
> UUID, innocent as it may look, is not in any way less "personal data"
> than the author string itself. Your proposal would thus not actually
> solve the problem, only slightly transform it. Only when you truly
> anonymize (see my proposal about one way to to it), you can completely
> evade the GDPR.

In this example once you'd delete the UUID ref you don't have the UUID
-> author mapping anymore (and b.t.w. that could be a many to one
mapping).

This seems perfectly acceptable to be since the spirit of the GDPR is to
prevent easy Googling of who did what in the past, not to prevent
someone with tremendous resources from say doing a textual analysis of
all git.git commits to find out who authored what.

>> Sites that are paranoid about the GDPR could have a pre-receive hook
>> rejecting any pushes from EU customers unless their commits were in this
>> format.
>
> This won't work either. The GDPR makes each data processor directly
> responsible in relation to the data subject. So it does not matter at
> all who is pushing, it matters who is in the author field of the
> commits that were pushed. And since you don't have any information
> about whether those authors are residing within the EU or not, you have
> to assume they are and you have to obey the GDPR. Even if you are
> outside the EU and do not have any subsidiaries within the EU, the GDPR
> sill applies as long as you are processing personal data of EU citizen.
> Perhaps the authorities in your country will refuse to obey letters of
> request if the EU authorities try to enforce the GDPR on an
> international scope, but if you have a record of GDPR violation and you
> ever set foot on EU territory, you are fair game.

I think again that this is taking too much of a literalist view. The
intent of that policy is to ensure that companies like Google can't just
close down their EU offices weasel out of compliance be saying "we're
just doing business from the US, it doesn't apply to us".

It will not be used against anyone who's taking every reasonable
precaution from doing business with EU customers.

What do you imagine that this is going to be like? That some EU citizen
is going to walk into a small business in South America one day, which
somehow is violating the GPDR, and when that business owner goes on
holiday to the EU they're going to get detained? Not even the US policy
against Cuba is anywhere remotely close to that.

>> Instead I'll have a daily UUID issued from a government API
>
> Heaven forbid. ;) There is an old German proverb, warning that even
> humorous trolling might be dangerous: "Man soll den Teufel nicht an die
> Wand malen!" ;)
