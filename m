Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AA2DEA6F
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177676; cv=none; b=Yhfn8auoQqVPUOhD1IIBqB8ulbTqq57Dcz7dbx/DhyLG6E5D74U71k4n/Te/YEj2r7HYXZy9wEAGAAzK2kthPDTK5PK/9uIknJ2ihFZtq5EydXiZiGidwP1veIWn7gIfQmasSgNWluiXjhNXgXPUI7aeVmATfV9S6nEVFAJKl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177676; c=relaxed/simple;
	bh=TP+a3hN4f4J8xDFdWiFf8zgyv+RSJzZkO2J4BOzzV9U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YmYGk8oZjLBOZMhLLaRaMsy3u07nUG3j0m3wpL4yUQCPaXx8QZTAxvpmxn8TLdgD7UPH4lTiWjITGyttxoaAzdLBsz4zPUHg5fSDJj9XbITbvAKFgnvH3nLy7LiTBv3uNBPmh3hXgMBOFVWylr5DTbmo608j/x13UMtTxhKX0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=WiHZ+68g; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="WiHZ+68g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753177671; x=1753782471;
	i=johannes.schindelin@gmx.de;
	bh=TP+a3hN4f4J8xDFdWiFf8zgyv+RSJzZkO2J4BOzzV9U=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WiHZ+68gXIIF3UE+jcoodRhGFw/SAky7SEENjfL25xaRPuZ80iz85POgPvi1rkg2
	 khelt930S2ziGTSlftVdLYKWDkM/k4InJsbwbmAfGrtc9uQZww7eW8run5XjcghVb
	 eGtwde/rDRQ29ipG6Y7KjPkzByF9Jb1m8LE193znHEGG7DRISeaH6qiAKHzcvYLWM
	 i1YXcOn9CcWWrn7tH0sGYWFic5e2tNN46FS2O916rViSnj7gpG41H0toYSsXzXMET
	 rD5a9/upK4DrpQJZqHbkaoIIG9N+G5rO/+upYmbT9eTrGWbfKfcyk39nrSkTxBEv8
	 aMwwyZ1JDwU4e+olYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.49]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCb5-1u91wF3smH-00KFHT; Tue, 22
 Jul 2025 11:47:51 +0200
Date: Tue, 22 Jul 2025 11:47:49 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: James Gao <thehighmountain25@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Bug report: latest (2.50.1) x64 version of Git for Windows
In-Reply-To: <CA+=FFpNPLEYsajBZqhxhnD3-642t=qQribO+oNDF5-3hhuxDnA@mail.gmail.com>
Message-ID: <865894a2-ed71-5a03-a708-585cbb591ce7@gmx.de>
References: <CA+=FFpNPLEYsajBZqhxhnD3-642t=qQribO+oNDF5-3hhuxDnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bNlW3CH24HgNAjYMYmydhsV2Ui/eGiJPEqwkiEs88c8EQBsSlIn
 C0I9c6R5XW+OjHlsHVkRgtGzgT8aoTf1MB/ukoZkOwXAhA6lvav1SNqQVydgHylMULn+pla
 89585RH621Z/koBRUro19U0PsMvC6OuiPLFip8ANVYD8vef2mbp7/cJY8qetEp6LD5NQ71M
 lDMgEA2D7wKjujtdLQNIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KKofj4a6QJQ=;yGSm09H84snkxqRsZtwDbtyCvJn
 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
 Vf/cGujvCXsOEjmC7NRy5dZVO89Wl/2E=
Content-Transfer-Encoding: quoted-printable

Hi James,

On Mon, 21 Jul 2025, James Gao wrote:

> I just installed my system, and downloaded latest (2.50.1) x64 version
> of Git for Windows and installed it.
>=20
> I am on Windows 11 Pro, 10.0.22631.
> Git CLI is not getting permission to the folders.
> For example, I cannot run git init - error: couldn't set 'HEAD'

Is this the full error message?

> I cannot git pull or clone or git add
>=20
> It returns me similar errors:
> error: unable to write file
> .git/objects/36/dd1796da4dcbb2f53005b64afeef698cfaf510: Permission
> denied
> error: src/helpers/schedule.ts: failed to insert into database
> error: unable to index file 'src/helpers/schedule.ts'

This suggests that you somehow have successfully created a clone... how?

> I tried running git bash as Administrator, still not working.

That is interesting, suggesting that the "Permission denied" error message
is misleading and that the error is not actually due to missing write
permissions.

Can you say more about your setup? Are you trying to clone onto a network
drive, for example?

> I am planning to download older versions, but it would be great to get
> it fixed for lts.

I don't know what you mean with "for lts", but yes, it would be great to
get it fixed.

By the way, before you download any older version, do make sure to try the
latest snapshot from https://gitforwindows.org/git-snapshots/.

Ciao,
Johannes

P.S.: I assume that https://github.com/git-for-windows/git/issues/5737 is
also you?
