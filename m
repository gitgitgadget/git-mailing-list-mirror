Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF472047F
	for <e@80x24.org>; Mon, 24 Jul 2017 01:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbdGXBuU (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 21:50:20 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33297 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdGXBuS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 21:50:18 -0400
Received: by mail-qt0-f174.google.com with SMTP id n42so63308285qtn.0
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 18:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s5f5HTTC1eBl7BWKfb0guo7UNjUFuj+4Z7xeNw6LyTY=;
        b=UnIIS2Tw6dJRv3Y8SEIFrMn/gt4TDKLu1U+mp9ziE0xRpRlKw8wxU6IaHt8b3nRA3N
         +pXHnzp3SpR3zM3ULiYVcX7kMgb/c1lvUFy+GTPCaESfHpzPHgwopdBis5kP3VzE82/e
         4x8vid8yfoBriAOzrM6yjBJadhdzxPweSTfrsXWJlz+kjJQciU1cQjO/G6GZuTpupame
         wWFWgVvydNsO6NR29hzHwYFmN/4zT565ejEkhWpWGD5OsRI04/+H9cJ2QjNBidEPqSjd
         clE9SX/KdRywWJLZF+/9cqE4hMGip20NbPkUL2JGhEsFqxuDjmE8oe6WdwlaMsyQbn22
         VPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s5f5HTTC1eBl7BWKfb0guo7UNjUFuj+4Z7xeNw6LyTY=;
        b=mncMALk8d6JvCWfUBeMyX+B6BT8uJCHAd3Mh/BQlOZGL0OH2x9bAMh41W1TFJ02EAQ
         oUMEvKRSqzurzrEcMidWsMv8CQjlB7gzwL6AbXmEpJl9PahEtGp/7xymbwMWDnfk1hL1
         6eRD6/W2J1n8OfBXsV4yJNX9bl8jXKO1ehWldRBZezBVdeS/hSS5Y2ArKg9g6kqMAPVV
         yIL8E0PgAGGsXXPoZCVV9DYKxzmUGlz0wBClmWLBcQ2A7knEaCyK1TzOBO9XXi9U7R3f
         WdQEeBKsWFVrdF0Jec7NA1pnX3ZBYCwL0OYTM5xyXk71o6ZLzmOtF5/1x/0gZq2gtjaM
         SaTw==
X-Gm-Message-State: AIVw1112+dBlKazQlX3rS7rFVFRYSKfY4kWKtkzAEgL8daN9YaPg21NK
        ExJV7QU2u/eorr0aAJVe+MpWYNfyDiCB
X-Received: by 10.200.8.188 with SMTP id v57mr18281057qth.213.1500861018087;
 Sun, 23 Jul 2017 18:50:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Sun, 23 Jul 2017 18:50:17 -0700 (PDT)
In-Reply-To: <xmqqeft8fp5j.fsf@gitster.mtv.corp.google.com>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
 <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
 <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com> <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
 <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com> <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com>
 <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com> <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1707221323420.4271@virtualbox> <xmqqeft8fp5j.fsf@gitster.mtv.corp.google.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 24 Jul 2017 09:50:17 +0800
Message-ID: <CANYiYbG_gh82M5ccZA-DnVFr0XrCzDJYd=Q0KrDfQXGZ=2z9kw@mail.gmail.com>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-22 23:48 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> >> A very small hack on gettext.
>>
>> I am 100% opposed to this hack. It is already cumbersome enough to find
>> out what is involved in i18n (it took *me* five minutes to find out that
>> much of the information is in po/README, with a lot of information stored
>> *on an external site*, and I still managed to miss the `make pot` target).
>>
>> If at all, we need to make things easier instead of harder.
>>
>> Requiring potential volunteers to waste their time to compile an
>> unnecessary fork of gettext? Not so great an idea.
>>
>> Plus, each and every Git build would now have to compile their own
>> gettext, too, as the vanilla one would not handle the .po files containing
>> %<PRItime>!!!
>>
>> And that requirement would impact instantaneously people like me, and even
>> worse: some other packagers might be unaware of the new requirement which
>> would not be caught during the build, and neither by the test suite.
>> Double bad idea.
>
> If I understand correctly, the patch hacks the input processing of
> xgettext (which reads our source code and generates po/git.pot) so
> that when it sees PRItime, pretend that it saw PRIuMAX, causing it
> to output %<PRIuMAX> in its output.
>
> In our workflow,
>
>     * The po/git.pot file is updated only by the l10n coordinator,
>       and then the result is committed to our tree.
>
>     * Translators build on that commit by (1) running msgmerge which
>       takes po/git.pot and wiggles its entries into their existing
>       po/$lang.po file so that po/$lang.po file has new entries from
>       po/git.pot and (2) editing po/$lang.po file.  The result is
>       committed to our tree.
>
>     * The build procedure builders use runs the resulting
>       po/$lang.po files through msgfmt to produce po/$lang.mo files,
>       which will be installed.
>
> As long as the first step results in %<PRIuMAX> (not %<PRItime> or
> anything that plain vanilla msgmerge and msgfmt do not understand),
> the second step and third step do not require any hacked version of
> gettext tools.
>
> Even though I tend to agree with your conclusion that pre-processing
> our source before passing it to xgettext is probably a better
> solution in the longer term, I think the most of the objections in
> your message come from your misunderstanding of what Jiang's patch
> does and are not based on facts.  My understanding is that
> translators do not need to compile a custom msgmerge and builders do
> not need a custom msgfmt.
>

I appreciate Junio's explanation. I totally agree.

-- 
Jiang Xin
