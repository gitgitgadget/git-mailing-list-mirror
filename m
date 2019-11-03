Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820EA1F454
	for <e@80x24.org>; Sun,  3 Nov 2019 21:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfKCVqP (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 16:46:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59984 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727856AbfKCVqP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Nov 2019 16:46:15 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B0B996046C;
        Sun,  3 Nov 2019 21:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572817574;
        bh=UrfyB+knOjWY+AN/IrFlOiHoFGfm9f/EAJ44p6D9QKI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cQK/YdbYowCju9OMwr4LSEPkjTo02C0IFRTToae4ukJPNoeEx/REXAUs6kcbuKrE/
         VFKQHm6sZlgqXOeQBcs9Av7A/ddPJmmChwVOCNufhVyUAQ243heJC1jqH0ctr/yngV
         Bc6+NdcAbCcpmE8zgTQHQTtYyMCx8SERz6OZgxpEltwHhsEuPWVMn5a4q12it1jLZe
         UOVUCIKpIkv/M6jvxb2yz+EzOHYGjm8FxA0zV5idtrV6/mu2tCXOhywYOPQz9wf3I3
         Etbr7KhtwDVG3xp4lFAcpqmUWJxo6rKrjOn9NkSeH4ZpjAQAo/t+xWlfQ1ZqwB9xkL
         A7TcZamuZcbfHVU2dljZmAb+qWY4C2kE+H6cbT4jNem5194/Ha0NHVv4XgcdOjxGaj
         3gNINtNZZSHHxGfmzBE4QGkEiwQi6XknBP+eccM9NXt3QJ471gzRtDFShE65aIZhiX
         p3Rn5aeaAJY9U5JRmHqKcI4IXOpNgehlJq7+3YtXNHMYK6v2WqM
Date:   Sun, 3 Nov 2019 21:46:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] doc: dissuade users from trying to ignore tracked
 files
Message-ID: <20191103214608.GC32531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
 <20191102192615.10013-4-sandals@crustytoothpaste.net>
 <86h83lhugj.fsf@gmail.com>
 <20191103185908.GA32531@camp.crustytoothpaste.net>
 <861ruoiw97.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <861ruoiw97.fsf@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-1-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-03 at 19:40:36, Jakub Narebski wrote:
> Your proposed change:
>=20
>   +If the file you want to change is some sort of configuration file (say,
>   +for a build tool, IDE, or editor), a common solution is to use a
>   +templating mechanism, such as Ruby's ERB, to generate the ignored
>   +configuration file from a template stored in the repository and a sour=
ce
>   +of data using a script or build step.
>=20
> I don't see how such templating mechanism could be used.  You have some
> kind of configuration file with placeholders comitted, and you have a
> version of this file with local changes -- how templating mechanism
> could solve this?  I would like to see few lines of an example and its
> use.
>=20
> Alterantives:
> ~~~~~~~~~~~~~
>=20
> In our build system, we have versioned Makefile, and not versioned
> config.mak (with local configuration), which is included by Makefile.

Essentially, make and shell support this by themselves, but if, for
example, I wanted to adjust my dotfiles to set the email address once
and for all, I could create the following files:

=2Emuttrc.erb:
----
my_hdr From: brian m. carlson <<%=3D data["email"] -%>>
----

=2Egitconfig.erb:
----
[user]
name =3D brian m. carlson
email =3D <%=3D data["email"] -%>
----

template.rb:
----
#!/usr/bin/env ruby

require 'erb'

class Template
  def name
    @name ||=3D 0
    @name +=3D 1
    "name_a#{@name}"
  end

  def data
    ENV.map { |k, v| [k.downcase, v] }.to_h
  end

  def erb(file)
    ERB.new(File.read(file), nil, '-', name).result(binding)
  end
end

puts Template.new.erb(ARGV[0])
----

and then run:

EMAIL=3Dsandals@crustytoothpaste.net template.rb .muttrc.erb >.muttrc
EMAIL=3Dsandals@crustytoothpaste.net template.rb .gitconfig.erb >.gitconfig

The problem that folks tend to have is that they have a single editor or
IDE project file, such as an XCode configuration file, that can't be
split among multiple files, some of which are checked in and some of
which are not.  Other situations are generating a configuration file for
a web server like nginx in development, which may of course differ
depending on where the user has checked out the repository.

Using some sort of file like a config.mak is a fine solution, but many
programs don't support that, so it's necessary to create a template for
the build process and add a script to generate it.  The actual
configuration values can come from the environment, the user's
gitconfig, a YAML file the user has configured, or anywhere else that
makes sense.

As you can see, the example is large and unwieldy, and would not make a
good inclusion in the man page.  I included that paragraph because Peff
stated that it would be nice if we could offer people a solution, but
I'd rather drop it if it's too confusing without an example.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2/SqAACgkQv1NdgR9S
9otcTQ//dlUlee8Nk46rxA30f46JnDuiSdMyUCS5ougL2pkYHg4j3zQi7n/lyr6P
bh0YSPc1mOgXWB9e0RnfY0PbnBYxbDB8DeHuDj69LTVBdbIQIlQT1Fjxgckon2cE
UTdV6My3XUlZUnxrXfZxyxxJ2DDh5K55lNmb2ndN9/5bqYtI2tXO1rHOhEzSsfhQ
yYkplMmFsofcxSt/SNXvApeyKVVCdEO/N/A4CdiuiKkRR9gbgJITAmmUW9lXSLeA
6ELvBXCBVTabbTVGNYu0tzG7Z84wWiwMkswvZkXMQGOOgLKZcAYMMmsDBLMdF0H1
2/hoNzBP556C2kt9EgC0C8Q4MHOPXjxu+1Smg4+o9Fe5ZTxmvCWGX/iAr021ldCy
Q4v77297ON1IXv5VMZiM35Y5EjVLjlRFOYvxjYaq3p6BE2jBTT7wSowoiuMmeaw0
ixZuj0ItU49lddaBmYLREZ6AMFH6YAttWHOJKbJVDLqB1vU7Jd4a24hD1t07je2g
jVcAgsWcuYKzWlbUKgf0b09WOvmbmNta58+wSc4UF26G91CzJS8b6Axcc5OFuRoQ
r2w00ZkbGF7MOrJm9IAWiO8f1BSmqRCM7NTq2tygaR1sZX7Wv9ciCiZj+7aJVcgQ
j70PBeDRWFTB7aXR2CYkeKBxqanqyJIq+fLSpMH7EkDe7qjKSkM=
=jNFL
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
