Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4921FAFC
	for <e@80x24.org>; Tue,  7 Feb 2017 00:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbdBGAvo (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 19:51:44 -0500
Received: from ns1.bonedaddy.net ([70.91.141.202]:39256 "EHLO
        ns1.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbdBGAvo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 19:51:44 -0500
X-Greylist: delayed 1144 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Feb 2017 19:51:43 EST
Received: from ns1.bonedaddy.net (localhost [127.0.0.1])
        by ns1.bonedaddy.net (8.14.9/8.14.4) with ESMTP id v170WSlu026565
        for <git@vger.kernel.org>; Mon, 6 Feb 2017 19:32:28 -0500
Received: (from pabs3@localhost)
        by ns1.bonedaddy.net (8.14.9/8.14.9/Submit) id v170WSnS026562
        for git@vger.kernel.org; Mon, 6 Feb 2017 19:32:28 -0500
X-Authentication-Warning: ns1.bonedaddy.net: pabs3 set sender to pabs3@bonedaddy.net using -f
Message-ID: <1486427537.16949.42.camel@bonedaddy.net>
Subject: idea: light-weight pull requests
From:   Paul Wise <pabs3@bonedaddy.net>
To:     git@vger.kernel.org
Date:   Tue, 07 Feb 2017 08:32:17 +0800
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4lSPfwpYTWNFu3o/x8S4"
X-Mailer: Evolution 3.22.4-1 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-4lSPfwpYTWNFu3o/x8S4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I had an idea that might be interesting to git folks:

light-weight pull requests:

Anonymous and ssh/http-identified users should be able to push just
using git, within the refs/pull/ namespace, to any non-existent branch
name or to a branch they created when previously identified, without
forking off a new repository.

Advantages:

Removes the need to look up who to send the pull request notification
to since configuring that is up to the project itself.

Removes the annoying scenario of having lots of remotes that have been
removed after the corresponding pull request was closed.

Moves popular git hosting services from primarily a model of forests of
forks to one of contributions to well maintained ongoing projects.

Allows users to use their preferred git clients to issue pull requests
instead of using web interfaces of popular git hosting services.

Creates a new standard for contributing to repositories on all git
repository hosting services.

Contributions from people without an account on those services are
possible.

Contributions from people without any git repository hosting of their
own are possible.

Contributions from people who don't use or dislike MUAs are possible.

Disadvantages:

Pull request spam, could be mitigated with configuration options.

Extra configuration and complexity on the server side. This is once
only and means less complexity on the pull requester side.

Will not work with typical setups where the git/http/ssh user does not
have write access to the repositories. A workaround could be some sort
of hybrid-repository setup with the new refs and objects in a second
repository which would be shared by all pull requesters.

--=20
bye,
pabs

http://bonedaddy.net/pabs3/
--=-4lSPfwpYTWNFu3o/x8S4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAliZFZEACgkQMRa6Xp/6
aaMtyA//U7YMJf+l3bguUqV0K5PNd2X00bxSxVRARc2Ni/J+7Lty4mbGcpYrn79S
U7+ieC44a8GJY7btJ4ZnnC2wxbJQWTaNZZyvV9vanihga6AwoI/hsT7c8Ly68zSM
0CWFuI9JL3rg9WySnJm7LB39guVoyoTk5xGGgh5YFYImlzLt5qR8CjfoAw3Z7Odp
z861OKD8i4is24zXFKCbgBEF/fAZv3+f8HWqicrd3BmnOoHgPi5UbqK9TX32eWem
0lK8bDIJlfL8B2O2G5zCab8VHs88wu5WjEFU8Q9G1U0JdFRqYVKulNkr3A853Qdy
ebNKjZK/Vdugj7VK+8abaLWzaFkA+NF/E8cwW27jhWZZiaXGF3Is4eubi0tkPsiC
pLa++FPwephP4VN8LTgEL9+HHSRSuEotzb5/TMc6EQ65oeQN5p5ocScXCdgoZJMw
hIkHEt9gFnZFsOhMnAulWcr47XJNurd+OAn2F3XGqrm0GWuo/jQ4eT9MCC0hp2nH
bUvjdbZFrOiuWguKA6my5gpsx8LbFSIDtLmIIf2cWsoYERZKP/RzEOzUogWl5ubp
Sb0AZtvUIoSZPzpHJabQf5c6nMraw6Um5pkimghBdkjh05UPAnzEw2ifxJxGCogZ
QedhuNXUcCbplbBKr8roDjPt5ihGUmYnFXQ2gDXLipASrcwBE4k=
=K/Ly
-----END PGP SIGNATURE-----

--=-4lSPfwpYTWNFu3o/x8S4--
