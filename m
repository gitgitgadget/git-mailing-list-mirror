Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC05F207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 14:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034856AbcIWOg2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 10:36:28 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33012 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034659AbcIWOg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 10:36:27 -0400
Received: by mail-qk0-f195.google.com with SMTP id n66so7259736qkf.0
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rZr1+SKXx8SvXQjbW6ZEm6WlpzaspVIKYMbeibSnq5E=;
        b=FUa215dMdVYOJOh7eoXd9I91+LuatyhSiHuBEMjNc6ZtxZl/0GbnNYMUYknLDC7rRQ
         DKrKaGyNemiSlnh5IINrlq+sHvSP8VLVRlOTvf9IwlycrRLB5CxO40wkLFHokGZGHtTN
         OlxM92eyuoSAnXgS3+QegbPjm/F6VDG76HOfiPlqzW2EtEFr9/nJZDU5FMvMKhyzP46G
         dyNFxDhbqK6dYp65jVBnLk5YthSMHAw7/UhOat35aBX4/RtRf+tsf5QaxUub09nuaT+Z
         S29psdVa7Ccz+Kjs0tZ1YNCAbYR2pZbZo1A4ifKq6dnCGrUhwT0rPI0EZ2eRkDePwsie
         +ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rZr1+SKXx8SvXQjbW6ZEm6WlpzaspVIKYMbeibSnq5E=;
        b=I6G9S8SgQJ0Owv6cn75CgNGVHnRt94lC+wYL5oH6smI5F4m/jGSG7OkWwb8u4RL787
         E+vLF0N0tOJyJin+8u+GQAzADPHoXSkwFyIsZ1PwWjOS/PixP+yhs4c0n8uldsfgZ+a2
         FJbMX/r+wr1/tuubks5aZfWCwR67r6OqtqII0JRFRC1sxZzNiGBOnFX/G3sgl27k7hhI
         cBrP0nt8NYMVuwA4Qj+NNRDFiYrecD2IT1fqKaX7hCjcMgw/7n8+CqwzkTz6oMLNIck0
         F5PS+rV3t/So0hmaaHsXOOAT0t1A0trXwyA2gJ3W4eN+5k69bO+gKFTRSWCHbsEzrisk
         fYWQ==
X-Gm-Message-State: AA6/9RmHBiWNMtUXu2XrGzam2d2H3Z2fe6gU5TRBmqVPSTOQ37G/QUdQFSP/GYO3oo3lCdWt
X-Received: by 10.55.75.79 with SMTP id y76mr8551877qka.9.1474641386408;
        Fri, 23 Sep 2016 07:36:26 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-16.NATPOOL.NYU.EDU. [216.165.95.5])
        by smtp.gmail.com with ESMTPSA id d68sm3978239qkg.23.2016.09.23.07.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Sep 2016 07:36:26 -0700 (PDT)
Date:   Fri, 23 Sep 2016 10:36:25 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>,
        Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: Re: [PATCH 4/6] tag: add format specifier to gpg_verify_tag
Message-ID: <20160923143625.ynnzgkikj625f6ij@LykOS.localdomain>
References: <20160922185317.349-1-santiago@nyu.edu>
 <20160922185317.349-5-santiago@nyu.edu>
 <xmqqponv3b4x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rinuenzmzsefh7hj"
Content-Disposition: inline
In-Reply-To: <xmqqponv3b4x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rinuenzmzsefh7hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2016 at 01:58:06PM -0700, Junio C Hamano wrote:
> santiago@nyu.edu writes:
>=20
> > Calling functions for gpg_verify_tag() may desire to print relevant
> > information about the header for further verification. Add an optional
> > format argument to print any desired information after GPG verification.
>=20
> > diff --git a/builtin/tag.c b/builtin/tag.c
> > index dbf271f..94ed8a2 100644
> > --- a/builtin/tag.c
> > +++ b/builtin/tag.c
> > @@ -106,7 +106,7 @@ static int delete_tag(const char *name, const char =
*ref,
> >  static int verify_tag(const char *name, const char *ref,
> >  				const unsigned char *sha1)
> >  {
> > -	return gpg_verify_tag(sha1, name, GPG_VERIFY_VERBOSE);
> > +	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
> >  }
> > =20
> >  static int do_sign(struct strbuf *buffer)
> > diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> > index 99f8148..7a1121b 100644
> > --- a/builtin/verify-tag.c
> > +++ b/builtin/verify-tag.c
> > @@ -51,8 +51,10 @@ int cmd_verify_tag(int argc, const char **argv, cons=
t char *prefix)
> >  		const char *name =3D argv[i++];
> >  		if (get_sha1(name, sha1))
> >  			had_error =3D !!error("tag '%s' not found.", name);
> > -		else if (gpg_verify_tag(sha1, name, flags))
> > -			had_error =3D 1;
> > +		else {
> > +			if (verify_and_format_tag(sha1, name, NULL, flags))
> > +				had_error =3D 1;
> > +		}
>=20
> Revert the unnecessary reformatting here.
>=20
> > @@ -56,6 +57,15 @@ int gpg_verify_tag(const unsigned char *sha1, const =
char *name_to_report,
> >  	ret =3D run_gpg_verify(buf, size, flags);
> > =20
> >  	free(buf);
> > +
> > +	if (fmt_pretty) {
> > +		struct ref_array_item *ref_item;
> > +		ref_item =3D new_ref_item(name_to_report, sha1, 0);
> > +		ref_item->kind =3D FILTER_REFS_TAGS;
> > +		show_ref_item(ref_item, fmt_pretty, 0);
> > +		free_ref_item(ref_item);
> > +	}
>=20
> I haven't seen 5/6 and 6/6, but if this is the only user of the 3/6,
> it would be much better to have a single function to format a ref
> exported from ref-filter.[ch] so that this one can say
>=20
> 	if (fmt_pretty)
>         	format_ref(name_to_report, sha1, FILTER_REFS_TAGS);
>=20
> or something like that, instead of doing three that will always be
> used together in quick succession in the above pattern.

Oh, this sounds like a better alternative. This would be instead of 0003
right?=20

Thanks,
-Santiago.

--rinuenzmzsefh7hj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX5T3pAAoJEEaPEizoFiKV7Z8P/jnhCY/ljmR+MUoKVQd8/SkI
t8oSMewy4yE/oRfd3Zihl82GTxhAWuW2mQ4LaRYSEFdh3L/L1LwEAQFnYCzvHLKU
BrKubdgulhi8rvgt0EPvQ2ootBjpVpTbXLgUPVXm4Qk6YhgGmKw3+E+t97Xm0qBb
+DRCuBHz/kJbPTzvofs4ltGaH8j8rTjUiol9BAQb09klOwINstQ3OZ6V0VwMw9bV
x4UoL5aUe7Pxcn19ar9vgMDFWs6CnmRYTaEG/kZVoQ5BPt/BoDCqYC0yKXamQ8Ss
ihqkrW2y0gLSWxfOczpbjEsd6WxrQ/c3jRNesNDkzbQQbay/6I/yRmw2QxCst5/Y
0n8ZTh1wZZouE2PGw24+5F//toKjFd9F8W8+9ThOWGh7TVBIizdOnQh8ZS4PMIOq
0suBg8mGVnzWQsL+gsUzXYPqkpsnyowmF5UnG/+X4n/1EctPTQjyE/A3ssoJnofi
AMMWp3SRbrsLVUKV+QA6a5zIlWrnUNx4P1iEu+H2J8GVfjDGCm84wgwGzdUB8dnO
crXmbyhae68IjbVRplEUpKbWSUMMUd/SQTCAJ6kB3ZciCJcn6dJAODmygkpCYWid
PoPbxNMFG+ioeU0aOCk+KIr1GssJeIWDwS1rkKMKOqXCqnTTnntjHZDhVyfdiO7l
aLM7RG5Ymi9Ml1rWsaqw
=C3LP
-----END PGP SIGNATURE-----

--rinuenzmzsefh7hj--
