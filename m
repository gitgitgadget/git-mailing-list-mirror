Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D24C920401
	for <e@80x24.org>; Thu, 15 Jun 2017 23:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbdFOX4D (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:56:03 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34763 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdFOX4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:56:02 -0400
Received: by mail-io0-f177.google.com with SMTP id i7so21054230ioe.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HNFRfCpj08xObA3b8rCTpFAK3jWyMAXefehC+OFPvIE=;
        b=A04u66KJqeGXJCXnRZJu0/obNsDwJPoOLWpXoLp31sf5IDgfO1X0IYoq//jKjOzuYy
         M57niN93gl61uGFKEIT4bmneflPbbw6vZoto6dX11/2vAMnsGMWoKVS3zmaH3MoyUO0h
         fh2/ClqPTZp97LHJC/mwAIkPzq7/2/T3Sh/FASCVKt0d95P/GZXh5U5lmMygZRBJNtBR
         tXhq/4wURe1Y0/E0ke9jBkxwS3Uja98xEmgKHGJ2wwaojz8FN2isHFOEg0i01Wuj1e/B
         vix2adsrgAuID2p7dGh8eIVGtEDKb8S6ULl0zSmJ5D3cKr2hwvdAfxtvLrTiV2DVHm0R
         ArEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HNFRfCpj08xObA3b8rCTpFAK3jWyMAXefehC+OFPvIE=;
        b=HWIbSahBby2gn5nVCdEVo1iD7RhlD0U2ouZyh2XJ9DrzMYYpzwEpTBH6EEJs/sruHe
         NgEG6QKX85Fv/V8UwAtGutVWYwUSpTLrYzTQ5f9BgFY2I1YvJwuUYjxKdv8g0XFFK/Zd
         rW1V2ptBdNeBW8t5kCwpaz5DfevZa/ZAE8//6vzNf2cSa4L1b14G2P93m9q2/pAUEq0K
         mSWT6hIbQeIfi24c0+22K7SPcwoCx4Hey1Q7DBvRsOprLpaEV5VcCPDSScBNUIJD6thP
         MKmrHA3gZvyrawBuJT9GHVOja7VJdYBTyYUwyf9uK/HewzfkvqO3h9vt6tsz9D5ecEQr
         7MtA==
X-Gm-Message-State: AKS2vOxSSxILNBp03hDGfCigc90mQzfmOSSsbbpPWXo2zYohmu4gT5iX
        z+DtT2Vz1WKkjZ9GXseqhzFeKxBGuQ==
X-Received: by 10.107.181.22 with SMTP id e22mr8659471iof.85.1497570961276;
 Thu, 15 Jun 2017 16:56:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Thu, 15 Jun 2017 16:55:20 -0700 (PDT)
In-Reply-To: <CACcTrKfPKdPCVONMcGRbisK_WOt70yLdjavZnLTMMVocrwzk1w@mail.gmail.com>
References: <CACcTrKfPKdPCVONMcGRbisK_WOt70yLdjavZnLTMMVocrwzk1w@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 15 Jun 2017 19:55:20 -0400
Message-ID: <CAJZjrdW=1MbT=Lmouswez3W4hGP=anuMqMnQPkLta_fhUU4hCg@mail.gmail.com>
Subject: Re: [suggestion] Include commit-ish in git status output
To:     Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 7:43 PM, Mahmoud Al-Qudsi <mqudsi@neosmart.net> wro=
te:
> Hello all,
>
> I hope it is not considered too forward of me for my first post to this l=
ist
> to be a suggestion on a change to git=E2=80=99s behavior (though not in a=
ny
> functional manner); but a persistent frustration for me and everyone I=E2=
=80=99ve
> worked with (so, yes, 100% based off of anecdata) has been that the outpu=
t
> of `git status` does not include the commit or commit-ish, and one must
> resort to a `git rev-parse HEAD` call.

Can you elaborate on why you consider this useful specifically?

Do you think adding a $(git rev-parse HEAD) to your PS1 would do the trick?

> I apologize unreservedly if this matter has already been discussed and pu=
t to
> rest; I attempted to search the archives for a reference to this suggesti=
on but
> was not met with any matches.
>
> Additionally, if this list is not the right place to make such a suggesti=
on,
> then I would appreciate if someone could kindly point me in the correct
> direction and apologize for littering.

No worries, you're in the right place.

> Thank you kindly,
>
> Mahmoud Al-Qudsi
> NeoSmart Technologies
