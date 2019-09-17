Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FD11F463
	for <e@80x24.org>; Tue, 17 Sep 2019 15:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfIQPK5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 11:10:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45112 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfIQPK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 11:10:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33so3627075edh.12
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gr4/enrqX6QME57yQVO1nkACDKPa9nlHjZSyBjOTZM=;
        b=VNfLV5AXVWvFrwGH/zYmrBI0khoSupQusvpRqaaDeJr3k9vP31zman+Td+V7lJ4xZ2
         v701zblih/ii9AtaWVJ5XC60liuvZ0v9rXrJfSg6XbCgldkFKlQihsKa87g528D9pryE
         YTdwIlb5rapa3KkNUBW2aFR9vyKHsU9BbHUbZefGIghlm3RDv6fSmfaUVcf9vYArItRf
         nv2S3uNpMHJrrvL5Plv2Id5hs09g8ZAHFf3+HUUed31uNNW+qfrrrharrVnSH//ONLa8
         EORtX+pHuvsMxBXIsHGMtzzTUOxZIYYLaRysCjxkmEdL0NGz5Re5Kof4gx7ZE3qMPhRb
         I1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gr4/enrqX6QME57yQVO1nkACDKPa9nlHjZSyBjOTZM=;
        b=YbE87N19DIE6ZTdny9llxYorHK+mIOTL/+C6qTtETTz3TUXmAtfd7lHCTjoOk+65SZ
         8s7xBUmZ9I689k6WbAQ5lIEUwPSnZbpPovECWds7IE7x8yL4g+ARZBah0gmu+sANyFNO
         KE9zc66Y+5D45Cs/bOCGuY3mCvphuFlIKfJ4Gu0D40q7amCqfUWb3LgL9x/2TxP+ApoB
         y1p5gVCtdk0tQgyrQrw2hh9RXwC+dsQlzTOIr3R7Eh9GWUvfBmI5v27EzY9x/O0eCVUI
         PN3v0YJsJKeNT8h2BObc1TKq/MrxxT1GE+Xt+B2qarUxw1T0OHlLrpNrM55oG1xjY9Z9
         BBXw==
X-Gm-Message-State: APjAAAXi1H89pIkS4QZA6AnP2Cm301mC3SDyOJ9dEjn2qSzF/ncDsQAM
        NdrlsdGQxOYEziNbxkYNjdwpS/hrtwSjLKUmUFeOADtX
X-Google-Smtp-Source: APXvYqx1RfXPTrIRoc6t16oIfF7XxTyFyeahwVmmzSl/bQYpGM2IqiSiY9C9zjX7/hSGnjH55LdSwJFM5uEov+ols6c=
X-Received: by 2002:a50:852c:: with SMTP id 41mr5016231edr.201.1568733055207;
 Tue, 17 Sep 2019 08:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net> <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 17 Sep 2019 17:10:43 +0200
Message-ID: <CAP8UFD38S_nV2NmjeadZ0J5ftJgBwghOZ+BNHZaNQ72nZmLtNA@mail.gmail.com>
Subject: Re: Git in Outreachy December 2019?
To:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily and Dscho,

On Tue, Sep 17, 2019 at 1:28 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 16 Sep 2019, Emily Shaffer wrote:
>
> > Jonathan Tan, Jonathan Nieder, Josh Steadmon and I met on Friday to
> > talk about projects and we came up with a trimmed list; not sure what
> > more needs to be done to make them into fully-fledged proposals.
>
> Thank you for doing this!

Yeah, great!

> > For starter microprojects, we came up with:
> >
> >  - cleanup a test script (although we need to identify particularly
> >    which ones and what counts as "clean")
> >  - moving doc from documentation/technical/api-* to comments in the
> >    appropriate header instead
> >  - teach a command which currently handles its own argv how to use
> >    parse-options instead
> >  - add a user.timezone option which Git can use if present rather than
> >    checking system local time
>
> Nice projects, all. There are a couple more ideas on
> https://github.com/gitgitgadget/git/issues, they could probably use some
> tagging.

Thanks! Maybe we should have a page with Outreachy microprojects on
https://git.github.io/

I will see if I find the time to create one soon with the above information.

> > For the longer projects, we came up with a few more:

[...]

> >    - git-bisect.sh
>
> That would be my top recommendation, especially given how much effort
> Tanushree put in last winter to make this conversion to C so much more
> achievable than before.

I just added a project in the Outreachy system about it. I would have
added the link but Outreachy asks to not share the link publicly. I am
willing to co-mentor (or maybe mentor alone if no one else wants to
co-mentor) it. Anyone willing to co-mentor can register on the
outreachy website.

Thanks for the other suggestions by the way.

> Converting shell/Perl scripts into built-in C never looks as much fun as
> open-ended projects with lots of playing around, but the advantage of
> the former is that they can be easily structured, offer a lot of
> opportunity for learning, and they are ultimately more rewarding because
> the goals are much better defined than many other projects'.

I agree. Outreachy also suggest avoiding projects that have to be
discussed a lot or are not clear enough.

> >  - reduce/eliminate use of fetch_if_missing global

I like this one!

> > It might make sense to only focus on scoping the ones we feel most
> > interested in. We came up with a pretty big list because we had some
> > other programs in mind, so I suppose it's not necessary to develop all
> > of them for this program.

I agree as I don't think we will have enough mentors or co-mentors for
a big number of projects.

Best,
Christian.
