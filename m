Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35002ED870
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306464; cv=none; b=i7wjHWIw6ihK8I2dWGV6p/YZQUtHIVlEIyBAimuJlOLGMAjKpujIc9aZwdCOWFtQz2ODi8bsMajaWVkdu25dhSeoFIGIDlbgRNTAiMquPq3NqePNu9gO0kDcGKNYmFX8ZwYey5V7pLdKSaokj8/aRBXaxMwRxulwTca+H7l6S40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306464; c=relaxed/simple;
	bh=XOZl2uFq7jIEj63qES67e9tGHpYJEtXoeRGmVqTDVjM=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=qngX2M/Rw6EKHIQ1k/x5/vnT7OkO2i/ISWs178OwrV9tGhJte1/YixBpVr/fJNyGQX0zQJDhr3fbxMPdQzafnMht6cMP+DmK7BIlMWrVnAE84AT7p3FDto6ey6fBwHgZCybqSAEEtvucIhgKxxNKg5E4VDgdCWqppcS0Al/4zFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=iChdb4Cc; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="iChdb4Cc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782306460; x=1782911260;
	i=johannes.schindelin@gmx.de;
	bh=092SwHdDi9/MLIyOMJ6UWszsHz7mRxbcF2yk8fYeW6A=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=iChdb4CclNeE8gkAMzUBTJ6XwPD3gqXPXcsl25SVAhW3Oo59d7eAE9hSpRnAn2Gk
	 eGhMSvnvBRGlu67dZOiYzjCv+GpfmwK67x/bjIGnwSf6yasFad6nBagMuw0FjDNfa
	 iW6lgtppxIDsgDWfNAS9RshAMa1Oys2fXzATxb/LMiV7ozeKZ2rh3jLK6OVxTaoa1
	 faaVPFr0rcqBcqby4agv5lk6aBIRsYL1WikKn99JAjP6TawfPlC00YF+ivpSEdnDN
	 RALbsHhHnKLlkVyhc+6tP03PIMgT9BVWQMKsu0NsbCRDRyDkD5vb24xScLGP/SShW
	 73dhy4pwPC4rMTW1yQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1wTbu03UNk-003JZI; Wed, 24
 Jun 2026 15:07:40 +0200
Date: Wed, 24 Jun 2026 15:07:44 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.55.0-rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1MSKuA-1wiwvU3fzM-00Im1Q@mail.gmx.net>
X-Provags-ID: V03:K1:hXrj/mn3SX3tROwIQxyF4Ww+sxLLqCa4eJcbIzSKUlikbEk03ZP
 co5Q4hUsBOYcDQwYuRZWX+IwDM244+afNghQtXo3wqr4u2dsh0rnLn+9Pluqh2+F0dDtfdk
 cGfAarBN/PltAbLjEmd3tQyKizM04GRN+RLc+bNV/cVspAB+x/+vLwMiRllqFwndDy+t52H
 mzoBs17yRuRTSQLStG3qQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GNiIDHJXsh8=;cP3h1R4SOOxuY2aOm/kn2d8dUvg
 m/JWgJBLsSkrGqrhjh0EOmN/p0/ECVxRePhp7NrqicmZV1wu37/k4yD3GrN7MD+DLAVy7SVC0
 IPPlDvOD50wY9VFqDBwbrilYqPi2G2vb46cjd6AMInrPZ1keupyzq1Y5fV4RcDw2sMfY4ukHa
 HF67G276UgnoaE1zyJUhqtm2SPisAD1o3UrBNN6NqX7Niu8zT68yYbwXQRmOL8C5ptiEKHbP2
 V+A0gq1xb8/gKiU0iei/rad2Sk4FTIzOj+DIT4gIewp9wsJ20w0qDM3Er8VMq8YG15sC4H/P2
 yqa0on/cqYUIMfzKsn791VvTe6g7WtFG+rysYgz4LJ/hBU+bJrdLEdh8vszs7LSjOvVn4xqkO
 Woa8hrY7jNq18F0I8C/lRbC85vtkr2D7Cyc/M/M8CSPJ2YjJxf/0s4TOICBVLyeUe6ZsQAxFL
 hy31pywEuHkQU4EFhOL1oY3tpzxGg3kM/QeE6h6IMvlU3PqFAb34qzb09pFVPGBrK98RJh5L6
 xU0G0fzPdSFxpvs2seiUe82lAq08Q7XEzr/Q6C6VlRiGbEjydJ1KjEOyH64kewGb/cIwzYOfT
 hI2toCqBXVT2oTPu588tj0WUVtJxmZMmII0LgCCnHIB55NFpZxz6cEUd9sWjnMUzXL2Wz7RLA
 mom7KvuSoyeQo263Q09/Oy+jnf+OhaMOuFzJ9ecljfj6Icl2F/d75PWU8XOwqJvPkNoBXoH+m
 svX5l8HUStulecfHB1zr3vQiP3cpbqDe2m4ExzwRfESa4aEzkfsZuidYzo8Fg1MHHFZfavvMR
 0DR5UvJV515ryu3GXeutTLAigF45MPUu8XMVx3zXFxfZarL4hEiU3qWiwL5yNLCaM9ZpiaV/0
 YTPQv3CAv+aCm2nzvjgKReSA/ZSdEMtpCTaFS8RoHAJuhTffttLtkML5kZVSkiPvXa6D9M+Sf
 2MqnoK4vGoFWo2fbYocXKyhiWI69PFKHI8mBWvaz6qKRUlKN6Ec8wLfxZQWqj977t67LeqqIA
 q3eQaBgMWnyGfbtSjXRceKWjE30wsKme33yYknE9840P7U6wl8CkuTXCoum/V6wHdaoH6gAaC
 +HRCUX2Hag9wRKwjYSGmq4+zwerwg1vQoj92qE/PJ8Vi4IU/RLBC1vIX2qtEUdeg1xbBGLqqE
 Ds1VyzQJ3OCTju55VOPbdlfAXaeHGQNb4QyyuB1xO2Tl9XegAT3oxzdkNHN/o9Tx8jD8W5mdl
 QF3KzG4qmW1Hsojb9lE3/ClU8zjaygLRh0O0y+eqOqfLBd5Y6JNZqaaP/uR9MKZ2r5Hd+OjPl
 m70BEjUuhBzmPtgesU8fH4A+rlfJqGhpVuQLruwWlWM4zSh0/QdHXfNzYgzpHNErPGY2M5zPO
 YetUYx6zxCJuSGlmvsXp3M1zU8mmfzjzykqX80h4YEAclKEqQI/ro2t78NGUMa8yDVMRIdYi7
 CeX+eWcVNeFQKrS8g+v2eIl1UgM6fNdhMb204BVDFsu8fx5cKMDpH7IO/1iELcme5hmtff7vY
 nul2xFeNY9iSk2yV/bge8zadgrbmbWqpIWLKxW87so3nWW9mqYbsS/AUv1x8p+waQTmU30XG0
 oOSENn/Zq/qWzemj4HL/ySGSsSjwU9TFS+pnN2irCsXS391ikiaGgjYSaE880uxqaUIkUARaC
 BUJbCEBhD8WFKGxo9+gIrzdfNX+yD+/+hRLgKIuQMpZJWrdFZfuLy+/wS4aIth4wGBaFkYtuR
 mKvqvhhIyiJuJOEjyi1bnPhBNmJyPZ0j+khtF7J3+8s/f6G0rWgRRKZPm2uom4yK70xlMwTgF
 FQYmpI09hMq2AhJ7K3dAuVzJkGYUfOa9+UyiPuXsKtFpZqUOOn4Je3RE2ZmKSCWD42K3y6xEn
 0zTr1IZLdB28ktTjujjDEGTHUIi3oE9RnVgKZrz+WgIpnWOOISftnxLdlO58CBkmbfbdW05ld
 Fktg2rxxDKy4MOdZlwJSNjbNSigMMNFjoqEHkfBs+HB5nBmKHvVzScQ8LZMX/jTqXC7h1EBrd
 SdvQzwK0zrp1bXXwNgDnv0L+rs2Jeeq4bORrmCboLGjewl4lhy5t+oLdtpeeydyepri9pm9cB
 fptkwTscjlVj3vxxa+cWzJcjKSy434dLl2jCp9m26fvSjX0of6h5ZFfIhJ4JmZMAY0zU046za
 1CzhKHAM5CG+IYINr8PoL2VzgmHE0ZEyZ8IErlARsSC2VHsSaHsfmxf1RuPebJr9tew96mk+z
 ch1UPECGPYSc+z14MrQLYg94FyiJEnYp/G0oYdZdBQ3zvrPSmL+mbto6O8GOdCBOZXcxOSABj
 Z53zWEg9AYVhh3XAaZ2QbKq6GHMDSWjWqRVSD2/abNwVKOuzLlzwT32P3eJTr4H+3lgVxmZi+
 tjVfZyokNdCKo4Fr03QM0/nDhT2/+lxlW6J5OLfGDBbKH3zUCN2kJrU6PX+0ujzgmTzryxZRe
 nFDovNtEUwhIvS8yo8BktPcV68wq7Qx5abO2Ymge0FcLRD6NJBhySIt6oAFiDDG/RIHS08Ain
 2Tg7EfJn9h9E/eULUBWbclpnAjRUSac1OK7/hD6ZbsXLV1gd0vaGowO0tNDRV8M/Ka2SrSNNW
 ED82GzP4LvPvEFvunbdjA1rirLPRbsyK0QRD4zw5TpZNLXUkLKLMp6ZIA6dVhHdel0hUvvo0D
 hyDvxX9YlAYAe7Co4X2fqHF0LgieTPA3AEfVVIamYkGoOQ/UlkzuNXTHp5jScVyNyc1N/Lood
 hGYf1ea81d3TYoqrMl44jNRITUYSRo3oRKYMB4uJV6YEEIgjmN6kQiLoFj1ZZVDVfcVKaberh
 P4yqNfMiEk0egzizGIloysAOT3fgkpEyjTSh4S5b/XqKuf/dh7ozkJJ1VipHncQFgKl2E9NLV
 HkIC/YYc8lEDeZV/6VH/qxb7D6oFOidydrEHm2z7E5I+8yK85TS71FeO+6adyzjMNUJ8rkMcg
 BalehkvGcfgROuPZudKmU95Fe4JoBgg0j8r80gA5GeaOwwnpg7XSvocKrzCPdSoqgNkAjCgYX
 3mdT0JI3jqgR+623WewUktG+xcYADWDq9YWVTzFPWtr+SzXfF8ON7fwx1ECXujs3CLCJUSslx
 /2+aAUVSwL6ReLvvZNmKA/Gsy/UERe72STIwqBUThBeIlqj7RAmfh1nPHENY7QMEp/Sm+hFUL
 WFXVugQXHqpigJ8t6RbnLkXydotY0kIpM2/5VRjC7ND3dongNg2F9wNjwxpbUqq0dfiPu3Ewu
 vZRoIlCASTkyuzA6ZjRKYTUHoKAZuhW7J+KOH5izAsTd5ul0XuqJZFf0cV1GNKKOQJJysVxwE
 yWGZCXau1CHAGlFfJkdzfZlSJFfJNJLZ47vWD16PjHpaSeoQmuUd8tQKuMFJbadCchvdGct9S
 0wBeklv9iMiC2rMw7/GvA3exOnMENkhpazm7+AegbN9EnIpnvd9dqycKHIsNq1L3tiBHm9Ltg
 F3m3yQX2VdtQApm026qG19SgyfcPUugoGni79TxkFqXxHI+ONwdmES5vKx+L5rfToj77TcRmi
 n9MS3Hla3JFGVDt4Bh5tqAjdRrqVNGOuWMf7MHWE0xY6v8rX/Kn91Fmh7ormht0NUlI06CkLw
 SDJCnUL0T7YVPw9fNTTy+EnjYT6RrtmSIoqSve/wvfAeOa2aR9WkQVLn44GzMdb8WNfOHFsMn
 sUsvve4zX9ll5BrkchcSHJEQ1Z8kjbORKlLX9DYtW58FNdfSpKgxfaaAtTI1iAsK+iC99JNR/
 gsM/2RoSIztJPTzcDkEPl91DMaIJ7rQ7KfpvA8UUtxcal0kXRimGYowIuFDRgQzD8FzijT47V
 HVcKaFgHwcxGdxr7ekvlnjb9WalTto/2Z/orcpx3TTzs0d5hF2M9tHdcURf1XbDctL9oSL8tY
 Ietu6uqv6UyOI4N4sCZVA1aWYqAAOas+wvkyIjLUAbE06KvwrppTkuOIMKkdBLj9PFwGk7zhO
 lSFL7xkHOghtqrfCvNEMtbZF5DTt/Jwr0feETsFiCe2Bb3csbPGo6XzkPOMuDrC52UmE8WYvc
 fTQgHBFpQCgbQ1bVwGNFP6EMUJFCaX1ufaSyffDOSiJcH6CySP0LYs4oeu+/ruRQCrWd+YoGM
 9+bgtgVskCDikaEpi5RyCJdLnO8ziDj+PfmOfhu7ZhvcrzvoVmSqkhEML7hv1ZOqYMTXo/IMR
 WeGfvnbYHcx7wu1Tg7EMDw7F00S164qpEPLWNQRrgpiLeej0UoivDoXLdrbiPQhMnM7CKxSh7
 /XsFlxSNcUMDwUURvHZnWR6OoTJA662c2JtFlmDJGpWtRC0sMkydqBRX2m7Xqw0c6StxmHmBt
 bRpP5IrUfjiNzb2IOhFblmR8O1feoFX/4DCedPSnoihEODiiJ2z+FSSnIbYkkljffGUeLzyLB
 VmBP6nq0I+E1SvL8bgCEH+QO/dNRiMJ6j7xrh5xzql7ETeV+JwGh3GZPPwWCOqp1cNNWGfFuy
 Y+3JSXLolrn2djwAv0H0TNUesLjHvWwwRMN3azDh+oKZEoz/xvycoW46hzEoZIx99w0oHTPwc
 ON3Uji/f67uruUFHREkdALco9Ins4wPjdTzhZe/JvNMzMAhHoMwuIu1cdAyMWwNc3ACPAQlbR
 sZNPW2Tb3C/yzQpxcan2oer1eAYUHvl6zNULq4/CdD90sw6P8XtfodCtJMk8rdNKBht12X5uw
 0wwVC5meeFqInSAOfMBvyS2XJ7xx3oVtrgQGHpaJKtN/efdww/JI4VBE5hc1SA8bJ3/eo1e56
 7aHggC1mF6EfBzlus0d+RW7DHdUeJDWRL0c7cIChWCtIVVFtbO9wnVu3G2cmeNAX0Ikt2DMN6
 RtZgX3nQYG6OCClfc0+F9CNAOF6YGcayzv8O9jg3NfVrp9J6DtQL95z6yqThkm6Wa1jb2zlNc
 s5eezOqi04S/chRzYYsTXDZkAFvf+MU2fHqMWH2bpYHgarT1laefMa0RkuXBZgpcg9Ws4Szwe
 lZkBz3pefPnU9POILjJcWlt27r8VGaqFJ0Ezq/yM4sRl5eT1rZV596FRe35OI7OYCPPMU+xbV
 STbCo2jHIS0HAZ81oe3M2hEuck2Csjgll/sZGXiH9QQcuOVWbRHA3/z45X7RBvLs9ZChmjj1M
 VwJWFyr7hxCTyyl4sQnKcHMg6/w97+6IenngdFhumucMhiDVWKi/+MfC+nV61S7QLkS5jh4bd
 QxkgoyJwKVkxFSXH9I4HGRjq0NnvicLD2EyWqSF5vMePVKuiF0L9Mz6o16EDcK27YU0nevN62
 LK35dtD7OSa3ImmZbZVje+Jqdn5DT7PAqUtUlJMebx9t7kAbWDxHiw5/qVNNRNeTPPe7PNC7N
 q4hxuuGSzqzHWDYJPlAP7hH1K09SsBAvAK488l3Na3qRYjchgsHw8YNYkVEHdKMBtF6bJefW3
 UVYcD+YZCwYtuXOww36JaJfJtXKnkHWUwMpQA5yltFr5ep1oEp23b6TGq/g5UmDetsJTsmlH/
 5CEDOfrduMOX7LS9d8PZGcrMjvS7AjnIGJ6byzwCDk16gmogCQKINhHOA

Dear Git users,

I hereby announce that Git for Windows 2.55.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.55.0-rc2.windows.1

Changes since Git for Windows v2.54.0 (April 20th 2026)

Following the MSYS2 project, on which Git for Windows is based, Windows
8.1 support will be dropped after Git for Windows v2.55.

New Features

  * Comes with Git v2.55.0-rc2.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.9.
  * Comes with Git Credential Manager v2.8.0.
  * Comes with cURL v8.20.0.
  * Comes with less 702.
  * The FSCache now accelerates more git add scenarios.
  * Comes with OpenSSL v3.5.7.
  * The diff helper handling Word documents was ported from Perl to
    Rust.
  * Comes with Bash v5.3.15.

Bug Fixes

  * A regression in v2.54.0 that could cause endless "Unlink of file
    '.git/objects/pack/pack-.idx' failed. Should I try again?" loops on
    older Windows 10 versions during git fetch operations was fixed.
  * A bug that prevented proper shutdown of processes launched via Git
    Bash under certain circumstances was fixed.
  * A bug was fixed which could cause parallel checkouts to fail under
    certain circumstances when the FSCache is enabled.
  * Git Bash (MinTTY) now respects screen scaling settings under more
    circumstances.
  * A couple of bugs revolving around very large clones/packfiles/
    objects were fixed.
  * Following TortoiseGit v2.19, .git file validations have been
    tightened. As a consequence, access to remote repositories via UNC
    file paths needs to be allowed explicitly via the safe.directory
    configuration.

Git-2.55.0-rc2-64-bit.exe | 804b7e3392c94c26b5bd3a979febcf5f0bdac04b09d20572c10ab3daca67dd0e
Git-2.55.0-rc2-arm64.exe | 08009883dd388a2de7f6fbaa0e2efafe35d3a041269760d265c0462a52cd5802
PortableGit-2.55.0-rc2-64-bit.7z.exe | ed27e72d93a42ab9f4e62ff0a9f7b54a84c8712d29b3817af60b2a986b0a626f
PortableGit-2.55.0-rc2-arm64.7z.exe | cf1a4ab5f7ba0d35d4a9919d84327fd3e0ca170fbdcea4a82a49091614e925e5
MinGit-2.55.0-rc2-64-bit.zip | 8cb142c6bc4d8385d5efbe0068f8804573e3b569720f6f7f64e90425b92d05c9
MinGit-2.55.0-rc2-arm64.zip | 64226274ad601325aa181bca160529d0d26f13cd64742ce1b939ac096297476c
MinGit-2.55.0-rc2-32-bit.zip | a57922d0c1cd8925f24affee4a42e8e216dacb0ac51f675bbd85ef8e2ebfde01
MinGit-2.55.0-rc2-busybox-64-bit.zip | caf5daa4d5d9b251cc7d109202aee424100bffa12f9e146810255e908d02e9fb
MinGit-2.55.0-rc2-busybox-32-bit.zip | 1edddbfa04d2f544a9f34b275fd9844d3b365d7c318ab29f996bca9bb48963a2
Git-2.55.0-rc2-64-bit.tar.bz2 | a700459442bff0705e62e3441c1f6e5cfdaf191156e7cc06b68544678d663f3a
Git-2.55.0-rc2-arm64.tar.bz2 | 44fc3dfd5235c17fa607dcd9972f7c6b67fb106a4bdbcabb74ab17313d9aeaaa

Ciao,
Johannes
