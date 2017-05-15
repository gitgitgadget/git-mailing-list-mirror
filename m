Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE322201A7
	for <e@80x24.org>; Mon, 15 May 2017 13:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965210AbdEONwU (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 09:52:20 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36859 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965201AbdEONwT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 09:52:19 -0400
Received: by mail-wm0-f46.google.com with SMTP id u65so82463103wmu.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MVlaChkkItWJ45pA/t4AmuY+5R5uTuiwK/tupl2f/9c=;
        b=t80uaHxZtkcuP3gw9G1aKiXUrrPccqQYNEHHIWYtxpuTFQ08wlqIR+5vm8BLSxxI9P
         rCgei7FegxkAe0KLjLAV841BkCOBunaXmot6MjRlxGKwu9Azrge/bCr1DU95hokhJr7+
         O3vEsqqa9bSgcnWUdQV5FBwipiwCOhfmmvcgNtQ8RBdIgmVQ1175h9BYrpKEfaAsa9fe
         DMCpKm6fWmwqqEJLzo4nrwc561DIwIDUsvfuMws5S5kbhJf/oxTS8CqXE4Ujh+kd0+tA
         rRRubvfGvgIqTUgu57fF8O2yBC6uGKRFWSB4rNVGZRf2RmBpC1ioumOBZGfrA7YVYP4w
         /cYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MVlaChkkItWJ45pA/t4AmuY+5R5uTuiwK/tupl2f/9c=;
        b=Ra7S/6GHEwtXudJoVqgs/Mwr55M77uodFr/HMoGzGTe7g2cpFV96Z0pua1zufk5XH2
         IHthcFuK0J9hMGUK25jrJzZp8+i4xB6+up5qRvE6lBbu5hFA6hT5m0CKCg+HxozEcqux
         PxsQOqOIOXjxBxHfEUA78YT+gToih4xvjgnPGiLIUEza9XbBCMnlvUhEJnRNotUg74BI
         dFkZCmezC7g514tkcQ9CYLDbZvwy5MV+9+ngNk57VjIhdp/p1nqWyApFDHFxz+ZyAFll
         v+HK1DJIexOuBVlFMnLXWO1zdQDxH0k3c2hciciMcKBVnrH42yElnCrbvnaGsugnFFr/
         VcFg==
X-Gm-Message-State: AODbwcDtH58jA+9iHTrQfLGThENalDArxPuqB4RLQWrFph1yq6M0ozrm
        3ZjQlLtm1LDsvoEr+lk27tzn82TjFA==
X-Received: by 10.28.175.84 with SMTP id y81mr4071558wme.25.1494856330961;
 Mon, 15 May 2017 06:52:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.132.34 with HTTP; Mon, 15 May 2017 06:52:10 -0700 (PDT)
In-Reply-To: <xmqq7f1iv5fn.fsf@gitster.mtv.corp.google.com>
References: <20170505052729.7576-1-whydoubt@gmail.com> <20170514031513.9042-1-whydoubt@gmail.com>
 <xmqq7f1iv5fn.fsf@gitster.mtv.corp.google.com>
From:   Jeffrey Smith <whydoubt@gmail.com>
Date:   Mon, 15 May 2017 08:52:10 -0500
Message-ID: <CAPX7N=4jidx5pr3BfFoTL27gbHDT6sdm1q2Z2YxfjsBuN01XaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/22] Add blame to libgit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did try to keep any unnecessary changes out of the big movement
patches (17-19).  Would you prefer I break down 19 further?  I had
been holding back because of the added churn that would introduce from
lots of changing function visibility in blame.h and blame.c.

(And if gmail would quit trying to make my messages 'rich text' --
a.k.a. HTML -- that would be great...)


On Mon, May 15, 2017 at 4:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff Smith <whydoubt@gmail.com> writes:
>
>> Rather than duplicate large portions of builtin/blame.c in cgit, it
>> would be better to shift its core functionality into libgit.a.  The
>> functionality left in builtin/blame.c mostly relates to terminal
>> presentation.
>
> As I said in my review of 04/22, it is a bit hard/tedious to sift
> the changes to refactoring that actually changes code and pure
> renaming and movement of lines across files with the current
> sequence of the series, so it is very possible that I may have
> missed something, but from a cursory read through the series, from
> the comparison between master and the result of applying all
> patches, and inspection of the resulting builtin/blame.c file, I
> think what this series does is very sensible in general.  blame.h
> does not seem to expose anything that is not needed, which is a good
> sign.
>
