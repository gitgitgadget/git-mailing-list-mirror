Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C89FC433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 00:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D612A60E0B
	for <git@archiver.kernel.org>; Sun,  9 May 2021 00:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhEIASI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 20:18:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50470 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229594AbhEIASI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 May 2021 20:18:08 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 838436042E;
        Sun,  9 May 2021 00:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620519395;
        bh=HCSm7y3TsFp0ZPgSORE2BNs5EQ6F87GJWEdfsEXW81A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=T4G0k9YBLB3CRSaTCakzl3P4HIujbpMGMQqhnES2NGmy3IxINQpi9ZA6lsP0pmqDZ
         3iXNe7+2TqOV4cyc98f4zp4cK2D+l0VFhm1kFAVfKniaRUgZuJDVJm9wxXaw2fyaZm
         ujcHahsX6bI3v5EIWKqC21BRUm1+B9gpieJz4mKEZanJgUxQDr5e4VeUkd4lgK4anE
         iBJ4rhF0Ax62/a/8qYTsO2z92drvnf0U4SoKu5pb+e2Pyf9kjK/UKDSFMspMvsbo4K
         p1/q95TPthuILYfmT2tt9H8pI0uuI7FiO/WyJdC0hjAtfKfPRFNEet0JhH2ii3AEaV
         nSDPTEgzT1hW6qEyOp5qnoO1D/7SZa1ZLCBEZxyOgmOnETNcCoHc84c3v8tXD4OBon
         4DSpaWkqAe52IZgaZdyVFplXoihH4nL76pm9ReI0ks9d1eXO2jnGpzT2u/WJVck/4r
         HhQQAUxHG/QlGsv8pxlkaY002ePaUD+bVzE3AkMB7V0U7IQMfrs
Date:   Sun, 9 May 2021 00:16:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Dave Huseby <dwh@linuxprogrammer.org>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] Modifies documentation for universal
 cryptographic signing
Message-ID: <YJcp3ZkZOfU+EMym@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Dave Huseby <dwh@linuxprogrammer.org>, git@vger.kernel.org
References: <cover.1620454449.git.dwh@linuxprogrammer.org>
 <c454bcc4c3c5de1a17c63461c6091689098c75b9.1620454449.git.dwh@linuxprogrammer.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="muYbY1+3+PwPDm4t"
Content-Disposition: inline
In-Reply-To: <c454bcc4c3c5de1a17c63461c6091689098c75b9.1620454449.git.dwh@linuxprogrammer.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--muYbY1+3+PwPDm4t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-08 at 06:18:23, Dave Huseby wrote:
> Signed-off-by: Dave Huseby <dwh@linuxprogrammer.org>

You definitely need a commit message here explaining your approach and
justifying it.  I'm not saying that your approach is bad, but people
generally read the commit message to help understand and review the
commit, and we will want to know why you've made the decisions you've
made here and rejected other solutions, and the commit message will
hopefully explain that to us.

>  Signed Commits
>  ~~~~~~~~~~~~~~
> -We add a new field "gpgsig-sha256" to the commit object format to allow
> -signing commits without relying on SHA-1. It is similar to the
> -existing "gpgsig" field. Its signed payload is the SHA-256 content of the
> -commit object with any "gpgsig" and "gpgsig-sha256" fields removed.
> +We use the new signature format whenever signing commits without relying
> +on SHA-1. The new format adds a 'signtype' field, zero or more 'signopti=
on'
> +fields, and one 'sign' field to commit objects. This allows for the 'gpg=
sig'
> +field to coexist if needed.
>=20
>  This means commits can be signed
>=20
>  1. using SHA-1 only, as in existing signed commit objects
> -2. using both SHA-1 and SHA-256, by using both gpgsig-sha256 and gpgsig
> -   fields.
> -3. using only SHA-256, by only using the gpgsig-sha256 field.
> +2. using both SHA-1 and SHA-256, by using both gpgsig and the V2 format.
> +3. using only SHA-256, by only using the V2 format.

SHA-256 repositories already exist and already use this format.  You
cannot change it now, since doing so will needlessly break commits.
Just because they are experimental doesn't mean we should break
compatibility needlessly.

>  Old versions of "git verify-commit" can verify the gpgsig signature in
>  cases (1) and (2) without modifications and view case (3) as an
> @@ -427,17 +426,16 @@ ordinary unsigned commit.
>  Signed Tags
>  ~~~~~~~~~~~
> -We add a new field "gpgsig-sha256" to the tag object format to allow
> -signing tags without relying on SHA-1. Its signed payload is the
> -SHA-256 content of the tag with its gpgsig-sha256 field and "-----BEGIN =
PGP
> -SIGNATURE-----" delimited in-body signature removed.
> +We use the new signature format whenever signing tags without relying
> +on SHA-1. The new format adds a 'signtype' field, zero or more 'signopti=
on'
> +fields, and one 'sign' field to tag objects. This allows for the in-body
> +SHA-1 signature to coexist if needed.
>=20
>  This means tags can be signed
>=20
>  1. using SHA-1 only, as in existing signed tag objects
> -2. using both SHA-1 and SHA-256, by using gpgsig-sha256 and an in-body
> -   signature.
> -3. using only SHA-256, by only using the gpgsig-sha256 field.
> +2. using both SHA-1 and SHA-256, by using both gpgsig and the V2 format.
> +3. using only SHA-256, by only using the V2 format.

The same thing here.  This is currently out of date; we use signed tags
for the same algorithm (that is, for the SHA-1 signature of a SHA-1
object and for the SHA-256 signature of a SHA-256 object) and fields for
the other.

> +Version 2 Format
> +----------------
> +
> +The goals of the version 2 format are as follows:
> +
> +- Backwards Compatible with version 1 without any intervention.
> +- Eliminate signature-format-specific string matching for detecting/pars=
ing
> +  version 2 signatures.
> +- Use fields for storing signatures in all objects and transactions.
> +- Have a field that identifies the signature format.
> +- Have fields that store options required by the verification tool.
> +- Store signature data verbatim as created with the signing tool with es=
caped
> +  newlines and carriage returns.

We probably need to define what happens if both a v1 and v2 signature
occur.  Probably the commit is invalid and should be rejected.

> +Fields
> +~~~~~~
> +
> +The version 2 format uses three new fields listed below:
> +
> +- signtype <signature format name>
> +- signoption <token> [=3D <value>]
> +- sign <multiline signature data>
> +
> +A complete signature must include exactly one `signtype` field, zero or =
more
> +`signoption` fields and one `sign` field.

This is going to be a problem.  We want to dual-sign objects over both
their SHA-1 and SHA-256 values.  We already have dual-signed objects in
the repository.

> +The `signtype` field has a string value that identifies the type of sign=
ature
> +that is stored in the object. This string is case-insensitive and is use=
d to
> +identify which configuration settings are to used when verifying the sig=
nature.
> +The corresponding configuration settings are in the config file as:
> +'sign.<signType>.options.*'. The 'sign' field stores the text-encoded si=
gnature
> +from the signing tool with any newlines and carriage returns escaped as =
'%0a'
> +and '%0d' respectively. Whitespace is significant in digital signatures =
and
> +the protocol for sending/receiving data to/from signing and verification=
 tools
> +requires that newlines and carriage returns are escaped. By storing the =
escaped
> +version in the 'sign' field, we avoid extra processing and error-prone
> +escaping.

Is there a reason we can't use the indented block format currently used
by gpgsig and friends?  Are there really formats that need to support
carriage returns in their signature?  If so, can we just specify those
algorithms will encode it with base64?

Also, it will be required to escape other values as well.  For example,
if you encode things with %, then you must escape %.  Git will also not
allow NUL bytes in commit objects, so if you want to encode arbitrary
binary data (which I would just do by requiring people to base64, but
you may not want to), you'll need to escape them as well.

> +The introduction of the 'signoption' field is necessary for Git to remain
> +agnostic to the tools used for signing and verification of cryptographic
> +signatures. Some signign tools do not produce cryptographic signatures t=
hat
> +include all of the data needed to verify the signature. A good example o=
f this
> +is the minisign tool (https://jedisct1.github.io/minisign/) which requir=
es the
> +public key to be supplied to the verification operation. In that case, t=
he
> +signing operation would return to Git a 'signoption' field along with the
> +'signtype' and 'sign' fields to be stored in the Git object. When Git ve=
rifies
> +the signature, it will parse the 'signoption' fields and send them to the
> +verification tool as OPTION commands. In this case it will send the publ=
ic key
> +along with the signature for verification. This design allows for arbitr=
ary
> +options to be stored in the Git object by the signing tool that will get=
 passed
> +to the verification tool later without Git knowing or understanding any =
details
> +of a particular signing tool.

While I'd like to see us support minisign, I have concerns about
embedding the public key in the signature.  First, that bloats commit
objects, and large commit objects can cause performance and scalability
problems.  Many things like partial clone implicitly assume that commits
and tags are small.

Second, the goal is presumably to verify that the signature identifies
some relevant party, not just some arbitrary user.  As a consequence, I
think it's safe to assume that we have a way to acquire the public key
of the trusted user whose signature we want to verify.

> +The order in which OPTION commands are sent to the signing and verificat=
ion
> +tools is significant. OPTION commands that come later override OPTION co=
mmands
> +that came earlier and had the same token name. Git always sends OPTION c=
ommands
> +from the command line after the options from the config. In verification
> +operations, Git sends the options from the signed object first, before t=
he
> +config and command line options. This ensures local control over option =
values.
> +An example would be if the sign.openpgp.options.minTrustLevel config opt=
ion is
> +set to "marginal" and the command line `--sign-option minTrustLevel =3D =
full` is
> +issued. Git would first send an OPTION command setting
> +`minTrustLevel =3D marginal` from the config and then override that by l=
ater
> +sending an OPTION command setting `minTrustLevel =3D full` from the comm=
and line.

It's a security problem to allow people to control verification
parameters or command-line options.  The former allows users to validate
signatures using weak algorithms or reduced trust levels, and the latter
may allow arbitrary code execution.

Unless this field is going to be used for some signature parameter other
than public keys or verification parameters, I'd rather we omit it.  If
we keep it, the allowed parameters must be strictly defined and
documented per format and not allowed to contain arbitrary data.

Overall, I'm generally positive on this approach, although I think it
needs some further refinements as I've mentioned above.  My preference
is that we specifically document specific signature schemes and, if we
keep the options, which options are allowed.  For example, "minisign"
and "signify" are compatible, and by specifying and documenting
well-known formats, we avoid the problem where people end up writing
invalid commits by typoing the name in their config.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--muYbY1+3+PwPDm4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJcp3QAKCRB8DEliiIei
gR4dAP9efwtvkBEf+GQze+irr8TuF2vH7HojhV4ayasiPDxzsgEAxQH7wMwqIud5
Bya/CnGlUqQtLenC/ibpG7HeJp9YWQo=
=RCWH
-----END PGP SIGNATURE-----

--muYbY1+3+PwPDm4t--
