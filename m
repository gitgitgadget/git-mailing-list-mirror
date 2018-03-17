Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6441F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 08:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeCQIJH (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 04:09:07 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36388 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeCQIJG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 04:09:06 -0400
Received: by mail-ot0-f194.google.com with SMTP id 108-v6so12669351otv.3
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rxfi1oXzlxxueHGPe38IuqMiR8j7o/zLGvLrn5B0EtE=;
        b=dMPJAnwh8snBgZ+Rl/N3Qao4uRoH/jdPedUlMDTtiS+YDtlhsTjARpOnUyx7PxudG4
         z4TJByp1z5zM7BTOHv6ld5igpzLWbhb1v++a4miinJQRIQoAnaiu6364UXGLhoMcaaHA
         KnalOWAody+9AVX+vzTC8kJQ5tQjI7uWfLNvBOXP9LAdIurOstSI+d1Pkrcq+nCi4Oi5
         aUxk6H/rJy6y0SzI1Y5usXtZo7P/au8Ci3Ne9wihS5IFmsy0SEMQNSoNouqc6332+syp
         IfsI7zRelxPBjY4Xxec07muXlCbbfbX/fytRF2sjw0z87A8m0Rc5M9vsUz2iQvZl4S1G
         Xifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rxfi1oXzlxxueHGPe38IuqMiR8j7o/zLGvLrn5B0EtE=;
        b=CthA1VC4Ro35qTK2Qgow1WLp+0soeorPHFqW/+zsUCAE/XrEa9wl0anc+LJUg1xDMF
         pEuTEJQMYj+XVQ3HNqY5enCP8+t3AbgQh1gYasPGtkzDg8aRlP/rMBrwbKSsrdjpKCmN
         udGV9NQqgFtxY+cmXjPTdp4Rp7NST7rtVmzWRNl8oh0+5DOnnkLJ3IcexPzBFnxA6pk8
         uG+JDDfCMlr21iRxeBU+7I23arS287gRTm1D5m2u2mx+XRjzvzY1px5hfLx9WwqVloic
         wCv5ItnHlzC4Ybu3ecB7cJGYTczf+XAuNMclaJEJF5F2BhpTcP51XAEtxLe1c/k7rDko
         wQiw==
X-Gm-Message-State: AElRT7GNHkDKCXLllw02YIL5Xqv401bKFJc2XgW5gaWWI1QFExjp05bW
        yC5s4zjHsDGUpeaYY/LyNYBBhO61atYG5M7Ecl0=
X-Google-Smtp-Source: AG47ELv86Yt9Efraz3E21Dz2ytWhtz+gbiduGALf0OCXJ2dxl7IEqmdRuz3c96wnGsJVSTR96VSrGbueHGoV4C/UyoU=
X-Received: by 2002:a9d:ae9:: with SMTP id 96-v6mr3237538otq.75.1521274145820;
 Sat, 17 Mar 2018 01:09:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sat, 17 Mar 2018 01:08:35 -0700 (PDT)
In-Reply-To: <xmqqlgerzojl.fsf@gitster-ct.c.googlers.com>
References: <20180316200648.18256-1-pclouds@gmail.com> <xmqqlgerzojl.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 17 Mar 2018 09:08:35 +0100
Message-ID: <CACsJy8DBDqin3xYk70A2HxrZ6AYJhd0V5dj98Ni+j8t0vdNGyQ@mail.gmail.com>
Subject: Re: [PATCH] format-patch: use --compact-summary instead of --summary
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 10:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> For reviewers, a couple fewer lines from diffstat (either cover letter
>> or patches) is a good thing because there's less to read.
>
> I can certainly accept that there may be some reviewers who share
> that view, but me personally, I would rather have them outside the
> main diffstat section, so addition and removal of files that are
> rarer events do stand out.
>
> I guess people would not mind an option to use it, but they can
> already say "git format-patch --compact-summary $upstream..", so...

Good point. I can't negate --summary though. But that calls for another pat=
ch.
--=20
Duy
