Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF413D279;
	Wed,  5 Mar 2025 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136749; cv=none; b=IU5F1z69qURL0gnEve08djQ5fP7460VBO9Z198pjGTV2x1KPhq5X0vE3wGAcufJTPuyRvNh11CA8TJP8jLjp0ZUjIhbKOw3CSaUPh90jTpNkYRXZvth0W/1ij+ORIl1I6IFi7pxAWQTjwyYPLRJ7T6SiyEXGQcXGAczMWzw16uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136749; c=relaxed/simple;
	bh=u9X0uTuMD5xXXkNo9+ZowwFWWsSLP1ihHn6blmLs2XI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OEq3M47xgylBJRGMSl1vVq5TWeTTtuHfE9I3PLorF6LCWZ9SDAzQrkR6DzGqhnKy2mYY4FKedezXvx7ZSObdP5u5opSFhsavsc1PlFBmigFUlpNgyU9LuCVf3+LTUq70VWiorDF9/auao0TlP6My4z5JtcbmJ1BztQE2hikBFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 52515a3P572794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 01:05:36 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqqjz94r8p0.fsf@gitster.g>
In-Reply-To: <xmqqjz94r8p0.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.49.0-rc1
Date: Tue, 4 Mar 2025 20:05:31 -0500
Organization: Nexbridge Inc.
Message-ID: <001e01db8d6a$b4480470$1cd80d50$@nexbridge.com>
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
Thread-Index: AQIhUqYUUR69MpQbjmD+IdO9yTIAhLLYL9Tg
Content-Language: en-ca
X-Antivirus: Norton (VPS 250304-10, 3/4/2025), Outbound message
X-Antivirus-Status: Clean

On March 4, 2025 12:46 PM, Junio C Hamano wrote:
>A release candidate Git v2.49.0-rc1 is now available for testing at the =
usual places.
>It is comprised of 367 non-merge commits since v2.48.0, contributed by =
68 people,
>17 of which are new faces [*].

Rc1 looks good with OpenSSL 3.4 on NonStop.

Thanks,
Randall

