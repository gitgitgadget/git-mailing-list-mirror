Received: from outbound.ms.icloud.com (p-west3-cluster4-host3-snip4-5.eps.apple.com [57.103.74.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917E2D1913
	for <git@vger.kernel.org>; Mon,  4 May 2026 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887521; cv=none; b=VC42UWI9w4TrvuPqiM9+RTXqQEpPGnpCKAiVGIVMEs+yN4bWjZ3ObUUR9nN0BlevGhp01VDsXHyjR48IidaitD2rUAw/iN9eKKqyfDJfEoePj6RKaNaaZkbuNCUCAZqkg9DLTgqcr1CLja5fZAAwONgcblqXCfJq6ydGv87vaGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887521; c=relaxed/simple;
	bh=N+DnRAwO4dlUql6FZgin1AHpl5KsbfXS37QUM2r08CY=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:References:
	 In-Reply-To:To:Date; b=gI4nZuUeMiRaYoRNWA7AYuRRGEMgoxVVhq7uTWJMFsv3CZzyA6URMPTPeoM2qoGOUGyOV56Y/UDlXYw1rYkMylwKzK8arXr0HUylK4m1JLRxnQsZSz7Z0aBhPdDpaZ4PrKuu/1dylGFBRXoMSqayzgyfuLfevcJxDr4JM65fJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=wF3vixva; arc=none smtp.client-ip=57.103.74.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="wF3vixva"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-6 (Postfix) with ESMTPS id 6464E1800760;
	Mon, 04 May 2026 09:38:38 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQpOHV4ARQBADVYCWwZLVxQEGVsUVlsCQAk4Wg5bBEcUFxtcABcNVk1YEEoMB1sCQHkRUAFYHlZeWhdeTUUID0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9Mf0sHWXZSBEkUSQJaBUYGRwBLHiwEUnFdfTxyKXMvBUYJOwpZdwJRHFYNV0NUBF9OGQxKHVJWWxNVF0YJ
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777887520; x=1780479520; bh=N+DnRAwO4dlUql6FZgin1AHpl5KsbfXS37QUM2r08CY=; h=Content-Type:From:Mime-Version:Subject:Message-Id:To:Date:x-icloud-hme; b=wF3vixva5E0Z7V8FQfZymhm6K7JlkuKANAVfhWVXHjfNIrkSE8pUHq7YPeP4yNsMxwT9WmDijD9CWdAP8ipbfHlR5MDuIaIubAL7DBagk8s4Vb61gw3QHf05spRii6qBw4lIq1lqoy3YUMFWm7afzUg+50zj5+sxEDJPF/mWN1niNCNiot/PNwmeSGCZJ78qTYPhIS0Nj0mwq9Att6uUUDJo5dIYChxcHQ0cPsl7zkMq26+mZapxxp34Uws99tvNnqU2YTdltNL4NuSe8Y18sHC2Yy8ZqcYhn0RcNWItlUiLrKQc/i6tIjv2ay6eCYixlPIQ5fGZD0ZCPHxF6whUdQ==
Received: from smtpclient.apple (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-6 (Postfix) with ESMTPSA id 2E5B3180074F;
	Mon, 04 May 2026 09:38:37 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aa Kk <ahya0000@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: 10.26
Message-Id: <F344A969-1172-4793-A39C-DDADDD760C94@icloud.com>
References: <8277F598-127D-4629-9EAE-3B0D690B4209@icloud.com>
In-Reply-To: <8277F598-127D-4629-9EAE-3B0D690B4209@icloud.com>
To: git@vger.kernel.org
Date: Mon, 4 May 2026 16:38:36 +0700
X-Mailer: iPhone Mail (23E246)
X-Proofpoint-ORIG-GUID: Y33ICl6uensVomGwAh0mhyrLByBy4dyU
X-Proofpoint-GUID: Y33ICl6uensVomGwAh0mhyrLByBy4dyU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwMiBTYWx0ZWRfX52Z+TATI8gmW
 rtP7x1X8l8LzeZEz5LSAMFISyrIR7djShfN3NunkLbHd9R4gxNQaXYWtQ1119yQ1IicC4AhlV2E
 Y1eTjMKcONFrfta2El8lhfUbDK18Dmt4h196cXLp4+zS0ocpUYm0Fp3654nz97uTfPfQbSlcGQ4
 tIqwjKUXUcC9kE5OXsCPfavb6uP7Gh63WY7Aa7qkd6mz8NZ+ysBQevk8y8dEPUceBsa5qiY0qqF
 +frgsZ9wdDhhnUKLn3BOy75KWMh9qsugBzp4nYB5MQGV/ze7vNuh8WLotTQLQ8QNau3gMnpVoYx
 uFPGDgtVwbDHTu5Df4i25RZMLrT5XkJ6bxCHKmlUW9vu5yYeJuyvttqQSoTNy4=
X-Authority-Info-Out: v=2.4 cv=NfHrFmD4 c=1 sm=1 tr=0 ts=69f8691e
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=SLUWHT11B0QA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8 a=GGtqhd-w0ZFF22iKQnoA:9
 a=QEXdDO2ut3YA:10 a=l7XeHLoSm2AA:10


Sent from my iPhone


> On 4 May 2569 BE, at 4:37=E2=80=AFPM, Aa Kk <ahya0000@icloud.com> wrote:
>=20
> =EF=BB=BF524152
> Sent from my iPhone
>=20
>=20
>> On 4 May 2569 BE, at 12:05=E2=80=AFAM, Aa Kk <ahya0000@icloud.com> wrote:=

>>=20
>> =EF=BB=BF
>> Sent from my iPhone
>>=20
