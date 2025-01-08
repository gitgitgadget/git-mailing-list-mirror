Received: from mail4.tt-solutions.com (mail4.tt-solutions.com [83.229.82.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40547202C4D
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.229.82.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364610; cv=none; b=cYuF46g1gVSb4j5y58WQsPMg6FpR12TNzw3dyh3KtOGIPA1H7G+E6fGIX8Ta4zoi10huZSo/eoF0i9HqSpUzDsSd0CvM7+BMJkY8WMoKB6O4ly7I00f9d7ChRU0KOMKdrIvKo+2LMA9yvlvnOwu9/dnAu0c6pUWTAvf5xQJdZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364610; c=relaxed/simple;
	bh=b0RCE9qHe5d+xJq2JjjDI8RBcGmGTZyfIVUrOpWmv9s=;
	h=Date:From:Subject:To:cc:Message-ID:MIME-Version:Content-Type:
	 References:In-Reply-To; b=sfYjZWjliMTS0YvoG1h+G6Nrpm0g7CdgBzkMNSPpAk2MYMfdA/5dBrCtHV7JcgZ9TCuiom5+r+ws8MhWx9H58/5rhLzE5GhW/dbCrNQ2sd+wWH2bzG8ZzpPbVzBgwd+8RlXNa0owA6p09JoH8zviDV4dUsXGAglLX4aTIaQ63AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zeitlins.org; spf=pass smtp.mailfrom=zeitlins.org; dkim=pass (2048-bit key) header.d=zeitlins.org header.i=@zeitlins.org header.b=bRzvGf2V; arc=none smtp.client-ip=83.229.82.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zeitlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeitlins.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeitlins.org header.i=@zeitlins.org header.b="bRzvGf2V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zeitlins.org; s=mlr; h=In-Reply-To:References:Content-Type:MIME-Version:
	Message-ID:cc:To:Subject:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gzRiNvAkTvYkbARUpvg2Yiia6C+BMAqYQz15N/CbYfw=; b=bRzvGf2V+Ddv4iqck4aQdBq/7q
	oZPFXfCmB8rcX5E8JdBgX28JhkcWSGMj8Cql4BblavhSW1Atan43ThvIa+P9pxrPkjhwcyG62yPf9
	axyohoUcxsaxiZ1SRKzOsOTrcCkFAwEV8mZMe0llf8xkQ6zbpua33YfHTDKAqP0KCl7CQlZol9bAs
	meggR6G7n5TjpEYqDyZkMYBxPTHEV3PXzwLaDVC5Ng2B3vpnhX5fxlmVgFSxK2OMZZhaJ0Sb2w3k9
	Pe+pP6A2yxjBGg0Ma6Hzb+cZsWJSMQhzs4lxqMnUd70/7VIGr1RYCaieDe4Zf6rdNnRcckx/qIh6F
	xAAs1jOQ==;
Received: from [192.168.17.23] (helo=dark)
	by smtp.tt-solutions.com with esmtp (Exim 4.96)
	(envelope-from <vadim@zeitlins.org>)
	id 1tVbke-006R0G-21;
	Wed, 08 Jan 2025 20:30:00 +0100
Date: Wed, 8 Jan 2025 20:30:00 +0100
From: Vadim Zeitlin <vadim@zeitlins.org>
Subject: Re[2]: Would it be possible to add an option to disable validating submodule paths?
To: Junio C Hamano <gitster@pobox.com>
cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Message-ID: <Mahogany-0.68.0-2854301-20250108-203000.01@dark.tt-solutions.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="8323329-628175011-1736364600=:2854301"
References: <Mahogany-0.68.0-2854301-20250107-230058.01@dark.tt-solutions.com>
    <Z320RGb0tqNyvvxt@tapette.crustytoothpaste.net>
    <xmqq5xmqqk9j.fsf@gitster.g>
    <Mahogany-0.68.0-2854301-20250108-005035.01@dark.tt-solutions.com>
    <xmqqjzb5nvhd.fsf@gitster.g>
In-Reply-To: <xmqqjzb5nvhd.fsf@gitster.g>
X-Mailer: Mahogany 0.68.0 'Cynthia', compiled for Linux 6.1.0-10-amd64 x86_64

--8323329-628175011-1736364600=:2854301
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

On Wed, 08 Jan 2025 08:03:42 -0800 Junio C Hamano <gitster@pobox.com> wrote:

JCH> Vadim Zeitlin <vadim@zeitlins.org> writes:
JCH> 
JCH> > JCH> Sounds reasonable, but I wonder how this would interact with
JCH> > JCH> bootstrapping.  Should it be configured in ~/.gitconfig, possibly
JCH> > JCH> with [includeIf] to specify the directory you'd store a bunch of
JCH> > JCH> repositories you clone from outside, or something?  I guess "git
JCH> > JCH> clone" without "--recurse-submodules" is simple enough to be used
JCH> > JCH> for bootstrapping, and then the configuration can be set at the
JCH> > JCH> top-level superproject after cloning but before "submodule init".
JCH> >
JCH> >  I might be missing something here, but if the question is about whether we
JCH> > need to have any special support for this in git-clone itself, then I don't
JCH> > think so, it's a rather special use case and running git-clone without
JCH> > --recurse-submodules and initializing (some) submodules later while
JCH> > symlinking some other ones is only a minor inconvenience, if that.
JCH> 
JCH> If you say so then I'd stop worrying about it ;-)  I am not a heavy
JCH> submodule user myself.

 Well, let's just say that I'm not worried about it.

JCH> The worry came primarily from the fact that this was reported as a
JCH> "we have been using submodules happily in this particular manner but
JCH> with a new version of Git it stopped working" regression.  Your
JCH> set-up was created with an older version of Git that did not have
JCH> the problematic "defence in depth".  If you or somebody else wanted
JCH> to recreate the same set-up from scratch, would "git clone" that is
JCH> unmodified, other than conditionally disables the check introduced
JCH> by the commit e8d06089 (submodule: require the submodule path to
JCH> contain directories only, 2024-03-26), let you do so?  Or would it
JCH> also need to honor the new configuration that conditionally disables
JCH> the check, and if so, how would we make sure it is read during "git
JCH> clone" (which has kind of special chicken-and-egg problem with
JCH> respect to configuration settings).

 As I was trying to say above, I think it's unreasonable to expect "git
clone --recurse-submodules" to do something extra smart when there is a
simple (both to use and to discover) alternative of just running "git
clone" without any extra options, and then initialize the submodules that
you don't want to symlink manually and symlink the remaining ones.

JCH> > ... Should it be something like submodule.validate instead, perhaps?
JCH> > Please let me know if anybody has any better ideas.
JCH> 
JCH> Is "it MUST NOT BE a symbolic link" the only thing the validation
JCH> does?

 Currently, yes.

JCH> Would there be extra check on top of what is currently there
JCH> that may turn out to be useful?

 It's conceivable that there might be other checks in the future, e.g.
maybe the ownership of the directories or even their permissions might be
checked? Just to be clear, this is pure speculation on my part, i.e. I
don't see any real need to do it, but I can't be certain that there are no
scenarios in which this might be useful.

JCH> If the answers are no and/or yes, "submodule.validate=no" sounds like
JCH> a reasonable choice, but I am not good at naming, so we may want to
JCH> hear ideas from others.

 I'll wait for some time to hear if anybody else has any better suggestions.

 Thanks in advance!
VZ

--8323329-628175011-1736364600=:2854301
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQx+vLQdOwioQqkxtoG6kHeT2wehgUCZ37SOAAKCRAG6kHeT2we
hlHTAJwN+HyPsUaAXaemWZYS8HtUB2tm1QCfeh+VSiSuXvbUEv/Qhez3FCwtxfQ=
=9LQi
-----END PGP SIGNATURE-----

--8323329-628175011-1736364600=:2854301--
