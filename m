Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D9F187A
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="XAZgoMVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705131805; x=1705736605; i=tboegi@web.de;
	bh=AvE2k8hKAsjN5zbhvJDG/z9rg3a5fmBxjZFbsZ5SCdg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=XAZgoMVlgH/69lSfVQS0xhKUTfJp9wcSnNnn22lyY0lbFw+NlnUjJmW7yxmUCCsZ
	 nb9Nkc5zgK0DLYImPJawqf9PStzya3S8JYqwGpC+n+1mESwAH6Sdo8ogNnlRqcZUT
	 mjgd2IiHaUirPSZ9CvAuv1tLCNTMZiZvcUTxK0jxGbCo+TVu4/m64FE7WgZnLMMQZ
	 YrO0zYYkmsyYG1bFoofIOLPaeaRmjnGcwEg4zr3orb5yT7Ci5uh/9evZ0fU6C0oQf
	 C3IAv2wbtbcCzq3dCQDtPr70kMxfZOGDaWY3xHaMqEasYqBW2Kzv8CLe1+cexxHhC
	 AikI6vvBs4UHRxsnLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62uQ-1r4uGK3IS0-016SjV; Sat, 13
 Jan 2024 08:43:24 +0100
Date: Sat, 13 Jan 2024 08:43:23 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Michael Litwak <michael.litwak@nuix.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Suggested clarification for .gitattributes reference
 documentation
Message-ID: <20240113074323.GA6819@tb-raspi4>
References: <SJ0PR10MB569379A093B83BE01A04C789FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <ZaG0EkADl8hQZaqf@tapette.crustytoothpaste.net>
 <SJ0PR10MB56937175632E5D82793CE13EFA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <SJ0PR10MB56932ABBEEEC6F8ADE23995AFA6E2@SJ0PR10MB5693.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR10MB56932ABBEEEC6F8ADE23995AFA6E2@SJ0PR10MB5693.namprd10.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:eahncxOnZaO3r++soOTuKVM0XKqw9tgQEuMOQDbbyOdUId3A2OO
 cB5qh+Mrg9FpfB8qPbyDhONrbERaFjrzBw3BatyECwwb9AZjqli8f9xGXzKuL28tEJcblaa
 ve4Lk6o1uHaQbJown+mfUQoXswS3n3gZ2zLXQZcyjes2lIeeMUJwVlb5wmU3bApllcSxyCP
 Y7tx4no++cjpM0V+j1dvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wTyGD/q9dr4=;OV/86ZcSFiThtpomz7C5E7/gp6j
 JprMSGp+rmee87VlJ8emxIk/LqszvUO0BHxye+aJDPHSPakFrWDh0R+2bqkmgcyjxmYjRZc/8
 G/O86YXH6JsbmZUUahQslpouxDDigqGkpiWyq1qWEflo5gGAv5n62ABVaCfa4AubHwnCLQ86I
 xB6l9UlLUBNMHBOTRYWiKPcKNtgxlDqLz9DQDXFg5WqycUfAJkOIPdTwXJayfn5uh0VSCHDfh
 g73GeMhvAz/wY2p4NfBEGT3asuYFL7k/rsK+Cn93Yy1IClsLlLzV/xMVe3ojF2XD3ss2Jc6A+
 4Ipb9GDE4Gc+GSQwWFOc+Qt1Xy7lbp1hPrCIV7inC+z2ZOFu4QEz6fpBQQlqBv5cZDrWgH6Zd
 meOWDLRABkEjHloxvxVPPT/TAQct6wOMCYC9HU2+zO+qc+GynIeGEe7HioRhFo2wBh5OWma96
 Dw+WvlyQ8GTyGtOjAB5yY7Du1uxzrS+dKVZcmvyWhjmJppdZGK0argklyTLxmx1mYqs33t7jF
 yk6VkuCY/n8W0kL95pDLm3VExt8ttlwIwGReA0DJoY2PzPe5zsSMBywgOTi43n9qn6TgQwan1
 yPC40bJOBkt/b++7MnbkNwWydYCxAzaBaQEq8YYtavtmFvVnQZ6g5cHVqiqxQJ+i1J55TIf/6
 ILmzegfFuREYnFvwYFfgJ5Mmu4qkzO6cd4xdXMup4ucZ4MjafZi4fw5YHnIneRDlhZ74/zZij
 w6asYj6LG+PIlWtCPctLiHzIRrZDFuNX0HoLaskMUjXnR0hwGqJgyH7QNg/uH7wiX9Q+p5DtY
 12AFHzaaq+xeDGHdt4gRBd4YzIa3PXmDKVqoGTLCMH1K9WlKF58CZOAKuq1Dv1PMXO9HpoV6u
 8pPoR+ZnrZ7+CTVt42OVLVsZEtXboux+Plc+CKPO8OWg/Rrg0+t2X72cVLM3Fv1FKumUG5/K9
 vhNlVQ==
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 02:56:27AM +0000, Michael Litwak wrote:
> I just installed Git for Windows 2.43.0 and noticed the installer offers=
 three options for altering the PATH:
>
> 1) Run git from git bash only
>
> 2) Run git from git bash, cmd.exe and PowerShell (RECOMMENDED)
>
> 3) Run git from git bash, cmd.exe and PowerShell with optional utilities=
 (warning: will override find, sort and other system utilities).
>
> It turns out iconv.exe is accessible from cmd.exe (Command Prompt) only =
when you take the third option.  But iconv.exe is NOT optional.  It is req=
uired for git to deal with UTF-16LE with BOM text conversions (and probabl=
y for numerous other encoding conversions).

Plese wait a second - and thanks for bringing this up.
To my knowledge the binary iconv.exe (or just iconv under non-Windows)
is never called from Git itself.
Git is using iconv_open() and friends, which are all inside
a library, either the C-library "libc", or "libiconv"
(not 100% sure about the naming here)

iconv.exe is not needed in everyday life, or is it ?
If yes, when ?
iconv.exe is used when you run the test-suite, to verify
what Git is doing.

Could you elaborate a little bit more,
when iconv.exe is missing, and what is happening, please ?

>
> But when PATH option #2 is chosen, and iconv.exe is unreachable from a W=
indows Command Prompt, the git commands which call upon iconv.exe do NOT i=
ndicate the error.  The call to iconv.exe fails silently.  It is only late=
r after you commit, push and clone the repo again that you see the encodin=
g failures.
>
> And the warning about overriding find and sort must be taken with a grai=
n of salt, since the Windows versions of those programs are accessed via a=
 Windows folder which appears earlier in the PATH.
>
> So this Git for Windows installer screen is misleading.  And perhaps ico=
nv.exe should be relocated so it is accessible even when PATH option #2 is=
 chosen.  I intend to submit an issue on the Git for Windows issue tracker=
 regarding this.  I'll also submit an issue about the lack of an error whe=
n running 'git add' for a UTF-16LE with BOM file under PATH option #2.
>
> Thanks,
> - Michael
>
[]
