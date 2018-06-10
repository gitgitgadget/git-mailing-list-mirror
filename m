Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4CA61F403
	for <e@80x24.org>; Sun, 10 Jun 2018 00:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeFJABG (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 20:01:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36348 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753525AbeFJABF (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Jun 2018 20:01:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 75EBF60129;
        Sun, 10 Jun 2018 00:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528588864;
        bh=8Dx1OhInZiJcuCIuCRwYeLJyy6Pi5BcYRw+brmEOK+c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cAYkYoCCu59Miu7DZS9UH76EmPfxkvYRsohKD4GXARS7pUoqDW0vm3eHePuwNmV41
         Qa0+LdJNXwLnwVzJFyAvSfU2v9x6w54A5kr8ldyQHwAFxW9KmG/7AOqUEJ3xTbS7tr
         o4i24ZkGDeH0fzlL2jovtkqwAgJ+3mJID5OrrSGd1sgNb0yOrLiw456FkPJO1mA3wN
         Nr9It+tKD7/omouHVw+ZX0FYDMFVp2nB2+tjNw5JV5E5ANi4c13oat7ZFTBgVZ2xVv
         Z6IEhzkW1PXqB2C/6UeSvamshm/U5lzCwXmHGX02LlnUwMFMjGHivKDpAbi9dYzQ5U
         uwG3PDHpoQqS4kodr3gLrxDxNPHxPInCMAN0eqVstPit2LdIIVkWP5mlbbxd0TnYci
         CMLvzE/7TuNaK21+gMBEVYlu45cOH0RXh4bvNwwSogslV9pn4P3VD1TrJVqqkTzD/b
         5FDNSRKCK85IaXs2CkUwmuiu8CMjEnby5D8Z8RSiy/rfFMR1LAR
Date:   Sun, 10 Jun 2018 00:00:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
Message-ID: <20180610000056.GD38834@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
 <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com>
 <900a34bb-4d8b-4a22-a0f5-1d2f6df84945@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <900a34bb-4d8b-4a22-a0f5-1d2f6df84945@kdbg.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 09, 2018 at 08:56:00AM +0200, Johannes Sixt wrote:
> Am 09.06.2018 um 00:20 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> >=20
> > On Fri, Jun 08 2018, Johannes Sixt wrote:
> > Can you elaborate on how someone who can maintain inject malicious code
> > into your git package + config would be thwarted by this being some
> > compile-time option, wouldn't they just compile it in?
>=20
> Of course they can. But would we, the Git community do that?
>=20
> From the design document:
>=20
> > The goal of the telemetry feature is to be able to gather usage data
> > across a group of production users to identify real-world performance
> > problems in production.  Additionally, it might help identify common
> > user errors and guide future user training.
>=20
> The goal to gather usage data may be valid for a small subset of Git
> installations. But it is wrong to put this into the software itself, in
> particular when the implementations includes scary things like loading
> unspecified dynamic libraries:
>=20
> > If the config setting "telemetry.plugin" contains the pathname to a
> > shared library, the library will be dynamically loaded during start up
> > and events will be sent to it using the plugin API.
>=20
> When you want usage data, ask your users for feedback. Look over their
> shoulders. But do not ask the software itself to gather usage data. It wi=
ll
> be abused.
>=20
> Do not offer open source software that has a "call-home" method built-in.
>=20
> If you want to peek into the workplaces of YOUR users, then monkey-patch
> survaillance into YOUR version of Git. But please do not burden the rest =
of
> us.

I understand there's an interest in supporting the most people with the
fewest amount of staff.  I'm certainly in the situation where I, with
only minimal assistance, support every Git user in my division of the
company, regardless of technical ability, and I know how overwhelming
that can be.  (Burnout, I can tell you, is a thing.)

I also have to look at this issue from the interests of what is best for
the FLOSS community and for users as a whole.  Adding in functionality
that sends off usage data from a command-line tool, especially one that
is as widely used as Git is, is not in the interests of users as a
whole, nor is it common practice in FLOSS tools.

As a highly capable and technical user, I would find it very undesirable
to have my development tools reporting data like this, even if it is to
make my experience better.

The ability to load arbitrary libraries makes me concerned about people
using this to spirit away personal or company data or to subtly steal
data in a rootkit-like situation.  These are real threats in the kinds
of environments I distribute to in my work role.

I agree with Duy's point of view that GIT_TRACE-level output to a file
descriptor or file is fine, but a persistently enabled feature is not.

I expect this feature, if implemented, would be patched out of Debian's
Git, and it would be patched out of any Git I would distribute in my
work role for legal and ethical reasons.

As developers, we have a duty to be mindful of how our software can be
misused and abused and try to avoid that when possible.  I don't think
this feature is on the right side of that balance.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlscajgACgkQv1NdgR9S
9ot04Q//Y3e6siyQY4zOyuWw9CtRNziKoTMwarKrCDIe9QyPMDPdGpSc9fzSBkCl
xcsNWZ5xeqLoC2X5V3yUyqxHRTUs95TSCgaWAl1xLiuX9omArMhD6uKKlcgdbk7e
YRkoiRgFHSmk6oxSalPsQfDuZBkx2ceyw0BI7TE8EooVqD+gtF6CMzvQPyB3CDJH
40VTvSLq4Iuji6gBsEDprcCEBdDoVFhfRW9mA9iihE51Vi3Ubj+wx2j2Zlo9iqnP
g52+Fhmx4WCat/wci4A8Af7RJJYiLSpJB6PL4RCiKDbLfaoN+6T/vz06SCgb1LnB
DjIcjxbQKs6EdcKLEUfU/zC2wFNGX2RfJmIRDpwIgXs6lyVqgcY+oLF7yr6Ko3AF
gbVEejR7GHGhgEOpltaw/DjWB9QvNPCQLLQTb50SFraV+ITxMLLg8iUdqGamtQi+
ap5vfyUJhSXyE8scjS1Z2o0IXWtRSNLfYenyl0f+s8lHNiDqRHsEY7MR0MuZR1QZ
DzCchzX3zvCfz2Ak1RRjZcW9lBvHX7VGk3paQUeuifFWYAtIrbO9Ar/ZAfsL0oc/
k5MTgEpzuo6IJ0qpH+jqYi7Zlss8eGzKs2z5en1s7rEpHEaEqtfUXPcrvN/wGQFp
KoKBQVjUdUqWtTllWmo9ZVF9+w2ebFPEhLi/Wp+Vkt1NX1xgb7Q=
=6mrj
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
