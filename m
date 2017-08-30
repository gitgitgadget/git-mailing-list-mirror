Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3CA20285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750774AbdH3S7g (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:59:36 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36162 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbdH3S7f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:59:35 -0400
Received: by mail-io0-f182.google.com with SMTP id f99so1345467ioi.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cYsoudrMkzPg7FxU5KY5y00NLRQlUBgKuAGss1f/Nd4=;
        b=XcwfsvdhAff0tUSWdxi4QFGusrtl7INPnQsZ1/JN55GfTc/9Mh3CNx6YtoEswPRUVw
         QNe8duyk8B0pWW8Ps39MoyxpoKz+SsDF/DXBQhLJFiSWDXflvXta2dBT2Zh690/qUW3B
         g/5i22E42+tcyCtVmDVDyBrWlBAb/p3TwiBMmStukGj3FvELU4IVn09GkkTOCHWnlPxm
         JiBFXHLFXQyaiwQQcvIwFAYISV0qNJeqD72y5CR5ZllR16w0bD2S6r5p7DL8cLmctHJQ
         cBw8N879eC0pdzKm3iUFFfM2jz634nzoUWGk6kzLsGupEK5iBNM6hMRRc5LKJoW2wZNQ
         6nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cYsoudrMkzPg7FxU5KY5y00NLRQlUBgKuAGss1f/Nd4=;
        b=c6ucRzMHEs0neM/zIbTfD2vxZMm7lX/H4+OZcMQvCoElI85muF7N/nRFvbCAmc0HF8
         Tn9lz0z+G6ZNK371RQwzbfs3ut7PAo0zCOD/O03StXjgMWMEj4NyIuH1kQxkWvGeP7h4
         SBAOudT1XJB077elrB2Lis31hOKHhmSg4DgfWpPyrUmByNdoSssz/B1W/acnDl99phcO
         AfP/7HHCJgLT/4R5NgiygtdNjc/OZL6LQFzRkSx2ctWxUsdXYFChfGv4+5lUqJmpHgbP
         2+6mdYkB2eu5Q7u5mVhpb/0afpI6zThsCsxIG/6QCc8vmdq8PiQauojBEKdq8flMzeAQ
         xJvQ==
X-Gm-Message-State: AHYfb5hX4wmNgZkx+SiC3Ft/d/Pgvat2fyO9Nq5geJeVoj1/cZppvzEB
        1lHs0/ao+dO2SMQzuxSDcp204Mx5qw==
X-Received: by 10.36.185.90 with SMTP id k26mr2721145iti.129.1504119575183;
 Wed, 30 Aug 2017 11:59:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.23 with HTTP; Wed, 30 Aug 2017 11:59:34 -0700 (PDT)
In-Reply-To: <CAN0heSqGfxrFTwuaxgppZTx+3U=g_Qs4PyaCBF6ddV_PbvdpTQ@mail.gmail.com>
References: <oo62vr$pvq$1@blaine.gmane.org> <CAN0heSqGfxrFTwuaxgppZTx+3U=g_Qs4PyaCBF6ddV_PbvdpTQ@mail.gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Wed, 30 Aug 2017 20:59:34 +0200
Message-ID: <CAHGBnuMC_10krsdZe2KiQ4jjiL43kogn--dWjPgca_p2xgmQMA@mail.gmail.com>
Subject: Re: Commit dropped when swapping commits with rebase -i -p
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 8:07 PM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:

> The man-page for git rebase says that combining -p with -i is "generally
> not a good idea unless you know what you are doing (see BUGS below)".

Thanks for pointing this out again. I remember to have read this some
time ago, but as I general consider myself to know what I'm doing, I
forgot about it :-)

Anyway, this should really more explicitly say *what* you need to know
about, that is, reordering commits does not work.

> So if you agree that a "dropped commit" is a "counterintuitive result",
> this is known and documented. Maybe the warning could be harsher, but it
> does say "unless you know what you are doing".

I'd say it's worse than counterintuitive, as counterintuitive might
still be correct, while in my case it clearly is not. So yes, the
warning must be harsher in my opinion. Maybe we should even abort
rebase -i-p if reordering of commits is detected.

--=20
Sebastian Schuberth
