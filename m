Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F49135418
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740949; cv=none; b=bZy1jHQ1BTe2w7CPzf+lvDgr1SppLGviI6wrRAp5WQDYuUEixDFydzsP/E0nqCXpqJTAJsVoYkYjeSbyyb8OKG/YdLAc4Ecn4/8SnidetyZvjr93f2wQxirr/L1sM09VpV8Uq6D1OyeOqoRPzREvPHr79xSGmDl6tHpNyZ1fdY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740949; c=relaxed/simple;
	bh=QHxtSm6lEmPsmwNcuaNcFAFQoCw/odr7kdBrnOddRqU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=l8JE32AT/sF6D9T0jSYVVetmTU7TB6LGsKzlSJ3wr/MKb8Cns9IH27ag1gAry5Yil7ScQDsogjGNyeMPYHy1bMLM+eB8PUxIsW8ebTWWJBC7MEwpwZDd/ojeuIM8OfbbgUptZ5pOAxOoIEUfddRJXG2EqyUJPwz+Jrkur3xrypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=andreas.luettgens@gmx.de header.b=OPHWXc/D; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=andreas.luettgens@gmx.de header.b="OPHWXc/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709740945; x=1710345745; i=andreas.luettgens@gmx.de;
	bh=QHxtSm6lEmPsmwNcuaNcFAFQoCw/odr7kdBrnOddRqU=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=OPHWXc/DiFexAqH67fpi3i6UGOH+s5l+0Drg9JzMbuLExvo3msH9YV92vqOU9qCo
	 9oFHPY/oZDK+OFJmZ2hKOpD42ry0+dCsChx1IZW9EWzFcZLywXR4xewjOUDFw//C7
	 AKemLcK+sMzE2jQqyHQOPn2X654v4FAe/MhDP2igbNNGvlCVRXqtFcRbfTcCvAxji
	 bqKyI37JbFbvFAatwNkJ3sthAr4rLhnW1hJ97Xh73n+Q+J9ScgbfYirEIzpHMiR38
	 GFtue7ngRPRxij+txSm1Iyv5qsgZBzq+pxrxO9b/pkrTDAvf6NezTl9lsCNFQV9Ux
	 8RA/NvPjltCMpuT5pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.92.17] ([109.43.241.222]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4b1o-1rjY9O3lp8-001gDi for
 <git@vger.kernel.org>; Wed, 06 Mar 2024 17:02:25 +0100
Message-ID: <b2e88c02-82f2-473b-83d8-866b0e73bac3@gmx.de>
Date: Wed, 6 Mar 2024 16:02:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
From: =?UTF-8?Q?Andreas_L=C3=BCttgens?= <andreas.luettgens@gmx.de>
Subject: diff on the commandline
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:umv5C3Tj8sNTog1v4mkW+gTaPPeE1z7UR39pwqOU8j9dAnjcFZY
 8ouJA8ZQTxZP+R5hNgkhMhpppyV6J90t+7gKEPUkea1k9tLxtxvaVO87QGAiUiw7ElKWuYT
 Te7J/IJeURY3cTX6GjEYgDeSmrFAfsvNVw/gB5E+ChO6J+hmcDC9366PdMfHoo6IfJg95Jw
 bHPVFmDB+/zpQPg8yqkDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZTZi+6fnbjk=;gUOKZaFMmE3AghdZIJA4/OUQqKL
 DfUneE+7RPe7FmN12rH6dQpN4+AkHnfQb/xpaKXPI7awPWqxjXLDEzxmBT3/iw9cIwadV7Rw/
 /Ohu/N2qZuElAY+5iFOoGy0qMQDhkzsSEZj2aEA97X7bFwd+OZWh66WyiJ1nhaeXajsLB8ON6
 K8l+OWcG7VW41OQBQwJVm5tQtvfGDB1z2rqsrES7IiChcTN516cafmM8Uj7sL+X48kJFwSoKJ
 DTWRAxrVqhC9zmqMNRBcrw9aQCbhU2Xph6yaF9qUTXhsm7LVoVBQ7ctbkw0Bj5O7QB/uhQt57
 Zshm/lNmDSzZ6ebdNwwfL+S7g+iLU4Gyq9rp4ty2XXx5BAJKDflHg+KmCop8aWqllS9UKHcQ6
 8KVn3LU3Q49xV3RhK8qykNcIhTan1m882cslk2QREbVH0kAmGugQqfchYEJ/fHRa+PUR8DlKI
 AG0VHOzNarT22hoC2SIW3l64qFZzSuGzmzjFV0X4CQ4fMDpHzgp151Sl/J0bpMJkkEJdv56bD
 Rx2vyLV37M67yJdHz0kLrQk8H64YExH951P3bvbhb4I68et7u44Hlikp0uGx14zIyiw/qx8l5
 CY1V0IMqWX5Lg4kIc/9WfLbzZdpAwVLKfWtZecRpo1f9e2rS/6AWTH00+j3pg5dpxHzp+hBPG
 VV7CGz1jjWOEcIedQ/8+yJfZqTupdyY8i+6lVkM4blsEUbyNDBmQHAlKVxnE1tjNssrTBZZxZ
 PSWtpmTTIhqEOKcL2pSGdHH6c+OyzNDolgYj9h7xRhpBYKioq4mb3dQRZn/bj+2wzITsEr1Jp
 kxWqvDZxhjnSvvzUV0Bh5TfK+W3TmZmneehsCoI8AlSUs=

Hi,

like the new feature of diffing against the command line very much.

Would very much appreciate if pressing the ESCAPE key would stop the

git command and return to the command line.

Thank you for your great work,

kind regards,

Andreas



~/src/prj/lit/manual/wdfelements master* =E2=9D=AF git diff ../
../=C2=A0=C2=A0=C2=A0=C2=A0 HEAD=C2=A0=C2=A0=C2=A0 master
03e57af=C2=A0 -- [HEAD]=C2=A0=C2=A0=C2=A0 wdfelements.pdf (2 minutes ago)
cf8d179=C2=A0 -- [HEAD^]=C2=A0=C2=A0 CALIB_MODE (5 hours ago)
1c402ee=C2=A0 -- [HEAD^^]=C2=A0 .. (6 hours ago)
4b7d0b3=C2=A0 -- [HEAD~3]=C2=A0 .. (6 hours ago)
05d9148=C2=A0 -- [HEAD~4]=C2=A0 .. (7 hours ago)
69d3458=C2=A0 -- [HEAD~5]=C2=A0 .. (13 hours ago)
cff7654=C2=A0 -- [HEAD~6]=C2=A0 .. (13 hours ago)
51ed121=C2=A0 -- [HEAD~7]=C2=A0 .. (14 hours ago)
bfc349c=C2=A0 -- [HEAD~8]=C2=A0 .. (19 hours ago)
8172043=C2=A0 -- [HEAD~9]=C2=A0 .. (19 hours ago)
00dc48a=C2=A0 -- [HEAD~10] .. (20 hours ago)
c9453fe=C2=A0 -- [HEAD~11] .. (20 hours ago)
add366a=C2=A0 -- [HEAD~12] .. (20 hours ago)
cda039d=C2=A0 -- [HEAD~13] .. (20 hours ago)

