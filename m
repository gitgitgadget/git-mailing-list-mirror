Received: from outbound.qs.icloud.com (qs-2003e-snip4-7.eps.apple.com [57.103.86.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC023E3C48
	for <git@vger.kernel.org>; Mon,  4 May 2026 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.86.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918954; cv=none; b=Fv7G45JNOv5D+7V44gS80wTYWk42weOu4ihVYcHAcOgueeqJj67HUkn1HjYv0sagEy0kvmOIJux18QxftwXjz75qUPES6iHmrp3bcJ3bpDddupRkt6zDWQ1hrOZcFplcQGJ/g3jEVSeqaagW5PGw/JD7o7ejZwKMGkdOcpIFQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918954; c=relaxed/simple;
	bh=MhIJKMuU+ikfka9egI2b5CUSrjXKY+2hM3xTWHDnJS4=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:References:
	 In-Reply-To:To:Date; b=KWsO5m9tcZTWHVMTw/ZSvMVEkJk3BSH+zKAxZrskvf056J5NZxVC5HJGE0cb2gjWjYJZX0+DN0pAnxx2RaT+2LNYeERtzFeWSdG6uSUhX5bw43e9T+z/3mQkimTXlB8nujNndlRXH4RdKCeEoreQuqdNlRXPWSmT/cR+mGQDufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Q1s212bI; arc=none smtp.client-ip=57.103.86.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Q1s212bI"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id 4EE7C1800175;
	Mon, 04 May 2026 18:22:31 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPBkMGWwJeCE0dXAFdEhVdRVIFTgoCQAlIcwRUB10FXVZQAlpLVBQEGVsUVlsCQAk4Wg5bBEcUFxtcABcZUU0LWFsIWwQPH0wMUQJCBVZeSAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEEVABWB5WXloXXk1aAlZNBU8EXw5eA0EBVQIoAikfRAxKcUAOWQQ2FEAALgNZCzQBOgMrDitbE1UXRgkZCF0dB1hHFEcODxlaFFwYUw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777918952; x=1780510952; bh=MhIJKMuU+ikfka9egI2b5CUSrjXKY+2hM3xTWHDnJS4=; h=Content-Type:From:Mime-Version:Subject:Message-Id:To:Date:x-icloud-hme; b=Q1s212bIbWfWS92sxnxt2NBK+9PhPxlQYwwbhOGlt4RH+pxuQf/0ouoVQRFoOFZX0Pgv21/zO79mL/Q/e7r+9LGgGFCYsEVlTmmKyvOCXr94crB667X5LCKmI6KSdkZ9adtUN0/gHjWUiWDr94dKewdWbuufElmaVyIF7ZLU9KANIVJyh8YAVE1QRIecvdTsJKQhxakwMo7tgzmw2AkNNvuympHsKiqnY6O9w2gt8ISfFz8VCiXG4LHBNxdExFknj6WM4G000L5oBIT0qt0J7sNjynyS8goNMnU0gwWwgRlF+cqpJWoYIIJ5JU1ONcGrMQpfMGCLdui94eMmU5L3uQ==
Received: from smtpclient.apple (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id 1ADAB1800245;
	Mon, 04 May 2026 18:22:30 +0000 (UTC)
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
Message-Id: <77295118-1E5B-452B-926F-83C429D8B0F9@icloud.com>
References: <88D33A93-5CDD-40FE-A402-490A5944117A@icloud.com>
In-Reply-To: <88D33A93-5CDD-40FE-A402-490A5944117A@icloud.com>
To: git@vger.kernel.org
Date: Tue, 5 May 2026 01:22:29 +0700
X-Mailer: iPhone Mail (23E246)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE2NyBTYWx0ZWRfX3L+O1wlBMtoU
 SiKWKEcyKCoRw5e1IsbFhYP9I0njbCy67mlsxkZEfQFlhcLccb3/ogvDgIEiakrKKC3JwHFzBNK
 HsrMlVsQ26VpptqgQ8ZsQy61iApfAlplUwFjXp1l0qTY/XQmqdzn3tiKvLQRkek5yIVEqmo+obM
 SVECUDsySPHMSnmqSVkidZ3U0L0UxChsz+WLpP5LebAYZftDJIQBU/H5deNW4FmBDD+l4RTzkX2
 rFiVOZSB8R6Y4Yha2KnPEGJS0SLQ+aLALd+mcPz7nSj8xcUK1cIIbXZUz9zuQolUswpz7IPC62a
 4+3U+VTrvtAAPvhViu0s/c7PqKBIkj9clWiQ9m5ErRYf9otPpENYTsyRqTsesM=
X-Proofpoint-GUID: 0j3oqTP8fd3iWCMZS4P4e4LgM4LG9aAR
X-Proofpoint-ORIG-GUID: 0j3oqTP8fd3iWCMZS4P4e4LgM4LG9aAR
X-Authority-Info-Out: v=2.4 cv=aa5sXBot c=1 sm=1 tr=0 ts=69f8e3e7
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=SLUWHT11B0QA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=v3ZZPjhaAAAA:8 a=uU14XX-s0zQvFckFOGgA:9 a=QEXdDO2ut3YA:10
 a=UoVXzJWRzKW9j2P5KAX1:22


Sent from my iPhone


> On 4 May 2569 BE, at 4:39=E2=80=AFPM, Aa Kk <ahya0000@icloud.com> wrote:
>=20
> =EF=BB=BF524152
> Sent from my iPhone
>=20
>=20
>> On 4 May 2569 BE, at 4:38=E2=80=AFPM, Aa Kk <ahya0000@icloud.com> wrote:
>>=20
>> =EF=BB=BF
>> Sent from my iPhone
>>=20
>>=20
>>>> On 4 May 2569 BE, at 4:38=E2=80=AFPM, Aa Kk <ahya0000@icloud.com> wrote=
:
>>>=20
>>> =EF=BB=BF
>>> Sent from my iPhone
>>>=20
>>>=20
>>>>> On 4 May 2569 BE, at 4:37=E2=80=AFPM, Aa Kk <ahya0000@icloud.com> wrot=
e:
>>>>=20
>>>> =EF=BB=BF524152
>>>> Sent from my iPhone
>>>>=20
>>>>=20
>>>>>> On 4 May 2569 BE, at 12:05=E2=80=AFAM, Aa Kk <ahya0000@icloud.com> wr=
ote:
>>>>>=20
>>>>> =EF=BB=BF
>>>>> Sent from my iPhone
>>> <Contact 3.vcf>
>>>>>=20
>>>>>=20
