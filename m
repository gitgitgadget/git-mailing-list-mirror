Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C22961FD99
	for <e@80x24.org>; Wed, 24 Aug 2016 01:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbcHXBEn (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 21:04:43 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36384 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753548AbcHXBEl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 21:04:41 -0400
Received: by mail-ua0-f178.google.com with SMTP id 97so2951713uav.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 18:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u+8QaNsbCSoCIVc8MFFkDsvXP5aVAkDJFcljfcFOBpo=;
        b=HUHMQlmeX2qqaloKliXQYfBJwRSZzjygZ7eI6EWSdGkFNVtfV5Cy1FURDajhrQkp/Y
         HkTfgwbShh1hWtrmF0W3W4DopByrt6BA2MZ9WqSOEnivuY9JYKoEQOikZLCF0Rj9ncQm
         ASmocQ3Pkw6YFsg0YtVWE3w5yq2PSZPJVU4CYlhBE5yHuVuVIeyr4wqMyTKuWuzJCa3L
         oztws1AUgaHttVLIJHRzXwde23BUW2ipMPunn73amM97uLwf1gLcyJAPQQmSo1EVprWp
         AT/pOWeZhOVhAHN5C4c48uEc9XrDfwYQGYBfAQNqpIKL8vXzS5KS6ZRZuFoKZ7yjCESz
         DROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u+8QaNsbCSoCIVc8MFFkDsvXP5aVAkDJFcljfcFOBpo=;
        b=cgYm+NH//6Qhgu9KSLeotwJnXeQ80hFMs/fhBiA4H+aS49dEJSGWUjvxiTWqbMStF+
         OnnvoNRAXs3Yqi8ybkEH4j5Gk4drJmAHZ4Kcy2y1VNaaO1CSm8JckVSXTs0Yr7kJId56
         Lg53YmZCSUMC+iqSPBzGIL81PPkO3EMzmEovi96lgMm7IUp0IWS55qtRKl2/8dTo6q5+
         i9W7FO8221ZHuUZCum36sMOXOI2z3Da3lJcx94ePE5QKFOKipBFKhKzG5L+yEIvqFkpr
         Ag6ODteFhCwOw4j0n+Uy2+xt89jicms4VsKE+vgSWz7UytgocZNgqw1uUjOWQCkDEeWU
         PRHA==
X-Gm-Message-State: AEkoout+XTAZ2fn6JZL98Jg6Rm2h+tsB6m3oqQETxeRDwYbSJaOV+QPOz7ACIcr64IxeObz/cx0o8nBb6NudSQ==
X-Received: by 10.31.63.199 with SMTP id m190mr170732vka.23.1472000667109;
 Tue, 23 Aug 2016 18:04:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.47.140 with HTTP; Tue, 23 Aug 2016 18:04:26 -0700 (PDT)
In-Reply-To: <xmqqa8g3uppx.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox>
 <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox>
 <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com>
 <alpine.DEB.2.20.1608231553030.4924@virtualbox> <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net>
 <alpine.DEB.2.20.1608231736180.4924@virtualbox> <alpine.DEB.2.20.1608231758260.4924@virtualbox>
 <xmqqzio3uw31.fsf@gitster.mtv.corp.google.com> <xmqqa8g3uppx.fsf@gitster.mtv.corp.google.com>
From:   Dakota Hawkins <dakotahawkins@gmail.com>
Date:   Tue, 23 Aug 2016 21:04:26 -0400
Message-ID: <CAG0BQXmmW_0n4OMQVsVQ5+OKbNVpgXmXeExFUOXqY8nH=sg3Jw@mail.gmail.com>
Subject: Re: [git-for-windows] Re: [ANNOUNCE] Git for Windows 2.9.3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Duy Nguyen <pclouds@gmail.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 5:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > One way to avoid that risk may be to release the new feature as
> > "experimental-and-subject-to-change", so that interested users on
> > Windows can actually try it out to see if the feature itself
> > (whatever its interface to them is) makes sense, and you can gauge
> > the value of upstreaming it, while cautioning these early adopters
> > that it has not fully been through the usual review process and may
> > have to change while becoming part of the official release.  This is
> > no different from various "experimental features" we unleash to the
> > wild, either via 'master' or keeping it in 'next' (we tend to do
> > more of the latter, marking "see if anybody screams").
>
> In case it was not clear, I am _not_ saying that the port to Windows
> must not ship with any feature that is not yet in the upstream (the
> same goes for a port to Macs, where it may want to do more about
> dealing with Unicode "normalization" gotchas).  The differences in
> platforms make it more likely that needs for certain things are felt
> earlier and more strongly on a particular platform, and shipping a
> new thing as an experimental feature to end-users may be the most
> effective way to come up with the best approach to help the users.

What is the practical difference between what happened and releasing a
feature as "experimental-and-subject-to-change"?

I use GFW almost exclusively, but I pretty much always consult the
upstream documentation anyway (because I find it easier).

It doesn't seem likely that many users who weren't in dire need of
this feature will even realize/remember it exists, so it's hard for me
to conclude that anybody will really be harmed by this particular
(temporary?) discontinuity.

At any rate it doesn't seem like you guys are going to persuade one
another and from the outside looking in it seems like this argument is
more ideological than technical, which makes it seem like it should
probably embarrass all involved because of its length and publicity.
But maybe I'm wrong, in which case I'm here to embarrass myself.

-Dakota
