Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8791B1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932628AbeAISG7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:06:59 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:39744 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758745AbeAISG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:06:58 -0500
Received: by mail-qt0-f181.google.com with SMTP id k19so18910575qtj.6
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 10:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iZqkAgkPNYHAG5HE+8cc329RxBHzQCuaj90joVRArHw=;
        b=qyJzCqf5sTtTGpZbDr7y+9bXT6aMOdOj2n4ONBiFAFXfWAWZ3R9EjxwBCOkFFfsJWj
         GHoFzWby/Y8wBXVmt9nRCynTjKxykctDepAPqABRiTLSXOufzMVkAVCYX6xdqydY/4sd
         +JPjeeZaDX4yX+Fv180fQwijZ4tW61+EccXJQUCiLYAnklXlD168sCZmDE53vm59qV5e
         LXiCPhfaadOWl+/9nP7/amDOLDLqwIHqQI7DYs6cQgjJY2o2FvynmLCm7C5cn2DZpCZ5
         T3IALMreU7D6ZVEd6lLDEcyMN48G6YanfVXsdLKwcoHwGLHuJ7SxM73gpB4UfRaeyn3i
         gHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iZqkAgkPNYHAG5HE+8cc329RxBHzQCuaj90joVRArHw=;
        b=HYpjYvNNUtp8a0GnQb1ynKBRmqxrYm+w+GLJhRhYO8K3uxwwDGnzJ3axi5fRD2JREy
         Y0CsdSQxyuZNcVQ7GjpAQgOgTS/AMiQrOjSjoDymx6zQpMsQrWir7b7kQBk4jhiBybae
         IgVI24zfvqdWOz497xGdN1nybFOvtyR2oS8x7gxUO0bcf84zj7Ew5VWT+qM6EFnNsgXH
         9mAGR8OxG0OwMLALp3vcWHBV7uZiF3jVOXVRTSTwIMrgSatS3mUZQhlvM/kiHRFZNcmD
         qa1BZt/9T01diP0zL9UaHzSk61UbF6vcHaZFZKGcjz2PqIALTpUAVhWvoBK3wtY0rnG9
         fk7g==
X-Gm-Message-State: AKwxytd7GRZDTMNiJ/REMBFtLFiKfEZGmp1e/jcRHYKvoZOAV2cARrSy
        GIT2S3ITEiDDzU1zsoSbtx2fdw==
X-Google-Smtp-Source: ACJfBosMqMpFBuyzaiw6RqWDXT2E1lvJpsortm6ad0gfUfTciEM0Wj8+F8tGP8TRSn5pHkpjb3OMbw==
X-Received: by 10.237.34.137 with SMTP id p9mr21647168qtc.194.1515521217354;
        Tue, 09 Jan 2018 10:06:57 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-160.NATPOOL.NYU.EDU. [216.165.95.160])
        by smtp.gmail.com with ESMTPSA id o57sm9668703qtf.53.2018.01.09.10.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jan 2018 10:06:56 -0800 (PST)
Date:   Tue, 9 Jan 2018 13:09:34 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Colin Walters <walters@verbum.org>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: upstreaming https://github.com/cgwalters/git-evtag ?
Message-ID: <20180109180933.jbyidmmv5xpsjuae@LykOS.localdomain>
References: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
 <20180108204029.m42qyezojak4kohh@LykOS.localdomain>
 <CAGZ79kZ8AXezcX1_5WJsUJMHiHCzj2B=Uj8+4K3VF+cC6mTCqA@mail.gmail.com>
 <1515465051.2895186.1228754952.0036D645@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kgnzigqrbtkgjkeu"
Content-Disposition: inline
In-Reply-To: <1515465051.2895186.1228754952.0036D645@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kgnzigqrbtkgjkeu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > See Documentation/technical/hash-function-transition.txt
> > for how to do it.
>=20
> evtag took me a day or two to write initially and doesn't
> impose any requirements on users except a small additional
> bit of software.

I agree that, in nature it shouldn't be difficult, but I also think that
things usually take longer when you try to minimize code reuse and
streamline the system's design.

> In contrast, working on hash-function-transition.txt?  That
> seems like it'd easily consume many person-months of work.
> And that plan only exists post-shatter.io, whereas git-evtag
> long predates both.

I think this is partly true. A hash transition has been brought up
multiple times pre-shattered. In my opinion shattered was a much-needed
PR push for SHA1 deprecation. In practice, things changed very little.

> > Personally I'd dislike to include ev-tags as it might send a signal
> > of "papering over sha1 issues instead of fixing it".
>=20
> I don't agree.  I think it's pretty clear that a hash function transition
> would be a huge amount of work - not least because of course
> there are now at least two widely used implementations of git in C,
> plus https://www.eclipse.org/jgit/ plus...

I agree with Stefan here. I think it's better in the long-term to
push for hash-agnosticity. I don't know if git-evtag is hash agnostic,
but if it is not, then we have two transition plans to think about.

>=20
> > push certificates are somewhat underdocumented, see the
>=20
> Why not call them "git signed pushes"?  Junio's post
> even says "the signed push".

A signed push creates a push certificate.
>=20
> And I just looked at this a little bit more but I'm not sure I
> see how this covers the same goal as evtags;

Correct me if I'm wrong (it's been a couple of years) but last time I
read about git evtags, they basically did the following:

    1. Create a signed tag.
    2. Create a signed statement of all the references.
    3. Create a checksum of the checked out code on the tag.
    4. Create a tarball of it.

I think 1) is already happening, 2) is very similar information to the
one contained in a push certificate. I don't know how necessary are 3)
and 4), but that's just my very opinionated take on it.

Full disclosure, I published a "competing" solution a couple of years
ago[1] but, in my personal opinion, I think push certificates can
achieve the same security guarantees as my system with very little
changes.

Cheers!
-Santiago.

[1] https://www.usenix.org/conference/usenixsecurity16/technical-sessions/p=
resentation/torres-arias

--kgnzigqrbtkgjkeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlpVBVkACgkQRo8SLOgW
IpVKFg//Xg1jLavNjZnoJ+ZN2WBISvzhyWoaN1Sx8G68C6aE4Dgbz+zdMMDOjd6a
pbS/LC6hsryht/9YsRcFjziUYSAmXuCNQbsCkswsULxwGS3/K6Q0qMbnb7TSikJr
AHuTX4fq73IdjW+lGZfQ00nRv3Qhl9FR8pgDCPZo+jk91pEnnFg9P72kmHNf0ANE
tMCDpztCUMnQ3O7CAbHuS0B6QVYNObQWJgxYiHG/9DC3dxDMiFZ/nnrbtOy5s9sC
cNzF4/kOsfy62OLNfSdsb3mm/zswMNpYnyBXF2irRgu3qeMoq4mOD138KvBy95ov
8OBFcywnKjU4jOIEgNA9j/jg58Ke9WyrazqkPHIProbJZJLvUrhKGWvSIJ92SI+m
MvebE+JglT0GCG9TFaUFUg0NLhv1sdoGKyOFPBE8gWk99h7agWQ6qGDI/h8fl0Xt
ucBdvVB+yzHKUaIGBkyvRCGplhZNpB68jCODCEfQ4PStEot6eqdRDMhcQEPNGP+U
DprO/6RwNnPNOUsl86BNkddTtNw9xz5u2d27Rg03dPqfPe6o8/FMANoTwf0xydxt
d979hrQjgj5wvKD84E47DErA0leGJcm3/GoN+oZ49FcYxBfY6RGkK+G7rwciKE8v
HM0i3Erx3vRC7cZma6zlst8KcnMkYeJqMKIFGNHdqtkfzqIrwuA=
=+tAj
-----END PGP SIGNATURE-----

--kgnzigqrbtkgjkeu--
