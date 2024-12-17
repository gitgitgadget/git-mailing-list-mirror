Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08311F03DE
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439705; cv=none; b=qqADufi0fJO/7jj1UHlJsfw6CEVnxZQ4rZpII+zwtjDgbjtElotKPpS0iVXqrjnfesKMSpyeKSpeED4c4Vr2ZtruuFnKuE3Q5KIeugrKs4Jvq6DJAdnaqpueUuCOIaMrFi03G1xxfIezFj14scvGwgv3OITEkIf4WGwetbCfn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439705; c=relaxed/simple;
	bh=XeIARKHCTdxSS5pL36oxEvLM+gxE7J4sVE0UAGvl8hY=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=FFnxkdqyn9CjyuFh+MT7oM2pEqwe/wpJxoX5j0JUG8YBHhr4i4MLx2EMStAECDiTo7UomHV6HolgsQgdLSRNIxQA6VJiFT4TbZU5iT/byaNjHlKEgA8DcbHEbN+b6O6S6yJ3KSsakbw2v/xgQHcTUD/xF/PHAP/KkKHV7Yi6V98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=HU1zxuVs; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="HU1zxuVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734439700; x=1735044500;
	i=johannes.schindelin@gmx.de;
	bh=eChn/eMnykR4NALYJ2kyOPAsPApljyY1kveYbOkXByU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=HU1zxuVs1YM1m+lK1KSt7N3G2G16fjQGpm5HPRfFn5mSihaRJI8KDA+CwVcBKJBh
	 HMI1lnnR1FUwK87vr/KJFCw4CIHdsRnGd5Bcq2lIS6bJR4D9SftPE0jsVpjsfGCzF
	 Li566/yKZrKl0dV8KctbmSJdpCsO3El3e2O4ArP+2nrpI9tWT8CU7mJjJMDxzO7K+
	 Wm/vb6t3Gx7O7Ocfgv4Zpv+m3/RroXSBp93xDqasmrWDbSz1gpn+CToLTohQgHvd0
	 yTaZy9nItHhiXcmPIFU2hw2iQwAMaoyMen4wyWr6J8RbqhZlqsy8sj2b4P05oV2JG
	 7m5CVhn4FNz/T2FauQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.216]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJqD-1tsggp0HA3-00fihF; Tue, 17
 Dec 2024 13:48:20 +0100
Date: Tue, 17 Dec 2024 13:48:19 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com, git@vger.kernel.org, 
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.48.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1M5wPh-1tUOUB0QmJ-00HLAH@mail.gmx.net>
X-Provags-ID: V03:K1:IWhNq1fbmyBfbIxC4qyuW5hpa5S3wrqSxN0MvS8dXVbZThrgWC6
 JN7rD+ZdHIQINmNv51ZrzhjqYpC9e4Xw+OAxpJgksgiyoNZZ9NKUCpi8FgKJkfSNKUF4h5i
 BBoc9qFTv26AsPTdnF5o4I+Rrli30Z6QKEH1dkd6x4cN3IMN5nQddkTEbGwFyyaZeuS3pwI
 B2xe8oeDlNu+IM/dwaNog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FC3Qn1EFfJo=;+96RtyXnMH+B/Sbfb1F2FizSAyf
 uXYzBh+CXqJs2wGW7oiVTPohrPLrLxytK78sWlMBzsdVNZxkIYBoMkTYiRTV9ZjKREmpNdDVZ
 x9vlFbdQtpdJ4F9VjzFuJP8CC6CgGvQcRC5sapz8Hy82VxxtWiEsJrEZ2pGOlgpXJwNQuYt0O
 0py88kE3A1l9xF41EgGelfHhVZnl3QD9myb5EfUrH7/vhlJhF0OsEVnkq24gwSjIjOkazBNbF
 csFeCHX6UrcsJWfG41Ijz8BOZhw+ok+0hc7abp2xtjmYQtijCpU9OaY+yGXUxUuiTNzeX7T/6
 qnpnYY8yGD7/Xo08i7vpeDNIovYCCK25lDuubFDGZt8etQWz/uXcJ0dPmFeWBJlsn5kQNcw0n
 4MaEox0gWY8d3t4wMR1/BR96SewRt03yxt904Yh7Aw6sQzjODZ3z2FdZW9jkP/C6aHKIBoOVe
 9UpGKhCpt3f3tBaarOLpE+7uSa8TGFYjLc1zO5bcwFp0CotYCzNi+alFlVmrwo4z10rtwPqds
 UEUD5lmLdhsKMjN7mwuo8a727BLIvMHHXppRn9bkJCl0O5GWcqmltXWvLfl6pExR4wtRCSCYf
 Cx+Kzio6/WdbEq8Jd0jzaAjEWRwGR8F1STZA+SZiuFb26Ssud6b7RyHA1XQsiikw8iDX9y2q2
 903/XJdx2MutqjWVf2eh/hrZR3B6s4Gf4o6E7UaivznpQX9onzRLqWa4ECjWIubGhRuS7AHsl
 /S5nkHaNgFOhm2VXB+Dq5M+M47ead1kIyOt5EyGV+n4smt1ai+e3bjFU3+IGs/fW6s1N3HuCG
 NFz3cNIqaRr02rg2ptWjFcfABWEdJyp/+y4AfB/sN34LQQYygROKdhKeXrrwAqG1tD22TgzmN
 CpsgVAlETHha9BQXLyoTr/T2SCRJE9fxm1+sbH79f5c3W/xD1YmSair9wdqeKZxKH4Vqmuj26
 PsBRlhp++Z66wAugRrxwOfU9hp0GhaRvdERPvmitXFoMoXmc+MnhgXUtDgERanrvGT/P55Mov
 rqE86ZmNYAzOwSnOlNXInWYKWLGcIf4CmQEFayED5UcLFfNulko33Tv2w56oOmPJz0blEGYau
 M8CDqz+mgY6k4bN7x+ui1fl/ktEfurMYCDNkTAkV+A+vvwfb8zprkTDybhgzP8FqbIlCqo0Ms
 =

Dear Git users,

I hereby announce that Git for Windows 2.48.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.48.0-rc0.windows.1

Changes since Git for Windows v2.47.1 (November 25th 2024)

New Features

  * Comes with Git v2.48.0-rc0.
  * Comes with cURL v8.11.1.

Bug Fixes

  * The installer now correctly blocks the installation on Windows 7
    and Windows 8 as these versions of Windows are no longer supported
    since Git for Windows v2.47.0

Git-2.48.0-rc0-64-bit.exe | 553815da6a9652516a3162bf4bea4b60e13bfc3da710af60c034ee673bc92e93
Git-2.48.0-rc0-32-bit.exe | be45795f4deca6e6bc68c75bbc891b46b890347d53738d26ebde276a487f8bb3
PortableGit-2.48.0-rc0-64-bit.7z.exe | a94687e8d822b50f9ffcaed49d9e1a4836c50447ea8ce3fecc556214536473b0
PortableGit-2.48.0-rc0-32-bit.7z.exe | 4c8f62b2738326b7ec1db4a4c2c899792cdff6e48da6bea94ef24f0ed21ba5ef
MinGit-2.48.0-rc0-64-bit.zip | 981516b24ad7a83f44c6e7dd20ef70f60ef1f1e97772a1ecc9cd7ff7287c4cf9
MinGit-2.48.0-rc0-32-bit.zip | 63d86253c3654bb2310e71d6376dd8b986254b94c3c8e91add62548faba45e34
MinGit-2.48.0-rc0-busybox-64-bit.zip | f1bc9a83f59907690c954dc429ede14dae8ede7f0602628a5f0c34878c54d0ce
MinGit-2.48.0-rc0-busybox-32-bit.zip | bb2a3f6dbe5330aa1cf51c34387ede08f1ebf8035b30135f9316469c2d230565
Git-2.48.0-rc0-64-bit.tar.bz2 | 0459027325f1bb353ced02bfde2f007e6e5c7dc61d7ebc9205eea4a033a3c99d
Git-2.48.0-rc0-32-bit.tar.bz2 | 8abcc6c10767b6031d2171ef1288f9a79f1974424245e73b17867c13b409a26f
Git-2.48.0-rc0-arm64.tar.bz2 | 3d5ad1d678e273451358553c69a33b0d49696314a397a61b7ea164c79dd3455b
Git-2.48.0-rc0-arm64.exe | 5e7eec6217fd4f2612d6a745073044d4a49fdc730273885a996fbd86cc496b4d
MinGit-2.48.0-rc0-arm64.zip | 11b64e06c885a3a10c566649578e7897275f67c30aa6f4c8321469febd2d8fb9
PortableGit-2.48.0-rc0-arm64.7z.exe | 291f12d7c0acf59a22f939ffad8b2f3559f96b9780161d60ee92d5d4f3c8a044

Ciao,
Johannes
