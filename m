Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9A184E
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726362985; cv=none; b=cuGyWFmkYo1sBQgkjdWIpPzbsjkDfKvwNd3stG2eGOxmIwYxeVrXTtS+sFCrDOGWftRozvWCQ9xHLjQOr+4LV2lB8cQoCo7xvASazMM5ha3H9K5p3rgXuY8Y09lwvQsiGYTyUBrLGWGBPURfjeF1y7a43Z/pCQ9/TVqskZkfEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726362985; c=relaxed/simple;
	bh=dCbk+wfoDegscAvUPX9cgj6rDeO7AqHurj3K2Z1sMSs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=XL2hTN+RaCGpccvqgnb4PrGmJkTYaYe6oaMYSL2cNR9IeGO7RhVEsJkLiof6K5C6rk6DqBfMwwuehZk2cSv0TfyH8JRxOO+HOB9jjnUzYzDXUJYL+FSEFRuDQk84mkxB6htKK5aqwN5nZfnYr5BSlTvVPSqhDJblpFIr+W7pnm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 48F1GDPc3780197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 01:16:13 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc: <git-packagers@googlegroups.com>
References: <xmqqikuytbxd.fsf@gitster.g>
In-Reply-To: <xmqqikuytbxd.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.46.1
Date: Sat, 14 Sep 2024 21:16:08 -0400
Organization: Nexbridge Inc.
Message-ID: <023601db070c$db740f60$925c2e20$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJCfM3VzqklUlsxQxrz+2ecX1FRlLGJH8sQ

On September 14, 2024 12:53 PM, Junio C Hamano wrote:
>To: git@vger.kernel.org
>Cc: Linux Kernel <linux-kernel@vger.kernel.org>; =
git-packagers@googlegroups.com
>Subject: [ANNOUNCE] Git v2.46.1
>
>The latest maintenance release Git v2.46.1 is now available at the =
usual places.
>Unlike maintenance releases in the recent past, this one is _not_ about =
security
>fixes, but primarily about fixes to various commands that can work =
outside a
>repository barfing due to lack of initialization of the hash function.  =
IOW, it is not the
>end of the world if you did not update to this version for a few weeks, =
or wait for
>2.47 ;-).

Successfully deployed for NonStop x86 and ia64. Thank you, team, for all =
your efforts.
--Randall

