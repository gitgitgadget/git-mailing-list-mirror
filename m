Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5876745DC
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197581; cv=none; b=moWzPrr5Aks9VPVS7hSg0korYbzPsmfsDahMYV2Y68GXtwbhgUZzG/HyfZRHluCDc8RAcZyHzflEGUFof0fOysEGkgCnfhmqtvYKe8+EJTz26plZRPAeHD+7NHksWRAXxW67Aw+xUqGTW+Pjg8uJTjitODAWoMmOb6XYW+Aryhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197581; c=relaxed/simple;
	bh=dz4+WichKmqAPCtZC4GLEgYuxOIhGgyhUrD5Hfcr6xw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=uBpcdp4FMmzca97ekcOX9Tng9m5yCOQAan9NYB+oOmRwQBTZIe803kUrSutQ/uz+QpEcNKNBBTimtA4HUVSAJaUGgNHjhRi/h+uVSxb2LuSg4puddQdGAhelesYwrnehcUZ84h9q3zsFzFeSaxfUWC34uQ/At7WTa6Zmnmlmha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=GMX.De; spf=pass smtp.mailfrom=GMX.De; dkim=pass (2048-bit key) header.d=GMX.De header.i=ruege@gmx.de header.b=rs3iSl1E; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=GMX.De
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=GMX.De
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=GMX.De header.i=ruege@gmx.de header.b="rs3iSl1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=GMX.De; s=s31663417;
	t=1706197576; x=1706802376; i=ruege@gmx.de;
	bh=dz4+WichKmqAPCtZC4GLEgYuxOIhGgyhUrD5Hfcr6xw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=rs3iSl1EXJyfAZoElPDGqKXnNjCJcJvNEaUXAlPcQ4y2RwafL8XnaoZdHqoZZ47d
	 LwR2LohtYqgYATbpPZsdTvztGeF61OH3G/Ng+2EC6adt9XVUqw64IRSLKI62cBDV4
	 v8VN3tqj9oetMiDCVbSDjrhqdi+Sv0zKKixrzCX8cBSmcoORS9LBTMiuBQkS9iWCX
	 3ayA5PlGD0IkyCDYMa4scKHgFZQwiZqxZXmggtrka61jG7u+6TtRgHEOwNVmqyWVf
	 /Upx6qqExIjKPRT3mtBElIw3dzaDloyunYLqj/HcQZ5F4LLfrd3YYGi6QdhxvR0hg
	 VMfBYUs06N4pGb2lxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.240.1.107] ([77.189.146.233]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1rg2Tj3UKR-00Mrut for
 <git@vger.kernel.org>; Thu, 25 Jan 2024 16:46:16 +0100
Message-ID: <05dbb2da-203b-4e12-ba8f-a46e1fd3f622@GMX.De>
Date: Thu, 25 Jan 2024 16:46:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: P. S. Virus detected
From: =?UTF-8?B?SHIuIFLDvGdl?= <Ruege@GMX.De>
To: git@vger.kernel.org
References: <a96e6744-c0bb-4f6e-9066-646ca15a353d@GMX.De>
In-Reply-To: <a96e6744-c0bb-4f6e-9066-646ca15a353d@GMX.De>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g+TCsdyoxQfDDlnMenlTT7YIiYZC95YCArd4R/vL2Hc8NFS3Dcm
 7+Taj2hf+JZjgtB0WmpRg08VUs1x1c3kWOd1Qb4yPkyXH7HP/Cdq7wxXldj8VAe4idzjYZH
 QqCgS1XBqNH06tM3HIKpCuvczeJjgSlwqK3BKed7jNPnTBewuO3xYdUtmdWPoZmz/tOT2Wv
 Dhb6CSCj3Kn6xx3PPN53g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lcl0s6xoCdg=;WNtEDwwd6GiTWtzPFYonGNum5pd
 tp1KAdrLjtdMKOCsD/Lpxk/BlI9CUcWQKUNk/rReozITRVp/HRlN8bkrZRwQI3539e/scQX15
 xZfMTYm1ow40puOVSqpl9r7/557XCAo3WS13x0a7YWK/7bvf1gs50Zpb1yJ3n8FKMGkkZHf1/
 dJD+ZYI+Rh98KqhXiYg1W0m7FdwpAGKE/Gem7v1C3Es0dvROTlk9Lkt8FbzfcvI89xTy7jDD/
 W5H8wcZnhztGsgGgt+DYHx/V/wkNQpc7OfToOjCk4mQTZ7pZjUT16HvHwlBCnAxWqlh0KORo2
 9Dkvrllm62LGz63bXg+OTX3hSbCnTSOEu5aQAp3cYQNMg2KlYMzkTM2+BId77YejG2sLKdKmT
 gvoogEgqMnynU9yMtQF+sZSZRgG370SEGdxzl7kT5P5rsaobaywRQ2ldUjBAj1mOOIyB6BZxL
 4uunCx1DrFh/G29B6uhC4eLPs1Bgbpwx3D7oTkj5mJ7ub4KKzm4tC5Bm0h3S5GGrPvZm01TOd
 mngjXmkDslD7QZr24bOQz9HyuyJ+x3CWhADKXlDaVUOB/IqTgmiOrHf8zGunosqAIG4tyY9rX
 Hq0unN6S/qLkYKPJZa9PiHcZtcnPnuxfiLneVX5DIxe1s2NiI2nkw9W8Lsv1Jo+dRGfSg/1dg
 p8DzwtUTIW9zZdyOMQ9SVkWCsCT18MSVQGrW43FBarJhCsb2FbFx5knRH0beEpC0TNsYsHk+O
 h7HzJKvLLZ1euOoiVwpka3t34yo8ltquqIhv7KdF5c/v4EYAi2lFjvd83oQgvfDDRPC4ScC61
 4g9iu+W0iwazGCBbGc1yp0o6If6cBkR5ywmNBfPLISRK0b78mM9s6p0XaAmfoonTQX+TeTyXA
 6H1hXpZnInhrfDPkKmWUs85vVQKeB8bRB2nLHtNQfAqHjPMDa9xa94OAxruTV5FfhcQceQIk9
 NPhCMn2AeFmwYBAlvlVq3Ht5DL8=

Tried a few versions:

First version WITHOUT detected virus (avira.com) is version 2.41.0.3.
All newer versions lead to virus detections.

Best regards,
Martin


Am 25.01.2024 um 16:23 schrieb Hr. R=C3=BCge:
> Hello,
>
> trying to use windows version 2.43.0 from https://git-scm.com/downloads
> my antivirus software detects it as a virus.
> In parallel something wanted to change my hosts-entries.
>
> Ist that normal?
>
> Best regards,
> Martin
