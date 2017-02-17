Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9CC20136
	for <e@80x24.org>; Fri, 17 Feb 2017 13:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbdBQNup (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 08:50:45 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:33229 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbdBQNuo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 08:50:44 -0500
Received: by mail-it0-f41.google.com with SMTP id d9so13556511itc.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n0euzFZxU/KyWblsu2v3PAsfbe4H2X/6UJYHqVIqfUs=;
        b=GCzWQh03XuXlBnqTPsvXdiWS9DmxwFGMx4M2E8jVpVs17Peuf5Nzzlkfz+3R9LA8q3
         AS/A1w5atgVWaVoVdadd0Hhjv+bdENgqg+9aHAUsDaB/F1l7I9uDU3HEl1ws2WxhEOxC
         2jKDZQxP2SmFk7HbTwcDYfamvynd1t5DKlCrced5sv7jaqAAnWM3JUYqsJl2vB1dLbmg
         ohfuFHmgHhOx+iUWRGmB/JjFbdwawtLIjBhGgc+JGoXajM9cxzXiqHTmAOeQxTzTJP3/
         yLTdbuSXaSSmK61ZTLam4NY/JlvagaGomqmzXU7q9MiId277Xr/e934631xTRRxF54Ct
         XVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n0euzFZxU/KyWblsu2v3PAsfbe4H2X/6UJYHqVIqfUs=;
        b=JKSdA062c1k7Uk+mjVqPTtsWXV6dVqlFWDILf25MGVPrDD/i1fZE113jlKcglSkvCK
         0S9Mk3p4+Sbn/FRQ7p2oDcs6o/7NbD3/FC9yCkatO3TYADg8/KY/55LdjBrbcXJbTjcf
         wMRNZC3+sm7mtIgoJQeSuAKBK8MQE5jJ9fgSMjiB8KgoBGbv//EiG/y9KJclpCPPXwCm
         54GGP825AsKNIhSDRYGF8sdQrscfNW3JyjZAwyHjtWfZn0xrHzSF9aE471JeY98YCwJc
         fIZPjCXtsESa0iJlU+KmiObq/LbKZ39Hfoj+1urK8PvoHLaBcbm0QEuPnuTdFvSSfqcQ
         6Iyg==
X-Gm-Message-State: AMke39mtm4jFx9MTB5Nm/PKgB/N7gOe+nAjurhfrE+9hhc2MeF+18M9LvhIzqh7Bf63LLhLyaVXSs78ikEzhWg==
X-Received: by 10.36.103.9 with SMTP id u9mr3393323itc.91.1487339444135; Fri,
 17 Feb 2017 05:50:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.157 with HTTP; Fri, 17 Feb 2017 05:50:23 -0800 (PST)
In-Reply-To: <CAM_JFCz+9mxp37BTT7XPJ0fMd41DdbAxnvQF7id9msH+SDe6_Q@mail.gmail.com>
References: <CAM_JFCz+9mxp37BTT7XPJ0fMd41DdbAxnvQF7id9msH+SDe6_Q@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 17 Feb 2017 14:50:23 +0100
Message-ID: <CACBZZX4Zmwb8ZHGBXCpm6=yH_uxc-K1X1vv1jQ+wwnUPneqM4A@mail.gmail.com>
Subject: Re: git alias for options
To:     hIpPy <hippy2981@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 9:23 AM, hIpPy <hippy2981@gmail.com> wrote:
> Git has aliases for git commands. Is there a (an inbuilt) way to alias
> options? If not, what is the reason?

This has long been on my  wishlist, because there's a lot of
copy/pasted logic all over Git to make git foo --whatever aliased to
foo.whatever in the config, but only for some options.

It should ideally be part of something every option just supports, via
the getopts struct.

However, it can't allow you to modify whatever option you want,
because some things like git-commit-tree should not be customized
based on config, it would break things that rely on the plumbing
commands.

So it would have to be a whitelist for each option we allow to be
configured like this via the getopts struct.

Also there are surely other edge cases, like maybe the config option
now doesn't 1=1 map to the name for the option in some cases, or the
flag should be config-able but is has no long form (which we'd like
for the config), then we'd want to add that etc.
