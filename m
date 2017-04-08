Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B29761FAFB
	for <e@80x24.org>; Sat,  8 Apr 2017 07:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbdDHHf1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 03:35:27 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35291 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbdDHHfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 03:35:25 -0400
Received: by mail-io0-f171.google.com with SMTP id r16so7252965ioi.2
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 00:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ov9yTVD4Dxiho4cbO30DNwg4UpZtPjb3iHNNVYP21qk=;
        b=MoGHsHaYiPElEucek2FIIhQssBotpvt1ZubEAAhSR4G6Xcg7COuj5HAxXURtU1Y01S
         NXI0ttc9vlJOYIQ1t8AlV8LVnnO4l0LIOQSLHpqZcxNpgS3EztFM/gEnjY3cuJPjst4l
         mnOCTYJ3rBze904EwkFoUDoJZ9bGBpSpLFbjtUvbbAepVcMqC2wviFcCsyXyZ0F7PjIb
         7jAEunOZgP7PYG5kFWzKV5ITUSS9HQ3uSnCw49qXMc/ICqFNZBO0lCJld9YkvB7VcxrR
         pusoA/dKEoKhtS/WZ907wk/39eFn25GrqPA+VzCJ9voW3rc1C4YnQTBE8bjoLAhtn4RH
         rpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ov9yTVD4Dxiho4cbO30DNwg4UpZtPjb3iHNNVYP21qk=;
        b=VMYNm5LVpziT7NNq5tNS1JLIGRffTHaRetOAbxsWAjsNPjtAZKc+bXIbbQDFUkwC4J
         6ZJXavbpJq/qT27IkWaYbUNaQCOBvPrjKJDzAdYg/L2mCS0rhze7d9MsiIs+6CLPL0t4
         6deDQgSL411LwXrZ5CPhHS/aEiX4T8bBeasdaIYxNubC2qFsJBqXaEhZDRn7khCZnvCp
         7dqNUOgyxxvMY58uowmFv8z0oQhEERIN/qXUI8iBrobSxWTJVSArTIXbDu4Eu25aT0/N
         h61Z1wyWEgrN5Jo/UvWf7hNimdY/uFZRxvQi1vLq2es1s+v0zyCqZ9X/ta0R9sp+4Bea
         LsYA==
X-Gm-Message-State: AFeK/H2jeXP0JDCQGAbmuV641WwfnVdtEURI6jt8Wh7120Zyh0Wh49ts7STg3RZjT/1Nb28nlMOukXD78/aIOg==
X-Received: by 10.107.46.229 with SMTP id u98mr29935711iou.147.1491636924796;
 Sat, 08 Apr 2017 00:35:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 8 Apr 2017 00:35:04 -0700 (PDT)
In-Reply-To: <1491617750.2149.10.camel@mattmccutchen.net>
References: <1491617750.2149.10.camel@mattmccutchen.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 8 Apr 2017 09:35:04 +0200
Message-ID: <CACBZZX7MeX-6RHgh2Fa9+YL03mjxs8xmyE86HnVxBxjMYizcig@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 8, 2017 at 4:15 AM, Matt McCutchen <matt@mattmccutchen.net> wrote:
> When I'm rewriting history, "git push --force-with-lease" is a nice
> safeguard compared to "git push --force", but it still assumes the
> remote-tracking ref gives the old state the user wants to overwrite.
> Tools that do an implicit fetch, assuming it to be a safe operation,
> may break this assumption.  In the worst case, Visual Studio Code does
> an automatic fetch every 3 minutes by default [1], making
> --force-with-lease pretty much reduce to --force.
>
> For a safer workflow, "git push" would check against a separate "old"
> ref that isn't updated by "git fetch", but is updated by "git push" the
> same way the remote-tracking ref is and maybe also by commands that
> update the local branch to take into account remote changes (I'm not
> sure what reasonable scenarios there are, if any).  Has there been any
> work on this?  I can write a wrapper script for the simple case of "git
> push" of a single branch to the same branch on a remote, which is
> pretty much all I use right now, but a native implementation would
> support all of the command-line usage forms, which would be nice.
>
> Thanks for reading!
>
> [1]
> https://github.com/Microsoft/vscode/blob/535a3de60023c81d75d0eac22044284f07dbcddf/extensions/git/src/autofetch.ts

Is it correct that you'd essentially want something that works like:

    git push --force-with-lease=master:master origin master:master

As opposed to the current:

    git push --force-with-lease=master:origin/master origin master:master

Which is how the default:

    git push --force-with-lease

Works now, assuming you're on the master branch with correct tracking info.

I haven't used this feature but I'm surprised it works the way it
does, as you point out just having your remote refs updated isn't a
strong signal for wanting to clobber whatever that ref points to.

Junio implemented this in v1.8.3.2-736-g28f5d17611 & noted in that
commit that the current semantics may not be a sensible default. I
think looking at the local ref instead of the remote tracking ref
would be a better default.
