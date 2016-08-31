Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348FC1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 13:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934365AbcHaNm1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 09:42:27 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33672 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933073AbcHaNm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 09:42:26 -0400
Received: by mail-qk0-f182.google.com with SMTP id z190so51359592qkc.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UxNNTW+ODDc3hkUQL9TTUrJlPfKvUrA5733M9XWpAIY=;
        b=fSXWU2AqsgjV/xNO9a8Or+s0F43ZWBaR9DW6O5OQbUO3yTPAp3JdheZmlH4YzWve+l
         dtO7lyTHL2MO9pLeDstvf78xkwSxy0uU8yOv0fcxK4eCauIAS48HzmXEH0Sex9MO5WZr
         IvOFMwuzXRBJdDfrqJBg0TFx4/YMxKU7QYdwUBPXO7H3i5i7uVN2WI6mWsiYm8pVGUD6
         gGbVJCr8PN0C041aOED1eL1WvWylN397/G1YkzONRZOmr2ASRIq9+jkhRWnfhEiKf+Sn
         vLU6YHcoNHFsEQtxr7MbjGDM2rtcHEctfuj4pXuWI7TGb7DWyE303vBX4AXeacyeUItj
         z3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UxNNTW+ODDc3hkUQL9TTUrJlPfKvUrA5733M9XWpAIY=;
        b=BLwgasjzjSE/KfCClvz4M31+XrhWn+KAO8Fb0zKH6JWHMiwByChyWiUqtqRlqCZoNu
         Yp7ni2Zgx3jAFF7L0/8AAY1ORgDTqAlU2g65XVZUShvNfFoeCL8UQcuVRjXYQskA23Hg
         f506/J9Np/hccXh94cYNncnRc8jJp1C4FlrAqSrW/JwtrPvNSmmMHiSV7RTPrqtAO1yY
         HOfiiAAOhDg0JS/wre4ITB9JA+qx4i/ejZdEiot2asZ3xir51O1k8y6hv/godiHdap05
         tF0yU+pX1VcmraewKuh7+0+wOU+ecdgG9TKzHIt5Psv1Vwju41YNvZqpgLnz4+EAhNiJ
         4lnA==
X-Gm-Message-State: AE9vXwMkmSZK+BkXQqkflQRTk4Q8tiWhCX654nmggzs7S0Mxf94G6NDE4YpXGG7xYfhuSSzAFzLh8yqo2312AA==
X-Received: by 10.55.79.139 with SMTP id d133mr10923398qkb.110.1472650945451;
 Wed, 31 Aug 2016 06:42:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.193 with HTTP; Wed, 31 Aug 2016 06:42:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608311227150.129229@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
 <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
 <CACBZZX6iEmbb68tzRKNAryp5qmt=iU9FMuOe2ONV=2ojcazoEg@mail.gmail.com>
 <20160830205151.k6ufhfzl6gh4uuog@sigill.intra.peff.net> <CACBZZX4NyjkK0Nf1JVGFRhc0xnLYg2YX6ctO5OxK3Pi60r5KaA@mail.gmail.com>
 <alpine.DEB.2.20.1608311227150.129229@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 31 Aug 2016 15:42:04 +0200
Message-ID: <CACBZZX6exynt_9_wVtEN19HQt_rPJdo5Ck3jujdQ-hLdMAGdmg@mail.gmail.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed tests
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 12:29 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi =C3=86var,
>
> On Tue, 30 Aug 2016, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, Aug 30, 2016 at 10:51 PM, Jeff King <peff@peff.net> wrote:
>> > On Tue, Aug 30, 2016 at 10:48:19PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >
>> >> >  -failed: $(patsubst trash,,$(patsubst directory.%,%.sh,$(wildcard =
trash\ directory.t[0-9]*)))
>> >> >  +failed:
>> >> >  +      @failed=3D$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
>> >> >  +              grep -l '^failed [1-9]' $$(ls -t *.counts | \
>> >> >  +                      sed 'G;h;/^\(t[^.]*\)-[0-9]*\..*\n\1-[0-9]*=
\./d;P;d') | \
>> >> >  +              sed -n 's/-[0-9]*\.counts$$/.sh/p') && \
>> >> >  +      test -z "$$failed" || $(MAKE) $$failed
>> >> >
>> >> >   prove: pre-clean $(TEST_LINT)
>> >> >         @echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $=
(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
>> >>
>> >> I don't at all mind this solution to the problem, if it works for tha=
t's cool.
>> >>
>> >> But FWIW something you may have missed is that you can just use
>> >> prove(1) for this, which is why I initially patched git.git to suppor=
t
>> >> TAP, so I didn't have to implement stuff like this.
>> >
>> > Heh. I think each iteration of this patch will be destined to have
>> > somebody[1] point Johannes at prove. ;)
>> >
>> > (But I really do recommend prove if you can use it).
>> >
>> > -Peff
>> >
>> > [1] http://public-inbox.org/git/20160630063725.GC15380@sigill.intra.pe=
ff.net/
>>
>> Sorry about that, I see it's been mentioned already.
>
> Yeah, it is true that prove(1) would be able to help. If it worked
> reliably on Windows. (Probably Perl's fault, not prove's.)

I haven't used it myself (or any Windows thing) but people say good
things about http://strawberryperl.com
