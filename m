Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6237320248
	for <e@80x24.org>; Tue, 12 Mar 2019 15:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfCLPs1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 11:48:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38666 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfCLPs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 11:48:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so3258681wrm.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 08:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/t5U3rZ9OQyz7sA4n9jl3dEzrcDbiFy9sQzC8CSJYJ4=;
        b=O9wXFuxmLM2VEDf+/Tn2OLOLzeC0aMvkkBzchGNn9MnhwmKtH0qUe+Zb3PTBcZpu68
         mWsy325BGL/kUzj7g1qChAw3h7l2JtOH+GIGkyVul1e9/J41B8giW3GLllWczWAp/NUz
         Hgh5Bzz8ighaWvWMINmUiEkF3cEAZuMbLLHnd2V/Onks3WTDWPKUJQHtJvSaH6Rgwyon
         AlG0+wijOBdwQOUSdmfIfdl+Y0IcVNnSLRjHUJyNPaeuhQW/2T6qEYyjzkn1s07HjAD4
         Yp3gfYVSM/Cam+67THVUoDhfRfJT5V0y1JPJf9omgbmb0/DYugcOi33bTSS9pO9m/uQt
         Gr0A==
X-Gm-Message-State: APjAAAU+On7X8jp0D7WSyYEltemS++BMbW1hBuWQwoXqev5CouBFzdAm
        HIW0cDDl0gbo/EM498zvcRW1InTXHiRpjAfFEK8aCMDj
X-Google-Smtp-Source: APXvYqx2tFtn+wLKOuG4SqRwmZb15kUW1v99T8btx3EeTebuasSptnkhKlEx1kcHEJCafQAi61VO4JPl6tR4B5IwYiA=
X-Received: by 2002:adf:dc10:: with SMTP id t16mr25126855wri.40.1552405705065;
 Tue, 12 Mar 2019 08:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190306130446.2193-1-corentin.bompard@etu.univ-lyon1.fr>
 <20190306130446.2193-2-corentin.bompard@etu.univ-lyon1.fr> <86va0o9qsp.fsf@matthieu-moy.fr>
In-Reply-To: <86va0o9qsp.fsf@matthieu-moy.fr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Mar 2019 11:48:14 -0400
Message-ID: <CAPig+cQEYDay9kTUpBepw6kN_PgpG4dRXeNf82Kty+E7piXeWg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] doc: format pathnames and URLs as monospace.
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        Git List <git@vger.kernel.org>,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 9:16 AM Matthieu Moy <git@matthieu-moy.fr> wrote:
> Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr> writes:
> >  Changes: We listen to Matthieu MOY and Eric SUNSHINE's remarks about
> >  our mistakes on the last patch.
>
> This addresses all my previous remarks, so this (patches 1 and 2) is now
>
> Reviewed-by: Matthieu Moy <git@matthieu-moy.fr>
>
> I'm Cc-ing Eric in case he has anything more to say.

Thanks. A few comments:

In patch 1/2:

* drop the full stop from the first line of the commit message

* s/futur/future/ in the commit message

* s/There are false/& positives/ in the commit message

* s/both, It/both, it/

In patch 2/2, there's a 'man curl' which probably ought to be
converted to `man curl` (per paragraph updated by patch 1/2), but
perhaps that's outside the scope of this patch series (though it would
be easy enough to do -- but not necessarily worth a re-roll). Nothing
else popped out at me while scanning the patch.
