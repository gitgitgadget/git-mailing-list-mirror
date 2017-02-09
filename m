Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3687D1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 12:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdBIM1u (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 07:27:50 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:34501 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdBIM1t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 07:27:49 -0500
Received: by mail-io0-f176.google.com with SMTP id l66so15324904ioi.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 04:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zWkmAIYx6h9yKkN3cy+dzQTbK0nnTCUVgcz7HWI9W3c=;
        b=RYY7HsFezEu6XDrA5ajXvmxSk5BojKErpAf258SqOEv4LI0FTxuQWDrCJz+uECAb7U
         qlWQn1E/FvQvez3EBluFCaX0lCFAvaRIkjCjcnoIqgUtcGL3Kqg6CTloyof4CodIpt/7
         OI+hHq9RE7+RDzeFjBl0artLmSToTadsNNsMipdjil3Ha/J25lkGvbdipQ2tGuFOvjsk
         q4F1Js8eLhfh+Wn8XdXm9eumKx2y0hceyt0tgq1Q3T0PHZLFOXt6w4CKT/0ShY73nLbt
         7JNuIbJxB5qV+m1mfTAdXZivYbAcv5z1GPpaxOazH7+xaVKMnlcJNDbesKsNZQ3/B61K
         tGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zWkmAIYx6h9yKkN3cy+dzQTbK0nnTCUVgcz7HWI9W3c=;
        b=Dxy8wa9YfHBKycBcvIk4ozI5Y8v+IsDAqmsQyRTzsAcI6/UccI935cXZW5PEgLltO/
         azW84+BtQ8nXu1hFQ4zJ+FD15Vmd7iB2AGL47+vnMmTBnweqTbnVR2yDDsenOP2YHeS4
         nre/xsGvKqNFWPAbPF2YokjjZGHMuOlD6kZp75na1eZCdkDfMiz4qn9Qwn0/ceKVkouQ
         8og+HHTQ6Zu4lf3ecBHL0DHgZTVef3ZLA0JCJWLWd9rWfd7ctkEh2aQ9e2lwtX6dAZBl
         bt3L0GFPO5DksIi9Ro9jizvFh8ZfEegnzJx1L6GiIspSX3yy/YsIw0hUq/TKA3e9eCgN
         1EJg==
X-Gm-Message-State: AMke39ne+lOd245FN/Ji2FkFVvX7WAVK36JlTi2EOuoFThKzKoFITUGuxgbxNXTYRMnPCaTmrEprZ7CKkyjxuA==
X-Received: by 10.107.161.83 with SMTP id k80mr2745578ioe.47.1486642701027;
 Thu, 09 Feb 2017 04:18:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Thu, 9 Feb 2017 04:18:20 -0800 (PST)
In-Reply-To: <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
References: <vpq1svtstud.fsf@anie.imag.fr> <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Thu, 9 Feb 2017 17:48:20 +0530
Message-ID: <CAFZEwPN0gAof6akk66VycirCsDSxMXKx2HdS7QaTxnaaAv5qJA@mail.gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
To:     Jeff King <peff@peff.net>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

On Thu, Jan 26, 2017 at 2:15 AM, Jeff King <peff@peff.net> wrote:
> I do not mind doing the administrative stuff.  But the real work is in
> polishing up the ideas list and microprojects page. So I think the first
> step, if people are interested in GSoC, is not just to say "yes, let's
> do it", but to actually flesh out these pages:

I will help with adding more ideas to the microprojects list. But
since I am not quite familiar with the whole code base, I will need
some help with verifying those whether they are in the scope or not. I
am not sure whether I would be able to help with actual project ideas
but I will try. I will do it within a week or so.

Regards,
Pranit Bauva
