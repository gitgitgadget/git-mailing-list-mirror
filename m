Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14E751F404
	for <e@80x24.org>; Tue,  6 Feb 2018 13:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeBFNUB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 08:20:01 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:39032 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752810AbeBFNTx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 08:19:53 -0500
Received: by mail-ot0-f171.google.com with SMTP id f18so1671955otf.6
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 05:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=trqpgts6mcKEjOLKDVitP2NxGZC8g1/sD/Skxp2+Ot0=;
        b=g1v5V3Hnihpgsy4lkCy+EF/+5cmgRpQLmd3LL44RxKq5kmHMivY6yPs1MKONXDPSOe
         f5bCVmlhzd8CM4Fkl/LNdsk4DYKuVQCdH7N3pjvCoceXAF+SnyMV1ZYwhu74zVhQmHLq
         38UvEViFQZoG2TqyBFs2jSPC8YVT0bMeFJeuI53i2loAYYoEYj+5Vty6ubioMv5ihGb/
         BcR8QCNowyd9WSRs+Xp4N0h9b3bG2EbOfdaSiHbxR7cdwr7KHkLRYpDkUg446ethy4w1
         o0Jen0Y+z/KWFFVmSzrn0u+sC7y1kuhmx8VPTtGFk8JYLFRzjpsBJwuZIWVv0ObXbvhf
         wIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=trqpgts6mcKEjOLKDVitP2NxGZC8g1/sD/Skxp2+Ot0=;
        b=JtroHeMgJNe3gJ3nvTHOX4Xvpy/0A1kai6oD+psDdyjJr/aS4vIAuDkbu2wBve+ZQU
         hcJkrKuX5GkCyPXUBaBfXWrpVAtEwWkvF8XcJ/KbVp1fYZ3espfJgRD22hlTkTwoiBaD
         WbF+iKYO0OqhZYDvHizI5MbImxtMPvMNyMIOyxAdk9dXjr8huim279FbJWeODTMwWu60
         bhnWhUHg3VVt+wY+HyWPQqDWQwvZr4rNIi2F4PWzVkMFacXnx293A/CkEAUudDXibvKq
         rLPWI5+kVe6soVM8hQoYDzZCKn6XfFW11T70sk1NrWZAZl8LR/k416MhR7N9WKgSiWkJ
         8QUA==
X-Gm-Message-State: APf1xPALAzT/nGJAzexHujZV1GtF97PCCS/NGXHOpYK4FemlAL/jT0X8
        Nef16fHNmejYlmLS2+RSzKnwCxAi3wM7i7V17Vg=
X-Google-Smtp-Source: AH8x225lfHIh1coTM+FQ7nHr03G2v4sVtztzH5++vrgT5zyaJMTa5woHD0lprOJOgwaTLZAbF5kkrKpfxuKh6ui/7BQ=
X-Received: by 10.157.31.47 with SMTP id x44mr1720472otd.165.1517923192920;
 Tue, 06 Feb 2018 05:19:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 6 Feb 2018 05:19:22 -0800 (PST)
In-Reply-To: <CD3563ED-5E0D-4238-A664-4F2335598FE2@kuleuven.be>
References: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be>
 <87607nvzrd.fsf@evledraar.gmail.com> <20180128075731.GA17412@tor.lan> <CD3563ED-5E0D-4238-A664-4F2335598FE2@kuleuven.be>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Feb 2018 20:19:22 +0700
Message-ID: <CACsJy8A-KCzMCK34w_qNOQH2urwoQ-NmFZ+iR6Hyc3TQjGz1fg@mail.gmail.com>
Subject: Re: Cloned repository has file changes -> bug?
To:     Filip Jorissen <filip.jorissen@kuleuven.be>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 8:09 PM, Filip Jorissen
<filip.jorissen@kuleuven.be> wrote:
> Hi all,
>
> Thank you for your quick responses. I was able to resolve the problem based on your feedback!
>
> Based on this experience, I would like to suggest that git is somehow able to avoid these problems by doing a case check itself rather than relying on the host OS for this?

Git itself can't resolve the problem. Case checking is just a side
problem. You have two paths, only one of which can be checked out by
your OS. How can Git know which one to checkout?

Git could pick one at random and hide the other (using sparse
checkout, behind the scene). But that can still surprise the user "how
come I see this content (of file "AAA") while the other user see
another content (of file "aaa")?"

I don't see a good solution for this. I think the best we could do is
warn earlier at clone time "trouble ahead! Your repository and your OS
don't like each other!" so that users won't get puzzled at "git
status" later. Would that help?

> Kind regards!
>
> Filip
-- 
Duy
