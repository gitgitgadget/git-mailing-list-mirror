Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14A31F42D
	for <e@80x24.org>; Tue, 29 May 2018 19:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966657AbeE2TyV (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 15:54:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57590 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966532AbeE2TyB (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 May 2018 15:54:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:cc62:bd61:abbd:bc4b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E63A160732;
        Tue, 29 May 2018 19:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1527623639;
        bh=zMHJN2sS58R5ipOjIGnloB29p/RyOWEDeEtC2izBVas=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IOUY/94SDxIW5er5eYVJlxdo4ncNCS0f2+drusbxcGexRq9JzRBGLUp86qPASqL0W
         WoGTcJd9J0MnK5jmFNdkh1/m+YcOcz4sxNtqluFMqjYdn7shcXFbHpdrA0lWY9tRbV
         656UKoaERLP8CdS4eH+i3X57DiSO2QjMEsRfqVdo/8BCiXpzdT+kxoY8RHxvOqjtNI
         JJ1Ehg46jyJ8zBVTlkNMQvjXW+jcb/56bhNKSJvGszH1QuResuCquPdYUwaAn+xXjg
         qGcCsecQ2bw5HD1MNES6QU5HWlV7bJjmlnlimfLTEDMqrFC43xc06Tpy5xYpOYFjTN
         ApDQv2nJTs2wKIVuehtT1A0TE9gP3ojV9OG4jCk0TU66mOJYD72+blfKwLNADz1WCN
         X4KjV5Of4fm+JimKCYpNk/E07VdTIEC3FTUTj7z0CaMlflVc/5tUejB9uYGa1XmMp9
         xxON0H0c0k8zTWJqNc4ac5OHLk4eZ+PBZqIXxN94KWDWL8g93cD
Date:   Tue, 29 May 2018 19:53:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/1] SubmittingPatches: not git-security@googlegroups.com
Message-ID: <20180529195353.GM652292@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20180527140433.32277-1-t.gummerer@gmail.com>
 <20180527153418.GG207547@aiede.svl.corp.google.com>
 <20180527210822.GB8868@hank.intra.tgummerer.com>
 <xmqqbmd0lc11.fsf@gitster-ct.c.googlers.com>
 <20180529180203.GC8868@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDuspjMMC1Ui5ypn"
Content-Disposition: inline
In-Reply-To: <20180529180203.GC8868@hank.intra.tgummerer.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NDuspjMMC1Ui5ypn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 07:02:03PM +0100, Thomas Gummerer wrote:
> On 05/28, Junio C Hamano wrote:
> > This is a tangent, but the use of footnote below looks a but
> > curious.  How would {1} reference pick which :1: to use?  The
> > closest preceding one?
>=20
> Tbh I didn't look at the docs for doing this, but just used the same
> syntax as we're already using and tried it with both asciidoc and
> asciidoctor.  And yes it seems like it always picks the preceeding
> one.

Yes, I believe the attributes namespace is flat and substituted using
the current version that's defined.  I wouldn't rely extensively on
that, though, so unique names are probably better.

> > As this appears on a page that already has other footnotes attached
> > to an adjacent paragraph, I am wondering if they should be made into
> > a part of the same numbering sequence.
>=20
> I have now actually looked at the docs, and this numbering has nothing
> to do with the footnote format, but rather is used to substitute the
> attribute that's specified in the curly braces with the text that's
> after :<attribute>: [1].  This initially confused me a bit.  Maybe it
> would be nicer to give the attributes names instead of just numbers?
> As we keep adding footnotes, that would be less likely to produce
> conflicts between the different attributes I think.
> I'm also adding brian to the cc list, as he first converted this to
> AsciiDoc for opinions.

In AsciiDoc, footnotes use the named macro syntax.  I thought it would
be difficult to read to have the footnotes inline, so I chose to use an
attribute to substitute them.  I used numbers because we had a small
number of them and the original footnotes were numbered.  I was trying
to make a minimal, faithful conversion.

I have no objection to named footnotes and I agree they're easier to use
if we have a large number of them.  I think whatever we use, we should
try to make them unique, as I mentioned above.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--NDuspjMMC1Ui5ypn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.7 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsNr9AACgkQv1NdgR9S
9oseMw/9Fp0isINxBMAxRIyWY35wQmF+Ga1DFYjmE7nH6tf2k+DrLGrCYqN+AvOf
5x2X5pSGrBKSizF0f7qAXkroKREDSv2tQD0JpEl+mJEBExivIUh4+q2uk1EtpQGO
Wo0klTQJMj/JCL3dsrQ47uAzKRdB9Jp1VSRiO1KUtFfEdo6+eSFp8WYXiw2PqvvD
lYAHNs4TZs9JfxjCmHMgovktburm14EOXn44BjYzk7W9elZg2mwnUHc0nA8W7Lxw
Wdx597+3l6eBHFKJizhKGu3ps3tSPJuBodL9ng8XUNe5cLlamrmZtmRetDwRl5s0
zflS3PaUerkQguOi9X+uwL5tDPUdmkttozu3yZPmHtCbsGSWSO2s4DWGvKrVILBZ
k2afBnDK+gmViraFOYjo9k8FtBwdojGhH+STzGEu2c+Fhq75cefmL9ZMQIAxtTOw
YIjrNNQaML9iKHcP21K1dVIHhxOuPrNu4p/z3BRfMCJHzW9mM8SbHdG8WvDrmlgn
1jtx1dgueQ7Wgfc/7KU3Z6LBCjOJaogzCeRWCsywQNE/1hU8J27Pu1jbi2oskVGw
tpWXc9WiBF//YC1o+lP1CzxxBeu1jmfY8BDIOZyBn2/pWfvLDAtvS6y24v2OpqWd
VuI0DMsTSy7nQtPRmNGRZOLlakWIY4sofNLIeeG61DkK9myYmqg=
=Mqfr
-----END PGP SIGNATURE-----

--NDuspjMMC1Ui5ypn--
