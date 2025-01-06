Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9131372
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736196483; cv=none; b=swtmHhmHRRGKInFlnmPrAkfiFe/fWRH0/8QQBCvVBliZSxAfnVxQp/BpieimD4mTxlp7kvr1oy2f7tOHTMyKHAo0eKyAcJ4GJTu9cz9aaLyhBeKcm2R1Q8uk8fhqr4txV4thWrdZeEiKHpobNUviJ0r5GI7/rFqzbTJm9gy7D34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736196483; c=relaxed/simple;
	bh=lFPP1IWKiMn3CZgKK669H2zecpT5qZrgcfQQ4w1lzp0=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uQdX42k/yKZah6Uyh1MYFHAQuDhoVbljYSXf1dfnRR/a3b7MzO4Z9g+IFJDG6eXbhGp15sRnrigf2EZfnrzLkhBAP0u7vEMD2heGd73vLtLUGO2+Xlt+6uTbnQHf9OF4AY16wKxbQEna/6BtZKTBNddrCKHrCqHeUS00uwCRuMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 506KlnIV1342569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Jan 2025 20:47:50 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqbjwjyalr.fsf@gitster.g>
In-Reply-To: <xmqqbjwjyalr.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.48.0-rc2
Date: Mon, 6 Jan 2025 15:47:45 -0500
Organization: Nexbridge Inc.
Message-ID: <000501db607c$40c009a0$c2401ce0$@nexbridge.com>
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
Thread-Index: AQJahAhHT7U2e764xetiQ5+Rss9Ds7IL77YA
Content-Language: en-ca
X-Antivirus: Norton (VPS 250106-2, 1/6/2025), Outbound message
X-Antivirus-Status: Clean

On January 6, 2025 3:02 PM, Junio C Hamano wrote:
>A release candidate Git v2.48.0-rc2 is now available for testing at the =
usual places.
>It is comprised of 584 non-merge commits since v2.47.0, contributed by =
81 people,
>33 of which are new faces... <snip>

Our main build/test machine is undergoing to periodic maintenance and =
upgrading so
we are on an older box. The build/test cycle on this one is about 40 =
hours, so apologies
that results will be delayed for NonStop. This one is being done on our =
ia64 box instead
of x86.

--Randall

