Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2460420356
	for <e@80x24.org>; Tue, 18 Jul 2017 17:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbdGRRzP (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 13:55:15 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36378 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbdGRRzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 13:55:01 -0400
Received: by mail-qt0-f178.google.com with SMTP id 21so22225822qtx.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FSteY05CTZFrKQqwKEEUgqnQJ1JTd+luHXV1uCa9C2w=;
        b=C49w/O0p5YmMrAz9znfwp6cCOVCkG6jIMOf8rogrswUZMGEdRXVPJxVC5hOjk3v/EK
         XW7O885t/UTio0hGK7DJW7T2Eoa9HcpjbP9ZFSrTz0R2f8eI0dsRi9M9agGmhBgQPt/J
         5Bhc7AiXMWo3NC5tbzTT88yVL0vMFZgMGE+bdoIpU9FlDFvhLpcI9fnW20ubD3/I4vTo
         iA8Gg+37aqMY/oR6WCEYBUH3ZJFwL6lKcYaT6Qgd/qwXurFlF5IXFBKQmeIqHdu/1tql
         ZO0P3nCrZlTiVDcHMmeu867mbtP4YHzuEezuxUaNavd7s0d49TEDphspywnRwKk3EKac
         a/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSteY05CTZFrKQqwKEEUgqnQJ1JTd+luHXV1uCa9C2w=;
        b=PlPE3sbwx/1XQCfcHZh2HtUW8su1jrAApIHsFMRESB2+asWGbKY3kuFPYy2HCTEysM
         AP3kau/oEooi4H3db1eP4PNxjn7cZH2kkQVoczOP+wL2jXoxEKioIbdQSawpF4o+J6jy
         j4EX5xRLiF8eR22AYEMEMdDJ/IGpg+sfQMJzmO+f9p9OxuVLitfIcdI989w5DhVk0zjY
         MjhvGrnwOqDPIAJrdgfJbz6qX6eTc+uPdDO8eGvybKIb6sDR4Olb+kf8/bsiS3Dm7exW
         rSrdTtWdS97e6q5EBfwKxHH+U0M/Jzlh2UwxrpQR/qXDF+d+9Nkqmw2VANYRjQL3+vGE
         cYQA==
X-Gm-Message-State: AIVw1109KBqXYln82+1M97RorV9WkF1BtDtcs+eNQqTzbXwohvDSZHe0
        o6kdpr8RwF08aPhP
X-Received: by 10.200.48.237 with SMTP id w42mr3821977qta.54.1500400500497;
        Tue, 18 Jul 2017 10:55:00 -0700 (PDT)
Received: from LykOS.localdomain (ENG-KCG295-01.ENGINEERING.NYU.EDU. [216.165.113.136])
        by smtp.gmail.com with ESMTPSA id h34sm2257395qth.0.2017.07.18.10.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jul 2017 10:54:59 -0700 (PDT)
Date:   Tue, 18 Jul 2017 13:54:59 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
Message-ID: <20170718175458.hadk64c3yccyv57t@LykOS.localdomain>
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
 <20170714002754.jyck5qmykbmuado7@LykOS.localdomain>
 <xmqqfudzsq7u.fsf@gitster.mtv.corp.google.com>
 <20170714140241.mqg5256ml3grmrn6@LykOS.localdomain>
 <xmqqwp7bqbvg.fsf@gitster.mtv.corp.google.com>
 <20170717214241.yui75hywg2ddkfsb@LykOS.localdomain>
 <xmqqmv82g1g7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wejrk4ept7djpuzl"
Content-Disposition: inline
In-Reply-To: <xmqqmv82g1g7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wejrk4ept7djpuzl
Content-Type: multipart/mixed; boundary="ponppa6e32xeon4o"
Content-Disposition: inline


--ponppa6e32xeon4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 03:09:44PM -0700, Junio C Hamano wrote:
> I am not sure if it is merely "if it's even necessary"; if there are
> two tests running in parallel, with their own separate
> $TRASH_DIRECTORY, and one of them say "kill the agent" at the
> beginning, would it affect the other test, depending on the timing?

This shouldn't happen, provided their respective GNUPGHOME env vars
aren't the same. A gpg-agent process is spawned per GNUPGHOME on the
versions that I've tested.

>=20
> I would imagine that the sockets are kept per GNUPGHOME and they are
> not going to interfere, so if that is the case, I do not think we
> mind helping folks with a buggy versions of GnuPG by having a "let's
> be cautious and kill a leftover agent before starting to test"
> patch, as long as the reason why we do so is clearly understood and
> documented.

I double checked the patch/solutions/causes just to be sure I'm not
doing anything crazy. Here's a v2 of the patch that kills the agent upon
cleanup rather than startup.

Thanks!
-Santiago.

--ponppa6e32xeon4o
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-t-test-lib-flush-gpg-agent-on-cleanup.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 20491890b804d13f9edb0205c1cc21d080beffe2 Mon Sep 17 00:00:00 2001
=46rom: Santiago Torres <santiago@nyu.edu>
Date: Tue, 18 Jul 2017 13:16:11 -0400
Subject: [RFC/PATCH] t: test-lib: flush gpg agent on cleanup

When running gpg-relevant tests, a gpg-daemon is spawned for each
GNUPGHOME used. This daemon may stay running after the testand cache ile
descriptors for the trash directories, even after the trash directory is
removed. This leads to ENOENT errors when attempting to create files if
tests are run multiple times.

Add a cleanup script to force flushing the gpg-agent when before
removing the trash directory if the test is GPG-relevant.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/test-lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b6e53f78..ed8796d7a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -732,6 +732,11 @@ test_done () {
 		EOF
 	fi
=20
+	if test_have_prereq GPG
+	then
+		GNUPGHOME=3D"$TRASH_DIRECTORY/gpghome" gpgconf --kill all
+	fi
+
 	if test "$test_fixed" !=3D 0
 	then
 		say_color error "# $test_fixed known breakage(s) vanished; please update=
 test(s)"
--=20
2.13.3


--ponppa6e32xeon4o--

--wejrk4ept7djpuzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlluS20ACgkQRo8SLOgW
IpUJGxAAuNhFrfT6GV4nzJK23EyzgTy9NiWa9e0VAN0XSxRhy5wz3p+/bYfY8sB9
xH/D+rLmcH5CyCmjIo75OE8os8b9aUlnYiXkoyE2jm/26X3KKGlUpWeoKRoPG8S3
x1T9HaYh6r1aLc5nvlUzqR62r6U7sES+PhVUJadZVB07R1Lc5kqRdps5LYmJKas3
v2prSGcikD3eytXR3Jd8K49IeDH6CWC7gKqvN06qrzQU1hK7PDFpoJht9jP9B4gi
U0IA9RQqdenkcXt81T3gtgcp7N6Zs//HTi9cjeN15VdnjFlexVr5y1OhaliJZm0I
5TkTuPFJfAGoOKp+1ykLGux+XuoHTN+uykCHNzgbiQwQf2eQNDJE4Z44fYv7C/gI
mgIj/7Fkq4G+BpSO0xb8rhxmYrog4yBjHTa5zrlE5g17mN3ZBwYO/KJW9DbrYk53
i7S62VTTcenDGZmHsHSoBMhiCuQrrdqP5CX1YvQfnzmHZPk82CpDzOIFdWvMNcNE
JbtqtU1CjmbOYu6LYhO5OT+BkNNk1uUHcVxgYnJsH1/CRYNqseFYjH1E+WRT24Ob
R6IyboHIkMrhRoYAqyqjFA3d7C+1d0F/xRHMERBp8Es4ltypwlWmJ+k57Ez0n9T9
I7jm806RameviCBqiUQ1rP4512t33Vt8hNm8uiABmEEGWy1lu5U=
=Nhjn
-----END PGP SIGNATURE-----

--wejrk4ept7djpuzl--
