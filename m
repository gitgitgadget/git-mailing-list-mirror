Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560842022C
	for <e@80x24.org>; Sat,  5 Nov 2016 12:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbcKEMpa (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 08:45:30 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35790 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbcKEMpa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 08:45:30 -0400
Received: by mail-lf0-f46.google.com with SMTP id b14so82565161lfg.2
        for <git@vger.kernel.org>; Sat, 05 Nov 2016 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iiuppCgqUd3PbIQcQA0+uAWYN2qgaewjeCcr/4ZrTmU=;
        b=T60iVlcCQopcprv/93wnrlFPqt4pyBfpOqxfbhyny7gQlPQ+bDotEVN5VfVqmdqtvC
         6DcJlreSRRi422n1z3vHWIfjXCf9Lf98RG/HkR+wmrLsSQZ6JsW/NXXalC+/RZTp6sqh
         IAj5Ns5Imq9q9cGlclrq0vchnQMa2ISNFrA+ekzsZwztVvj02VzWp0w21izTxIBoTQWQ
         m6P7g0YCjWaYEm/5sGDJQWCt2XQG6pTpQmAJSFn9adaAdwWhmdDBHvMUWimgHvch0qBs
         iGbetFZxdfGIi2vOu/bDeEuvH7edRPTi2RzxfWmLcjreplwj5f/5GemBcy+XNzUnJ9ZE
         QwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iiuppCgqUd3PbIQcQA0+uAWYN2qgaewjeCcr/4ZrTmU=;
        b=M4+MEl/uswpjonG4eWgFngAidyeygK14nq7aFtsIuRBRfevYK3BaOKm+4cSSOapgA6
         xXsW7jmw41+G5L/FZfnNMxqVKpJalIoxx/30H+I22047qRqywA6kY+YB//aqdYdHKUmI
         WDjuek1T98tXs+Gsvy2LyT+eRZ9iU0D35cLAkzem7iVGp70VCq3LUu8CFjuYwGXIUuvy
         QtjwKjxtgoasJqKtAQ7S+amWpW3zLPPU7/NaJwlpWpFerNtYnWcoGxDnONi28GvezQ9O
         +BNB3p2ru7D15lbBQhrND9AGP6sEpFOkEx0jN01Bb4nK4UL8hBRKuEf3khjc6RQRXeNI
         9Kxw==
X-Gm-Message-State: ABUngve1v4tnnUFp/HhYAxT2KOFGDb5PJbxCO5VQ3w4U8IwmFEpRT8EbyJM7zaCpe6Hzy63OgH7iWAIJxQR0iw==
X-Received: by 10.25.72.74 with SMTP id v71mr12348593lfa.130.1478349927992;
 Sat, 05 Nov 2016 05:45:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 5 Nov 2016 05:45:27 -0700 (PDT)
In-Reply-To: <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com> <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
 <xmqq1syqedv4.fsf@gitster.mtv.corp.google.com> <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Nov 2016 13:45:27 +0100
Message-ID: <CAP8UFD1EZ8HBzLAeyFBFgU7n2uJpswqgEgA4XM1YJuRAG_ZAAQ@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 5, 2016 at 1:17 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sat, Nov 5, 2016 at 5:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> Couldn't a RefTree be used to store refs that point to the base
>>> commit,
>>
>> I think it is the other way around.  With the new "gitref" thing
>> that is a pointer to an in-repository commit, RefTree can be
>> naturally implemented.
>
> Yeah, I should have read Shawn's RefTree email thread again before
> posting and especially before replying to Josh.

By the way, reading the following email by Peff where gitlink
reachability was already discussed:

https://public-inbox.org/git/20151217221045.GA8150@sigill.intra.peff.net/

and where Peff wrote:

> Of course, the lack of reachability has advantages, too. You can
> drop commits pointed to by old reflogs without rewriting the ref
> history. Unfortunately you cannot expunge the reflogs at all. That's
> good if you like audit trails. Bad if you are worried that your reflogs
> will grow large. :)

I think that we may not need "gitref" at all. We perhaps could just
have more ways to configure and tweak how a repo manages commit
reachability related to gitlinks.

With shallow clones we already need ways to configure and tweak commit
reachability anyway.

And with what Peff says above it looks like we will need ways
configure and tweak commit reachability with gitlink/gitref anyway. So
the point of gitref compared to gitlink would be that they just have a
different reachability by default. But couldn't that be replaced by a
default rule saying that when a gitlink is reached "this way or that
way" then the commit reachability should be enforced, and otherwise it
should not be?
