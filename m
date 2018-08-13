Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD0B1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 20:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeHMXZx (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:25:53 -0400
Received: from mail-yw1-f53.google.com ([209.85.161.53]:45110 "EHLO
        mail-yw1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHMXZx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:25:53 -0400
Received: by mail-yw1-f53.google.com with SMTP id 139-v6so14588814ywg.12
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uNx/tORwLgNcAWe35kb4jvccgXQJzj6KJUlcmQF0XaE=;
        b=ss0fOimNK8RbDo0UUCs3Nr/fBuL15JAJK/BKnb4q4Hbb+rkH9aByJU+42WqyTic1Dt
         hO6B16+WXSfOkR/7UByyGqg+edFNRPRXKxpidbRlMUbNCS5VvOiaIOHQOcS++YHd7iUu
         oSQrPPclUNBkg2fJaJ7AM7G+BZzWmMUfF2twUQ8yFS2rJGFCet4gzRL/vHTECuPpqhUv
         H8N1Dh+JRkuPihqzLy/gDMwNiiDN2pxdYrZP7MwtiIzLQhi+kmYebI7zVWCCCU8xNjfj
         nGtM8nyA1lHfYRlpGkbUo7NEhUO7voJ87JhTBYTxntj62wPfOGb0naB6kTtnNQ2nFzgR
         MCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uNx/tORwLgNcAWe35kb4jvccgXQJzj6KJUlcmQF0XaE=;
        b=kTFMpzorL/aaK6rrES0vD5Ds08czs5shUwQymdAo0LS0bYeHrfxt11X/KCtNTuMP/Y
         77EzWEomaFUW3W0InIx/RlG7/kcNd6SM5D4gxiNCa/BXBuer8naoRHnPRsx3ORLDiFjM
         DKyvPIIgkbWK/Fga04+crIyQz1PmuG+xl8FncpWtA3nbXFsZlVpfK5zPKvfOFAVhAT3i
         nb4Y4y//nZKwRXMjpFe7PlYxDRGZc3zNii32pz+CTvHrPQsFUl8hWrV7q6ClmQ0eIPoj
         CCuEfBPRNr/suqWqKUBTblmSMIK+RBYL8+alv32MxKNk2tjPDMPshkEgdxlXOI7V2TCs
         +luA==
X-Gm-Message-State: AOUpUlGitFN2FZwbsxKwWa56RQUXGmqWe4kNJjIO4VFO3UXIzV1XQLDT
        i7w2cSEBGIQZUCn1TOd/smWagvGpJcX3WMmET4eHcA==
X-Google-Smtp-Source: AA+uWPzrUeSm6uO9ZeFlXVuCAURhMMW/QMzGftna4jgDx1r09CcwgiYQ7E7ko6Aw8ZXUy6T+acUDzIuemdMGoSkQJUk=
X-Received: by 2002:a25:cc03:: with SMTP id l3-v6mr9987383ybf.334.1534192922759;
 Mon, 13 Aug 2018 13:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180813163108.GA6731@sigill.intra.peff.net> <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 13:41:51 -0700
Message-ID: <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
Subject: Re: Contributor Summit planning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 1:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> >    Or would those companies be OK with trusting that some 20-ish of us
> >    can hold our tongues for one day and not ruin the surprise?
> >
> >    There's also overlap with the remote A/V concerns there. I.e. an
> >    acceptable compromise for those companies might be to talk about
> >    those features freely in the contributor summit trusting that it's a
> >    closed forum, but that wouldn't work if it's going to be broadcasted=
.
> >
> > 1. git.git$ git log --pretty=3Dformat:%aN --since=3D2018-01-01|sort|uni=
q -c|sort -nr|head -n 20
>
> You'd need --no-merges there at least.

No, I would disagree, as that removes you from top of the list,
and you seem to be a pretty central part of the community to say at least.

=C3=86var specifically pointed out that we might want to hear from you and =
Duy
if you want to attend a conference and if so how we can make that happen
(by choosing location/time/setting appropriately) IIUC.

>
> Oh, using "git shortlog" might be also simpler ;-)

I guess you'd need to memorize a different set of flags for that
as without -s it would be harder to parse than the oneliner above.

Stefan
