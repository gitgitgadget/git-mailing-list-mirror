Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08F8207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 14:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034799AbcIWOfX (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 10:35:23 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33560 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034752AbcIWOfU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 10:35:20 -0400
Received: by mail-qt0-f195.google.com with SMTP id p47so3582275qtc.0
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PgxqDz2NOeBSJ9RZQFbVRzCedFHkQ6Gy/ga0EsM9AtU=;
        b=JIzaqvxyWc0otblsN/rJeQPfDnU21JupBtvAAOpoDJtgGfhIj/bB6w2AnH1Kg8t6vY
         zwLLLHTduUg/zA1zrKxECCK+yEnU9Y/9vcxfesjqNS5rQAPzSK9s41TVTWHJagSWxqK0
         k+i/osRJ70KzCD6ImVqmnMiYxx0ohoxx/ei0NjBDjyqnc6cB3K5+5HAb1i1HCkOEKOzx
         v5KBmvy+l/3rTaAcSq0SQi0e+lSZNGwozwKttWfyM994taIYTLX32Psv6HsXj7zSTVuZ
         N6WJ2dz4wkj3jwU0rDF/abnSd8sSZgWgAbq2oSxMugz8r6wJ9iEDBCIwwalJk/C2jREw
         Dakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PgxqDz2NOeBSJ9RZQFbVRzCedFHkQ6Gy/ga0EsM9AtU=;
        b=Sm8KeQ/bYVo6PWXwvuCgYnz6c+izbeMZwcXEx6kaJa6SlQx55E3SQwjK7eSgpkIETu
         hXprNbQ1VZnDft+KRwMHio91rwSN95OO5BLOo89uZBA3hwZtf2Zlj/KCYqKPGRitxnyS
         sEYiqzlJwwvpRlC5ZhMldzbLykNlCY78XV0G4Y6SJbE4HELbIguMSm/DjhbAa+9z6wEI
         weklYVn9Eq9rm40gGXymwauFArQ2GVFfIHlx1rxEBIgbKBJ8hgWgwUWur7hOfHkXfg4G
         Rxd8GwdbE7B5FL9la5AW6obRAzBgCs9pTNpqxltbFOc5tMgpMkl48YInIqqW8IGj3zAT
         bAcw==
X-Gm-Message-State: AA6/9Rm27RCAN2t82ry1YeBTQFlPxsf37/GCTsEH0N5VfVY6m7EBvCte1DGfUBNr53EU9g8Z
X-Received: by 10.200.34.81 with SMTP id p17mr8203626qtp.7.1474641319113;
        Fri, 23 Sep 2016 07:35:19 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-16.NATPOOL.NYU.EDU. [216.165.95.5])
        by smtp.gmail.com with ESMTPSA id y203sm3970652qkb.31.2016.09.23.07.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Sep 2016 07:35:18 -0700 (PDT)
Date:   Fri, 23 Sep 2016 10:35:18 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH 5/6] builtin/verify-tag: Add --format to verify-tag
Message-ID: <20160923143517.6afqausmuf7ugc43@LykOS.localdomain>
References: <20160922185317.349-1-santiago@nyu.edu>
 <20160922185317.349-6-santiago@nyu.edu>
 <xmqqintn3aai.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="soeh7j7ri5pu3swg"
Content-Disposition: inline
In-Reply-To: <xmqqintn3aai.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--soeh7j7ri5pu3swg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2016 at 02:16:21PM -0700, Junio C Hamano wrote:
> santiago@nyu.edu writes:
>=20
> > From: Santiago Torres <santiago@nyu.edu>
> >
> > Callers of verify-tag may want to cross-check the tagname from refs/tags
> > with the tagname from the tag object header upon GPG verification. This
> > is to avoid tag refs that point to an incorrect object.
> >
> > Add a --format parameter to git verify-tag to print the formatted tag
> > object header in addition to or instead of the --verbose or --raw GPG
> > verification output.
> >
> > Signed-off-by: Santiago Torres <santiago@nyu.edu>
> > ---
> >  builtin/verify-tag.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> > index 7a1121b..319d469 100644
> > --- a/builtin/verify-tag.c
> > +++ b/builtin/verify-tag.c
> > @@ -12,12 +12,15 @@
> >  #include <signal.h>
> >  #include "parse-options.h"
> >  #include "gpg-interface.h"
> > +#include "ref-filter.h"
> > =20
> >  static const char * const verify_tag_usage[] =3D {
> > -		N_("git verify-tag [-v | --verbose] <tag>..."),
> > +		N_("git verify-tag [-v | --verbose] [--format=3D<format>] <tag>..."),
> >  		NULL
> >  };
> > =20
> > +char *fmt_pretty;
>=20
> Does this have to be extern?  I do not think so; prepend "static "
> in front of it.
>=20
> >  	while (i < argc) {
> >  		unsigned char sha1[20];
> >  		const char *name =3D argv[i++];
> >  		if (get_sha1(name, sha1))
> >  			had_error =3D !!error("tag '%s' not found.", name);
> >  		else {
> > -			if (verify_and_format_tag(sha1, name, NULL, flags))
> > +			if (verify_and_format_tag(sha1, name, fmt_pretty, flags))
>=20
> OK.  The callchain from here is
>=20
>     verify_and_format_tag()
>     -> run_gpg_verify()
>       -> print_signature_buffer()
>=20
> so not cramming QUIET into the flags parameter that is already
> passed is cumbersome.  As I said in my earlier review, it would make
> more sense to have the conditional NOT in print_signature_buffer()
> but in its caller, but it still is OK to add GPG_VERIFY_QUIET bit
> to the flag, which you would check in run_gpg_verify() to decide not
> to call print_signature_buffer().
>=20

Yeah, in retrospect, this sounds like a more reasonable approach than
doing it on gpg-nterface. I'll keep the QUIET bit then.

--soeh7j7ri5pu3swg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX5T2lAAoJEEaPEizoFiKVpQsP/1cPfBgNLSjsGKuUPyIkugl0
ng4XKYB7MkDyqG0sswjfr5cfotSmXdWETjNC+7pQ+aw1Sj+MEmSV3IJSsSmMmGsJ
uiLt8Qpu17a05UM0yTzlaednBagRatAmjXvm3f6jdrLdtGgPZl/4kCIqCOgdzqYP
Mjh101opA9a37OCFc1vRvfWAqOZR8XD5wJQuCGhUdlxfaNyswmBe0kjuF9vcqkeL
S3aeNIy6koxO6t7f79w4q3zVbElpCFfPEoELbIv/Vpz0Q/Hjok2A63yBXCeDEfc4
bNIxnCWB7JgGhNMhVPUGl2jTu0SlSN+LyNN2/4yHJu/w9qSEjr3LZR8cb8vCICKg
iCx+A3BlpUJPVX9eYJ2K3Jxa8A1UoecbM1ALnDRlldIij2xyEsgNtdD2/c198MQT
9ZaZCfLG7SnCird09kgXoTMUmKgPNrKgo0Oh71xH0XF2sYWZB/Scda67z1OBXHIg
HgN9EyaKBueS+sT8Z/T/7lvMLhx3/adjeI97qL/94NnqYIE1e45uA+qrTBJJb7X4
3YRMTJHvsR/WHxWsaPVuA6T7CGJHxcvAov4eTnukprlr9JNE2JcBtX0+NCYP4AwK
VJtiOLrDXk4Y2IBt6YmxDdhfBPis5u2fyyn+HCiGoS1qmm2hrHiGVRGNL//EwDRC
dsaQi9zdlpZ7Urc+/m7Q
=HH05
-----END PGP SIGNATURE-----

--soeh7j7ri5pu3swg--
