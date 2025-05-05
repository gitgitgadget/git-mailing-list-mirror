Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4714B965
	for <git@vger.kernel.org>; Mon,  5 May 2025 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430037; cv=none; b=sKD75We95VHzGKqiFsjrp5+fMZM6myArE3oobyB75AnDGqul73JYseWcrJg0cgA67mwGzsjtAaWkysf1Bt2zYXx+QFpkbR3XH5gjD8yLGiXQQcSrlCG96is1+3pdAHQa6Z4NWN5kEKKGlHQyUAKXIHP7AZlEBS0CRKt2REUZ2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430037; c=relaxed/simple;
	bh=60ot4QyJd72+ppeWHAf0qFYidZait5djix1AytI6lcU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jq0o3uuol84YBVWmlPeB5WqeWRNJ6cVxOBZGw7GIcNJo/KMCNxB9cAKSzfgcXrRfg3o+CX43JRPTEdS/y9bS+oT50+lkILUP/25PAgvoWuhYkuMzPwycMAeqaDz3E0yLn7PsHJnNY/y4HH6J+hdiGbflr4lDi3P0jIo73B+lmDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=twghHMe0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="twghHMe0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746430030; x=1747034830;
	i=johannes.schindelin@gmx.de;
	bh=Bnr9HzDMksBoOhT9TZXGnFeldbZeLr84Vq2fiw2GAhQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=twghHMe0FIaRIgHx0XuFCUva+h10ndEzR3ejz6/Z82vlM0+/J9x/IVHrmrC9wCHR
	 KFr2xonNpfyiUkxxVaNRL/Mw7GWTwrxuiTkZYF7xcwl2ybm/91VRq/acpCR8Tt2Fw
	 G7CPHZygBS5jFt99R2+enKAQzi0RlFq+uMy5duKKVadVY4437PnjY7Zbsc5ZbGAW5
	 Ttd7U7dIIfSG9qDKbZL/b23DNcdMVWLROivbV/kwYIf/njw2b9cpFgMW8+jQ/UZGU
	 4Jk7Yq2+DqYBCj4cqmZh4Yf2IUIj6jDXtyTprYfPeprShrfeNZRD1+ZPhfIPKKXa+
	 w+41e96APOwOGJ9q7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.189]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1usq1a3MpI-00dFcX; Mon, 05
 May 2025 09:27:10 +0200
Date: Mon, 5 May 2025 09:27:10 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] ci(win+Meson): build in Release mode
In-Reply-To: <aBhVWMabOFYRUjvD@pks.im>
Message-ID: <5e2fdccc-2c52-805f-ff9c-b9e0e72614ac@gmx.de>
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com> <pull.1908.v2.git.1746282346370.gitgitgadget@gmail.com> <aBhVWMabOFYRUjvD@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PfEZwS5uPtZewNAFsly8HMRITy2RMdNQs9dtjjvxbY60yqJ5f7x
 Tm8B6j2u9UDpyLSiArKOC5D9nfq6OWoGmCijw/fTvLGL9V4mub3SH/iweQ2n2X8qYmjm5Uw
 zQ/L0aQMOyNxbMDOACXjnY9TPUfCyqFdKzXNGrVysLKevD8dOmuDcsAl7vshgV5EZzzyvbh
 T4O5lSKjS7FbnBCUIRnHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jLanDc2p/Hs=;Iw1QqTlWXi06vXUvDoJ4ABq3BTA
 3GrAr725i+9GsHbCfl+qpwTeuebAiYTROQC+CC1YlxrzKCDfpdb0ntzkJ/WRnvgKRRDCRXboV
 47udehtcuW4Z2/mHOMwu3WFMXDcqzS5oc2GH4ZkHBirHPsLoEUk8E1OOsD2uU0ZbJD+c1o+T3
 K/1BITyuSIq32gTtmk5P2CHw9aLae+ceBM/J2vnGEMEzGiwWLbJL+e5vQiFMTiEr1i5cHhgY6
 bdzJ66EMvQy7mi3QydrpEmTP5eIUz/HMa8xBODZJz7F3206oVrgEMGtcSR8GxL16IcT49WAz7
 pjZLFbKMUHluX7agZCRAXcHGG3GjRQkeWOHZCvWCn9hcY9k7AYtrR9ZbCFqAxRBy90K8PHgQV
 YBbaaAzjNUadJOtAhoK0Co314Ptlp5cTMNNEvbQBHgf6EOuWj629z1Vi1mZASFTOH2ILl1AOS
 O8qNsPDCr/n+EQ4/6aqiiSGpvZ+IZAI8mm0iJLyQYQhf0T2nnvIBM3TszoXP2Vfn3/3DvpBsx
 hBSn2eEdeI1Ft5HWRJ+ri4d0NDBci0sxwqDSMKbnU/x8vJAhWXQuKeNs+fkO13HlwMDTSJ9EJ
 bpTA6ymDV0kTtVGRz9l+Uj0RrN7pf7fz1d/O2eGpMtEyt0EhWvUd4Fs1JHMsaZPpUENE1Gj3q
 ocPpw+IMdhY2RxIt1JjbQNTIClYGX+hdzKLi+RTU/07jYGzZ1FMM9o+VqYhOtr2bAYNcPDqu9
 SKfK4SGTZTrYFk6PvpzrQROXkaPxotfj56GmQNByugNNP1cXq0lsD28g3m2Sx+yPjW6OT68ai
 R0xTcJzfZje7cNpq8MiYkdjB9dxErxwqVNIuPFPHlEYYLypD2HEJgE59owLm1BT8ooGu1VIuP
 7tQ1cL5MAoRZTQZM9RNWfLvHHuVJ4aSPXzZ1NvpgkHckKITf25B9sa795TJo09k/TGxtcgbsX
 KAJ7gzxQBRThfHO6EjZE6JsbXXKGM+RUMyB0lof5KWJSLSo1rav0P+Xt2hJ7GIx4Strer6hPU
 B00sD26ev1+3hXMzQKrjp+0twQz1uFANFfY26jpvIXn6To93h15vm8f43TX47QpJGQJcw3te6
 UrMwn8HGoYjPARX1VaD0qQM9jRw1Ov4Fcrk8syfM5vVd20gt7a32vgYvPpbHgP4AmdFe5uMOP
 IchM7iy+QVeR5+QQF7J8SGFsNkdWlyerNpJOXVz0SBMfLjWkPwWPgAyop55Ix6AfQE0WQdWgE
 CqS8B09t7eqWg2nJKwZdYVN+JMnLnrqa2GlMMaEkw12opl6Ri0dX0cIkeK/+zbHqeMp5O03x5
 /YZjjWstF4ccE6OmxxEWB9z4X530PyKjdW+EcP1UMW6LQFaVaMEl9nmGDGNelHA1qX/8AqE8+
 iV8lN3atH18I/dYWs/WF+KEy3tFPWyw/NwgOTxP9acXIhW5mHyeqaOSCAZVuE/Ahi7TGR0gFO
 5VDGFc3/5dsqxp7er5ZgZX6ho7gW5IqFcGdwMs/B1rokcyOSKE6RfFSYeTI82f4zhFvXfDHNM
 CM90v6KlgluH11cyJq6Ljh517/dVKH/KfDV6YiQINmGhdA5IQdAioa+SqgMTTgWfGQDiQ6ex5
 jyikYv1r/bpgaaJ4YFLW+P4++k5gQ9FvTKc/rHVSLKCm38qXCva+1JheGMCJbOYxdHr7JKg3c
 4p7Db7OfE4QkhwRn+QCocY8lHgjGqCAXhtLkVQzgv+dlrDeNV2BiJfebn/W8riA0dskVxcByV
 Az/uiIAwUOYYZBBTPjPymudq1zbQsg29Z+zZE2Ngq5T6hSqQtjD71zImmSk/qnqvMyy3WCQJU
 XQ+t7pRxVRZM985VgyuJRY9scrGHJVzf7stR21xv/Bt4aVe2c2Xff3JNYXQMHO6h1BFnXS80V
 DmwXjUXnqKpOl0GB+P3zZRpzhrwq6CkHubTSsB1eaoi0R9HtpZBPzIdmcJUl0ZjrmGeQrB4AG
 xaf/LYqL8WLaRL4HJ0g8lkmZurRkMFA9g5NCvtBZCIYtVoZappYO+6UODuvhx15k2n62QkZrN
 P7e55IjEg/32UyxgG1E1DW2uxILPfcVpr/YPkNtbZja6a8b7BHuVSn0IbTBHiNJs2gD/Rh0i9
 7+QumoAc+eRj++exxP33OQAsU362NotHC2dG10ZEMtaOxsnHIwwJNLIhpSGCAnRcyqWc6+7VF
 AbOgN9DB0dI9/zJVjq8+rhfkxbPaNI0/8JeHRjnWSWs6bSwutq4U6xvMnebhUd4lfGLyhYEp1
 13p1hEZS0+paw9oyERRluu3TTBgu/Xbkw8R7fnGa20Ey7WSId2mKvCXa8LJARGg4+k05jUXa9
 VcDeoKYU3C+6adPGRzDqd5PxmlwkWT62PaZPAsjbavA5MWZZimwq0LTQV1JvBo7WCsFuBd2gl
 XFg2LkmhkbTWINeBMXEBHbyjXn91mYT0nehL6GDZgaCmSHPuOfVnfenJoHV8giqj3Y2u2eIup
 49znUUY+sZvRMxsCg3IhYKyVVPmz9a9KqUYJ6d4CFfLQ83GzUx595WTu9uqUiImSh7LsVwIfX
 kA8MF5su00q+NnIGf6ucrHSF3oxUy/CB077g6/rmUOXeKp7eN1T9hrAMfCw56s3Ur+d+Cv35S
 OWesXgSH/qIHtf2U8H542GsHK+iGzdDS0d1YPI9geRCw5u43Z8HtFnfpr9as1gNxAC6VSVbqJ
 jwAq650kyqx1c6t2eWfN/qiMSMn4OsIoooYaKP3zaGRyTXE4vk/wp7s9+qkW/1uDhC3qnsM+C
 zwAofNN6w3Ed4ow14PAIbpDB+yc/FtZMhqueR+pao6a+qRULRtG+y3sUUZo30cUu2trra6j3y
 lEg0dPX3CFA3hrESfR56oXcQROyIAH6JW/ijpMMg9YgeG3VBs9vmM/DDh7/IxQSfNBc4pqshI
 wDU0+rIaNr4Vw1M9i3BY+3NPfCX/OnGg95swXNt/XsyxXFqovlREThgi7pUTbGVjn4WHZSZZ2
 YJ1PDGPwd8eXKZC3NwD9LIIAKPOnWJy/KpIKRFNAGs6AGQ3QRuqAMmS3ZoaPZH+A2A0dCr/3l
 ahtXMQ6JVzFi6FT3zHDWss=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 5 May 2025, Patrick Steinhardt wrote:

> On Sat, May 03, 2025 at 02:25:46PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >     Changes since v1:
> >    =20
> >      * Rewrote the commit message to reflect that this patch is still
> >        needed, even if the symptom that originally motivated the patch=
 was
> >        addressed in a different manner, because it was merely a sympto=
m of
> >        the underlying root cause that CI builds should not let Visual =
C
> >        build Git in debug mode.
>=20
> Ok, makes sense. I think we should ideally address this issue
> strategically, e.g. by getting rid of asserts completely in our
> codebase. But for now I agree that we should just build Git in release
> mode on Windows.

I am afraid that getting rid of asserts in Git's codebase won't ever be
able to address the challenge that Git -- despite much reluctance --
relies on a couple of external dependencies that might at any point in
time cause `assert()` to be called, e.g. due to unexpected changes in the
CI runner images.

In essence, we will need both: CI builds in release mode _and_ converting
`assert()`s to `BUG()` calls (the latter, however, for different reasons
than to proactively address CI hangs: Git can convey better information in
`BUG()` calls than in `assert()` calls).

There are more reasons to use release mode builds in CI, too, but we
already have a compelling reason to do so, therefore there is no need for
me to spend more time assembling an exhaustive list.

Ciao,
Johannes
