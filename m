Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCCA44C6C
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735665600; cv=none; b=Mi2o5cy12QlxyUv4eTwF+bqGf/pDlVDfMAz9dkkcwdU1JpHsLTclQG4TrWvzTxKdkTeLZXA8DC7+fgrIFpFb3m5vxQBvcrGXmmWS1zuSVae8WsjcRIodgax/x99FBHgP1fOcps7F1lJjPTxeENdfI9tr0sdfD9752SpGfY5XPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735665600; c=relaxed/simple;
	bh=6Yj0CAP/C4tEdb48ISuuMN4bYHRf+MgmU+K5/7kPlpM=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VUsTFf9tDiEFBsykgvThT5HH1EHpbjSMnuC0tU9DB1aEKDGtUVunt3KrfrqK48TH4NYrPmmYJvKIKqAMMr6MCYoEMJffyvcGa2KdLJ1FIPUDlYHT2nw7vEv7vQiH4Au1roXmqZOA4lk3eNWMAlSCwRtFRrwrHqmQtGaayX5/L00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BVHJmUE271197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 17:19:48 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqjzbhxeho.fsf@gitster.g>
In-Reply-To: <xmqqjzbhxeho.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.48.0-rc1
Date: Tue, 31 Dec 2024 12:19:43 -0500
Organization: Nexbridge Inc.
Message-ID: <043301db5ba8$323355a0$969a00e0$@nexbridge.com>
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
Thread-Index: AQGB5UvmfZOC5SwMDjWCjv0vcw4fxrOzhW4A
Content-Language: en-ca
X-Antivirus: Norton (VPS 241231-4, 12/31/2024), Outbound message
X-Antivirus-Status: Clean

On December 30, 2024 12:33 PM, Junio C Hamano wrote:
>A release candidate Git v2.48.0-rc1 is now available for testing at the =
usual places.
>It is comprised of 549 non-merge commits since v2.47.0, contributed by =
81 people,
>33 of which are new faces [*].

FYI: NonStop builds/tests look good for this release candidate. Thank =
you for all your
efforts.
--Randall

