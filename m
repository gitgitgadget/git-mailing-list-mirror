Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0DBC1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 20:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbdBFUYT (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 15:24:19 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35466 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbdBFUYT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 15:24:19 -0500
Received: by mail-ua0-f195.google.com with SMTP id 96so8411378uaq.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 12:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sqlkmKDNLf9jra0YUB+Mp9I+Q+qiFTfSe5iBqqU5GFc=;
        b=BsbEw2bvpgiRv1FWdQ5WrFs281gnFsZnIKeAAFzgFlvLWZaVHhUhX0owW9VdkbiOIp
         ltOvJLxChNwlqLWu3ltQK7FEuLIidWQIS1gE7myAW4Ps30Ay/jxZVqijjoK/Dk3rRLbi
         Je2tLFyzlWSJLWyslYdxXEj94/mhJENdUonWT/0Qa8cQTpOZS0s7jwV4YeosMM3/Xx97
         qK4dicz2vdvTMLcvqwKcqAnWJ1gCLjP4Z3OTvpw/vubKnITquA11ZGXOAw1SVRTUHcyZ
         Kk3duV3nFZnsQkJl2WGYqgRbwk9xgimg3sDZQ+am2meQk7+20KdW3w5sWiw/HIuAhiGT
         rxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sqlkmKDNLf9jra0YUB+Mp9I+Q+qiFTfSe5iBqqU5GFc=;
        b=b8LvlOnTewnPcElexnk6SBLXSmriyWDVHbcTDIIC6CcljtG8n97KBDhF1r6wc89sAT
         7xtfqgT9He64tYFjG3SLfbAsyJtwvadpLvU0eIPzGAnzCiDYYFwK3UmsDUMbbCT+bdRo
         ZqthwXHE7nlAbhtHB2V4USbuw/onuql7lbm771Ni6WkI5kTRly4WZ9fzdMjsLfyHKH5y
         q8rEl/yvwfncVZS4RclDkL0U62ARZiqQcTx8XKyUAVJSb0DzJJcsPbwOsDI/WNHfxp6H
         WCtWQE80jWT7sho5FGFxcgU7wg1FHyCM6hZK7DOMkuoLvbzcuMbIeTDkHeE3vDSjMaDk
         B7HQ==
X-Gm-Message-State: AIkVDXKswND8o6xP7NHmYRZZMItgXxf8GMkMiMoXY2BtVYdjMJ11N4yktDGs/TZkBNAnQlgjmiS545TSqQCP/g==
X-Received: by 10.159.48.85 with SMTP id i21mr5964676uab.73.1486412658116;
 Mon, 06 Feb 2017 12:24:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Mon, 6 Feb 2017 12:23:37 -0800 (PST)
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 6 Feb 2017 14:23:37 -0600
Message-ID: <CAJZjrdWq+xSEoTypA_hWdQJgioGOHJd3V7djeQ0YxpzvhuoM=g@mail.gmail.com>
Subject: warning in tree xxx: contains zero-padded file modes
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm just going to go ahead and split this off the git/git-scm.com
issues thread since this is a distinct topic.

On Mon, Feb 6, 2017 at 12:49 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 06, 2017 at 05:18:03PM +0700, Duy Nguyen wrote:
>
>> On Mon, Feb 6, 2017 at 1:15 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>> > # Irrelevant but someone should take a look
>> >
>> > 693
>>
>> To save people some time (and since i looked at it anyway), this is
>> about whether "warning in tree xxx: contains zero-padded file modes:
>> from fsck should be a warning or error. It is a warning now even
>> though "git -c transfer.fsckobjects=true clone" treats it as an error.
>> There are some discussions in the past [1] [2] about this.

I think you forgot to link to [2] :p

> The bug that caused the trees is long-fixed. There's a question of
> how severity levels should be handled in transfer.fsckObjects. By
> default it treats everything as a reason to reject the object. Dscho
> added configurable levels a few versions ago. It may be a good idea to
> tweak the defaults to something more permissive[1].
>
>> There's also a question "And I failed to find in the documentation if
>> transfer.fsckobjects could be disabled per repository, can you confirm
>> it's not possible for now ?"
>
> I don't know why it wouldn't be, though note that it won't override
> the operation-specific {receive,fetch}.fsckObjects.
>
> -Peff
>
> [1] If we had a more permissive set of defaults, it would probably make
>     sense to turn on fsckObjects by default. Some of the checks are
>     security-relevant, like disallowing trees with ".GIT",
>     "../../etc/passwd", etc. Those _should_ be handled sanely by the
>     rest of Git, but it serves as a belt-and-suspenders check, and also
>     protects anybody with a buggy Git downstream from you.
>
>     GitHub has had the feature turned on for ages, with a few caveats:
>
>       - we loosened the zero-padded mode warning, because it was causing
>         too many false positives
>
>       - we loosened the timezone checks for the same reason; we've seen
>         time zones that aren't exactly 4 characters before
>
>       - we occasionally get complaints from people trying to push old
>         histories with bogus committer idents. Usually a missing name or
>         similar.
>
>      So those are the ones we'd probably need to loosen off the bat, and
>      they're all pretty harmless. But it would be a potential irritating
>      regression for somebody if they have a history with other minor
>      flaws, and Git suddenly starts refusing to clone it.

The linked issue on bugs.debian.org has seen activity recently, which
is the main reason I mentioned it separately as still relevant:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=743227
