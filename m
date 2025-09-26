Received: from smtp122.ord1d.emailsrvr.com (smtp122.ord1d.emailsrvr.com [184.106.54.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6145DDA9
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846406; cv=none; b=TJczfdgxi5fzpq6950xVVG7duyHSB8S20L10U+Vi2zLLuQoqjFdy+RyD51ot3pO/tMDq+jlddCTIFYXlFmg1PAl3rHXgqNN4iXerP2zqhcyGdYSn/wdQLS3yzp/jlLZzsmgerJQ5t2+C6KptLCDU7Eb9vC9W8b5dSlxtsseZFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846406; c=relaxed/simple;
	bh=SQoYIXVx2l73aKU/TcQHSIMiyBfEDZ4oMbGMao1TWA4=;
	h=Content-Type:Subject:Mime-Version:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=J+GltZsdpSaaiQz//Zeyqwi7nTsUqPQAKdi8r7ep48n3RV2kx32S/dKTfUVm3pndhzo7nry+SBXiHbH8iTUl9nmVGrTLk9FujSdcFLOjQROm1HN5mr4BoPl2ZxjqN0gF2SC/3C0DLiGwgVAuQX/OoIzXyw1i+vfY6pSaSyaStMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=electrooptical.net; spf=pass smtp.mailfrom=electrooptical.net; dkim=pass (1024-bit key) header.d=electrooptical.net header.i=@electrooptical.net header.b=mSI+S7D+; arc=none smtp.client-ip=184.106.54.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=electrooptical.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electrooptical.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=electrooptical.net header.i=@electrooptical.net header.b="mSI+S7D+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=electrooptical.net;
	s=20230609-lhoc62o1; t=1758845435;
	bh=SQoYIXVx2l73aKU/TcQHSIMiyBfEDZ4oMbGMao1TWA4=;
	h=Subject:From:Date:To:From;
	b=mSI+S7D+5U132Tcyn7nuyfMUdL8Q+4pgCqqgyQB8aGxlAgH8boJPGLhwr5IrA709H
	 NhBa0oO94gxft+4iF2gMhR4puIHR22VRjOm/Q+TmFdLfEDthcKXbDInWmRTYDNvdVZ
	 IzqLrv1ckc2LcrG+HvJmAGrHVYkGnYhjT2/ubDj4=
X-Auth-ID: pcdhobbs@electrooptical.net
Received: by smtp16.relay.ord1d.emailsrvr.com (Authenticated sender: pcdhobbs-AT-electrooptical.net) with ESMTPSA id 11E8C402A0;
	Thu, 25 Sep 2025 20:10:35 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: whatchanged is super useful!
X-Apple-Notify-Thread: NO
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
X-Universally-Unique-Identifier: 786E8540-60BD-4EC5-A9C1-24E6F71EB0AD
From: Phil Hobbs <pcdhobbs@electrooptical.net>
In-Reply-To: <1c5581eb-ad69-4a18-b798-c54344a4208a@app.fastmail.com>
Cc: git@vger.kernel.org
Date: Thu, 25 Sep 2025 20:10:24 -0400
X-Apple-Message-Smime-Encrypt: NO
Message-Id: <72711D1A-020F-4B63-A72E-5DD46A7A7EA6@electrooptical.net>
References: <1c5581eb-ad69-4a18-b798-c54344a4208a@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPhone Mail (22G100)
X-Classification-ID: ca98d638-3d79-4278-a332-eb7084df4c86-1-1

Fair enough, thanks.=20

> On Sep 25, 2025, at 17:55, Kristoffer Haugsbakk <kristofferhaugsbakk@fastm=
ail.com> wrote:
>=20
> =EF=BB=BFOn Thu, Sep 25, 2025, at 23:44, Phil Hobbs wrote:
>> I use git whatchanged all the time.  Please don't remove it!
>=20
> It might be useful but everything it can do, git-log(1) can also do.
>=20
> You can replace it with `git log` like so:
>=20
> =E2=80=A2 Given: `git whatchanged <opts>`
> =E2=80=A2 Replace with: `git log <opts> --no-merges --raw`
>=20
> Or you can replace `--raw` with more modern alternatives like
> `--name-only` or `--stat`.

