Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1C7B207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 09:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1956161AbdDZJCF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 05:02:05 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33222 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1434939AbdDZJAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 05:00:39 -0400
Received: by mail-oi0-f47.google.com with SMTP id y11so169087358oie.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p8dpeB+agV15xsOV58p5vv8TzAqxHSm1HgJaLZkUM5s=;
        b=hCtGo3+pTg9MlHkHJ9YG99H5dI81keRzxlPJscUiJ5GrnGdolkGKOK+3YiDDJRTvuC
         t5H9JuIPgNh7jaWIWOyGdFGnAJjH+/vx3jhmmglMTSVi2hFAP49hg5SepJ0yYxu1T4Yq
         9V0dI4wAih7j1Mc+7ELNzPeUoNdIogwS9yGivqhTEVcGswpfgIObOWnGii16Q9/nnFDA
         TN8syzdRBcruzuRWUalZ/CpnRPWK8hmp1XgOCu5P51omKEls6aljbgjOwvkfDd0nu6xF
         DPzB7cjEhHWSqRQRYbU6H0TlIF4wtTSVv81+jFj5sWPRDFmNDICUHjgrzvE1LRC0iDVX
         gLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p8dpeB+agV15xsOV58p5vv8TzAqxHSm1HgJaLZkUM5s=;
        b=bxA4dkyaAYFfMNiZx+aZwibJbT+T5D0zIyl3qnjlJSA5/DVgSixLgl3bDZaK68Wxi4
         PiBH0cuj7QuL3ssFBHZNkKlddSX8y79vx4qCiRv4TcomIvqCLTjfgBoTBzhLWgeyFubp
         QTbYuJrnEDQW++AiUjBoQI6lYC5q79jgbbwC72YbAlIqC6ObxACvcmiBQv4vut2f6let
         bTWK+2IKrbjI3G6nxJzDmkMvvoKTvKHIKLuh9CCkn9bH3lDi0AlHlYhRiZxTMtNTHYv/
         oPaSmUfklMsDk2QWZ/A2+V97XzL6iApqCVc/i/DRX888XaEx/HuCIq44FJNQNmwbVeqw
         z9dQ==
X-Gm-Message-State: AN3rC/4PbRT9Ukfob1c0rLZYW6rWCsRHmQkyisTsYyQ/vC+q6qo5MRFH
        6wRbJ2zNgRZ3IriwkTwqsDGhblLzUw==
X-Received: by 10.157.6.78 with SMTP id 72mr21052353otn.37.1493197237359; Wed,
 26 Apr 2017 02:00:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 26 Apr 2017 02:00:06 -0700 (PDT)
In-Reply-To: <CACBZZX7x0hSy5PTCo1Cf0Hp09jBhnSF0T=BseH68kwMRmqGJig@mail.gmail.com>
References: <20170425094453.9823-1-avarab@gmail.com> <CACBZZX7x0hSy5PTCo1Cf0Hp09jBhnSF0T=BseH68kwMRmqGJig@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Apr 2017 16:00:06 +0700
Message-ID: <CACsJy8DDDG0YKsXG8JWhowJ7TOH7Psw6v8B3AHA-dTpCHs+vYA@mail.gmail.com>
Subject: Re: [PATCH] test: remove unused parameter from the wildmatch test
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 4:51 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> We wouldn't be using fnmatch(), but I think it's a probably a good
> idea for the tests to support a mode where we have to declare
> explicitly whether something should also match under fnmatch or not,
> so we document the differences.

It was that way for a while (when wildmatch code was still "young")
then we removed fnmatch tests because system fnmatch was inconsistent
in some corner cases and because wildmatch code did not change much
anymore.

If we start turning it upside down, yes some sort of checks like that
may be a good idea (or at least until new code stablizes again).
--=20
Duy
