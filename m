Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E0A1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 04:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeCTE2F (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 00:28:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35312 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeCTE2E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 00:28:04 -0400
Received: by mail-oi0-f68.google.com with SMTP id x20-v6so11150oie.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 21:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QN3ABdMPD/AKpqzT/Y3dun4foxWIoGNncIcOJchir9Q=;
        b=G42kq95BWqEekCZuIJ/awhLHZ81Kq8o1GKM93Wpj9QJ6n+apbQIw+Snr2XkddrZoTR
         GtMHdGD/WRE1BJawInwyyrg+zogP3+ox0EBU/hKNZwDus8upp7FQz/1T7lOE/MR9c/I/
         V9SuKkh3ZUSum0atfNobey7w2lfQbvFHKbmfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QN3ABdMPD/AKpqzT/Y3dun4foxWIoGNncIcOJchir9Q=;
        b=t/IiZjMLkMOI4/3d8RefV2nn7sC86wRjIyczHJ9T34X1PH4RBPmfjowFCTNSEc4Rpp
         s1wwAboReoDVTeouGkfXZB85iABrJ9TxXFiZd0Z6T4GauuRr1v3gILiIaUzdIE36uoxZ
         nROqH56w7cZX7W0jYU2lShZ1wOoWhgbScq9YbxCSjSLkbX3/lLFqFZk4L+NqsQDx26nh
         X5UAgB29Ctd1reoQ9g5ecu80D4gHArlee93PxP1qCXxKaGwqg96TDThDZn2Tp5dWlXdn
         NNIBFbRuV3UD8+AGmhBMMQ/BJ7SWry+uSC+ehFcArbTNcyjYSvmT3gz7OR8T3sZ9OkZp
         9D9Q==
X-Gm-Message-State: AElRT7EP0V9fjq1SyRPAMhwyHHGOJUURXHqKOyEC/ntA4jPjnZ+c7faw
        5qauWkNzU0cC1d77ZJGRYYoyOdAtQfovGPBf7zZFIg==
X-Google-Smtp-Source: AG47ELuDKLA5vY6i0uYuJn/8VuoTJ3PmFZW1Jzm4JC8ttXIQ1/nOvZX7U/6GorGkE6xSe23EIVo437T+33itV6tt0VA=
X-Received: by 10.202.11.1 with SMTP id 1mr5800267oil.157.1521520084271; Mon,
 19 Mar 2018 21:28:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Mon, 19 Mar 2018 21:28:03
 -0700 (PDT)
In-Reply-To: <20180320041454.GA15213@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net> <20180320041454.GA15213@sigill.intra.peff.net>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Tue, 20 Mar 2018 00:28:03 -0400
Message-ID: <CAHnyXxSOvU9aokdyo_UBcHPLeCSogyFCRjxXi9NkrmQbT0Qtig@mail.gmail.com>
Subject: Re: [PATCH] doc/gitattributes: mention non-recursive behavior
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That's perfect, thank you so much!

On Tue, Mar 20, 2018 at 12:14 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 20, 2018 at 12:04:11AM -0400, Jeff King wrote:
>
>> > I guess my takeaway is that it would be _good_ if the gitattributes
>> > documentation contained the caveat about not matching directories
>> > recursively, but _great_ if gitattributes and gitignore (and whatever
>> > else there is) were consistent.
>>
>> I agree it would be nice if they were consistent (and pathspecs, too).
>> But unfortunately at this point there's a maze of backwards
>> compatibility to deal with.
>
> So let's not forget to do the easy half there. Here's a patch.
>
> -- >8 --
> Subject: [PATCH] doc/gitattributes: mention non-recursive behavior
>
> The gitattributes documentation claims that the pattern
> rules are largely the same as for gitignore. However, the
> rules for recursion are different.
>
> In an ideal world, we would make them the same (if for
> nothing else than consistency and simplicity), but that
> would create backwards compatibility issues. For some
> discussion, see this thread:
>
>   https://public-inbox.org/git/slrnkldd3g.1l4.jan@majutsushi.net/
>
> But let's at least document the differences instead of
> actively misleading the user by claiming that they're the
> same.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/gitattributes.txt | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index d52b254a22..1094fe2b5b 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -56,9 +56,16 @@ Unspecified::
>
>  When more than one pattern matches the path, a later line
>  overrides an earlier line.  This overriding is done per
> -attribute.  The rules how the pattern matches paths are the
> -same as in `.gitignore` files; see linkgit:gitignore[5].
> -Unlike `.gitignore`, negative patterns are forbidden.
> +attribute.
> +
> +The rules by which the pattern matches paths are the same as in
> +`.gitignore` files (see linkgit:gitignore[5]), with a few exceptions:
> +
> +  - negative patterns are forbidden
> +
> +  - patterns that match a directory do not recursively match paths
> +    inside that directory (so using the trailing-slash `path/` syntax is
> +    pointless in an attributes file; use `path/**` instead)
>
>  When deciding what attributes are assigned to a path, Git
>  consults `$GIT_DIR/info/attributes` file (which has the highest
> --
> 2.17.0.rc0.402.ged0b3fd1ee
>
