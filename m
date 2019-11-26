Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD68C432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 14:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE462071A
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 14:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKZOvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:51:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:49778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfKZOvo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 09:51:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3585ACE3
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 14:51:41 +0000 (UTC)
Subject: Re: Failing tests on s390x and aarch64 architectures
From:   Marketa Calabkova <mcalabkova@suse.cz>
To:     git@vger.kernel.org
References: <2d7f373f-5cf5-a956-53d7-1e67ba157e9d@suse.cz>
Autocrypt: addr=mcalabkova@suse.cz; keydata=
 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
Message-ID: <94b6452d-9888-a129-78f9-38eb0f03eea3@suse.cz>
Date:   Tue, 26 Nov 2019 15:51:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2d7f373f-5cf5-a956-53d7-1e67ba157e9d@suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8N70CttJdc9AUa8rNWPQYYhXQfY2qZgxg"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8N70CttJdc9AUa8rNWPQYYhXQfY2qZgxg
Content-Type: multipart/mixed; boundary="sgQUpsEz090g502tjSKW4ft45Cbh4CpAM"

--sgQUpsEz090g502tjSKW4ft45Cbh4CpAM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hi,

just bumping this issue up. I found out that the fail occurs from the
very beginning, so from commit [1]. Hope this helps.

Marketa
[1]
https://github.com/git/git/commit/a73f91774cbfb6f31bca328ebf200498fe92d97=
a

On 15/11/2019 14:01, Marketa Calabkova wrote:
> Hi all,
>
> the test "PCRE v2: grep non-ASCII from invalid UTF-8 data with -i" from=

> file t7812-grep-icase-non-ascii.sh fails on the architectures mentioned=

> above (for more distributions). See the attached buildlogs. We are usin=
g
> git version 2.24.0 from [0].
>
> I think it could be caused by commit [1], I am not sure at all. It is
> not caused directly by new docbook5, we had it before 2.24.0 and the
> tests were passing.
>
> Could you please look at that? Thank you in advance.
>
> Best regards,
> Marketa Calabkova
>
> [0] https://build.opensuse.org/package/show/openSUSE:Factory/git
> [1]
> https://github.com/git/git/commit/e0ff2d4c7ec338e30ea5e0340cda7f5fe8a18=
7dc



--sgQUpsEz090g502tjSKW4ft45Cbh4CpAM--

--8N70CttJdc9AUa8rNWPQYYhXQfY2qZgxg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEVtVTyN9tQJ/wHqzxIe7T5Pvt6dEFAl3dO/0ACgkQIe7T5Pvt
6dH7phAAn3zNV6TdJFWWtz0ZgE7duy0/Pxqg6MX2txKXhcw6b4oj3UZM4o34QR0l
T/PPeaiRq6vTxoJDnX/T9b4gIWB7r9iMPAQGSn6JZ1kX1iMzfAwtVahQFzaWxu5B
4eAEazQmTMQFI5Evq8Gzpyawq9R0CQ1uu9MIW3qIZhysCEZlgct7qFRrNrDo2b3s
kzqLZWXuELxuoaA91/Amdb5PoqJjmx62OW3aEd8COppxZAoqi42+SNJZEuz8mIXE
dID5G7/BsU7J6nryMn6x0CwzU6hWCA+hO+GUE9iTJ7wyV9bHbSAvQ7nvsXlfhaGD
jB8IrIbG7bpmOpDO2wcLBINu1blGqYDi4bk3yhfgpTwAS0PlCX775yFBlgIXf72p
KRQrrhXbgwbYJrwOP7Q/JU2Sj8MWTI0NT8LTVEa9iE5qy7zCiD4cEz10IZFomISX
uzsd0U4gWuhT14n0W4pBiqsUfd9pFmLrDc0Pb2ONlSeXcHCJT3sbwPAUJjOijvO0
yWaBLY1ujTIdmr9gqPRL3AOHcUjA54+fbgBMfLtE6L94gnVeGhSrV+pbF2HM9qUs
etededoPzh5iFIjZff+rLzXEMXMAAi3lkS0YYOM3vmE0NonrMOj+L9VJIZbz+mAx
HrkUbuUZEvoE8P3BZ20D0JeA6l2xv1j3WpXO/umuoQeWVWNs/fU=
=I1Te
-----END PGP SIGNATURE-----

--8N70CttJdc9AUa8rNWPQYYhXQfY2qZgxg--
