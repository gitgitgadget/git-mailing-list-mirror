Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27E391F597
	for <e@80x24.org>; Mon, 30 Jul 2018 17:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeG3TQg (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:16:36 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:43264 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeG3TQg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:16:36 -0400
Received: by mail-yb0-f172.google.com with SMTP id x10-v6so5068785ybl.10
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6loemx9/bd7bWKo9ihKbgv0uNhikpI3FMf7Abr/vGIY=;
        b=udcLHeVAkIcYIa9mzZov6BtXK7vVr9AJ/YMXCPxhvlvsPoLV9GhDKrhexscsJHEYxH
         nYnMI/p27wZx/Ji28VfOhWf8ObpmwHBieyKfpmdom2SfCpvVsOWISQSDcSK2lpI3PB4n
         eaxBXYFOjHRtjNQro2zkKFO1zhDH+q6fwv6fB5SA7Jgl9VFcVrK+e2Za3pIZZ2wj6Gf+
         seHPTf6gBxPNTB/m4u3Ymo6GqpvoTeYzGruCYPG9R3BFC4Mfx8rlIgMA1t1iOBYJwb2a
         m0LzINxaI5fPEB36EEUgSnGjNI3prL50H3R65NLE+Xof/KeVVJJjrarenGJnLjU+5nh9
         Ql+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6loemx9/bd7bWKo9ihKbgv0uNhikpI3FMf7Abr/vGIY=;
        b=HBxDw6KoaHL0ts/vGYs4iNjTfVZFhwP+1pZe7SlEhSK9eOf9y12z25urjtOvSl7cgj
         gpkSugQfOmTlpAghisHDpJiT3sD2DPTzfxA9dUfdKzuvYmtvWRcj/y++wL54T1Rk0Fcj
         NbvdrKU+E6NwcykG3fpJAsionhoLO4NLD+PD7Q+LO10GVmqBvWJNQQ2QKvVE5ZjinE0h
         iIWstT6XqwMOTzfr4AB+4UioFV01ooButtxLgxd0OIrIMKDE4hCm11WW2oo8JEkKqKCl
         FbY8rQvhkU9TsH0835RdFenhEs+YyUESmYM/9o17i9IoVWccJsNIeF6Uve6KsEehy7Ut
         LBrQ==
X-Gm-Message-State: AOUpUlEpRwvludT/sLPDs1cEoZRtl6BvrELDFg2Czp43tgkxlMmOJ/KE
        rg42/HeIoCwD71Wxhu7CWnBZrG1kXugDaEBA20n3f+4RcsI8eQ==
X-Google-Smtp-Source: AAOMgpd5k0VmX0OITOFJvD1jj8cZOQgSzlpVrFB+Udg1l8al9qe4BGRXDDwY3TNn3xQyvlRF7OlqZEv+CbOLUv+dTTo=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr10189922ybm.307.1532972432115;
 Mon, 30 Jul 2018 10:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180730155950.17329-1-pclouds@gmail.com>
In-Reply-To: <20180730155950.17329-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Jul 2018 10:40:20 -0700
Message-ID: <CAGZ79kYnfJXRiLnx8oq9mZYrzfBa-79URn+j4QtsFu3d07Jyog@mail.gmail.com>
Subject: Re: [PATCH/RFC] Color merge conflicts
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 9:00 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> One of the things I notice when watching a normal git user face a
> merge conflicts is the output is very verbose (especially when there
> are multiple conflicts) and it's hard to spot the important parts to
> start resolving conflicts unless you know what to look for.

I usually go by git-status, but I am not the watched normal user,
hopefully. Maybe we want to run git-status after a failed merge
for the user, too, though?

> This is the start to hopefully help that a bit. One thing I'm not sure
> is what to color because that affects the config keys we use for
> this. If we have to color different things, it's best to go
> "color.merge.<slot>" but if this is the only place to color, that slot
> thing looks over-engineered.
>
> Perhaps another piece to color is the conflicted path? Maybe. But on
> the other hand, I don't think we want a chameleon output, just enough
> visual cues to go from one conflict to the next...

I would think we would want to highlight the type of conflict as well,
e.g.

  <RED> CONFLICT> <RESET> \
  <BOLD;RED> (rename/rename): <RESET> \
  Rename a -> b in branch foo \
  rename a ->c in bar

but then again, this patch is better than not doing any colors.

I wonder if we want to have certain colors associated with certain
types of merge conflicts, e.g. anything involving a rename would
be yellow, any conflict with deletion to be dark red, regular merge
conflicts blue (and at the same time we could introduce coloring
of conflict markers to also be blue)
(I am just making up colors, not seriously suggesting them)

I like the idea!

Thanks,
Stefan
