Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386EC74BE1;
	Sat, 15 Mar 2025 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742070126; cv=none; b=qz4N9GTUr5hJcpZj5OJafYxzosd2+ctSO8CbLlqnHlI5PddzvgEHzW4iUygra5+B5T/brClzJMLOLf9ZavEeeUMJBJsf3wSqAwuBpWJgw2ZNVQ3NlTPy43iUJH3gyGrRc1a2lCIu0+Dr6vZgV+R0bWOGY05h4OOX11jCU9shQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742070126; c=relaxed/simple;
	bh=m9XSxixhGz10BtM7ehfpQ80E3bOUWejCxn71Yizncjg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=nG1LrWMrYhwOGBaednxfLvTbT2Gp6N4iKfljz/m8ueI3bmE22miNmplgkeKMiYCZOJv8aPpfYweHBACeMOWDXUpYrYXhjEnXrgMJMImmxD22jZTZV8L539wD95zsUrOI2FmMtbNqaza3e1SQkqPckzH/2cjimV5v/4I0/mKpz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 52FKLwVI2764771
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Mar 2025 20:21:59 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqqfrjfilc8.fsf@gitster.g>
In-Reply-To: <xmqqfrjfilc8.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.49.0
Date: Sat, 15 Mar 2025 16:21:53 -0400
Organization: Nexbridge Inc.
Message-ID: <01cf01db95e7$e78aaa10$b69ffe30$@nexbridge.com>
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
Thread-Index: AQGDZJ0YDJgshp825WF4w10X5A0NerQkv2DA
X-Antivirus: Norton (VPS 250315-4, 3/15/2025), Outbound message
X-Antivirus-Status: Clean

On March 14, 2025 1:17 PM, Junio C Hamano wrote:
>The latest feature release Git v2.49.0 is now available at the usual =
places.  It is
>comprised of 460 non-merge commits since v2.48.0, contributed by 89 =
people, 24
>of which are new faces [*].
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/

NonStop builds are now available for this release.

Thanks,
Randall

