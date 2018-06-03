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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F43B1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 10:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeFCKp3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 06:45:29 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39045 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeFCKp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 06:45:28 -0400
Received: by mail-wm0-f46.google.com with SMTP id p11-v6so9005454wmc.4
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=kcW6MVRyQKUAUFWe7B1STP4jfJLHESqnUFh5yqnGZc0=;
        b=RSwDb41B6kJVAFjCzsQQXdSvnwsPrlqnb+um+yX+LnU//BHXNjh3YRilDKWdEvVBSN
         g5tViRDKYs52/o4b7wisbu6Q93cmL0f8bmHgfrZEmmVoFV4K5yjEH9snqSHDj0JDFq2n
         xu6IE+VJTGyie7ZZ/yL26h8f+Hqqy9B/OQ1Vjo1JWRj8dHQUOUrbHbkbJUXLqAGYqoF9
         NWH3JmtIspC4DPyWc2KgMs31FymTNbcmyFX7lVKQfg46f23bStaCKElvo/AUTMhYrIAG
         UuqkcS/cqTQQ6nD/NVwPbb96eDRUKcOMlTWYZX3nycwyeQSpKBQvIEZ82+kieUWN1H4o
         tMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=kcW6MVRyQKUAUFWe7B1STP4jfJLHESqnUFh5yqnGZc0=;
        b=NjBSh0vTMkVuqqUKcle9nJRKzXXzW48/LLy2AhsyQF+jpMWkgXeX8gtGSEmYOJmzm+
         SuoJfSS20TbcWuvXux9iRAYphgASe2lAiNeaGXBLdaN64nhvHM0r/oj7DoFv/Vouxqah
         6gVVET0vGyfsFgr6kEmAxtqIjLh5ORRXRfNkwrOO3tROFH+vfvu9411xnsTzkCREZkJY
         EqnxVIFltSW7JBGlyEKc/QJgiTEL3OwRWqoEMSwv+DB38iWzmWSO2/IiHuDRlOH+8p7s
         sqyu1GjsYhxTPf0f/LItapaFLYA3BgxqxwbaJ35vK4W1hUMBkBlHM1dRm4a/mmAjqTC1
         6SbQ==
X-Gm-Message-State: ALKqPwdcWTtgfwou/7K6+/KZZ9TsaGYkD/FmQYDtY0ySCEYIpRkb/kbI
        zb8p6g0hVDFwAlXRq3lYkm8PwAIo
X-Google-Smtp-Source: ADUXVKK4B+u1X9sEtmKLsHVlolnD8e3XoRLkD2JPWmZAnBcxKB9lpUax60FylRvj2Bi+uU6bIO8wMA==
X-Received: by 2002:a50:d59d:: with SMTP id v29-v6mr19717475edi.167.1528022727266;
        Sun, 03 Jun 2018 03:45:27 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id e56-v6sm14330369edb.31.2018.06.03.03.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 03:45:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE> <87y3hlecod.fsf@evledraar.gmail.com> <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
Date:   Sun, 03 Jun 2018 12:45:25 +0200
Message-ID: <87vab087y2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 03 2018, Peter Backes wrote:

> Unfortunatly this important topic of GDPR compliance has not seen much
> interest.

I don't think you can infer that there's not much interest, but maybe
people just don't have anything to say about it.

There's a lot of discussions about this that I've seen, but what they
all have in common is that nobody really knows. Just like nobody really
knew what the "cookie law" would be like.

So I think all of us are just waiting to see.

I took the bite and tried to paraphrase some stuff I've read about it,
but as you pointed out in 20180417232504.GA4626@helen.PLASMA.Xg8.DE I
incorrectly surmised some stuff, although I very much suspect that *in
practice* the GDPR is going to be more about "consumer
protection". I.e. regulators / prosecutors are much likely to go after
some advertising company than some project using a Git repo.

Just like nobody's going after some local computer club's internal-only
website because it sets cookies without asking, but they might go after
Facebook for doing the same.

> [...]
> In course of this, anonymization could also be added. My idea would be
> as follows:
>
> Do not hash anything directly to obtain the commit ID. Instead, hash a
> list of hashes of [$random_number, $information] pairs. $information
> could be an author id, a commit date, a comment, or anything else. Then
> store the commit id, the list of hashes, and the list of pairs to form
> the commit.
>
> If someone requests erasure, simply empty the corresponding pair in the
> list. All that would be left would be the hash of the pair, which is
> completely anonymous (not more useful than a random number) and thus
> not covered by the GDPR. The history could still be completely
> verified, and when displaying the log, the erased entry could be
> displayed as "<<ERASED>>".
>
> What do you think about this?

Since the Author is free-form this sort of thing doesn't need to be part
of the git data format. You can just generate a UUID like
"5c679eda-b4e5-4f35-b691-8e13862d4f79" and then set user.name to
"refval:5c679eda-b4e5-4f35-b691-8e13862d4f79" and user.email to
"refval:5c679eda-b4e5-4f35-b691-8e13862d4f79".

Then you'd create a ref on the server like
refs/refval/5c679eda-b4e5-4f35-b691-8e13862d4f79 containing the real
"$user <$email>". If you then wanted to erase that field you'd just
delete the ref, and it would be much easier to teach stuff that renders
the likes of git-log to lookup these refs than changing the data format.

Sites that are paranoid about the GDPR could have a pre-receive hook
rejecting any pushes from EU customers unless their commits were in this
format.

Perhaps some variation of this is where the GDPR v2 will go. It'll be an
"obligation to be forgotten", and I won't be allowed to use my own name
anymore. Instead I'll have a daily UUID issued from a government API to
use on various forms, and the only way for anyone to resolve that will
be going through a webservice that'll reject UUID lookups older than N
months, caching those requests will be met with the death penalty. We'll
all be free at last.

Okey, that last paragraph is just trolling, but I think that refval: ->
ref convention is something worth considering if things *really* go in
this direction.
