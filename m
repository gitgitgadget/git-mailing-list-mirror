Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF2F2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 19:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757195AbdCUTNw (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 15:13:52 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34030 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757074AbdCUTMu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 15:12:50 -0400
Received: by mail-io0-f179.google.com with SMTP id b140so54439112iof.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4v0lpxU4Hi7UjmL6P9K2RYJSqneQbMLVM5jKG9ugAEg=;
        b=LOYfSJeqFDx/6pMkWwWPVB4M0wrU1uJ2X9sVU6+IEMj/TiDP6oPHlYceTRSf+XTXUQ
         PneLcfqKsBGJOfqP4pk1+s1+s27Q+n8pL9hpGmCfyQnvYSQ2M3etujifV92vKTp8kBHp
         aZYDWonZFUgt+c2z1QfzwlPIuThpvAp9MGodPf+tQUDjNh6uNjSRR74uy4UAIuULV8KP
         wnLAN5AD0PhYzQ9xpyi0aENXRND4SOWY6O97johTivJb+wBk141dTTI7Hn5JQHN/GvBH
         Xh+koRBZysMDtww1SCA95v8pat14AY81apmi0LMFNJTcw3E2Tg18V6ugmrXX4exjS+xA
         nx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4v0lpxU4Hi7UjmL6P9K2RYJSqneQbMLVM5jKG9ugAEg=;
        b=Z8vAnlzpjN6xpX/RO+gayhikqh0TpiLQG21kenGX0DOx+GoV+YJCB/0P6oZuzWeZ6q
         uM+1YQT9+krDoOrRG886LN0vqfClUyhhe+5dMzXbHGpEz3X06PBO+fC9E/Hi7DXXpqOe
         zflKfDOkSo8J66KpsS9WRH0Vm1+uvTks21w3u86pYm2S5CRZW2Rw41Q5maQ/niEf7NCH
         nx1VNcQ1NL4f9lGJ44dVZZ98iBN7RAl2hD/VTF4EWCOe3WXTTydcdY7xRSlDULZ5yYki
         eYyL0AorehHgVuIG/SfYJZsuhFFsHT+eA//AfWSD76v2PNv0Tjt/JreiqfETXBhPjuY8
         9P0Q==
X-Gm-Message-State: AFeK/H0nWv43ZSKpF8mNJT4O9/8OovRj2GUGYZaA28jpGLo0nb0sOa54e31zCApPBuxoQxpOhb98hLnXlTVSUg==
X-Received: by 10.107.32.199 with SMTP id g190mr11148882iog.117.1490123569055;
 Tue, 21 Mar 2017 12:12:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 21 Mar 2017 12:12:28 -0700 (PDT)
In-Reply-To: <xmqq7f3ipikl.fsf@gitster.mtv.corp.google.com>
References: <20170321125901.10652-1-avarab@gmail.com> <20170321125901.10652-15-avarab@gmail.com>
 <xmqq7f3ipikl.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 21 Mar 2017 20:12:28 +0100
Message-ID: <CACBZZX7F66PogXWPQTsMr7d0C5kcxZiG87cn4TrYwFc4U1wsYA@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] ref-filter: reflow recently changed
 branch/tag/for-each-ref docs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 7:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Reflow the recently changed branch/tag-for-each-ref
>> documentation. This change shows no changes under --word-diff, except
>> the innocuous change of moving git-tag.txt's "[--sort=3D<key>]" around
>> slightly.
>> ---
>
> Thanks.
>
> Needs sign-off (I could just add it back in if you tell me so ;)

Oops, will fix for v3.
