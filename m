Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B98E1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 17:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJJA7I (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 20:59:08 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:38491 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJJA7I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 20:59:08 -0400
Received: by mail-ed1-f48.google.com with SMTP id c1-v6so2486743ede.5
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 10:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PIBXcjk5oIB9dU9MoOCTrDcSo2m1GLuYEujoWGmhybw=;
        b=voVSNVmaP2figxffdFaZBt9eJuGOI260fzPfG5G51Ber4o5Y2Dn4uzpwPbM07srlaO
         rbRG998GV1FrBoK4FY6cuBM6dd9jH5KQa+gC6jENJFYJ6VTFJL8Cev83wPHaYrfX/5Zg
         bSb7Bx2Vt/D/WiaIJ0LyK2nSblBcym+tpAuO+vaygEYUlIegE/kVXCNzqHLgW4xHUbCM
         AOdxexq0LtfyUOiCbeNJf8BeDeZsodhLhZHKZrKPfyN6vIyMIYudhuR0bhtHtzEsNG+W
         SGV3gjixXyKW8dStXZrjyX2AokNG9Le/+IShKyYZdCxF/jDVHMRpIazWgRYi50fk0pI5
         o+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PIBXcjk5oIB9dU9MoOCTrDcSo2m1GLuYEujoWGmhybw=;
        b=QHFRjJGPMLdXf9cSTZNkaAqNCuhfSCwRmIUaNzvUlTjDIe0lJI43t25IQDxD2ly6FC
         wAotuSw3gKqeiyZMhKRuJx8ROZXNqtdtyRmhbtU2piwfGLMC42e0Jb8bzN4HLGKnbNt+
         3EBM9vVNIq51YugpY4m1UyUAJjyF63msFAEDuMa9nyDUmL+eF3wVk2v2Vl0e5hurxWsF
         IpwGdLWLZYMSMwRpPoOVFfk8nKSZyxKhd6kVcySKiOwfVWoLDN+kEzBa6Tm6VE779IPz
         1+Zb+VYaYyr3bNdzjWKFTLMssbS4imVOX1rOAco/xfOjic9Dly7WlrVJMJFTLaDABgvi
         4T3Q==
X-Gm-Message-State: ABuFfoiCHXP+bcfQv//G1SUFbjW/y2xRovZbB0HY5F0ho//IoiVzFU3/
        +0dnAIxnIXjuIY3xmlT6WqbcJSeeHbxDxIKJkPHmag==
X-Google-Smtp-Source: ACcGV62X2IvWKTcG+mR8FZlWMGFgOoJuT0RZu8vfjH5PVGHCn+6DnnBXo3aPVaOSPrxGxNLecHpWGwnNSSPSHr5TIYs=
X-Received: by 2002:a50:9931:: with SMTP id k46-v6mr36512768edb.85.1539106861692;
 Tue, 09 Oct 2018 10:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <87k1mta9x5.fsf@evledraar.gmail.com>
 <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com> <87h8hwafof.fsf@evledraar.gmail.com>
 <xmqqzhvorkq7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhvorkq7.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Oct 2018 10:40:50 -0700
Message-ID: <CAGZ79kbASAXMfKR95CNiJpRFTTq6DKho2v=UfpLG=_jnVCTTUA@mail.gmail.com>
Subject: Re: What's so special about objects/17/ ?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        nico@cam.org, Nick Alcock <nix@esperi.org.uk>,
        koreth@midwinter.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 8, 2018 at 6:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > Depending on how we're counting there's at least two.
>
> I thought you were asking "why the special sentinel is not 0{40}?"
> You counted the number of reasons why 0{40} is used to stand in for
> a real value, but that was the number I didn't find interesting in
> the scope of this discussion, i.e. "why the special sample is 17?"
>
> I vaguely recall we also used 0{39}1 for something else long time
> ago; I offhand do not recall if we still do, or we got rid of it.

gitk still shows changes added to the index as 0{39}1, whereas
changes not added yet are marked as 0{40}.
