Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A001F859
	for <e@80x24.org>; Fri,  2 Sep 2016 10:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753024AbcIBKZo (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 06:25:44 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35847 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbcIBKZn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 06:25:43 -0400
Received: by mail-qk0-f193.google.com with SMTP id v123so7595039qkh.3
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UpdB9QHx8O/ms2RnmSJ/n6zOMfXvS6XMxs4YryaZaV0=;
        b=bZ/Oy6f3wI1LFzNzXzMfpOtElMV4mpsW6pU/r82VGAyMXb3+Tqr23GbKCDABEesU6N
         9M5WYi+ImAjdgZO2lZs40JzlZwd9liWGzM2WWVVh91eidOHqg9lMv3pYDeKLDJunMZT2
         I+fisL5eNdKRSEE4ZfxWfjHYUKchzZYfO+Q+wHILer1eZUY6oF79Mam4L2zmcx2A1OxU
         kWApJBp1KOHZNhEEPTk/JDer6EbLIOQhgBy+HZUB5hTUer9WLwPnhjIuKX5RIYCEJrwT
         FGX8RA//C3klrNzcdKyQ/AwKCL9fzenLVtdjhPwiQFDM6p1M3AtHkEegkrmRm4CIwFXG
         gUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UpdB9QHx8O/ms2RnmSJ/n6zOMfXvS6XMxs4YryaZaV0=;
        b=kwQvZ8jwWDtYmLmMkf1oH/mOH4BI8XsLxdPInvNUv6Akb2NTQ7r6PPgKP5pDKN3aaS
         600+eXXv9tq+JtCJVLNrP36bWyT/oyoNSS3mbTTZ3HjNiDkwtvUeBSi9+NtFbIi+v4mc
         WMy3yIcBsX9a6nWXjsBt+JfCKvkijUXM7Z4dbnbMZ97dcoEywObT2AGfhxRGHNo0LF8L
         ggW/CBW9FJ2d9z6zCXPH5q3QBWEj5otFjE6pGqRshWNoMZoJeOckP6/ezexLX5uVM7Jz
         pLnJQGjH7u6ww1Ap2KKzDPJgh07cV5Ho2rHmnxNtgcmJBcbouGMQ3Rgp0hjmJPh4jZxl
         lc/A==
X-Gm-Message-State: AE9vXwMrSkyvF55Io3Z98BzDPsunSgmPT8VfpFN01cJD9PxZXf38LgwLitFF67AThdxXKz8Q79vCLdmjmFGb3g==
X-Received: by 10.55.20.28 with SMTP id e28mr9051843qkh.269.1472811942388;
 Fri, 02 Sep 2016 03:25:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.193 with HTTP; Fri, 2 Sep 2016 03:25:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608311702440.129229@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
 <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
 <CACBZZX6iEmbb68tzRKNAryp5qmt=iU9FMuOe2ONV=2ojcazoEg@mail.gmail.com>
 <20160830205151.k6ufhfzl6gh4uuog@sigill.intra.peff.net> <CACBZZX4NyjkK0Nf1JVGFRhc0xnLYg2YX6ctO5OxK3Pi60r5KaA@mail.gmail.com>
 <alpine.DEB.2.20.1608311227150.129229@virtualbox> <CACBZZX6exynt_9_wVtEN19HQt_rPJdo5Ck3jujdQ-hLdMAGdmg@mail.gmail.com>
 <alpine.DEB.2.20.1608311702440.129229@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Sep 2016 12:25:21 +0200
Message-ID: <CACBZZX56fjJZydnBrWUYtU6V3xyQyaLL4MYzVVF0yD4dRdducw@mail.gmail.com>
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

On Wed, Aug 31, 2016 at 5:05 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi =C3=86var,
>
> On Wed, 31 Aug 2016, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> I haven't used it myself (or any Windows thing) but people say good
>> things about http://strawberryperl.com
>
> Ah yes. This comes up frequently. Many a Git for Windows user pointed me
> into that direction.
>
> The biggest problem with Strawberry Perl is that it is virtually
> impossible to build the Subversion-Perl bindings using the Git for Window=
s
> SDK when using Strawberry Perl.
>
> Which pretty much precludes it from being used in Git for Windows.
>
> And then there are the path issues... Git's Perl scripts are pretty
> certain that they live in a POSIX-y environment. Which MSYS2 Perl
> provides. Strawberry Perl not.

This might be me missing the point, and I'm really just trying to be
helpful here and make "prove" work for you because it's awesome, but
as far as just you running this for development purposes does any of
this SVN stuff matter? I.e. you can build Git itself not with
Strawberry, but just use Strawberry to get a working copy of "prove".
