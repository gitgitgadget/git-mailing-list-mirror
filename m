Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D749D2013E
	for <e@80x24.org>; Sun,  5 Mar 2017 17:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbdCERpM (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 12:45:12 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36358 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdCERpK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 12:45:10 -0500
Received: by mail-wm0-f65.google.com with SMTP id v190so10397018wme.3
        for <git@vger.kernel.org>; Sun, 05 Mar 2017 09:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7HyWNljVypWwvRvJ9oVVOI8ryky9Xyb2GE8GBA3Kw0Y=;
        b=mrfEQCZ402fkChtYkNwhmwK7sF+eZl462NR8HhPi54LiNOBBhpIHXLxkLtWaAanUSJ
         3B/J/NN43VO0AyClj78WjqCrVjOlM8UBwaE4JCX1QPCz6tgIHbmUhC3QxUN3ECA93s2T
         B9b3E6ZPqkglgCDh3U4VkjPBhM3+hNIpDnlXx0a5Mpdl44wYV0dr5/Yf/1E8LtMJ6Yg5
         p+fbPjmDEppswRjKBh6G0L+KnKUmuo07zz1tiJLMmoTThdRCOkIAHaP5i0neC/tJOhh3
         jZxxB1ObIvD5UT2zLEnw8D9yOEq6oNXTOqd6ZgClEcDihWXtkCS5l9U6Pv7SmWeDzX7m
         EZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7HyWNljVypWwvRvJ9oVVOI8ryky9Xyb2GE8GBA3Kw0Y=;
        b=KM+rMXQ/Lnr+3/3WdlyhDmbcXH6rsZmu/PcABX6RI66+GVdWLC1lZq1yh0g6mEk2+v
         /Gcqf8Kdwtk0tZcessV6px/FKKOp2lqg/rHpm7JbMuylkHwELZqzZeFX9yuwU6MAonUA
         BrpeDNHXoDe7cpar9JSqdcoBBSLpU2jEAWv3AfGc65ZMtMxbCySKhTrgaFCb+gexTS00
         zRArTfgvPTKjk/9EOVMNYOzs2nmJa9H3VrNWwAo6EICTkA6YIj5sJGVJ+NxAovM5PRmG
         nAt3p5sxpJjBftFnsHgS69NhY27DZcxbwOFDdcCYzwg0sq0al1rVqpcK+oVbj8AuuujX
         VjZw==
X-Gm-Message-State: AMke39lV/kNBt07Q48oGZJE65HhglMzUwi/eUb7skgZygUAnXInn/vNrd+uh9NJua3Hjog==
X-Received: by 10.28.136.68 with SMTP id k65mr10982782wmd.48.1488735519133;
        Sun, 05 Mar 2017 09:38:39 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB65AD.dip0.t-ipconnect.de. [93.219.101.173])
        by smtp.gmail.com with ESMTPSA id x133sm11611548wme.22.2017.03.05.09.38.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Mar 2017 09:38:38 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <4a27f62d-5576-df9d-257f-60ff327547e6@ramsayjones.plus.com>
Date:   Sun, 5 Mar 2017 18:38:37 +0100
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <125BAC7C-0FCF-4E0E-9757-2BFACD1910C5@gmail.com>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de> <20170302105157.59791-1-larsxschneider@gmail.com> <alpine.DEB.2.20.1703021210170.3767@virtualbox> <4a27f62d-5576-df9d-257f-60ff327547e6@ramsayjones.plus.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 02 Mar 2017, at 16:17, Ramsay Jones <ramsay@ramsayjones.plus.com> =
wrote:
>=20
>=20
>=20
> On 02/03/17 11:24, Johannes Schindelin wrote:
>> Hi Lars,
>>=20
>> On Thu, 2 Mar 2017, Lars Schneider wrote:
>>=20
> [snip]
>>> One thing that still bugs me: In the Linux32 environment prove adds =
the
>>> CPU times to every test run: ( 0.02 usr  0.00 sys +  0.00 cusr  0.00
>>> csys ...  Has anyone an idea why that happens and how we can disable =
it?
>>=20
>> I have no idea.
>=20
> I have no idea either, but it is not unique to this 32bit Linux, but
> rather the version of prove. For example, I am seeing this on Linux
> Mint 18.1 (64bit _and_ 32bit), whereas Linux Mint 17.x did not do
> this. (They used different Ubuntu LTS releases).
>=20
> [Mint 18.1 'prove --version' says: TAP::Harness v3.35 and Perl =
v5.22.1]

I think I found it. It was introduced in TAP::Harness v3.34:
=
https://github.com/Perl-Toolchain-Gang/Test-Harness/commit/66cbf6355928b48=
28db517a99f1099b7fed35e90

... and it is enabled with the "--timer" switch.

- Lars=
