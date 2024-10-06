Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8F189F3F
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728254504; cv=none; b=PQo2E3isYx1XoanP+Kyeu7MamLxg61loj63TYZSoxI+DBkcMfjNF69Epg5Us4vWIVE9oVNty+IuC+GOGj4cw4Hvp8CEIJla+oAMPTepSql2MnAwXTK5+5btToGNWNIAntNQT93pc/pgNt9LmFwbqGrlYUvNg+POS0qtwacNrD7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728254504; c=relaxed/simple;
	bh=/h9DsE+nlj8zLkbppDf0sY/VwCAvFUmmISXtszt6cFg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oULawPndws9fGQTgmPoH6IQQZKLRbMiBnKns5FPitNPDC9Bq1Q+AQaQv+SIrs+jGwcQKJqZnUd8LGn1CLfXmAGAm5aS0VEN/1a1lBYAJ8RiqpWhkwIc35JsUj277/uO++25zcfwmWX2LdvpoFXVpCsE1y/UArHda13MjIy4DSpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=XMy+4mc6; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="XMy+4mc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728254497; x=1728513697;
	bh=/h9DsE+nlj8zLkbppDf0sY/VwCAvFUmmISXtszt6cFg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XMy+4mc6d62VKx0/2Cs0Uvewxyc3BdxbasBtPzuIsZOoHIL1hGnOIm8J5I/LRimzD
	 7RpXtzm9LfQIlusMjFR9HnIu5hDRCK8fmwPXC7Lbwun3gZHbxSExnfPQnlu+e4/HSq
	 S18kmNNYXFWvZ1dnedAKKvn3YZefu445t+Ng9tcAa2/9BeolIjbcUc7eZm6C9U21tR
	 AmkDcqP57LcGs96HD93FSBXgC83WWlJ5GxP2V7rVMCn3NniN1+tmRUj/74rP3PjfNs
	 vnr+V5vhabwoJS41C3VmkUZmy2Pby24dDQqWYo0Qbqkn4XC1EEBuA3SflNASTGVJwc
	 RVT26N29+dgrQ==
Date: Sun, 06 Oct 2024 22:41:33 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] worktree: sync worktree paths after gitdir move
Message-ID: <YYay6Jp5c84h3Tx-LViX4teN5KSBX5PL3_WcOFRzUooFrpJpcBD2SRWf1EQjvrMZsI6zkKyPd7JbWt3Ed3OIxCdkg17fY2qvmT4-B6a0RAE=@pm.me>
In-Reply-To: <CAPig+cQApvzpuCBfViPD_hJjqe_poFO8uB1GapeVpCd2EWvEug@mail.gmail.com>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-4-cdwhite3@pm.me> <CAPig+cQApvzpuCBfViPD_hJjqe_poFO8uB1GapeVpCd2EWvEug@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: a28ecd87f47c696f8d7e6efcc77e533c680f2b36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------02bed41526f93ea2d369f2992508f124af7fd89812a616fdc505858cbeec40ab"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------02bed41526f93ea2d369f2992508f124af7fd89812a616fdc505858cbeec40ab
Content-Type: multipart/mixed;boundary=---------------------a74c4840eac0370fc7f6cf86ef75e115

-----------------------a74c4840eac0370fc7f6cf86ef75e115
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 06:12, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> If I understand correctly, this patch is fixing breakage resulting
> from the preceding patch. Unfortunately, this approach is problematic
> since it breaks bisectability of the project. In particular, it's not
> sufficient for the full test suite to pass only at the end of the
> patch series; rather, the entire test suite should continue to pass
> after application of each patch in a series; we don't want one patch
> to break the test suite and a subsequent patch to fix it again.
>
> So, if my understanding is correct, please put some thought into how
> to reorganize this patch series to ensure that the full test suite
> passes for each patch.

Yes, there was one edge case that broke and this patch fixed. But I
understand what you mean about the bisectability. I was trying to come
up with ways to split up the commits and this seemed like a good spot as
it just introduced new functions with minimal changes elsewhere. But
this can be squashed into the previous patch.
-----------------------a74c4840eac0370fc7f6cf86ef75e115--

--------02bed41526f93ea2d369f2992508f124af7fd89812a616fdc505858cbeec40ab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAxIMCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAACtNwf9FJGeQ774FWwp68QozuseuEmubYIjQGXZSqIxBEODMXdLcBM+
L9/71mUXxJcty6rh3UhoMUKXV8zMn+nvAhrIRXEsENt4172xwzGEh/9Ki1Pc
sRGrn6gcU2xSEgTODNMHrhnfVKUE96C50952iTDLY6ymHImSMG3M/gC10IBt
WnP8urpJSLsFdmzwaYOmBw79d+N+/sSp4sKHXFFeP7mkzdykPbWdKvdlWX7Z
N0cjy6gCjqXsaG2cZ91i2VnhAbrMZsCJ4Wt+/Nl98foEpdzvWsXmQ7ehbO++
a3MPd7GmcfEhik8O+ZSYR263jCeTuKwawUsu7NwbfzCeFGjwuHTI+A==
=YMve
-----END PGP SIGNATURE-----


--------02bed41526f93ea2d369f2992508f124af7fd89812a616fdc505858cbeec40ab--

