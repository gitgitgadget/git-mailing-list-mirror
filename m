Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8AEF1FAFC
	for <e@80x24.org>; Tue,  7 Feb 2017 00:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbdBGA54 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 19:57:56 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35065 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdBGA5z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 19:57:55 -0500
Received: by mail-qk0-f181.google.com with SMTP id u25so73231358qki.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 16:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jWIWVADlSPH7squY2+D2cLtRp86rJIaIkFFQeYPvSRk=;
        b=YBcoNm4tzkgf9a6AIbBa62VSEGa++Cn3eVLAC2USJR85ic4XPGB/nDjZFGns3Ifokb
         /lFy05mU8WaC/scxIlqmXIwUHyAJ4D2aILulp6VQl2g6hpNR3Jj6Li/AGc8cIwPu4lRi
         Nk3ErI0gWj8alVtS+AmgUgysbaLGvT6FYxh5QWSGa59PxSXTCOHa6MNG9HPAnW6Q6mgs
         Pd5kD7AEPCa3GgcX0j70ilG712Z8t4MGxNE2UQM45VARLhW9ELONjsWrK80Rr3ddxo9v
         JRw1i6YjGSuzUrI0KylVBfhI4an8YUhK3V1fX/dwMzUf0eSG0+PpZqYKjmppjCpJlqo2
         MqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jWIWVADlSPH7squY2+D2cLtRp86rJIaIkFFQeYPvSRk=;
        b=mlnCkUSlMR6QzLFfnTX5cpGNnHUfZIqtKbidyrxLUsIrEiiYcEg8HEy4YYM+/VEC7Y
         opiRRNZZiHMS5AMQOmyXJs/RhCXfWvxxnLaYrn1oMvTVDb+8q1w8XTU3Jouy8tUtg1f5
         RFJHU/PljMUAl2HCxZBU5fNU9axSNDFabFTM6Zt4Y3o6tQg5Vu+iPS+FLbsmlXWeNT9x
         uuocXRN8EdOr1h9wuYcPhfGgvM2+Oqojq7GACZma8/6zVU8TsNqoQZVEdhamVjjxLVwo
         uQTvAtWMUP3xbc7yb6jIJE0+mS+ZY26RAG+c8mosTRfj9nsBOKoYXN3fX3Ux9UU1i/9h
         hB1Q==
X-Gm-Message-State: AMke39nGfd2s18Mn0ntBoYnKX4B3v43a0z2AJreKfB+50W0OTuI6/VpszBJBfu5ErOYpVdFk
X-Received: by 10.233.239.17 with SMTP id d17mr11540451qkg.13.1486429073914;
        Mon, 06 Feb 2017 16:57:53 -0800 (PST)
Received: from LykOS.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id e3sm2004340qtg.7.2017.02.06.16.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2017 16:57:53 -0800 (PST)
Date:   Mon, 6 Feb 2017 19:57:52 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Paul Wise <pabs3@bonedaddy.net>
Cc:     git@vger.kernel.org
Subject: Re: idea: light-weight pull requests
Message-ID: <20170207005751.cgrpwuvtljfgnntb@LykOS.localdomain>
References: <1486427537.16949.42.camel@bonedaddy.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kiqa6iffzjt6rzpe"
Content-Disposition: inline
In-Reply-To: <1486427537.16949.42.camel@bonedaddy.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kiqa6iffzjt6rzpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello, pabs.

IMHO, the notion of a PR/MR is more specific to Git repository
management tools (e.g., GitHub, GitLab). They all have specific
concepts/ways to manage the way how their hosted repositories behave ---
and I believe this flexibility is one of the beauties in Git . I could
see how this could be implemented by tools like this rather easily
(e.g., using symlinks + inotify or something less hacky).

I'm wondering if standardizing this would be more interesting to those
communities?

I would like to see what becomes of this.

Cheers!
-Santiago.

On Tue, Feb 07, 2017 at 08:32:17AM +0800, Paul Wise wrote:
> Hi all,
>=20
> I had an idea that might be interesting to git folks:
>=20
> light-weight pull requests:
>=20
> Anonymous and ssh/http-identified users should be able to push just
> using git, within the refs/pull/ namespace, to any non-existent branch
> name or to a branch they created when previously identified, without
> forking off a new repository.
>=20
> Advantages:
>=20
> Removes the need to look up who to send the pull request notification
> to since configuring that is up to the project itself.
>=20
> Removes the annoying scenario of having lots of remotes that have been
> removed after the corresponding pull request was closed.
>=20
> Moves popular git hosting services from primarily a model of forests of
> forks to one of contributions to well maintained ongoing projects.
>=20
> Allows users to use their preferred git clients to issue pull requests
> instead of using web interfaces of popular git hosting services.
>=20
> Creates a new standard for contributing to repositories on all git
> repository hosting services.
>=20
> Contributions from people without an account on those services are
> possible.
>=20
> Contributions from people without any git repository hosting of their
> own are possible.
>=20
> Contributions from people who don't use or dislike MUAs are possible.
>=20
> Disadvantages:
>=20
> Pull request spam, could be mitigated with configuration options.
>=20
> Extra configuration and complexity on the server side. This is once
> only and means less complexity on the pull requester side.
>=20
> Will not work with typical setups where the git/http/ssh user does not
> have write access to the repositories. A workaround could be some sort
> of hybrid-repository setup with the new refs and objects in a second
> repository which would be shared by all pull requesters.
>=20
> --=20
> bye,
> pabs
>=20
> http://bonedaddy.net/pabs3/



--kiqa6iffzjt6rzpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAliZG40ACgkQRo8SLOgW
IpVLeg/+PNeLKrBnYRr91TmeEkreZlus9CiQHyWx8gMZr/DtI0my+xNfQmYNCwn7
kP5aqXUllZxTwXJOwcPnSAqVfcxa12TTeZ6hMBt6LL52wtZrVpTaZQUIq5ekE6cL
92wYWTHi/RhVqyCjgLX8qNnSVjfgNRXAm6z5nzbDmcD1TWkVDEc9aI+2sF7YDybn
noWNbWjUnxKh9PQfI9LtVy950DqdbN7rUskFvQTiyDsO5J8btdfsxgxUOcp41Fwf
s55gW+gb4SfyTkTLZbkblfw9VAIarmYinEb0et+l7gvKSQWvWI610FNnsD7aYJ6L
VGmTs7UC9DPde2HLHo28Yg1K4dqjOpbM6DRDS8f/n1w7k3P8i5wyUrmQbwrRehRi
EyQKP+XCLMnaQl6GD874n7SkmgJa1wvhBbr4V5OzFUguhvE1nBABoKkSzturNf4J
uof/qgbQi4autYa43AwN4E6IxWp/FNOWFl+k33ctTOiVn2qdx7Yb40xTJysaZk4/
pyov6MKS5HpyEXCVzsRS+VgBaEzsGTF7xo3ogYuojE9ykLquTqjXxi1CdxDwlHiT
Ug7B24MHEQRAKIoK6P6vjzxDzw5sy96luTxGNUOTOu23ZBsd57Ujv/1rYE1qSr7u
uM3HbxNq2+xe9+FlY7Rsg61M3iCyGTHPF8PGudWPCr2DRevKR0I=
=f/pq
-----END PGP SIGNATURE-----

--kiqa6iffzjt6rzpe--
