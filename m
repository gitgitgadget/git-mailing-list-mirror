Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B881F407
	for <e@80x24.org>; Tue, 12 Dec 2017 10:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbdLLKvH (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 05:51:07 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38161 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdLLKvC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 05:51:02 -0500
Received: by mail-wm0-f50.google.com with SMTP id 64so19380379wme.3
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 02:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4SZWT2VjsM1SQ7ilcv6yLnvnmCJZxKr0QSsK1uv9lYg=;
        b=mX/Ne5Jjn61WySWawrG5SyxigvcPSHYDfq324PZ1zymiYef2QPDCMHo++BN8dAU/kg
         FKeE8wqTn4F9SrfIgVWPJWbN/2xFaduuWDluYEPg+LEce47biP19zhNz+YhJbDQWbsRY
         Xr+EDxOOkpifMXIQSuG8b303ncrYtx2ULBRQy5sZvc4HkgAevG581bFtH6CSnZUlO5BH
         pauRB5vGwGCAYBT5zdjwib8lStywNmXECxJLGQx18Uf4oW6cjFeSa8gRb35k+duaaufw
         tsQjgecz8WB0LUj5PmlNljkVHK3FAoN8klBW76AiVXkZSwkURUf9QgZkxx+yIl0ctZ1D
         +buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4SZWT2VjsM1SQ7ilcv6yLnvnmCJZxKr0QSsK1uv9lYg=;
        b=TawMuNxr1qIswkvlVfAoZYRfkZputgm93SWiGIPV06+2v0VdyXKE/9FyYqLreE8/fo
         hqCu5Iyye3mM/DKwP4J5N9sI8TflJagB7ReViI0mkMW8OEJ11UPzc5kZBMrK4mY19KPr
         6w+iyBUDMVd9kF6F2A/YCmhce6Kf7KjE1KSZlr59JWOaQ+H4AnBcLOeXtHgI6GcTpDfL
         MOXXLCMFmk6y+I4WQ3cKY+7ZFitq1anzUgHOCtdpI/+xQZmiT6K019TavScolgMAYYJY
         McoFThu/VySrBQEM5Am/b1GNUhfMx3Q9w/xw4LSY0gEYG7j49rDN5DQhumQs0SwogcWD
         0Olg==
X-Gm-Message-State: AKGB3mIKyzKaBaR2CV+zcxcLDcyjrf2jr3b7U6pTC7oIq2c/IxOr4pZW
        lXYiCC0Wqe1+B2PGE0FHYv2sFOuTiD/a8pIOESk=
X-Google-Smtp-Source: ACJfBoum/mtvzeH7sS4ME3S4OmckUyirBaZiqC71hmBjQ44E42AkSg30Y95uqouN+Jfb1M7QT3rGH4UkjArc/kvNUHE=
X-Received: by 10.80.137.147 with SMTP id g19mr2270671edg.293.1513075860567;
 Tue, 12 Dec 2017 02:51:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Tue, 12 Dec 2017 02:50:40 -0800 (PST)
In-Reply-To: <006301d372df$e82cf410$b886dc30$@nexbridge.com>
References: <000801d3713a$2f1259d0$8d370d70$@nexbridge.com>
 <xmqqindc4zhp.fsf@gitster.mtv.corp.google.com> <006301d372df$e82cf410$b886dc30$@nexbridge.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 12 Dec 2017 02:50:40 -0800
Message-ID: <CA+P7+xq9RHmhKXU=m7iMxZxHWye8VRhUH6thTbPn-AY3nu4H5w@mail.gmail.com>
Subject: Re: [Proposed] Externalize man/html ref for quick-install-man and quick-install-html
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 4:26 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> Sorry about the response positioning...
>
> I can send you a pull request on github, if you want =F0=9F=98=89
>

You can use https://submitgit.herokuapp.com/ to submit to the mailing
list from a pull request.

Thanks,
Jake
