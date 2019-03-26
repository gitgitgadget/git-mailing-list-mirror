Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CCC620248
	for <e@80x24.org>; Tue, 26 Mar 2019 07:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCZHNx (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 03:13:53 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55478 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZHNx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 03:13:53 -0400
Received: by mail-it1-f196.google.com with SMTP id z126so17923106itd.5
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l3BW8abW9Qblf444EqF+wBcXN3CbjKAYAZtBeqXeuW4=;
        b=Q5fAaOgPP8yqxRom46ALT2JjvoU3bR7c+2iRzhjIDiHAt5R+t6ds6A3xbPFQTWJYvZ
         8Yf9bErtu8fLtiOqihVVklg2ZdaNTU1lg00qWndqpo4Ca0LWWmR7ffPBJqsLDeXPSi/H
         fGGAAq1hu/H/f608wtW2fvwW1zJIZ9nHhHUUhBsqDqAumVcJ9AvkKuXy8L4njBzmBdTC
         8YJwVnNieNQe9qubWNzoj/FoWspk2cNymAjeW3U5Ib7Lw9oNSmPFuqn3DbeUsuXq6k8S
         hTsTu6bpqyQ1LvLA3vpdQ77u0jCnp3Sni4JnexHyXjNeK/3h++18qNEaCBO9RqyQfO3x
         3U8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l3BW8abW9Qblf444EqF+wBcXN3CbjKAYAZtBeqXeuW4=;
        b=mXiaHcGLWdiLM3N8KMR3Ude5O1mlbprNkn2NyVoV3LZ8ALe+fipYIgxVAEAVC02XvJ
         P4bt4nldH+BYLmUk79aGJgaN5ynil/AEdMtJ4Wg+hdEKL8M/A+LgzEw9A7qKsvbW04Lk
         KSr82nlC/h9TnG9nlj9y25oe1nNRy1tZhGK2LWQC6/qMipCh9ETw621/VoYqwSCBElCe
         NQXjG6LM49t7Xanm5bbypLqc1v02JHHG4ihvkaonQRX5kzPEaIkTZFFiwC6EymOQKE6M
         sHyDKe/TScIKYP6o/IKbAsueg2zJ/3z/1IfRjfwA0ddnHhiYWGrN1W9qIIsB8HLRXOFi
         YKTA==
X-Gm-Message-State: APjAAAX5xmNLygHfbHWUPJr84zzdMPWR0CPyD7QmslN/f8dEzypRp9rW
        6zySGY5x1PKCx4JIHeRbH1W0Fpu0ZdLBgwwzfFs=
X-Google-Smtp-Source: APXvYqwH7HV3Erf/oiAxI2y6n0MfgbJPZKbDjpzTnqRltzX8dSRuXpXEu+O8THYC3514mZp3zGbb0niW8DPt09Eqs/Y=
X-Received: by 2002:a24:7542:: with SMTP id y63mr2339586itc.70.1553584432432;
 Tue, 26 Mar 2019 00:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.167.git.gitgitgadget@gmail.com> <20190325202329.26033-2-avarab@gmail.com>
 <CAPig+cR0Ldt3EpQ683ZFNFXggfsTrdeZ3R-V6pDBZNA1N3c+xg@mail.gmail.com>
 <87o95ybmgf.fsf@evledraar.gmail.com> <CACsJy8Bk=Z8BaVeAhKzF4PWYLLG76cADooHKNw+Xy3EztZL1DQ@mail.gmail.com>
 <87lg12b13p.fsf@evledraar.gmail.com>
In-Reply-To: <87lg12b13p.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Mar 2019 14:13:26 +0700
Message-ID: <CACsJy8BpToq2VAzFo61dz7Hco42Sbka5qQm3ACn_6aejUxAKOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] parse-options: allow for configuring option abbreviation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 1:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I don't see how a new "abbreviatedOptions" is plausibly going to crowd
> out anything else, sounds pretty unambiguous to me.

By crowded I mean a lot of configuration variables under "core"

> By my count out of the the existing GIT_* variables in git.txt around
> 1/3 are already configurable via config, another 1/3 (all the GIT_TRACE
> stuff) is something we've wanted to have configurable in the past (but
> nobody's gotten around to writing patches for).
>
> I think it's fair to say that when we normally add user-configurable
> stuff we do it as config, not as new env vars.

I disagree that not every configuration knob has to be a configuration
variable, especially when core.* more or less becomes a dictionary
that you can't really read anymore (unless you know the key to look
for). But I see you're dead set on adding config vars. Go ahead.
--=20
Duy
