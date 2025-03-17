Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2E1AAE28
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207648; cv=none; b=K/fsrSHFz732c6FB40kX6tz0YTvhOvhM14IW9Z12SvbMP87uT4foGp3m7r63TXPPXhlg2kJqJJcoNXXsCMMlxvpAkuRzW/zOOtdx+Fy7AXszbtYstOrmWABclAqa3ZQpB0A9pXkt70fu3YqlpehrYq7WnZeyI2uMZJLNNUoSH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207648; c=relaxed/simple;
	bh=BRFm0nWtgSKMFQMUaBTofC3zEpl90fkdTUwV0Lg0MFg=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=IjUkI3w1dR+nJj+wtW330bj6xlwLK7lyKF6Sb5iiWrB81by75MkPBxvAtwGdNPxI7XoHbkCpsrmcvSsHNcrib6tzZrUAvuz14k1DOPeIrmLDBG9/3/jKUeBYmD9F5KW1RciB1iaahC/sjFvLDtuFi+vlV0YK56x+kxU2siFKhDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=EZyeQ7NY; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="EZyeQ7NY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742207643; x=1742812443;
	i=johannes.schindelin@gmx.de;
	bh=KsLRZzeidAvw5Gb2HMiMWUYZnbZ+N4rbPjaOz+qPqCE=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=EZyeQ7NYS4+T+Pmzsf1fEYIhRjQu04Q0T+zKbCXsELci5Q9/iW4PBHkTMWGDnNfa
	 tQfqlIS+sKRVc9zHsPjztFPK8L2g1wLD7tNhXxm9re91hUxGjyjUZMKBbVpsawgiB
	 LC91L7InnL8bqjm9AsgRw3uSMcM07lrFuai+ExXsjxrBeBnFalLgmS9kEJZ+1me2P
	 iDMdKerABruBURg7xFWeIKcjDPl2qevAype4spQh6rHeS3ZYxXfM2b7pM2qUVJf7J
	 r61/iRlxWOYWeYoLuDz/MqiIfHBY6n1hAllzDWTcLMkTSWQ+DDMElDF01emx9NavJ
	 Voank1xQLfCmB2y/Jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.73]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mxm3Q-1szFRd1BVu-00rqQm; Mon, 17
 Mar 2025 11:34:03 +0100
Date: Mon, 17 Mar 2025 11:34:02 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MSbxD-1tn8ja1MCn-00W0XL@mail.gmx.net>
X-Provags-ID: V03:K1:qWh5vkVBfmjt8J7Tc4jztFY7LDmtji0UlfH2VXOoesvVoM0RDM5
 /Op/hdAS3TR1RRil+Vo/PpWaWFv+ZcNo+HF0SzvAGM6VgjONdoheYtjt47GXllVwxogtVKy
 z9kTp6wrXi7N/DD/bhot9gLYUYhNG8277bQZUA8hy1YLc6yfW5zZU6ZZEHrdREvyO027pxI
 rx88aqXmPOk3S1r3FN4lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R3QjPt+AHSE=;+okOFUhEUsjy/JF1jkWMJjwUT+P
 l6MunO55Nu0cVAAKSrTnxxQy81jv2ebCY7uQ2X3oWyRuHsZT7e0dmjixXtWrlV7gUtdrbuZb2
 +A4Cxmvt0d8DA2nzcVYm3WW0h/hHomkZJCIpdaSddKjoNYbejRw5K7ZBb1GEasF1xdDBDfsBZ
 uQu2sw6kuKKjsLRKWsg427hfj2mDkQ69LbzJLdFYqbcBG6WKLF8ba09FPZ+b1kXyiRTAv32+M
 PpEFWlGbROCix8EiBLKialOH9JH/n+30VuYknHiXXnNOPk9CjzkAINdmxJ8EHloC4Zmc/e4ja
 fJzUEwSvlYbAZPpVL4bRdx74QyZkfqFLLYrzgENnZeuW0+fFMlHLW8hMrFDmCBkHVcJJUjl/s
 FI7ApuN1ikhJEqv+o8yFqggr4vkmr1F2DwMJtNOjQkPD+Ps4HSjWLXkL9Lsa2o0wHO2dM8DnV
 TbJylmxCvva9suA0fMV7AFwopTYRNFM8FY+jMfQSdz7H16d9mmzHiApvnLJnF3BsEu7zSbYT1
 0LT43TfMvqgBr7fPYBlXU/m+BFWbRsRO+jjD+NS2CK32b7TF06hbweGo0DCLRL7Nxpnm3NQoN
 QlgGtpmqmK/+hj3jd+f73P2cbIXkOpXj9fIPXpEO26uEXhuncBMP3P6YVZ7qpxMT4nvRuwI6d
 DJ/Ecgf6Nf5IQs9KKYX9KTolvgHCq8b44axJK7ohb3+rbyKWqqCN3HmpLwYR5ulcjI58T7qw0
 PmCPvEN9hQpnYRAKqW29wFCwN/JPxFjk7xqk4B3tBc+0A5kzreV+HLXPslOCPLBem4ny8oFRy
 GoSK+6QvbgRS7RbLeOKIJN6KlxJeNOUydaqbDIFmljYJn0NQjnBXzEMlBQ0sRZ1zcYTN7v/S4
 7Xs8SOrItoVwu9zCx7G2EbvNzHTeXd+arEP5pBpckQIfLb0hRV2o5stfS5vwSuQ16ssSMXhng
 4FylmL8whn42Tp2sa7r+AE9l1Wv7VvY005Xx3hZSKDb1pD9TYyORFzY/KUTrgB8U8xBnIuoiz
 c+nW+psR0hSLIFJlnFrDZPCCWEuJDu6Dc3uKkpYgJdnvuN/xVGYxOMyV8OfQq0LTVcwyxJPag
 wIOpyOvMoHokcHgPYDFmgj/lfC4XCRlPQQ7BsMlj8D217JsnB9cVEo2fEiD93F+An0Zbvrhai
 Xp/7otWlI5GlxzzRWhPsgeTr8qFcNllJaIIKyt6SYJ4tvAo5OghjawgW7jAXhGDa27Yc1FI2j
 a3Gn4R+gzgyGowm4E8jqD5l5mpS+qNhNGwxBp19jUFoBPbC9PO2JjUZpKiJowrSBeH5rt+FX1
 TzaR84gFuWpV2KOE/QPDWNmA0URxXycxDhH/qH5UW+lu6PfkHdpueW23+HwF3vz+HWzMLtXiq
 133Yhew76xOKzHBmJjq7eBcXri3z4W+9I3iZxTJHiPtBkRelphQtEy7+Vnj8CIyzF/OYmV2Ff
 xuaO4bAlbnFB23tdz7nA0vY3WD/kT+9+bnlS50rKppia1Kc11

Dear Git users,

I hereby announce that Git for Windows 2.49.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.48.1 (February 13th 2025)

Due to persistent maintenance challenges and the community's limited
engagement and usage, git svn support in Git for Windows will be phased
out over the next few months.

Git for Windows v2.48.1 was the last version to ship with the i686
("32-bit") variant of the installer, portable Git and archive. Only
32-bit MinGit will be built for future versions, until April 2029.

New Features

  * Comes with Git v2.49.0.
  * Comes with OpenSSH v9.9.P2.
  * Comes with PCRE2 v10.45.
  * The previously-experimental --full-name-hash option has been
    accepted into upstream Git as --name-hash-version=2 and is no
    longer experimental.
  * The git backfill command has been accepted into upstream Git; Its
    --batch-size=<n> option has been renamed to --min-batch-size=<n>,
    though.

Bug Fixes

  * A change in upstream Git v2.48.0 broke renaming symlinks, which was
    fixed.
  * On a recent Insider Windows version, users experienced the message:
    "Cygwin WARNING: Couldn't compute FAST_CWD pointer", which has been
    fixed.
  * A bug has been fixed that, when calling git add -p from VS Code's
    internal terminal, after using the edit command, caused the
    internal terminal got stuck and no further command was accepted.
  * The syntax highlighting of the nano editor was recently disabled in
    Git for Windows by mistake, which was fixed.

Git-2.49.0-64-bit.exe | 726056328967f242fe6e9afbfe7823903a928aff577dcf6f517f2fb6da6ce83c
Git-2.49.0-arm64.exe | 490ea5c2a1cb3ca4071079e262d1cba9331252cad1b76f9df1e89f04a09e761b
PortableGit-2.49.0-64-bit.7z.exe | bc980a64e875304ea5aa88386fda37e8a0089d0f2023616b9995b1ca75b471dd
PortableGit-2.49.0-arm64.7z.exe | 8fa7e49b319b1109173a90a110aaeb0e9004600ff2ed44adc7dfe56ab21e4148
MinGit-2.49.0-64-bit.zip | 971cdee7c0feaa1e41369c46da88d1000a24e79a6f50191c820100338fb7eca5
MinGit-2.49.0-arm64.zip | 847bbe519443cd24c716f490a769056a35f42474cafb757663e1dceca159e911
MinGit-2.49.0-32-bit.zip | 6d6439436d537624f619ffbf5dba49bcdc4ee1219c5c2756277669928fba2b74
MinGit-2.49.0-busybox-64-bit.zip | 600d27b4ed7d86f9bc908c3e6563cfdd14f746dee1e91d5f714bfc9e7472cfb1
MinGit-2.49.0-busybox-32-bit.zip | a6f1b25a1c910381b0886ff37baa3d77d3b662e0a54114ca19244a3f3e9381b6
Git-2.49.0-64-bit.tar.bz2 | 6c5d66e3dd6cd44e50ba7892e9e24ace57934f277a3424c9702a400b3fedc1eb
Git-2.49.0-arm64.tar.bz2 | 48109aaccc5387df498c6b91e5f25c27201dac80b62cae3c576d922b3129a66e

Ciao,
Johannes
