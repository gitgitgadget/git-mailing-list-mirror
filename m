Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_RP_RNBL,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBD11F453
	for <e@80x24.org>; Tue, 19 Feb 2019 22:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfBSWGM (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 17:06:12 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:40106 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfBSWGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 17:06:11 -0500
Received: by mail-ot1-f74.google.com with SMTP id b21so14635624otl.7
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 14:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pqVrH3Ft+mMzUfNfW9TFi6PM4NzXwLKRv+GvcQNH0cM=;
        b=iUk85sN1zTa5vTFL6POZwfTAN+DWHljXfYP86S2oP9qBX+znc/mmsSb66LACKWiv5y
         bSjkA7d/+vpMTbNwBaY0u6FHcCYfG4h9kagd8j+utwxxP8Yx/+GT+2TcvAsIOWsdXfVi
         Ij1ucz5YoW+s2fYIF9bEUfIi1FxGnGSsp2+vs/CasK2mOp1+6QurKyiXt6ZWVOYBxQ8D
         8voj+vhu2VhwiX2IpoTYEgn4jrzXS7pfZY8zbjkRR4954WCn0DXlOW9tImpaG2Sxbf8/
         2yOG0yPG6eguF7Hgtb+otvG3jsMm4r2mOZxoh+MJB++aur3RlA6EVkvrbUbehXLBj24U
         q4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pqVrH3Ft+mMzUfNfW9TFi6PM4NzXwLKRv+GvcQNH0cM=;
        b=j8ZLbBMeS52cxSnFbWr/lVbJIurGZOd3ty8/4SkRgkqomLAb+qY4eT4st6JgRzJkUw
         ZCE7r8Zc+fg8OK+hisWeUvIXhsbYO++Bc8K1/cbk+aEQ43Zehlr8FRxXWZdVEPrtbFa6
         aKpaHpUjVx/XEHGqIwMjmUArB2ofJbeZpEKV+qg/k7OpgQtkaCpAzcCtV9rfe1jfuOnC
         VYJ+/g4CrBEKguDPCbMtjY03LIwH2rxhMrUA0N7GteQ/AUiYR+BxBNbupL3zwrI0SWNj
         Yl/lspmVhK5EcpsfUWT/fgqIsADlwOhkTMC8aTgQ/WxM2LBzBPpDzCjPVZeIBx1yyRS4
         D+rw==
X-Gm-Message-State: AHQUAuYp23TdkZX1RkwtHi//Yt6dbQVRTXHbYEzou4eECaQAWYJmcJUg
        D3h/U+VwwUagULpQ2qglHgv+4Sg3DQVhoEnPpWW4
X-Google-Smtp-Source: AHgI3IbBnhKMnzeWz1mhwZnfKy1fRW4u9roptIdAeVpWr9aEzT2zUW1raSrn67Uxd45TCHKW8mtsK9hE6n3+UJJ/yalx
X-Received: by 2002:aca:ac55:: with SMTP id v82mr16266088oie.36.1550613970961;
 Tue, 19 Feb 2019 14:06:10 -0800 (PST)
Date:   Tue, 19 Feb 2019 14:06:05 -0800
In-Reply-To: <87k1hv6eel.fsf@evledraar.gmail.com>
Message-Id: <20190219220605.8905-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87k1hv6eel.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +when the server sends the packfile, it MAY send a `packfile-uris` section
> > +directly before the `packfile` section (right after `wanted-refs` if it is
> > +sent) containing HTTP(S) URIs. See protocol-v2.txt for the documentation of
> > +this section.
> > +
> > +Clients then should understand that the returned packfile could be incomplete,
> > +and that it needs to download all the given URIs before the fetch or clone is
> > +complete. Each URI should point to a Git packfile (which may be a thin pack and
> > +which may contain offset deltas).
> > [...]
> > +This is the implementation: a feature, marked experimental, that allows the
> > +server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
> > +<uri>` entries. Whenever the list of objects to be sent is assembled, a blob
> > +with the given sha1 can be replaced by the given URI. This allows, for example,
> > +servers to delegate serving of large blobs to CDNs.
> 
> Okey, so the server advertisement is not just "<urls>" but <oid><url>
> pairs. More on this later...

Actually, the server advertisement is just "<urls>". (The OID is there
to tell the server which object to omit if it sends the URL.) But I see
that the rest of your comments still stand.

> More concretely, I'd like to have a setup where a server can just dumbly
> point to some URL that probably has most of the data, without having any
> idea what OIDs are in it. So that e.g. some machine entirely
> disconnected from the server (and with just a regular clone) can
> continually generating an up-to-date-enough packfile.

Thanks for the concrete use case. Server ignorance would work in this
case, since the client can concisely communicate to the server what
objects it obtained from the CDN (in this case, through "have" lines),
but it does not seem to work in the general case (e.g. offloading large
blobs; or the CDN serving a pack suitable for a shallow clone -
containing all objects referenced by the last few commits, whether
changed in that commit or not).

In this case, maybe the batch job can also inform the server which
commit the CDN is prepared to serve.

> I don't see how this is compatible with the server needing to send a
> bunch of "<oid> <url>" lines, or why a client "cannot declare that the
> fetch is complete until all URIs have been downloaded as
> packfiles". Can't it fall back on the normal dialog?

As stated above, the server advertisement is just "<url>", but you're
right that the server still needs to know their corresponding OIDs (or
have some knowledge like "this pack contains all objects in between this
commit and that commit").

I was thinking that there is no normal dialog to be had with this
protocol, since (as above) in the general case, the client cannot
concisely communicate what objects it obtained from the CDN.

> Other thoughts:
> 
>  * If there isn't such a close coordination between git server & CDN, is
>    there a case for having pack *.idx files on the CDN, so clients can
>    inspect them to see if they'd like to download the full referenced
>    pack?

I'm not sure if I understand this fully, but off the top of my head, the
.idx file doesn't contain relations between objects, so I don't think
the client has enough information to decide if it wants to download the
corresponding packfile.

>  * Without the server needing to know enough about the packs to
>    advertise "<oid> <url>" is there a way to e.g. advertise 4x packs to
>    clients:
> 
>        big.pack, last-month.pack, last-week.pack, last-day.pack
> 
>    Or some other optimistic negotiation where clients, even ones just
>    doing regular fetches, can seek to get more up-to-date with one of
>    the more recent packs before doing the first fetch in 3 days?
> 
>    In the past I'd toyed with creating a similar "not quite CDN" setup
>    using git-bundle.

I think such optimistic downloading of packs during a regular fetch
would only work in a partial clone where "holes" are tolerated. (That
does bring up the possibility of having a fetch mode in which we
download potentially incomplete packfiles into a partial repo and then
"completing" the repo through a not-yet-implemented process, but I
haven't thought through this.)
