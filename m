Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83A62022D
	for <e@80x24.org>; Mon, 21 Nov 2016 20:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbcKUU4M (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 15:56:12 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34406 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753434AbcKUU4L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 15:56:11 -0500
Received: by mail-qt0-f177.google.com with SMTP id n6so213477022qtd.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 12:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OWxT2Se7CGvOvB+QEnAbJCB0/mogTi3mKhzj0+R0/Y0=;
        b=PlaJkJ2NDXA2X4+koFD+hGBpSDvWXyb+q4ilrbUmffe1V9Xrlo1vgRST7R9JLmTjE2
         B4GbadMMknEJ9CPAk2mZaygbXBec6o1hFxAlxtcSY3eMHruz+VskSDgK2PbPW4FYVtCV
         Jyb5cYsT26X/h0BAhto8cVUoK/i5rmczgXbKYKrQNwvOzcUnd2jh+XPeJzAArEM7b1tk
         aUxuqRm6Oupv5II+329PRlUMJ/3ewDQvSSNCfVHLPpkMQ1sPXCWO5HsawhkhEBlYsTPi
         sELlGEhyda8ofO7IMtVZNrv0intVVIzKEtmw56enKc3M157/PKACP91zYZd3hnNGzjKn
         g3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OWxT2Se7CGvOvB+QEnAbJCB0/mogTi3mKhzj0+R0/Y0=;
        b=HUhxgMx+2Q/h+tZKgQzZEA0Zr/a7JUfv6bhjmn0slddcP7i6IUyfeq/ZxjaGCGh/UQ
         nJqYThWpDhwbJz1lNX7wtCc+FjihCal3avV6AyY7NOp/ZUT4rFmiQu96dk9QbJOwkUzJ
         6JDtKn1t2b5Orn7JwSk4Evg+Srcne0f/uyLqZnMi+y8FHq6F65pG6D1MPKpsOtp1RLSc
         73+nGP4wzOublz0GxDq5ljrM7OKqC50kBSSeXU6OR+Oj7Aq3Of8LXWQbsJWEaw4fH45y
         bA2gEc3vOsHfLJv/Fz0L+cKeixVLZrFFYQPPHWvxlMl5jkBSorRFhH9bv4GRbu/w1bc2
         Qx3w==
X-Gm-Message-State: AKaTC02bebLl/41QAQwyVuhZIiIcwQxO/Tyyspul0HG21usyLXrsoy/M40Gjf7QdIyRoaHF7FEHoZnRugWiLJf2C
X-Received: by 10.237.34.206 with SMTP id q14mr9178283qtc.101.1479761770577;
 Mon, 21 Nov 2016 12:56:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 21 Nov 2016 12:56:10 -0800 (PST)
In-Reply-To: <xmqqd1hoimov.fsf@gitster.mtv.corp.google.com>
References: <20161121204146.13665-1-sbeller@google.com> <xmqqd1hoimov.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Nov 2016 12:56:10 -0800
Message-ID: <CAGZ79kZPZ5q_-XAb4FrzFDeZW8uYcy1byaD=Ron54Be=wTh5XQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Introduce `submodule interngitdirs`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 12:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The discussion of the submodule checkout series revealed to me
>> that a command is needed to move the git directory from the
>> submodules working tree to be embedded into the superprojects git
>> directory.
>
> You used "move" here, and "migrate" in the function name in 3/3,
> both of which make sense.
>
> But "intern" sounds funny.  Who is confined as a prisoner here?
> North American English uses that verb as "serve as an intern", but
> that does not apply here.  The verb also is used in Lisp-ish
> languages to mean the act of turning a string into a symbol, but
> that does not apply here, either.

I was inspired by the latter as we ask Git to make the submodule
"properly embedded" into the superproject, which is what I imagined
is similar to the lisp interning.

So I guess my imagination went to far and we rather want to invoke it via
"git submodule migrategitdirs" ?

But there you would ask "where are we migrating the git dirs to?", so
it would be reasonable to expect 2 parameters (just like the mv
command).

So maybe "git submodule embedgitdirs" ?
