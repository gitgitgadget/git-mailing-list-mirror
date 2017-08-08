Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1273B208B5
	for <e@80x24.org>; Tue,  8 Aug 2017 12:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbdHHM74 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 08:59:56 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33427 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbdHHM7z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 08:59:55 -0400
Received: by mail-pg0-f46.google.com with SMTP id u5so14611673pgn.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=mdQRcueQVuPjhtL+c+yv+7pt/M5AIvG/+7bQ0IFGbrU=;
        b=pCE2YzutzHb2OqhvHrrsO2ztpZ0ExIkkVF6iybbImwvaxSG2Q341JniLR091T0KQdq
         Mawr4GDKz07LrqgexArD3O125i/DY0qDYx9MwSnA+HnA91UVWGI3ywF51qeOPhQUeT78
         MzG99FK8uhkyw4GXW9GgD/Xu9VqRSKNGFnxRoR+iEiHY4pHIB5E2d+qTZ83xNaFxmsW2
         +oc2TJSnEU9r7b7eTuS9BHwvjWalgcd83CBef+AqVxSc+liupI6MVDAdO+/Ou4mrlYI7
         oTA8ZPPt0S6KQ02SlDjEIGiR42TX+eWi6Zicqrf4HRn/X7RKN/PfKpKE7Id8Mzdf9rd+
         U0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=mdQRcueQVuPjhtL+c+yv+7pt/M5AIvG/+7bQ0IFGbrU=;
        b=Q7ikpL0F3JuqoKDWKfYjixBhWXlJyMtwkGHjW0ewz6SSth3LgtYiSD/WxbQo96SkIJ
         n6XhuMGMoMpwNP4kFkuMFetprLaEKM01BZqRgq8ANVrRFvLkXT+wf9N/Ns/KVWAK4+GY
         vaNdsbr3touF3/huxp1hgNanyQxV8Xv7TVgTJXqJCuXgEfmA/W4lH+aBJswdODiQ354L
         jhQw5aJ6S+cB0dcivxR4cfwCaGvQyTndaqD/4JdzPtbvmrV31PWN3F4p5Fgln1DEFKm/
         h7QUiIqBW+hxICGRB6LpjtkpYbSGjvaNcUMj5CcVjUydReauf79EjA6t2DAZFwPYaWQv
         rElQ==
X-Gm-Message-State: AHYfb5jLmTPmVP4ksrN4GZOmN6nqOU6Xs5yuTsfDDGO+Nez76DvNGvWM
        D2HGK0IglzNjdw==
X-Received: by 10.98.2.151 with SMTP id 145mr4317657pfc.153.1502197194669;
        Tue, 08 Aug 2017 05:59:54 -0700 (PDT)
Received: from unique-pc ([117.251.239.139])
        by smtp.googlemail.com with ESMTPSA id c7sm2901959pfg.29.2017.08.08.05.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Aug 2017 05:59:54 -0700 (PDT)
Message-ID: <1502197230.2071.3.camel@gmail.com>
Subject: Re: Can the '--set-upstream' option of branch be removed ?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sp2q1cc.fsf@gitster.mtv.corp.google.com>
         <20170807143938.5127-1-kaarticsivaraam91196@gmail.com>
         <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 08 Aug 2017 18:30:30 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-08-07 at 13:59 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > I refactored builtin/branch.c to remove the '--set-upstream'
> > option,successfully. The corresponding patch follows. 
> > 
> > There's just one issue with the version of git that doesn't
> > have the '--set-upstream' option. It's described in the commit
> > log message of the following patch.
> 
> which is...
> 
> > Note that, 'git branch' still *accepts* '--set-upstream' as a consequence
> > of "unique prefix can be abbrievated in option names". '--set-upstream'
> > is a unique prefix of '--set-upstream-to' after '--set-upstream' has
> > been removed.
> 
> ... this.
> 
> Thanks for spotting the issue.  
> 
Oh, I would have to thank you for enlightening me about,

    "unique prefix can be abbrievated in option names"

If I didn't know that, it would taken me some time (or an email) to
find why 'git' accepted  '--set-upstream' even after it's removal!

> I think in the longer term we still want to remove --set-upstream as
> many people seem to say that its behaviour has been uttering
> confusing to them and that is why we keep giving the warning any
> time it is used.
> 
I do accept that. The behaviour of '--set-upstream' is awkward.

> > I guess it would be difficult to detect the removal of the option in
> > case it's used in scripts and might cause confusion to users?
> 
> If we want to follow through the transition, because of the issue
> you spotted, we'd need one extra step to make sure users won't be
> hurt before removal: we would need to still recognize --set-upstream
> as an option distinct from --set-upstream-to, and actively fail thes
> request, telling them that the former option no longer is supported.
> 
There's no issue in doing that if people don't shout at us for the
behaviour :)

Just to be sure, you mean "die() with a good message" when you say
"fail these requests, telling them that the former option no longer is
supported."

> Then after waiting for a few years, we may be able to re-introduce
> the "--set-upstream" option that takes the arguments in the same
> order as "--set-upstream-to", which would be the ideal endgame
> (assuming that the reason why we started deprecating "--set-upstream"
> and encouraged users to use "--set-upstream-to" still holds).
> 
It's pretty surprising it takes almost a decade to *stop accepting* a
bad option though many users are confused by it. 

"It's easier to do things than to undo them!"

-- 
Kaartic
