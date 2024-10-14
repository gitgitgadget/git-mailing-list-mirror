Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B58E762F7
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885768; cv=none; b=NVSfkmAxNQy07dB2x8YkBJelyN/hTeLruSk83Ww7Uu130LSpIPZTYqtnsyPmirTPG0NijYxqi5FecH/VTR0T+PRH/YDhLz/1uzYKCU+aW6SYja0SzG1dbpzi3lI5e6BbI96ETnLgeTO8l6IOcYiNry9bzKwjHEBuTzk2atgfUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885768; c=relaxed/simple;
	bh=+nXunkokkHcNnCnc68wJdF3BkvACpRKGrKzSH4G4fOQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WZuagSqQ2FMe1DzC0bHgEodNUVMrrvxdoI+EzftoQlqcyGWfzvfEF0Q6ULbcLmvCY6sxof1bsDlcC8vM+cffoEnmwjI53P/7i7Asi781EigieexMQGb2gGEsmKJrJQJTaj2UYwCRMgXsnFpaCT7otXRzyK/Mz4ZlOOvwcR3G8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=LPK/nv5V; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="LPK/nv5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728885756; x=1729490556;
	i=johannes.schindelin@gmx.de;
	bh=7sQavdsEJNT9f3O2b12AVJ4rs0bjBU49IUJ+20iP0Go=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LPK/nv5VcsPKi55UnBAU9Z/VfgXaJ3K/2sLeUl38nQBVgfA57SYcE5Rez5tkrj3v
	 gOlfJMhrHJRSYJaRJT+OSZYQJkUJ+B04VPxPtNOCYxFlmROaTZ1v47tjrKQnWnuy+
	 2x1TLnUuovKjRkhCXOQd0eWlrYn4u4yWJUE3WWvB1lnse3qYdMnVvyHLc3Ux4J+sT
	 6h8r+pNBJpTzbcxa/hy0Ka2I7j+vLOr+kvimY7cOBTq8VvqQ4upEDirzMtb0KwuKh
	 9kKoIoCFGu4yCOmmv782BiBvykQvGExdoa2xidCggdnE1KbigmQGMjQoRCstbHdnZ
	 WIzuLsP+MgS33fTn4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([95.90.245.139]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTNF-1tLSIr2N09-00IBCE; Mon, 14
 Oct 2024 08:02:36 +0200
Date: Mon, 14 Oct 2024 08:02:36 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Koji Nakamaru <koji.nakamaru@gree.net>
cc: =?UTF-8?B?5ZC05YWD5a6I?= <wu.yuanshou@foxmail.com>, 
    git <git@vger.kernel.org>
Subject: Re: Bug Report
In-Reply-To: <CAOTNsDw58poRNMpKiCOTouH84ah7+jvMfM0OPj-Y02Bo2O4kXg@mail.gmail.com>
Message-ID: <9d2d6e7b-9691-4c9f-9b13-f1019cd1c491@gmx.de>
References: <tencent_D0324DD61B7E04E0B4686FD8761E1CDDE108@qq.com> <CAOTNsDw58poRNMpKiCOTouH84ah7+jvMfM0OPj-Y02Bo2O4kXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1881731966-1728885756=:87"
X-Provags-ID: V03:K1:QYKZZsL7DVE32aFxyy0Yn+kStqpwcD2dQqvOJ3MI8gQdaitaARK
 74l5d1ZobXm5rrDtcbxRKHIqwtTlfulRAfuZPhpSNEoBNGVqDpxunHf128gOYuU2z61NiSn
 NHcOIAEpW65paWsatU2LRmmuWLf3D/G8cOOpDSS4NSq0/eGxhKOIpeUQ1ke9FBT4H9FeYW4
 pgICIyaFC7J5Yma9lIrrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SXTXWUtuKRQ=;78f98Y9gzW5RUm6o4Bdlx2Wn2Rf
 OdQARe3VFfPOOD07Ntm0XzQS2Z791PzwWCWpvPW0f6G++9oCNhgQUHE1Hd6J1Ue6TZWz3p0Ed
 KQdaqQLRFYhGZzjNH01Jq05j8NG3udaKSofSiDUn6w5FWlkCFVZ/yv1ochcSh3r4B0Av9kaIH
 CFAaoN08swByhGDBb9LwlKEjlDzdcL0ZzC3HvY4/AzzhITxOa1wqFi8QYFMq9EiUURLCjWeHA
 NrSUx6kIY3gHcT4OEGiyzUqaYvPbgzR5eoz3anYH2OPdFkrrE1Wc4Py5j3CujlC4sxYG1nOrX
 fV+UB3NfNjj65wlmN62aRjQRW8cFU6/G1Uc8jS2vdD+BVBy5Q3nqbaFL9TX1coRcB+/FFFkkF
 cEJ3msy1s4/lA3BgrnmGd1egvFQn/YCS+sBtLHa5R+CsrdxDTGYb5qGs5BgYzAG9lFJGEf8gw
 8u49VLLjYo10tQbw+1RPH3ueW5MRc0smomphWa/PF0XhVU3q7L9rMLLkA4EEE6Ag77MybK+8n
 JWtczB2pbwFTpSnLkJSV3E3LSJ3amGTUIoPV/poiZOoR0SfyBhQrPL7cJmJ3/sTmEHN1ks/t3
 VZGMsyFOT8f0237dBgx/uyVFGtrDSkyi7jh36K05rngRe9WVes+gLgm7BaXCyQ20NPPf8LD11
 GraQ5pMxFZ33Rc+j1qty8MmZs636zW1jDvhRXbv2PLXe5BPg43/4fB447NqsW70jHVfLHflWE
 4IR4kcXabCCSiJIXX3zRn1AXkMmsRH2ibQsLnHKudMi5f05Mj8PNZuosGpiBXGT0ssvoAPvsP
 xeDU608REDz4+e/kv0P4HJ1w==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1881731966-1728885756=:87
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Koji and Yuanshou,

On Mon, 14 Oct 2024, Koji Nakamaru wrote:

> On Mon, Oct 14, 2024 at 12:46=E2=80=AFAM =E5=90=B4=E5=85=83=E5=AE=88 <wu=
.yuanshou@foxmail.com> wrote:
> >
> > What did you do before the bug happened? (Steps to reproduce your issu=
e)
> > Update the git version from 2.46.2 to 2.47.0 .
> > Clone any repository from Github using ssh(HTTP is not affected).
> >
> > What did you expect to happen? (Expected behavior)
> > Clone succeed.
> >
> > What happened instead? (Actual behavior)
> > Git clone hang for a long time during clone(Maybe hang forever).
> > &gt; git clone git@github.com:ibbles/LearningUnreal.git LearningUnreal=
2
> > Cloning into 'LearningUnreal2'...
> > remote: Enumerating objects: 3416, done.
> > remote: Counting objects: 100% (360/360), done.
> > remote: Compressing objects: 100% (261/261), done.
> > Receiving objects:   2% (69/3416)
>
> I was able to reproduce the issue. It seems to be related to runtime
> changes. If we replace "C:/Program Files/Git/usr/bin/msys-2.0.dll" with
> the file comes with
> https://github.com/git-for-windows/git/releases/tag/v2.46.2.windows.1,
> "git clone" succeeds.

This bug has been reported at
https://github.com/git-for-windows/git/issues/5199 and has been addressed
in the latest snapshot at
https://wingit.blob.core.windows.net/files/index.html

Ciao,
Johannes

--8323328-1881731966-1728885756=:87--
