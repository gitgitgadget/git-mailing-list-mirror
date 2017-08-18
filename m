Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D825208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 17:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbdHRRG3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 13:06:29 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36821 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdHRRG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 13:06:28 -0400
Received: by mail-wm0-f49.google.com with SMTP id t201so4495678wmt.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=W0nDBoguhwKN41mdChBltYgcKdxFY6TwCjPgHEDcvfE=;
        b=QIhEC21vEmOmLQ2YWyYadrlIsq57zWZxvQRxkUyy9KcmaHXlwOzHPdBGW0zRe3JK5X
         b3+YZ3VjkFPP8VHvC4AgTncsSGI/jXwenha8ijKFlmKL51WetlisJ9FP605/ZQwX9rcK
         X7MwhaWgF5Q45io2KZKCSLTawKE4AnVzcnMcRJvDaAr9sE/DzLpQqxE0o1zePeSqrZTL
         5HvB8b8dnWsAabbYZlfrhQNSaikqVIcRazCglee70L5o/iqH7MrKmdQkpXXXQ22Wyzx+
         LsDox/zgsgR0H7PYH8EH42frdPtMAO6CjmJYNh1wesGbyaMFxB56B4vk0qM0SyPHMpUP
         SKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=W0nDBoguhwKN41mdChBltYgcKdxFY6TwCjPgHEDcvfE=;
        b=aQw7gwUFykyWmjtGbm60tjeyPUbibNN3LigoUQQMZLaV2qGesILh56e5KQ6ZUBKwjR
         bL9cp9lEjL4Lz+bCkIUrxHOZkjlihUcWlnQ3jciVpyc8jX1C8YpLfOLn1giErgIst5pU
         1Cz+Yx2m6rKQKdX8xf8YdBcvqQEj1u9f7lZ9tn1f4cLC1f50qwaLo50OfCXRCHjqBhVr
         LGhNqTvKM2z2S2Xteuk1ODW41x9imt9JtSs8iH9cCLXvNAEVksuYLfC2f2of8Ysa/EZJ
         tMmfnkOKIcGcWpcnYq6Parp2W3z4TYBgcCtPtiyx+M6nLs1tnAhV6YOWlFWxKEjHNoQX
         hMRw==
X-Gm-Message-State: AHYfb5h4QVBcKJc9aKXpTJKiJgwJw4i7CfTQT+p4YHdZfrBJ9FrGyOuT
        y9cTUmPmriM8DGlpYPZ3NfYwt1I1iRQW
X-Received: by 10.28.46.197 with SMTP id u188mr1783539wmu.26.1503075987107;
 Fri, 18 Aug 2017 10:06:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Fri, 18 Aug 2017 10:05:56 -0700 (PDT)
In-Reply-To: <xmqqd17sddvz.fsf@gitster.mtv.corp.google.com>
References: <cover.1503020338.git.patryk.obara@gmail.com> <cb98970b3f6c175321f52efb65deb48f9cfeabae.1503020338.git.patryk.obara@gmail.com>
 <20170818064335.h5sr5iz7mh64axji@sigill.intra.peff.net> <xmqqziaxcobp.fsf@gitster.mtv.corp.google.com>
 <CAJfL8+SHSAhgrMY6ONVHLMWEHcT0mhm4oKMmq6D=89SErDKiMA@mail.gmail.com> <xmqqd17sddvz.fsf@gitster.mtv.corp.google.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Fri, 18 Aug 2017 19:05:56 +0200
X-Google-Sender-Auth: aoTaY96kFQ7_0u3vyE0-tK85svk
Message-ID: <CAJfL8+Tkb1KOn6bTGd8QPwr3=GgxKNZbp9OD_RmNeN4w-Os-iw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] commit: rewrite read_graft_line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah! I presumed two separate loops, one throwing away oids and second
one actually filling a table - this makes more sense. I was just about
to send v4, but will rewrite the last patch and we'll see how it looks
like.
--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
