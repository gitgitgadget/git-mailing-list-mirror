Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BC001F454
	for <e@80x24.org>; Fri,  8 Nov 2019 16:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKHQo2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 11:44:28 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:44121 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHQo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 11:44:28 -0500
Received: by mail-ot1-f42.google.com with SMTP id c19so5690300otr.11
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 08:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTKn3/Ke3x9/SG/wt58rO00qRT0to8WVh3+CAs6d84U=;
        b=FKJq3KMaYcP8/qYMIJP1nZCMmf1e+DCVR4jQsujuHhiiWkeRKNJe9Mg/h5xeY0++CO
         J4mQmbx0p6GQDe/7j/vA1pLfuEZpkDmGvJbhaerf/I2ylqEdHDClAZBFSrBbR2JXicgo
         wgby3+v3zaXc/+OviomX/BiFLDpdqtHMvONwW8dsPAT+F00xIEe26BJCS3Fvyu/qJYVg
         QG0hZPe+fH+ntIWjofy78SCbI4q9CO5ENSkP2m2KdZrHeAGVPtwVxuo44sLAawUvaMcM
         Vi9er2CxpRKzOcx2yx8LsmkTkwmqT3XGjHfPTz6y8oYHj0bn2T6VCBr+5yZ4E4IHXbYh
         4AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTKn3/Ke3x9/SG/wt58rO00qRT0to8WVh3+CAs6d84U=;
        b=beJgZKKVvlryBZEKTTZb8P1D02X/+jHDpjBlKrbCAgyvzzflLRfmPXD3VaK8ZJAJaW
         nrdSFSPEcFV3Uao1IQfHZ76j/vxRRSDQQsOocJi2cIFEKy1yM3LpzBUOMQQjWAxGI7kA
         HIIgoF4xYXYeO5OaAICK/hWPbeAfUfG1u+4tFrf9Onso3U5oYKskpAFC854MrF2Qom3n
         iNuo+lZe8/440DYcO8coP71lxLGSFYy4iK/hmi05CqAqW8K+J90TvVdDfkIYzjTB/gjU
         pdh1jm3JTwV0vhRlSXoNJkIV6tZyAaxk7Yaz4PePTi1PwsFocF4QIzWwSzRKnmUK8OfW
         OJlw==
X-Gm-Message-State: APjAAAV3/bbZA/E2f9BT9eNUW0imF9LWpzwErOKTGqh2yGfjS+ZODxAk
        QE6bUjc2e4JHppMNDzACO5RIRqSpj/np86k/JSvFw5fR
X-Google-Smtp-Source: APXvYqzuFSA986aZcubNxuTjSx+gTDG8jbCWunQnbdl0KjgtAvMu/tqfGR0idHnT9jEercQoY7XaxWhGOdnKl+4ODIw=
X-Received: by 2002:a9d:6658:: with SMTP id q24mr3386144otm.345.1573231467121;
 Fri, 08 Nov 2019 08:44:27 -0800 (PST)
MIME-Version: 1.0
References: <xmqqeeyin4kx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeeyin4kx.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 8 Nov 2019 08:44:15 -0800
Message-ID: <CABPp-BHLAdTDaooQu2YXGcTEtqQrOwZ7cuQNhNuFEnV-yA0FiA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2019, #02; Fri, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 8, 2019 at 12:43 AM Junio C Hamano <gitster@pobox.com> wrote:
> * en/doc-typofix (2019-11-07) 11 commits
>  - Fix spelling errors in no-longer-updated-from-upstream modules
>  - multimail: fix a few simple spelling errors
>  - sha1dc: fix trivial comment spelling error
>  - Fix spelling errors in test commands
>  - Fix spelling errors in messages shown to users
>  - Fix spelling errors in names of tests
>  - Fix spelling errors in comments of testcases
>  - Fix spelling errors in code comments
>  - Prefer 'up-to-date' spelling
>  - Fix spelling errors in documentation outside of Documentation/
>  - Documentation: fix a bunch of typos, both old and new
>
>  Docfix.
>
>  Will merge to 'next'.

Wait!  I thought we wanted to eject the uptodate vs. up-to-date patch.
Do you want to do that, or do you want me to send a re-roll where the
only change is removing that patch?  (The other patches are fine to
merge to next if you want.)

See https://public-inbox.org/git/CABPp-BECJezMeg1pZyQijkBDooA_834weeg_2hsZ1Vonm-tAEQ@mail.gmail.com/
