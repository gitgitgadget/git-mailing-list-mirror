Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0B2627EC
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699189; cv=none; b=NI5Lv6xVplcpdc4goFcsn11mWfIjDTAK3mqP40rHbWUFReaiMn5VEq337zZNmVExx+38012icS45496cpCBqoK8Nff6UqgaJOrKNSXu5tMP5363sZ7rq0LJwgyrld61CzNzQzooHb+oA/WruY/iGekm8RIMSZ6eDxS5cM7hnkD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699189; c=relaxed/simple;
	bh=6lTGko2zbkLZn2n1MNjgOS0nj6/S99eRs8Te8K5kJxw=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=XFdaoCqlBfyiVEVwAoXTesmdSFRBBGC8MO+98NvVtqLo2S3LrW+rRFrKFY64MNN4rN2FtIeUvaT2fRMkp5dRQVIIjZI6mbHyn9vILdtdVb7r6JedvyimfzMv/beWGLxNJqCAX8KcXIbRruiSwFLvk7/ognGZdlIJhz8bibndIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57KED12B2657468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 14:13:02 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        "'Chris Judkins-Fisher'" <chris.judkins-fisher@donorschoose.org>,
        <git@vger.kernel.org>
References:  <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com> <011801dc114b$f38bb130$daa31390$@nexbridge.com> <37da14fb-fead-448b-b6a0-853c9fbea653@app.fastmail.com>
In-Reply-To: <37da14fb-fead-448b-b6a0-853c9fbea653@app.fastmail.com>
Subject: RE: git whatchanged
Date: Wed, 20 Aug 2025 10:12:57 -0400
Organization: Nexbridge Inc.
Message-ID: <015e01dc11dc$8aad1af0$a00750d0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHsFvP7gX54FcGLOe//MIdKXIkh5gNdpLHQAfdKQSS0ION7wA==
X-Antivirus: Norton (VPS 250820-6, 8/20/2025), Outbound message
X-Antivirus-Status: Clean

On August 20, 2025 3:53 AM, Kristoffer Haugsbakk wrote:
>On Tue, Aug 19, 2025, at 22:57, rsbecker@nexbridge.com wrote:
>> On August 19, 2025 1:51 PM, Chris Judkins-Fisher wrote:
>>>I still use git whatchanged
>>
>> I did too. However, now that git log --since has basically the same
>> functionality, Perhaps setting up a git alias might do the trick for
>> you:
>>
>> git config --global alias.whatchanged 'log'
>>
>> so
>>
>> git whatchanged --since=3D"2 week"
>>
>> or something like that should continue to work after the command is
>> removed.
>
>You can=E2=80=99t alias core commands.  So this will fail in the =
reported way before Git 3.0.
>Then from that point out it will work as an alias.

I know. I was being pro-active with my answer on how to deal with this.

