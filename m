Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E3341F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeBUXuS (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:50:18 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:33904 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeBUXuR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:50:17 -0500
Received: by mail-pl0-f43.google.com with SMTP id u13so1869744plq.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 15:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W7fPEyLCTWXUn26O2thtcZO6B4tzT7Ka1753ZtvTjAU=;
        b=N5ofsBqACMhGvUpthjOm7crPl+xfYIQ71ti8tSXZY7YewEu3oK/RsLK/edJ62b/obu
         evI61X8iH69o8hfElOLkbSMP4g72yERt/olNeklGYpJhY47HiUCh0cnt29b8RgkYQh1f
         4K4INvAhiewEQWi8zjYHF4w5cdXhqFbR2MPTueyjqxFsY7jALtjekP3v85pLoEjWHfVu
         znF8nzQ4de7l1BWiWsabn7G1udG+hOIw66TMHSV0znrUj4FedaF2pTH61FjaxNDY4Wz2
         uPePueTOGSin+MNvpictRtr9JcK1L4zMsVlZZrmfopPuHGdqxlKCGjkskX4gv8gT0Y+D
         PDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W7fPEyLCTWXUn26O2thtcZO6B4tzT7Ka1753ZtvTjAU=;
        b=aXx7LitVHkQxyJGzpSsnAHjc380FJJG6dVGFdtocT6O/3bpgciBQOTCOJaNwGHULYr
         F30YqRLplZfHvIwbmJ+EAgbGHghErEwtjLmFOLJDNH6p85gwNQdn5dkI8C1aejTCcrZS
         rMaEtyihpzdUgJifcD2VxemciGDsxw2URM26Cz/7WHg2ZpJFXxW3kuZKtj6dzWPcERec
         rWTlSt2xyY++2LJWD2C1UDqRl9jtFZMtSsAnL/4QYrpp+PsPa/AbckS5+yt+mq9env5b
         cbLR1CxSsZqNTVDm1E3QXl0UJbFEZWR2pppsm9bfAE74nBaeOfrbt6bLp4cVGYzJF3Ax
         PG4A==
X-Gm-Message-State: APf1xPCk8JoA4IdU1dBgIM1uEVvezQY04k13Ue3JDW+qkY6Z/JT0DUdY
        P3S20EmnLP+7++fVyg5U9Nc=
X-Google-Smtp-Source: AH8x225Qu+TPMUqexFbni0ZhfixWFsX9VH9Eq+W8EgLydqdg8HOKFY7Co9nCTN/oY3wf1WyuwyOaJA==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8-v6mr4692382plb.197.1519257016750;
        Wed, 21 Feb 2018 15:50:16 -0800 (PST)
Received: from pants.nat.office.privatealpha.com ([198.47.44.221])
        by smtp.gmail.com with ESMTPSA id l9sm81491180pfj.167.2018.02.21.15.50.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Feb 2018 15:50:16 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: bug in HTTP protocol spec
From:   Dorian Taylor <dorian.taylor.lists@gmail.com>
In-Reply-To: <20180221221516.GA7944@sigill.intra.peff.net>
Date:   Wed, 21 Feb 2018 15:50:15 -0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com>
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com> <20180221221516.GA7944@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Feb 21, 2018, at 2:15 PM, Jeff King <peff@peff.net> wrote:
>=20
> Thanks, I agree the document is buggy. Do you want to submit a patch?

Will this do?

Note I am not sure what the story is behind that `version 1` element, =
whether it's supposed to go before or after the null packet or if there =
should be another null packet or what. Perhaps somebody more fluent with =
the smart protocol can advise.

---
Documentation/technical/http-protocol.txt | 10 +++++++---
1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt =
b/Documentation/technical/http-protocol.txt
index a0e45f2889e6e..19d73f7efb338 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -214,14 +214,17 @@ smart server reply:
   S: Cache-Control: no-cache
   S:
   S: 001e# service=3Dgit-upload-pack\n
+   S: 0000
   S: 004895dcfa3633004da0049d3d0fa03f80589cbcaf31 =
refs/heads/maint\0multi_ack\n
   S: 0042d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master\n
   S: 003c2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0\n
   S: 003fa3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}\n
+   S: 0000

The client may send Extra Parameters (see
Documentation/technical/pack-protocol.txt) as a colon-separated string
-in the Git-Protocol HTTP header.
+in the Git-Protocol HTTP header. Note as well that there is *no* =
newline
+after the `0000`.

Dumb Server Response
^^^^^^^^^^^^^^^^^^^^
@@ -264,8 +267,8 @@ Servers MUST set $servicename to be the request =
parameter value.
Servers SHOULD include an LF at the end of this line.
Clients MUST ignore an LF at the end of the line.

-Servers MUST terminate the response with the magic `0000` end
-pkt-line marker.
+Servers MUST follow the first pkt-line, as well as terminate the
+response, with the magic `0000` end pkt-line marker.

The returned response is a pkt-line stream describing each ref and
its known value.  The stream SHOULD be sorted by name according to
@@ -278,6 +281,7 @@ Extra Parameter.

  smart_reply     =3D  PKT-LINE("# service=3D$servicename" LF)
		     *1("version 1")
+		     "0000"
		     ref_list
		     "0000"
  ref_list        =3D  empty_list / non_empty_list

--
Dorian Taylor
Make things. Make sense.
https://doriantaylor.com

