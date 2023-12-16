Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9424B37
	for <git@vger.kernel.org>; Sat, 16 Dec 2023 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="DCADK7gF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702733325; x=1703338125; i=tboegi@web.de;
	bh=6N7g5KyhdQ6yCY3p6fKVCHXWg/4pa6r7NcMZq4Y4oJQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=DCADK7gFS0cf9ZkOQJiE4jpCJUxoHF4QKXQU8SVI0mzLS/b8oBupPpI0UERSK4Yi
	 QMR/XfPywPIOvMAKsxMC5oI+b7PKL7jDymLnG95OUaCE8Uv5Q+5+mcsuHz2dBf3M4
	 4BRCTtpvkhz1HRGgi6rLv4QwNaC05gHfcEneKD1Gn8l3YCoorWwUxh4Q3d4RHcZaD
	 YrEklHNjN09C+WSc+m5GSvYmB3SfrqUiiWMdKJN1wEMk10il6+V0sMcSkTPEHxYeY
	 9CXmDkb3+SzGNdmAglKjd+I15jRGT21WAZ7jnD1ylwcPJDv2D1THRBtY4iwHf/oSg
	 6J9/fTae6aYWNNs42Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOlwj-1qpYoc1Sf9-00Q1of; Sat, 16
 Dec 2023 14:28:45 +0100
Date: Sat, 16 Dec 2023 14:28:44 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Cc: Haritha D <Harithamma.D@ibm.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Propose a change in open for passing in the file type.
Message-ID: <20231216132844.GA10935@tb-raspi4>
References: <E1D54D98-3836-41CA-84B5-32AEAF7642D8@ibm.com>
 <ZXkwTYD9nmPYn9UW@danh.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZXkwTYD9nmPYn9UW@danh.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:Re71JCuEl6iVytyTotr/glEJSp+UinxV9qiaypwvXOvR4Rd9CVA
 QjKaHJ7rMGaJY82d4+D5rfe2cNEohcT3AW742o7xVZYSLL8iYwM8zJaXW9k3ya5bqlIf1SI
 zCsEPH4KKNtPMsFgeY6IcL/Yyi5iy0swIXA9naDNkLg6FBFlIebukTYHCf6uS7TFu1BZYge
 WwyAM6QqobibITMDLBU3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:geVEB9on3u8=;VaedUuh9upflmhspKa9EhrR+2NP
 LY20FcErZtKUks18yxUCdb/JK7ytJDCELFc2n03eyyMBYD4YpFADiepYt3UhOQHChudnggIne
 UwxsOrlqLSYhmkAJqk+3kI+xKTs1tI3VmYztfoQPYYUYUjMzWQ95Ch+z1M94yeYChQ27I0tSR
 R2OqV6rxF7KRpEBuRHQaWin+F28aQRfOzADcM6dOZ1+ZEF4YMUSQIuPm/BcYi0HSv4tRz1Yv1
 YJtsGU0E7lOYTpa+XpUTYwhQ4Zf8dDBWaEFE8GpSN+y9Zr9Q0+XyHtRNSiSRWTUzdJdnf9azh
 y7I3v2l20H+1GIZAs36HNDZZPH638ez1+ijD9K0HB/2Z/RcLxjZAzryHcS1spvYm+QRn2GivV
 BZuPVWBlGfe3TReSiyXmWeGxzN/dET0/A9Zfz8eWDz7wd+KNNRhmrd9rq6jR2wjP7byjL2R/U
 jlHbkFffgCWLvmIi0xOPpod0KQ2ydvJC6Jml3MI7Ojz+SvjTs7sJEOP4JYpD1FPXvccfh67iW
 txNfG6SbBpOpXMJ0U+u3q12oLECA76DGveBu7eL7klhoL5NHKErzNq8lx2UVM2n3BXOnel8sr
 S6h8jFyeqOjZ5y/R82TxS/FP882i+XJ9MM5CcZ6ZzsBpmQQjQhLsoZnI3rJEt7sFGuztbIEbt
 Xu1Q9bYXxE4F8GoFebQBNw6vNtqC/aofB0/uLI+NSjVHk1xMwupq62XRVifQDauoMlGiuiLtT
 w8i0Gyk7lrs1qPM6GKMgCZkB0ZucbwphS/lGCiXvm0RAHcAVJBmck9My8O7inl/tQHPmIUBbm
 Fzgsnp6+jUr3cX8tyfpqrdhA6kqiI0hP47+ixFq6u2fvJSdr3kzH5GFG7pvoJBCSIJyC32JRz
 rAHYUJ0r+aMN7A5ga6YpsTiKb5AAXSASnrJmK7zRI0es+yfShsoabcaU8U/A6BLy0YYLl9Zle
 WtyuMPV/avSjEXmrPdCVx3yBZ/o=

On Wed, Dec 13, 2023 at 11:17:17AM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=
=B4ng Danh wrote:
[]
> Would it work if you always open the file as BINARY?
Yes, I think so.

> And let's all the
> conversion done by git via some configs (core.encoding?)?
We already have an attribute, "working-tree-encoding", that
can tell Git to do the encoding/reencoding.
The advantage of the .gitattributes file is, that it is
typically commit into the repo, and travels with `git push`
and `git fetch` or `git pull` to the different work stations,
so that everybody has the same settings.

In opposite, config files are always local.
So that everybody should do the same (local) git config.
If that is forgotten for some reason, then different
configurations leads often to some kind of chaos.

But I don't have a z/os sytem to test on.
