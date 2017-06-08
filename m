Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79191FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 12:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbdFHMwq (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 08:52:46 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33911 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdFHMwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 08:52:46 -0400
Received: by mail-wm0-f44.google.com with SMTP id d64so13996981wmf.1
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6Zx1yC8Fe8shWvP6/l1EBObPPupchJHcX4cd0svhbik=;
        b=j0MpBjcpWCkpyAiVko7Bi3zqIUhHnE5oXweuzZyK9IsDSkb2T3pD0355R8Vyp5vWeY
         uJ62yN/j6rZgo7B3KjHiwgqQYJJhUZybGdvDO61aHjnVxlMbzkAmu81gBnj08OjMdDjh
         rIT2reo6Ha1VsYD9TlhSKc1fGqr5PLMcotF+1KqzgdXT5IIEM4Fipk/ETGyog7t0L/b7
         MevJGfliU0pJE1jduAjtq0+UC9n/zUgQTzP9XLdvR41fWodP/HqF5A9llNKJNPwrPnUN
         yr2YUisj99gEE2sb9PTJPN3pgETEOcn2QM04NAPsdMSTN5PpSBzjsiilKyJzBNm0kMGY
         VGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6Zx1yC8Fe8shWvP6/l1EBObPPupchJHcX4cd0svhbik=;
        b=Q3qH3RmD+foqtuGCwhwA1wPepn1OTNbyQcUhgh7tYJlXexSkdZKCN6FwqK+TwC5c0u
         psBUclq7ipd+JF14xYTnjl/l4YyszKaM/WQCx26RTlGgcYavMT44pCGrefs2gjcjG6Ql
         33xbiUDmmihU2Yf4Po3ObuBMU49n0ZEb2SsqYUNI70U9l66Gi5n1hvP3OajLif3FE4pb
         cHACOhuBZpeGmO7prU77cVyUeYf2oxroDeie9AZzNKuOaW+rUJKH4rTY8V5YO9s1sehV
         YTQ2/IfOFECjP3kzgEz8ZzX02t88GfsucWwjWDZ117Ama3vmrf0yZMMAqLWzNepAekEp
         0T6Q==
X-Gm-Message-State: AODbwcDq5zTN5lwnHTuHVVzYbOQBI87YkgDk6dHLu/o411ua9Go1YOkd
        XNRKB9rV7YGZKg==
X-Received: by 10.28.175.147 with SMTP id y141mr1748536wme.111.1496926364522;
        Thu, 08 Jun 2017 05:52:44 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id v72sm9499685wrc.53.2017.06.08.05.52.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 05:52:43 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: There are too many unreachable loose objects
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170216225710.6nnbw65qoeb6lrw5@sigill.intra.peff.net>
Date:   Thu, 8 Jun 2017 14:52:42 +0200
Cc:     Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <987153C6-2F10-4229-8E59-B106604896DF@gmail.com>
References: <CAE1pOi3bpL0zTS9w2QCOrXcWk5pHj=xthxo2nYi8KEwJ=TgXfA@mail.gmail.com> <CA+P7+xqWoUBOoFSiOTT5U-9aoqESUMnZeSGfvhGte2LqF18gmw@mail.gmail.com> <20170216225710.6nnbw65qoeb6lrw5@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Feb 2017, at 23:57, Jeff King <peff@peff.net> wrote:
>=20
> On Thu, Feb 16, 2017 at 02:36:10PM -0800, Jacob Keller wrote:
>=20
>>> Whenever I run "git push --force(-with-lease)" I get a variation of
>>>=20
>>> Counting objects: 187, done.
>>> Delta compression using up to 12 threads.
>>> Compressing objects: 100% (126/126), done.
>>> Writing objects: 100% (187/187), 21.35 KiB | 0 bytes/s, done.
>>> Total 187 (delta 78), reused 71 (delta 20)
>>> warning: There are too many unreachable loose objects; run 'git =
prune'
>>> to remove them.
>>> To git@git.company.com:project.git
>>> + 51338ea...b0ebe39 my-branch -> my-branch (forced update)
>>>=20
>>> So I'll run "git prune" and, for good measure, "git gc" (which even
>>> includes "git prune"?). The first seems to do nothing, the latter =
does
>>> its thing.
>>>=20
>>=20
>> It may be that it's the server side that needs to git-prune, and not
>> your local side? I'm not really certain but you're doing a push which
>> talks to a remote server.
>=20
> Yes, certainly the position in the output implies that. These days you
> should see:
>=20
>  remote: warning: There are too many...
>=20
> to make it more clear. Perhaps the server is too old to have 860a2ebec
> (receive-pack: send auto-gc output over sideband 2, 2016-06-05).

Do you know if GHE 2.9.4 has this fix? (Is it OK to ask this here?)
Context: =
http://public-inbox.org/git/9C2F2EA2-0C59-4EA2-8C8E-10228FB82D90@gmail.com=
/

Thanks,
Lars=
