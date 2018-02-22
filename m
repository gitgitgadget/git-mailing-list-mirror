Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381701F576
	for <e@80x24.org>; Thu, 22 Feb 2018 07:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeBVHX4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 02:23:56 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:45131 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeBVHX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 02:23:56 -0500
Received: by mail-pf0-f171.google.com with SMTP id j24so1755552pff.12
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 23:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc:message-id:references
         :to;
        bh=v6HeWlnd+TR0vjSgQ37cBN5C8FiI6yLVdTaQaT2B1mY=;
        b=kyGG85NDrAiQ7k7Ke/nIKdj7lNzHV9G5rP9TtRsGJJAPGZj8JwXfOx1v7Oy1imSD7x
         INpUfGN/XN6ldbsQsfv/DCwRNSuz+23/mg/Ez3BXHbmnUbpcFYtNOKRIXscfenYUp2U3
         oYRiAGVI2weBhWAbqYelYfdSYegIs0Q3FY97Vofs8NZeUk/sCZn1iqv9M/UnKVD2ZbWC
         Rs8/ZpQ6ZzsLZadcWr4XDaYOaxK0HaXaphpOHUn50YlKt+BlbdZRjqk1QZwhqxJyVtkg
         sZIAOEP0DEFhrOC0Hs5ZnK8Z4ieaJvfArEtzQK0tWUJAOpbGyThFEIHstXw+mLJXJAM0
         lcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=v6HeWlnd+TR0vjSgQ37cBN5C8FiI6yLVdTaQaT2B1mY=;
        b=aM09JIj9cN+5M5t7TUxqxomUKifn0jRyBVC3ESDeSncQK0U2FtDCkUyHu59pxc34jj
         Sthd2rvDWskIAhAJ9dqESrmU/+vhbdlCoL2iAmYqXo9+qoRzE31kpcka3jy+n7KucZau
         dRNyCAjjyqrFaXFZK9NzarhNER4kTSg54iadCgCk8HnMFhL3ULK3+ovPZmlxaXVDjpH4
         muXgwwm/C7tHlWdpWhfhCIofUktIBsSl/6t+EP/ZKLWP1mpIqvYkBbdE8+CDm0Ah4RCQ
         FJ/lgbMJk9ek3sQzxNufk6pUsWPOM230ahnwbe/aQwkm7cvKz2yBGqaQC3JFFNtG0EZv
         azYQ==
X-Gm-Message-State: APf1xPBFGu9PyVEuxU4TWFOMVigMvnu2bJ9TnYi4JTxdujNYTCuMQ+9G
        ff2rN8aFoaQe84g6syxJcdY=
X-Google-Smtp-Source: AH8x225N8uvUNlHLPTJd8YwqdSKC+wl68dmdtDyxAG7komidg/kvrF3LmpaGSrL1TB/oIbTJgY3X+A==
X-Received: by 10.167.129.67 with SMTP id d3mr5959512pfn.108.1519284235559;
        Wed, 21 Feb 2018 23:23:55 -0800 (PST)
Received: from pants.nat.office.privatealpha.com ([198.47.44.221])
        by smtp.gmail.com with ESMTPSA id f74sm4446741pff.8.2018.02.21.23.23.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Feb 2018 23:23:54 -0800 (PST)
Content-Type: multipart/signed; boundary="Apple-Mail=_7A6F464F-D931-4A7C-9F6E-9092563BAC35"; protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: bug in HTTP protocol spec
From:   Dorian Taylor <dorian.taylor.lists@gmail.com>
In-Reply-To: <20180222053722.GB133592@aiede.svl.corp.google.com>
Date:   Wed, 21 Feb 2018 23:23:52 -0800
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Message-Id: <614A9A36-9DE3-4A85-BFA8-8380C4AC21B8@gmail.com>
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com> <20180221221516.GA7944@sigill.intra.peff.net> <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com> <20180222053722.GB133592@aiede.svl.corp.google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_7A6F464F-D931-4A7C-9F6E-9092563BAC35
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 21, 2018, at 9:37 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>=20
> Thanks for writing it.
>=20
> Do you mind if we forge your sign-off?  (See =
Documentation/SubmittingPatches
> item '(5) Certify your work' for details about what this means.)

Sure, or I can just re-paste:

Signed-off-by: Dorian Taylor <dorian.taylor.lists@gmail.com>

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

---

>=20
>> Note I am not sure what the story is behind that `version 1`
>> element, whether it's supposed to go before or after the null packet
>> or if there should be another null packet or what. Perhaps somebody
>> more fluent with the smart protocol can advise.
>=20
> I believe the 'version 1' goes after the flush-packet.

I took a traipse through the code and couldn=E2=80=99t determine it one =
way or another, but my money is on that looking something like =
`000aversion 1\n` on the wire.

--
Dorian Taylor
Make things. Make sense.
https://doriantaylor.com


--Apple-Mail=_7A6F464F-D931-4A7C-9F6E-9092563BAC35
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJajnAIAAoJEIqxSjt9ja+jwS4P/jKSGqnVe64i/KU5aYlBl5th
fuWpBvaV1y7R4mVkFxUVaRR4btLe3iDtPJFiCpw+AyUtGsqRWWOre5UMoZe51+LJ
+OH6M/qb/O9/vhT1JC5IFoh40EuwE0sNz4elS0ixJJuzpW7FN2mQcfYgT/OR0BPP
4FmU8ap1HJjipxatPkY7cvjOr2U84s2hGRC0YaoUfmc3IgoQ7ncN1aMqEUB3Rhk6
d/ZQATB0iE4srycbDKWWU5FmKan7b+eVhIbQJPV/6EaYDKZEJBbXNmUZ0sQNn7L0
IbgqAX+Skwy10UMAvg0sHEbdDKH/2ILqWIh1ljQacHwFU9+4P4SMbhGWljE3zcsj
3rfj5EY3099WbHp/I//QZBKuRRJBGKGGsM/91iVb/pi3PCJz/uuU808V4MMgcL39
Trilmos0S5RqDH97dNJfeDwbcMkaP10f3hs39AAjmN9JwRzRC9xDrLCb/0uaxkHu
vW+qMnQCfMge/av/U4IdOkH+DY2SC+lM0m/PI332fvTznAXhAIzzp7EBIs4szphO
pthkyQXiqv37UuzxRBjEif3JDEboVVWBfSlf5rFLrNLIZfthMCjXhos54CxT1b6L
USeclie0r1NEAizzqFfXZMivknGDqJRjeKiu/STy11JGJ19Yij4vRIznCZdT3jWX
JlfV2CNvjeHg+A023a2p
=it1L
-----END PGP SIGNATURE-----

--Apple-Mail=_7A6F464F-D931-4A7C-9F6E-9092563BAC35--
