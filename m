Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270B320373
	for <e@80x24.org>; Mon, 13 Mar 2017 23:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbdCMXIQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 19:08:16 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37246 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdCMXIP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 19:08:15 -0400
Received: by mail-wm0-f53.google.com with SMTP id n11so51528102wma.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 16:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dkderj/KoZsgPW3edSngDCGOoTc/GPPKdBbnp2RS4pU=;
        b=vNkNMwnOFJV4VIgqnwUjt0EkIOHhPyKGBjbTPgMyp/T5UUcQpVueQy2RXNCDOXj2Oe
         brIParxS0SzuMELoofKu26qLU+NKFZ3s6WyEObNk7n3fsRux/6B+lndmZO6WBbaX3ZY7
         lvMkSoXZi9YptlPDii7DZM61l/helxaHDAFtAxJfSqc3P9y+DOmYKDfhy7zdmsNkvq32
         7xQejwJQpXRjmq3i6rdCYvRI8zlk5Vg9b7Ug1O/mKAv3L2Nr/nbL2zaVxH+VYQ6S0g4f
         e/ceRrqPfVI7ZlbMzpCvVlaveo0OXPlcUl5yMW8j4vhuMtSkRMtC3fBqJeESyiBgOaMg
         vyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dkderj/KoZsgPW3edSngDCGOoTc/GPPKdBbnp2RS4pU=;
        b=Pm3NtZYI5WvnBTlIFG9kqJZn8O0Cm+2qP6zD/2PKU7v2jDfvqaAowAoIj+OFTbTWEK
         s8oWzmYjPVcSLwUGsR+tilyzC3JrThkiiIbDQ1e2kpRVa6ZuWwRTcOPv4EnhXJ9rheX5
         FSQUv6O/cwI02GgT+QkPquphn2LPay9riHgjLOKeyCaQkQkX5fvLyHSSUcCxHs9XoXGP
         qhnpxAw+LCa/6ddhVnKxADKZabuDq37bi/uYPrHrTAuGVEuBxys/bAm+7lXmS440e9aJ
         3BIaynfGkrzNR7Pl1YUCvn+898VK0HIoJ1cQi7W+kY41W8aE7/I07Bwdl45B8cFg2nOF
         DYyw==
X-Gm-Message-State: AFeK/H0s2fsoJFrX6cTPSqgtnfikar333q773TJUEJKnZwlSN2aVkS2BzrO712wdsLY4jw==
X-Received: by 10.28.107.141 with SMTP id a13mr12453056wmi.61.1489446493534;
        Mon, 13 Mar 2017 16:08:13 -0700 (PDT)
Received: from workstation ([213.149.51.172])
        by smtp.gmail.com with ESMTPSA id m83sm12980672wmc.33.2017.03.13.16.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 16:08:12 -0700 (PDT)
Date:   Tue, 14 Mar 2017 00:08:10 +0100
From:   Domagoj Stolfa <domagoj.stolfa@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible git blame bug?
Message-ID: <20170313230810.GA80865@workstation>
References: <20170313201104.GA32821@workstation>
 <xmqqmvcorjyo.fsf@gitster.mtv.corp.google.com>
 <CAPc5daVRX_-bJ_2reDLKJin9PNfy6EjbD14T=Mpx=9P8xzdmuw@mail.gmail.com>
 <20170313214400.GA98717@workstation>
 <xmqqfuign7jw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <xmqqfuign7jw.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> > For example, saying:
> >
> > $ git blame time.h --since=3D2017
> > ^e19f2a27ed8 (Domagoj Stolfa 2017-03-12 20:43:01 +0100  33) #ifndef _SY=
S_TIME_H_
> >
> > $ git blame time.h --since=3D2016
> > ^21613a57af9 (bz  2016-03-13 21:26:18 +0000  33) #ifndef _SYS_TIME_H_
> >
> > $ git blame time.h --since=3D2015
> > ^48507f436f0 (mav 2015-03-13 21:01:25 +0000  33) #ifndef _SYS_TIME_H_
> >
> > and so on, with different hashes.
>=20
> The output lines "^deadbeef" does *NOT* mean that commit deadbeef
> changed the revision.  It just is telling you that the hisory was
> dug down to that revision and it was found that since that revision
> there is no change (and you told the command not to bother looking
> beyond that time range, so we do not know what happened before that
> time).
>=20
> It is understandable, when your history has a lot of merges, the
> history traversal may stop at commits on different branches.
>=20
> Imagine a case where the line in question never changed throughout
> the history:
>=20
>           o---o---B
>          /         \
>     O---o---o---A---C---o---o
>=20
> Imagine A is from 2015, B is from 2016 and C is from 2017.  C's
> first parent, i.e. C^1, is A and C^2 is B.
>=20
> If you ask the command to stop digging when you hit a commit on or
> before 2017-03-13 (03-13 is because today's date is appended to your
> 2017), your traversal will stop at C and you get a line that begins
> with ^C.
>=20
> If you ask it to stop at 2016, A won't be even looked at because it
> is older.  The command will keep digging from C to find B.  If B's
> parent is also newer than the cutoff, but its parent is older, then
> the line will be shown with ^ and commit object name of B's parent.
>=20
> If you ask it to stop at 2015, the command will first consider A
> (C's earlier parent) and pass blame to the lines common between
> these two commits.  In this illustration, we are pretending that the
> file did not change throughout the hsitory, so blame for all lines
> are passed to A and we don't even look at B.  Then we keep digging
> through A to find the culprit, or hit a commit older than the
> specified cut-off time.  The line will be shown with ^A or perhaps
> its ancestor.
>=20
> So it is entirely sane if you saw three boundary commits named with
> three different time ranges.

Thanks for clearing this up. Is this documented somewhere, so that if it ha=
ppens
again I can point people to the docs that explain this behaviour?

--=20
Best regards,
Domagoj Stolfa

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHQB+y96lmmv+IXofwxT+ikb0YU4FAljHJloACgkQwxT+ikb0
YU6P4AgA1z6EontM0+cFVBmJl9CI2xmtsN+jcYyu8xcFSswvmumx1yvgQjTSHmBp
nu8IwnNrXvOcUsFQf4KFhSnyRE4K/CLCtVNr/VTxfnySMSSVqfycOFpvaIEWqFEi
Vv3a/N4Wwqw4PQfahhrTeq9ex2zUqxYCObav8UI37GOtp2tOrIn19ZRn2GadpIU0
8aocjZC5PKo35vxoKXrktvu7t3uXIkXh9iqU+n4l8nOQeQAxeD3tsvbkA5azBeUd
nhG4/z5se1LM56uRjptYBhDzLs4h/g1JlnW5fKO20cGJbzBCOXtcpRTf+Ciua/++
H/zc4Gl5UH6ExQL8vE/R+YKQvdbSxg==
=Xx2c
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
