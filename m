Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 599311F576
	for <e@80x24.org>; Thu, 15 Feb 2018 10:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755300AbeBOK1n (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 05:27:43 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33118 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeBOK1m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 05:27:42 -0500
Received: by mail-wr0-f173.google.com with SMTP id s5so2812901wra.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 02:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5SuJikjVf4YBT50Xs2pCRMzlJ1CJHnSi2AfoMYyC3j0=;
        b=Y2K+pWAVaX2THjsY4ZPRHGBfd4a0Z2MiUxo295zDhC7fFMQjQSBKjRu4y873nV1wgs
         vxBtG2nvpv6rOdIsLIQcbIdhGInNNh3kiIiSUhcoeggR4vzOOiTU037Iys11mxzZhMgu
         HYUP3iFH/4fzxHZkWlMdmIN8BquoXBw4mvur/mvizqpfJllHj0XSiUxmws7FtP1e7OIa
         q0atocD7zqc7evgSlEVQlBGM2zUYd99YtItQE1fQCsQ02imyx7Fj/rIGB1yE6Kf1fKLf
         jBeQLQB4Ax5+bqh+Zxd/kIA5zX1ApkDajppThkvXty61VzRXKTDvfggB+zSxiCMU/jVp
         XQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5SuJikjVf4YBT50Xs2pCRMzlJ1CJHnSi2AfoMYyC3j0=;
        b=C3ddfr3FdCm+5mnNYx4pEylyBLVo8pU9weoWz2bziOWszODfNDYjVUnATijw1jhrk6
         tJuNgLKlZOlo2vcPfJfLSveU3P30Fxgif7DFkvRqQ1ODolq1C6QsalvhlaAwhNtxTULV
         ZQxxv+8R6qMcsWKr4S7nF6pubdEHFXUdbG4Kudgu6041GLxPa7mrZ7ThCjchdXQT76G7
         nDCuZpktm4gs+4Smt9PeHsPvK2crJB4f5rLugLXlsEblvypHiJa0T7i+vDQjQ3cODbp2
         6Aw3oMpNkIz5DSalaTABEnILWDlaF1qGvh8Jg9f446j8KnODmyzqkWQpfzYJtU1CeGgM
         jJwQ==
X-Gm-Message-State: APf1xPCbXnJ5oXCvnoS89oQVGLOm04BGwualGn1H6dQ2QkANhTTumc7V
        YDi3bkChp7EzYOOPMlfjT32AzCbkfpxVqfZX6+FUNA==
X-Google-Smtp-Source: AH8x227T6JslQchXFE6NW3ccHq1Mzgcswdhc1RWaBvi9MNf2JKm0N+F+o6Q/qI77K86OzP17PO7ih2Ez8F9HTbiuqvE=
X-Received: by 10.223.135.65 with SMTP id 1mr1957309wrz.238.1518690461398;
 Thu, 15 Feb 2018 02:27:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.17 with HTTP; Thu, 15 Feb 2018 02:27:40 -0800 (PST)
In-Reply-To: <20180215055158.GM18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f435c-80fa0ef3-afaf-45b7-84a7-28e2bb66f320-000000@eu-west-1.amazonses.com>
 <20180215055158.GM18780@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 15 Feb 2018 13:27:40 +0300
Message-ID: <CAL21BmmvOHFve7FRfnRKuzsEm+Hkwo5AZUmqWrM-tmcbcLTSFQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/23] cat-file: move skip_object_info into ref-filter
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-15 8:51 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:
>
>> Move logic related to skip_object_info into ref-filter,
>> so that cat-file does not use that field at all.
>
> I think this is going the wrong way. ref-filter should always do as
> little work as possible to fulfill the request. So it should skip the
> object_info call whenever it can. And then any callers who want to make
> sure that the object exists can do so (as long as the formatting code
> tells them whether it looked up the object or not).
>
> And then ref-filter doesn't have to know about this skip_object_info
> flag at all.

Your message looks contradictory to me.
I agree that ref-filter should do as least as it's possible, and that
is the main reason why I put this code there. Moreover, I think that
it's a good idea to implement that variable not only for cat-file, but
for all ref-filter callers. And I think that it's a task of ref-filter
to check whether the object exists or not (or - whether the ref is
valid or not). But I am not sure that I need to solve that moment in
current patch. It sounds like another separate task.

>
> -Peff
