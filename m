Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C461F453
	for <e@80x24.org>; Sat, 29 Sep 2018 15:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeI2VnI (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 17:43:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43191 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeI2VnI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 17:43:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id u23so10562542edx.10
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=le+SXr3JVXxl5IUfVDGtdhN3w9W7LA6leCQRTLBiNXc=;
        b=ROcNnWZ/56+i5HX69MQPP8V7MLSutfZvdbXMsmWGjUWQ/Pzx6uF12szNa/DxwXec6w
         qiNv4xbieCsPuasHrIg3Y3+DoiI8R2hr6ZvFsOK/YlwtI60vHjnpAP8MVqlUHomQbGms
         nDbGWTTjligbz+X8n2vHCmMwUA0PDmUkgwuiQjrBBJRmeER4ILIZrOC11VxgtgVIqb/u
         byOfKk0VWkhVgZ8ASSI8KmPKnQs78KxXG1kkbr17lj4m1SxrgC5I6lo0urf0GY3Hxkmu
         Vukgy6Ya8t11JYutjY77bqhCoKdVG2EDAvugEZOZ4BCL/2bh1kO1E8woyp6LIlAaplKJ
         d5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=le+SXr3JVXxl5IUfVDGtdhN3w9W7LA6leCQRTLBiNXc=;
        b=UwxodE25aCrbZmJ+uMLTCdYmehvA5g2Q4Tieofmkef+oqGDh5dHRvOZlv5FLuFA9tx
         VfYDPA5Mls3R4/CLcAmUKTAO9EF2LtaFEHmxdMT+qd2MiGdoitSrHc6lg4940d8iTR7o
         jeTF7OZ+ZvHM2/1Epvz33ZC0lb5f6VfnMYUn9gSTA/l6d4i+bS+KQStpOCUtaAMgXN89
         WqlimNedgxeHM8RZb139wViEKiPFt+/vBkGIdkLwGsm/rctB0bNJSptXPbLt3zD8V6/V
         20Cz5q/Kfr6NTZ+A/tOPe9i6qQpOP40Zqxv+Pe2s6EYCHxT/j4H38SdIiDNHXZvF89F/
         sJnA==
X-Gm-Message-State: ABuFfojochK9m57inzB0h3I6b+GN0xR5SJmsmOa8M3SaXTnMkewA/yTB
        o3yuNRC3YQ7Gg7NEfwzlglppACrheYI=
X-Google-Smtp-Source: ACcGV60IU4uRX5QgWS0WQdI2t4k0ssqQefRmXQd/2PQgu51FSek0EjlMnxDsvgspWEHkutfEQSOGYw==
X-Received: by 2002:a50:ed1a:: with SMTP id j26-v6mr8568562eds.29.1538234059364;
        Sat, 29 Sep 2018 08:14:19 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id a21-v6sm2859977edr.57.2018.09.29.08.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 08:14:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Subject: Re: Git for Windows for Unix?
References: <87va6rhqup.fsf@evledraar.gmail.com>
        <20180927160523.GA112066@aiede.svl.corp.google.com>
        <87tvmaj4fq.fsf@evledraar.gmail.com>
        <20180927162623.GB112066@aiede.svl.corp.google.com>
        <87ftxtieeg.fsf@evledraar.gmail.com>
        <20180928204233.GA193055@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180928204233.GA193055@aiede.svl.corp.google.com>
Date:   Sat, 29 Sep 2018 17:14:18 +0200
Message-ID: <87efdcibed.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 28 2018, Jonathan Nieder wrote:

> Ævar Arnfjörð Bjarmason wrote:
>> On Thu, Sep 27 2018, Jonathan Nieder wrote:
>
>>> That said, that seems to me like a lot of work to avoid adding some
>>> patches to "next" that belong in "next" anyway.  I understand why the
>>> Git for Windows maintainer does not always have time to upstream
>>> promptly, which is why I suggest working with him to find a way to
>>> help with that.
>>>
>>> If there's something I'm missing and Git is actually an uncooperative
>>> upstream like the cases you've mentioned, then I'd be happy to learn
>>> about that so we can fix it, too.
>>
>> That's one and valid way to look at it, convergence would be ideal.
>>
>> Another way to look at it, which is closer to what I was thinking about,
>> is to just view GFW as some alternate universe "next" branch (which by
>> my count is ~2-3k commits ahead of master[1]).
>
> You could view it that way, but I don't.  Many Git for Windows patches
> have never even visited the Git mailing list.

Not to beat this point to death, just replying because I'm not sure if
we're talking past each other, or if you're just vehemently making the
point that these patches *really* should be sent to the ML (which I
don't disagree with at all).

I meant "alternative universe 'next'" in the sense that it's a published
branch that's shipped to people and is consistently ahead of master, not
that the same process of sending patches to git@vger.kernel.org has been
used to generate it.

In the case of GFW they have their own internal contribution mechanism,
GitHub PRs etc., and only eventually submit things to the ML.
