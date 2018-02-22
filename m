Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4821F404
	for <e@80x24.org>; Thu, 22 Feb 2018 16:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933119AbeBVQQm (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 11:16:42 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36425 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933096AbeBVQQl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 11:16:41 -0500
Received: by mail-pg0-f54.google.com with SMTP id j9so2178799pgv.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc:message-id:references
         :to;
        bh=JIeAZTLUYFAPD/c3fRWFv5cH95NAcpMrhsu8C/Lr6z8=;
        b=SIqgTYshmOzUZAbVvxKuAhVzZa2tQMuflGvMNFO6cFhmDFfw2TU5wjTDPH6UuPUOQU
         Ve7WCJVwsTSLbHi54bRdFMSdgq8R4jd1nxkKTe48YZgh7HMcQjPB6J09BDQA4XcNnrsJ
         ccT06WCD11TgrLxF9lFOTKbu6dJt3J3ii56u4iE/MZDx/n7xgQQ5ALyMqpBdi+J3fOMQ
         JGSyqXIoTEHrk8JkMTxIVUQD0d3fSM1knmwDLdrprU79JtmhsMCL/QAkL4isOVaghp2W
         PaQl39imXmhJrKnHjXUPy+9oaC5FEdLlR1Sl0WJbnrmalf/6J6xHJtDFVS5ykwVHFwHU
         LuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=JIeAZTLUYFAPD/c3fRWFv5cH95NAcpMrhsu8C/Lr6z8=;
        b=F4A+uhkNMRyWIOZ9eLTFUL0P7efeXY2TvdxRHKjF15IQADGwFlDjMOLyyjNs8hRVyz
         ncHs8+dnfwgAS0yYPrEDmXv4CP6ICKp0/9NLqzG2ySIWn3v9elQsf3eOATTWe462aN8v
         Jljmn1KS3UUWAd0lHAHcPSCoYt2paCcsMc70yfTJSzugUl7Pe6KuRuPVe8/6BVyE946x
         ZP3bjAe/9Y7mi/s8rQ9seLq1S7wuEQUjbhhDw8OHA0+Cu7PoVXnRsMGyUuZPzO0NOfmJ
         5LyKwAE0deqr6g2A70eUzXdc7Jar8qVPfQLHdtnae2rtLgDY28ZWOUBbWFSlofqpvsPW
         3lcg==
X-Gm-Message-State: APf1xPA6twqtHgkhVQBAO27S0dEHAVs96IETreqHrCJNp9q6TFWy9ySL
        chpNKga1csocvduXrkTSL4IuXl5v
X-Google-Smtp-Source: AH8x226Nz6s2K3xHmMFhLwZsPOczPgT/Zbu2C2yC8B4kdGMq03cN8nSxB/kXrpXJvdyASpaREtMRZg==
X-Received: by 10.99.4.197 with SMTP id 188mr5917023pge.359.1519316201130;
        Thu, 22 Feb 2018 08:16:41 -0800 (PST)
Received: from pants.nat.office.privatealpha.com ([198.47.44.221])
        by smtp.gmail.com with ESMTPSA id b84sm789747pfj.11.2018.02.22.08.16.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Feb 2018 08:16:39 -0800 (PST)
Content-Type: multipart/signed; boundary="Apple-Mail=_2B1031BB-C4E1-4F82-A08A-16EE904797F2"; protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: bug in HTTP protocol spec
From:   Dorian Taylor <dorian.taylor.lists@gmail.com>
In-Reply-To: <20180222100840.GD12442@sigill.intra.peff.net>
Date:   Thu, 22 Feb 2018 08:16:36 -0800
Cc:     git@vger.kernel.org
Message-Id: <10FB4001-44CD-43BC-BCFF-D6ACB7A68878@gmail.com>
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com> <20180221221516.GA7944@sigill.intra.peff.net> <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com> <20180222053722.GB133592@aiede.svl.corp.google.com> <614A9A36-9DE3-4A85-BFA8-8380C4AC21B8@gmail.com> <20180222100840.GD12442@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_2B1031BB-C4E1-4F82-A08A-16EE904797F2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Feb 22, 2018, at 2:08 AM, Jeff King <peff@peff.net> wrote:
>=20
>=20
> This indentation is funny. But I suspect it is because your whole =
patch
> seems to have been whitespace-damaged (see the section on gmail in
> "git help git-format-patch").

That is, bit-for-bit, what came out of that submitGit thing that is =
advertised when you try to open a pull request on the git repository on =
Github. I was a bit surprised myself.

--
Dorian Taylor
Make things. Make sense.
https://doriantaylor.com


--Apple-Mail=_2B1031BB-C4E1-4F82-A08A-16EE904797F2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJajuzlAAoJEIqxSjt9ja+jqEQP+wbZIytxLcTdTOZLKB3ClKJX
v5qT3B4WIdZraoNgPEafHUFq+2uzwr1DfEDWNXFDt/SQkiiOyqsi3O4h2TmmbHfK
WNrK9S3gQHlIa5v0kpYWu4ClTxf29h4Bsq5Xb9DvyLLRWW4bRwYmydK0kFZYRkjZ
ylKZm+BmRHcrZZoCgXeI646tRpGYbjxJavpZRzH4qM5wlB5aXPETFTW3xbUUH//P
J62zVPVMxgUe5zmolh5FzhgWZUM4KzK7nAV/pghm2ptMEiEaLu1w15+R1uwJcZB9
JdV08tLwmkcsN0CJXrnjz4nM5N/h+cr9zxDz4gJYbBixqI5CtCmHmjHXkdf9N5u8
lutm760MnhZdeNlTFI/tOQcCdMp/VlvAaufdJJcb0sGNWOWYYJCCsTO9SGeHIHAq
y53jV/uS7KZxj/vL9/hw8PIo5cR5KSY1WpGoJx8lPLfU6xAY2YHZ4dbjopuLX9hb
S0MUOrS04ydMr6IHuqXYLLJO6fZf2yx9CkW4b+OduWKImk98aSrKyo1ZDdv3zd6d
fWlb88Av0+qbWkcoTb/klcyBmmC03lp0JIue+ih6jkTm8gvnJSMKreAPY8VJWpK0
VaT9687vu/GIb8XrsRohPdR+9NGZn0F3losPTB7iuRGQGVdwUhcNrFmVsKbC5GLn
k0ZhRED70AyGrfR9lAdy
=qbIO
-----END PGP SIGNATURE-----

--Apple-Mail=_2B1031BB-C4E1-4F82-A08A-16EE904797F2--
