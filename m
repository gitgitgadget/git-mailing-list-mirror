Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45CCE1FA21
	for <e@80x24.org>; Mon,  9 Oct 2017 04:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdJIEFb (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 00:05:31 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:44512 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbdJIEFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 00:05:30 -0400
Received: by mail-pf0-f175.google.com with SMTP id x7so2232716pfa.1
        for <git@vger.kernel.org>; Sun, 08 Oct 2017 21:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wiK1SD0KwBTioMFLrsAr7cImbNXUtefX8ivUzwGOjXQ=;
        b=ZBjzlTm6OLp2ZXwAyDXO0ZttHEDRIjwPYcDK3Tdt1/XVeyYIJiIH5RYXhvzV12xQ3/
         pbB0415UUea7lDmMZ1B9gEVUaTpDV9FnhntolwQf5goKYqSpm+ds4qU0C2Aw2TwrGK/E
         RgE6MRPOC+d3dzkEjpmegXHJUKyUOIQbjryfNUmGXQBowC/26MJppT6Uk1hoMpXdHBnV
         dVCkLRhmMXmC/xxKdpNB4L2DnjECx7IOAT57sAeEThX50D/UsXpgT22xXAPLY9TP5LvA
         Xf49D0CFD+tAD20alVJDr6GLggOd/x7kdoguaJvvQOAhpqFSuKv1eEqaDsLH/ua+Y4fg
         bU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wiK1SD0KwBTioMFLrsAr7cImbNXUtefX8ivUzwGOjXQ=;
        b=Q60UmjjOux7uUGgqeSSXJhszaHwc7b/OwMaOCXn4NlkWe8IVJpefs5O+9Hb+nrZDEx
         q3mNF4YFM05jXlCC/5OqTl0wu7eRI900a3ZnoaM2xqTy4UABmgckc4cO7eqsftuvf/VF
         AUx3toKWkceuGJkT7axl8mXsBKqK3taFhvEPJ6kWBc1VBcAklCCos+hZwnwPR8AeFxfj
         h/ygIKPE3eEY23sZVBlqLaX/ACy35OMewCqdDQNNZ2meMt8iompEH6keQebyNE3rDqH9
         ZuvpiuZ0ptgRUiGUXtlRE7b3YJBASmD/ZeKo7+C260bxEuZkVnaOZwLEpQjQwlj6tjxO
         7LvQ==
X-Gm-Message-State: AMCzsaWUXPG4NKQoeUTj9Cy1UttZBBw5R6DNoq4em/dpjlI2kLjXu/sK
        dqTBgqOmdN1xwADfIicmzF2RiL64wODFxU0Ei34=
X-Google-Smtp-Source: AOwi7QBmaQzoWuOl6cahQfUFY2rL/CYEaIPQENNpk/g2nDpUZc6PIpEALJiwyPgtYZejpMbVYLEXdhtzw56MWcB8kz4=
X-Received: by 10.98.62.195 with SMTP id y64mr6949876pfj.140.1507521929926;
 Sun, 08 Oct 2017 21:05:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Sun, 8 Oct 2017 21:05:29 -0700 (PDT)
In-Reply-To: <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-4-bmwill@google.com> <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
 <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 9 Oct 2017 06:05:29 +0200
Message-ID: <CAN0heSo3fQzqv8xqqBs8S5MST0fs2ABh69L0cL1mi+pwUTG8oQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention mechanisms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 October 2017 at 11:40, Junio C Hamano <gitster@pobox.com> wrote:
> Simon Ruderich <simon@ruderich.org> writes:
>
>> Did you consider Stefan Beller's suggestion regarding a
>> (white)list of allowed versions?
>>
>> On Mon, Sep 18, 2017 at 01:06:59PM -0700, Stefan Beller wrote:
>>> Thinking about this, how about:
>>>
>>>   If not configured, we do as we want. (i.e. Git has full control over
>>>   it's decision making process, which for now is "favor v0 over v1 as
>>>   we are experimenting with v1". This strategy may change in the future
>>>   to "prefer highest version number that both client and server can speak".)
>>>
>>>   If it is configured, "use highest configured number from the given set".
>>>
>>> ?
>>
>> It would also allow the server operator to configure only a
>> specific set of versions (to handle the "version x is
>> insecure/slow"-issue raised by Stefan Beller). The current code
>> always uses the latest protocol supported by the git binary.
>
> If we do anything less trivial than "highest supported by both" (and
> I suspect we want to in the final production version), I'd prefer
> the configuration to list versions one side supports in decreasing
> order of preference (e.g. "v3 v0 v2"), and take the earliest from
> this list that both sides know how to talk, so that we can skip
> insecure versions altogether by omitting, and we can express that we
> would rather avoid talking expensive versions unless there is no
> other version that is understood by the other side.

I think I've managed to convince myself that a blacklist would be the
most future-proof approach, simply because it cannot be overloaded with
any other meanings in the future.

If an ordering needs to be possible, that would have to go into another
config item. An ordering would open up for some interesting issues, but
at least that shouldn't be any worse because the blacklist-approach has
been taken (as opposed to a whitelist-approach).

To aid with a slow roll-out, the default blacklist could be used (start
by blacklisting v1), but after that the default list should be empty. It
should not be misused for slowly rolling out any later experimental
versions.

Letting the blacklist be different server- and client-side seems useful
for driving the experiment forwards. Post-experiment, I'm not so sure,
that just seems unnecessarily complicated.

So, here's a suggestion:

* experimental.{client,server}ProtocolV1 is "0" (don't experiment) or
  "1" (experiment).

* experimental.serverProtocolV1 has default "0". Unless early feedback
  is negative, the default is changed to "1".

* experimental.clientProtocolV1 has default "0". Switch the default to
  "1" after some time.

* Big warnings that if someone finds themselves switching to "0" they
  should get in touch.

Once we feel confident, we implement protocol.blacklist and let the
default be "". The experimental.* are simply dropped, no "aliasing" or
"transitioning". That is, we activate v0 and v1. We don't respect "0" in
a blacklist (but don't forbid it either). Once we introduce v2, sure,
but until then, some will just be tempted to blacklist v0 "to get the
modern v1" -- they will have risk, but no benefits.

Martin
