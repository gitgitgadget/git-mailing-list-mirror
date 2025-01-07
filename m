Received: from mail4.tt-solutions.com (mail4.tt-solutions.com [83.229.82.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216E1F75B3
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.229.82.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293841; cv=none; b=YiQ1+wrj7hf6oy9mLrwxEccSVfFXB+Sakg3HID1WBVeQF/YHdMt04qsbOZYTHSc0Nl2e6HyNZ8ZLdxj91v8V4Hycp573h3tZ81CrRFxvygqdWhpNW6rshA4YqW3EHSHYhy5eXJpnD2dXLLny0DqXrABZp6orLPC7bb2w/9DWB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293841; c=relaxed/simple;
	bh=qDbOOE26sIo3eXGOkoSwf22J4MFq91H3p7ZaSSuHe9o=;
	h=Date:From:Subject:To:cc:Message-ID:MIME-Version:Content-Type:
	 References:In-Reply-To; b=LDHJeMiu2UL9hvMQRbd4DjLB+UKjNl7//RHZInYQ60H84Y00cTJsB5fr1A+nhxsYnme7LYzQZJ2uwR3QspGUXRkTNB3g4ass37tETQ7C7D/L2/siQOxTtMxnQCplMPZKAGIRfBYmAQsahMihCKH/cUc/GfW5aPHJLc+jutTFPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zeitlins.org; spf=pass smtp.mailfrom=zeitlins.org; dkim=pass (2048-bit key) header.d=zeitlins.org header.i=@zeitlins.org header.b=bBU8DMUz; arc=none smtp.client-ip=83.229.82.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zeitlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeitlins.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeitlins.org header.i=@zeitlins.org header.b="bBU8DMUz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zeitlins.org; s=mlr; h=In-Reply-To:References:Content-Type:MIME-Version:
	Message-ID:cc:To:Subject:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+fTc60HIa0QEBuLY3cLHiWN+rnVZv95vqSZmXqqUUrk=; b=bBU8DMUzN2cSQfzpUmuGKS/u3X
	/BMZe38obZkpS0i62VDUQT6VPA/yRHVUGnUHwY/FVjM27Jsbzz9AOEqxxbXCk/cRdb6dfFl3K8tuU
	OS3uEeZl7V6bfPHuUEg/Vhr0JkAa2FYfIm+jdIO7oDPtx1i/xRc4vaKlaeXF7M+yAKkWSWWRadHk5
	zFRfDosZachcyeBxy9Ci1PCUgNzaIJZZrNNKRQ48OTecpOhvIeeoonWL9wUpEj3PsFmmBfZP+zpaj
	fSTlw7oU8quffoFFx5frle34YkluS2nHUzxGQsRQVHK9uUpZ8Xtw2MNe3xk9l43P8wBPOJdP7vTMw
	5ZR65NYA==;
Received: from [192.168.17.23] (helo=dark)
	by smtp.tt-solutions.com with esmtp (Exim 4.96)
	(envelope-from <vadim@zeitlins.org>)
	id 1tVJLH-005rfO-2F;
	Wed, 08 Jan 2025 00:50:35 +0100
Date: Wed, 8 Jan 2025 00:50:35 +0100
From: Vadim Zeitlin <vadim@zeitlins.org>
Subject: Re[2]: Would it be possible to add an option to disable validating submodule paths?
To: git@vger.kernel.org
cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <Mahogany-0.68.0-2854301-20250108-005035.01@dark.tt-solutions.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="8323329-1101513929-1736293835=:2854301"
References: <Mahogany-0.68.0-2854301-20250107-230058.01@dark.tt-solutions.com>
    <Z320RGb0tqNyvvxt@tapette.crustytoothpaste.net>
    <xmqq5xmqqk9j.fsf@gitster.g>
In-Reply-To: <xmqq5xmqqk9j.fsf@gitster.g>
X-Mailer: Mahogany 0.68.0 'Cynthia', compiled for Linux 6.1.0-10-amd64 x86_64

--8323329-1101513929-1736293835=:2854301
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

On Tue, 07 Jan 2025 15:25:28 -0800 Junio C Hamano <gitster@pobox.com> wrote:

JCH> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
JCH> 
JCH> > Since this is a defense-in-depth change and it seems to have broken a
JCH> > reasonable workflow, I think adding a config option for this would be
JCH> > reasonable.  We've recently had some discussions on trying to limit the
JCH> > defense-in-depth measures we implement on the security list in the
JCH> > interests of allowing better discussion and feedback on the main list
JCH> > and avoiding regressions in people's workflows, and I think your email
JCH> > lends support to that approach.
JCH> 
JCH> Thanks; I was writing my own response and said pretty much the same
JCH> thing as above, before I saw this message.

 Thanks to both of you for your replies, I'll try to come up with a patch
relatively soon.

JCH> > I'm not presently planning to add such an option, but it shouldn't be
JCH> > too hard to add a global variable for that (or maybe something under
JCH> > struct repository) that's updated when parsing config, and then check it
JCH> > in `validate_submodule_path`.  We'd need docs for that option as well,
JCH> > but that would probably be it if someone wanted to do so.
JCH> 
JCH> Sounds reasonable, but I wonder how this would interact with
JCH> bootstrapping.  Should it be configured in ~/.gitconfig, possibly
JCH> with [includeIf] to specify the directory you'd store a bunch of
JCH> repositories you clone from outside, or something?  I guess "git
JCH> clone" without "--recurse-submodules" is simple enough to be used
JCH> for bootstrapping, and then the configuration can be set at the
JCH> top-level superproject after cloning but before "submodule init".

 I might be missing something here, but if the question is about whether we
need to have any special support for this in git-clone itself, then I don't
think so, it's a rather special use case and running git-clone without
--recurse-submodules and initializing (some) submodules later while
symlinking some other ones is only a minor inconvenience, if that.

 OTOH I've realized that I have no idea how the new option should be
called. I had initially thought about "safe.submodules = bool", but I'm not
sure if this is really consistent with the existing safe.xxx options which
look and behave a bit differently. Should it be something like
submodule.validate instead, perhaps? Please let me know if anybody has any
better ideas.

 Thanks,
VZ

--8323329-1101513929-1736293835=:2854301
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQx+vLQdOwioQqkxtoG6kHeT2wehgUCZ329ywAKCRAG6kHeT2we
hkvOAJ46a0n5jHBEQx6BZJX3jMj+ENbRMwCgjlACxkZlf+hn2JSnLq55nTFuRMY=
=0fJm
-----END PGP SIGNATURE-----

--8323329-1101513929-1736293835=:2854301--
