Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A496DC11F66
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D39461C81
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 13:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhGGNcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 09:32:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37860 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231743AbhGGNcN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Jul 2021 09:32:13 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8594E60450;
        Wed,  7 Jul 2021 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1625664572;
        bh=5Z4/Hp4G3+m+tC9JM9EWlaJdzGy4Rn/0efi3Yqut1po=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=S3f6QQyea3XL++dMLFL7Q4LVXz0xY2VjqoHUZTbSTzeIp/XT2V4jLU3S/tlpkX9fI
         EjUjhf8d9CXCWwxzGXwXMRWZ9XFiXN3lj4iNnVjKifufODASREkQdJ2f13YsXg4kig
         oyt41iulc5qu16p6CebO6XyYEqkYRjQgU1Ta4kG+wBzbkibN7IRj4TU+xuRAkH8lqX
         eIXh0Rni/8f9fPjZf6ukkvzL3ta9l7NJGRC35+9/aUiNXbnY2oP6OPdQJFeqpc3VCU
         NJnI+uwAvM9LHxNSlbhouzZ+MBh+ZmUDpGQKv2q4MkWXvVuaCmstUzYPfs2eTCX6HH
         1Ywup6gktAy9SBCueqTB2cCmyTB9tqczP+KEqTXmsmC4wMesYrfAx0hdChGkqmqJ4D
         xJPtIqO/AfqMCwPysa5Ozo/l9kTv1AjQ0egHmsGbzd/mNpV3Nox0n4oqvBry5VKzBf
         AUiZ9Z90oP1Fhig8q2zMMHxaa555uRHtAUo59O1kld6V8tL905d
Date:   Wed, 7 Jul 2021 13:29:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Aaron Hall <aaronchallmba@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Default ssh command
Message-ID: <YOWsNk4GqNUPyHD5@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Aaron Hall <aaronchallmba@gmail.com>, git@vger.kernel.org
References: <CADrEZfE+LuDnhWkRHPMwHq7aGYcvDeqken8uZzPgHREtf0iqjA@mail.gmail.com>
 <xmqqczrugahy.fsf@gitster.g>
 <CADrEZfGHAi=Lr6QMsJbXGy1Rs9VDzTVxQPNH4xHHj6ataEAvVA@mail.gmail.com>
 <CADrEZfHJZT47nNZJ8v2T4vOJkMN7ccaai6DKdzFLF8Zoc42hWw@mail.gmail.com>
 <CADrEZfEVbtbovTbFM2BEuK_cWp4jcV3CZyrzasvsvFbuu1rmWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w22Fog/0l9zM/GF3"
Content-Disposition: inline
In-Reply-To: <CADrEZfEVbtbovTbFM2BEuK_cWp4jcV3CZyrzasvsvFbuu1rmWg@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w22Fog/0l9zM/GF3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-07 at 02:13:34, Aaron Hall wrote:
> > When we use ssh to run the receive-pack over the wire while pushing,
> > we do not ask for pty, and because the "-e" option to set the escape
> > character is meaningful only when ssh runs with pty allocated, you
> > shouldn't have to do this, unless you force pty allocation by
> > e.g. passing "-t" yourself.
>=20
> Then I wonder why I'm getting a pseudoterminal.
>=20
> Note that I'm using git from git bash on Windows in a walled off
> corporate environment.

Do you maybe have RequestTTY set in some SSH configuration file, like
~/.ssh/config?  You can also run "ssh -vvv HOSTNAME" to see if there are
any config files.

For example, if I do "ssh -vvv git@github.com"[0], I see these lines:

  debug1: Reading configuration data /home/bmc/.ssh/config
  debug1: /home/bmc/.ssh/config line 44: Applying options for github.com
  debug1: /home/bmc/.ssh/config line 67: Applying options for *
  debug3: kex names ok: [sntrup4591761x25519-sha512@tinyssh.org,curve25519-=
sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,e=
cdh-sha2-nistp256]
  debug1: Reading configuration data /etc/ssh/ssh_config
  debug1: /etc/ssh/ssh_config line 19: include /etc/ssh/ssh_config.d/*.conf=
 matched no files
  debug1: /etc/ssh/ssh_config line 21: Applying options for *

That tells me I have some configuration for github.com (and for all
hosts) in ~/.ssh/config and some for all hosts in /etc/ssh/ssh_config.
It doesn't tell me what they are, but I can look in the files to see.

Also, you may wish to run "env | grep '^GIT'" to see if anybody has
configured the GIT_SSH or GIT_SSH_COMMAND variables, and check with "git
config -l --show-origin" to see if someone has overridden the SSH
configuration.

> The ssh manpage says:
>=20
> > If no pseudo-terminal has been allocated, the session is transparent
> > and can be used to reliably transfer binary data.  On most
> > systems, setting the escape character to ``none'' will also
> > make the session transparent even if a tty is used.
>=20
> If we want the ssh to be binary transparent regardless
> (and I think we do) then that makes my suggestion,
> `ssh -e none`, still perhaps a good one?

The problem is that on some systems "ssh" is something other than
OpenSSH and we will likely break those systems.  That doesn't mean we
can't do it if it's necessary, but it does mean that if this is a
configuration issue, it would be better to fix the configuration if we
can rather than potentially break systems needlessly.

This problem will also occur for tools like rsync and various other
programs which expect the standard behavior for the ssh binary, so
making a change here in Git is also not the right place if we can avoid
it.

[0] Chosen simply because I know it works, it has configuration on my
system, and it's publicly accessible.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--w22Fog/0l9zM/GF3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYOWsNQAKCRB8DEliiIei
gQQoAQCXG/SK4dfRDcVXb41RP1a3u5ibiyX9rcp67IfqCx2uyQD8DDEy+AkCEt8G
gsQ6MTZdi5G20r9zlubGD2M9LAmgWQ4=
=/VpL
-----END PGP SIGNATURE-----

--w22Fog/0l9zM/GF3--
