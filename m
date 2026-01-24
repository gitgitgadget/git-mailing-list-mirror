Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C329E11A
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769256545; cv=none; b=ptb1h3gNsWnWRczOYSp0EMymVShiI4QiaFg4DO0L2PTU2VD26fPaxu+KC0I1tgHgTdX3s0aewZaqbduWWekxlw9Z0wvlyxKqZe+69qc+eN/romb4Iy0lmFhqP41FMGlieAgEFwuXfPYfV7w4xipKarlr6BXztM2ev//eTOGMXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769256545; c=relaxed/simple;
	bh=soRhfYRcetgKbw/ShOY/8wRGICAT7cLfk94IArqli5w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VLwPf3Nb5kDdowv4E60xLPkNl66r+q0HbUQjFPhdNeiJ4f97/GV4UjXixoomeI6QcJfDQPJT/n7tBkk0zi10v/rcjHrqHwE+N6CS1PZRAM5RFZb4rz1+3ZBIHl3vP6f4inbGBffgEbdu2ww9u7LdSaFEB2SlJR/3vz9Z+VkH+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=RPTS5kuG; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="RPTS5kuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1769256540; x=1769861340; i=christian@heusel.eu;
	bh=9Vi3+VNYP6G3t/XFVto+sVJoc6NxCSN2byLyxVKO95w=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RPTS5kuGvx7Ek/mWAOMd6umTXy/zw7bktQQzR+v4XRbuLlAc2f9H938ixBxrvc7P
	 Uqnwn3RUHxG5E+ueuemguTOwlAhEBnxIcA4OwuJgIM+6Y06w8NKX3R+95C/ZhKIAW
	 ohpKfvKQWqU1f4X4l6VYalOH/Pg7GaddUmpKnFgXhZsQ9QUmZ4iO1fV65XLsB9znk
	 bNN/7M+/XmJXE5+6nUzXTWJxGDVUEIEQ7vB64MkBmvkBiAEbf9Bn38Q/8+3lLDjYL
	 E5iwtn05ptKhzvixwoc5ai5GSOLSqF4cfsEvCfLIknPQCdUvvxQtCFJpjt4Wnn4XE
	 RnhTphJYAg493Jc+dg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.239]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1Yl9-1vmeKJ0KmR-00Gno8; Sat, 24 Jan 2026 12:43:44 +0100
Date: Sat, 24 Jan 2026 12:43:42 +0100
From: Christian Heusel <christian@heusel.eu>
To: Colin Stagner <ask+git@howdoi.land>, 
	Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Hesse <list@eworm.de>
Subject: [regression][bisected] git-subtree remote desynchronization
Message-ID: <755578cb-07e0-4b40-aa90-aacf4d45ccaa@heusel.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fgp756gtcnponeyy"
Content-Disposition: inline
X-Provags-ID: V03:K1:GKWtfO+fQQxEqMnqRjZ66fTyL+Zu7zYTPUTUxhIQP7C75GLUwzT
 cqA5UuSgMlHaC+R4XTeLfz0RzVw7I+ISLL0kUYpjttqpco2IcyudsiFUnuiUXQadbvo0Ns0
 t7vde1HOYYUNjZKNzu030f6LAZ0DRah8f1jdWQFslzZXIl9QlOTax87H/tUi1wi0HXir6ZE
 7/8IkE78jd0G+PVlbVARw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uUmtvwjflgw=;2YUQkoJ/dPTGi2s2e5TgHAGmlv/
 q6mWjLN6mCnm1kFslBiQnqsKnlgvI+p814Ad72XyYAPilzSOYIYoioBydaqxTwMkuSKHBmgk2
 e2wlEhRjPbxckEXCz635IWN3hK+R9yJ8hOH3649o8yz7jsz2zOI8NxRZOJAdVBproT8CFevDr
 VASgYhn4Ft+cCKLaOqK/OluyyzDAvuXJn405QrL5deVSWOelPUi7DvEGYId/a8uawMqgLAMQw
 XRBaRKX5IFrGOJ9PtmT9G1MmuruGXtr8fzYBaxClsd4uuE3G0oaGZj+A6ID67b2wY+cO7A10l
 gp4DIRODvlCdu02EOu1rH2s0TDGNGZnEu++9gLruiYp1NJc/2i3XJ6UezCFY3JAL3RiZkr749
 K1jvJoOkHmvx7UWuWOxXwD+FFQbU0TezIZsT8vsFs2v/8KRldbyAWrjcJsMewNsWcUjeXiX5u
 nGW2GqEfxCulYxXmAxnQCSgvXEngMkxZ1NjgMSMQrNEAy/E3PD6AfTmZvjNrqQfueX3grsIwr
 34ejP2Pmrz4ol14Eh5Hq9AsOSSR0jla5jLLrsiQShfHOwGJGE2gf11cYSDmcKO3HZQbVakMI8
 YJKOXDU/2AvoC5GNs3fG+TXbt37Un5tQdeF8ZMeanplGjek89iX/PlhHZwZ44ySxTPXPEwEAH
 Zu9C1wXWIKOCcbCDSM3pF7AeJTtdzu+xpdRua6Kr+RL+INhvsUWP3Q53apfrSUmKPeIPu3f+X
 xpKa/Ki3yn9GdP2Munlg5RALSOPXdd3cYpVDRiOC1AwyWYXQhspDPsN3zWBIGRgZSOA+Tcj4u
 2fzvg5KoZK8J765A0qOs5/wZed0tBAPiv/Sww4InmiIQEP8mEnRmC0hmw4XfMihIS70XYuPXS
 glXqAvaJBmykp2z6emKJs5pqz1X2Wg4BtnAzdMaYjo7mRkTQmQ4KFlSnw7SuxSGqpBQgRC+9U
 asLTCMjH0MABIOl9vi/+KIBxFJsSqCxgtfLMcdCLnanuckoWkzUtAvuXkmwUNOCN2C1i2FRIp
 WG5Ys/itbYm5TPGX014neJM75Pc+3Vg5lvNwai/o7UtOhayXAC6uyoRQh6n7WYsyBgeypp2/C
 wstr/MY+tFqCZUh/FL9JqhZIXJE0ksj4v4+ePK1bFeOYqoQtJsdBR1u8/g9J86t7AMkWq3kRK
 Jlva11CXOhWxoXwmHTG14u+UMpO6WYa2h4mm/lnKkUMcI8FILt7EUPyD7i7JDUfOWO9iRw36p
 WrmJBSEIqUYRzad1iZ9XILpKLRRLNBPd6WDiJRApK6QgnWLiFVkgl3XE/vvLTKdnZhOvPbAHD
 22WCtWG+5ulGSzZ/f8j9b5zrSfyza1bszaWY9qktE0REk+9vH5cSOqMse7HmKYl8BC0gGybQP
 w23ZtDHh5zajuOoL2QlzD8fTT73WKZ+QBMuTheQg6jM7pi4cQAPxpMq0ylJci+pR3g25SCb5W
 6zOMsQx46NVNVQyw2p5gSpJhQwQSRU0ZgRZ8iuzzDcqAzx3p4eXgy8sQjgeUPvkcdvQI0UraS
 CdO3QdVagaspKCFo034OzUq9sEhTTu2JzJi4pxYq92GeR705bbl0hnUX0hUc+L673RSY4bnu1
 uFvRMwD1oiCA/Jre9QqUjq7Nqbo3Q2zY2GYuf6PFjebs9s58VrWy0XBDic8UXicQ68iFQuguN
 A6cC1P88KICRBMz6PYnqp8Njvr9uT6dXC4r/YbK7NPnQ/KTbpRxeeZ7q6Pa7LSnjkjTknMuQp
 2g+7NwxAeoa50NfTJO8XmJF1qs0+2Lxrkyg==


--fgp756gtcnponeyy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [regression][bisected] git-subtree remote desynchronization
MIME-Version: 1.0

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I have upgraded my local git installation from v2.53.0-rc0 to 2.53.0-rc1 and
noticed that I can not use my local packaging repository monorepo (via
aurpublish) anymore.

The steps for reproduction are the following:

1. Update to the 2.53.0-rc1 git release candidate
2. Clone my monorepo for packages in the Arch User Repository:
   ```
   git clone https://github.com/christian-heusel/aur.git && cd aur
   ```
3. Push changes to one of the contained subtree remotes (this would normally be
   done via `aurpublish google-chrome`):
   ```
   git subtree push -P "google-chrome" ssh://aur.archlinux.org/google-chrome.git master
   ```

What did you expect to happen? (Expected behavior)

There are no changes expected since the repositories are synced after each
modification to publish the updates to the AUR:
```
$ git subtree push -P "google-chrome" ssh://aur.archlinux.org/google-chrome.git master
git push using:  ssh://aur.archlinux.org/google-chrome.git master
Everything up-to-date
```

What happened instead? (Actual behavior)

```
$ git subtree push -P "google-chrome" ssh://aur.archlinux.org/google-chrome.git master
git push using:  ssh://aur.archlinux.org/google-chrome.git master
To ssh://aur.archlinux.org/google-chrome.git
 ! [rejected]          70b3d81e370936e96f98d0aba357490b75ade7a9 -> master (non-fast-forward)
error: failed to push some refs to 'ssh://aur.archlinux.org/google-chrome.git'
hint: Updates were rejected because a pushed branch tip is behind its remote
hint: counterpart. If you want to integrate the remote changes, use 'git pull'
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

What's different between what you expected and what actually happened?

I would expect the `git subtree push` command to stay functionally equivalent
and the change mentioned above regresses my workflow. This tool and setup is
also not really special as a lot of users within the Arch Linux packaging
ecosystem are relying on this workflow.

Anything else you want to add:

I have bisected the issue to the following commit:

    28a7e27cff ("contrib/subtree: detect rewritten subtree commits")

This is my bisection log:
```
$ git bisect start
# status: waiting for both good and bad commits
# good: [7264e61d87e58b9d0f5e6424c47c11e9657dfb75] Git 2.53-rc0
git bisect good 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
# status: waiting for bad commit, 1 good commit known
# bad: [83a69f19359e6d9bc980563caca38b2b5729808c] Git 2.53-rc1
git bisect bad 83a69f19359e6d9bc980563caca38b2b5729808c
# bad: [0a5dcc1259fa0c8f5c21352c90b3cd3d43273345] Merge branch 'tb/macos-iconv-workarounds'
git bisect bad 0a5dcc1259fa0c8f5c21352c90b3cd3d43273345
# good: [ffae4da0128e035acd1887654c98b4f02785adec] Merge branch 'kh/doc-patch-id'
git bisect good ffae4da0128e035acd1887654c98b4f02785adec
# good: [6edbb7b1d0b50c70e2af0b5f68b7db0984b10be2] Merge branch 'en/fsck-snapshot-ref-state'
git bisect good 6edbb7b1d0b50c70e2af0b5f68b7db0984b10be2
# good: [9813aace1e52765e01e688672cdcdcbe25336ec7] Merge branch 'je/doc-reset'
git bisect good 9813aace1e52765e01e688672cdcdcbe25336ec7
# good: [d28124151851e42a3bb92963f5b747ad843f33e0] utf8.c: enable workaround for iconv under macOS 14/15
git bisect good d28124151851e42a3bb92963f5b747ad843f33e0
# bad: [79e3055baba32e2952e6e8994cdcd4fc145ba7f0] Merge branch 'cs/rebased-subtree-split'
git bisect bad 79e3055baba32e2952e6e8994cdcd4fc145ba7f0
# bad: [28a7e27cff717e5ef91f7445e6a418068608082d] contrib/subtree: detect rewritten subtree commits
git bisect bad 28a7e27cff717e5ef91f7445e6a418068608082d
# first bad commit: [28a7e27cff717e5ef91f7445e6a418068608082d] contrib/subtree: detect rewritten subtree commits
```

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.53.0.rc0
cpu: x86_64
built from commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
libcurl: 8.18.0
OpenSSL: OpenSSL 3.6.0 1 Oct 2025
zlib-ng: 2.3.2
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.19.0-rc6-1-mainline #1 SMP PREEMPT_DYNAMIC Mon, 19 Jan 2026 06:13:35 +0000 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.42
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
applypatch-msg
commit-msg
post-applypatch
post-checkout
post-commit
post-merge
pre-applypatch
pre-commit
pre-merge-commit
pre-push
pre-rebase
prepare-commit-msg

--fgp756gtcnponeyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAml0sG4ACgkQwEfU8yi1
JYU+DhAAwaxCEMvIdhIea3VC2QU8dygS0lDwim6gJTTL3VEkLhcPBMYX7vtN7WRf
dqjMi7jrAugDsx8toBtl90PY5uI5m9uZ/nD/jTlWpapmxB4GI6ULpeJDLxj/0FkT
hH9tAecoi/S6aUG/buaWkN2tT8CthsjWbPom9SQE5CqbPqXQSVujiF1ZyQjzBzYd
b11PojCInrWErOpBDqYINa/icJ7FcxfH1hoCkf/1+olzzp4GxsXCj8zppNif2AWD
jZVTXaQWjpKhTec68cott0/TsWt2R1QWyq7dlukeIcWlRmVNrA0+FmKXCrHjwERv
5A+1X32ZIc4/XKPYrjX/+BIUdYql4aAf4o7TGBFjXok463qPjRD6gaXWW3Sc7sUG
bOGSQg3OLzfwkRHpEx/28b7E57bE+zWoewsxkiDJEJt/TySMJCP4OD/3heOzl860
5qPthJXFnaa8PTmT9c4hM1QRR1VuTM0upg9FL+l/grCRrvCjrUTyO92Z/bUBE27D
TeEsM6rgXDAY582RWgXhdRl2ab2YD97POvVxWtot4pPXMuExpFE777DyOpSAVZBp
9Tx7h2FyC1PCjdn12OQOuPdUiOrDO3pknLiTLltnivi9vzDRlKv0ACVh9/vHBd2K
teT08rTh2m6q89O5lRfbGW1DZ5YF+8bY2XMHAhHuer6a9H0g4q4=
=l+PA
-----END PGP SIGNATURE-----

--fgp756gtcnponeyy--
