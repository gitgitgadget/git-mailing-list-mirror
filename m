Received: from smtp-out.dialtelecom.cz (smtp-out.dialtelecom.cz [195.250.128.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496FA59
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.250.128.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759388807; cv=none; b=Hks1bcvxfKxtpzs9wCcoeEz7cbaZtq+J4nE02GH7BprBrw1RJsdTE5jJunP5wMzN9GOTaOTVaXgdzsxsNlDMQupR5sR1qwqBsfDktnW3pkwJTjEMmqAemXy0o8osGpGb1p6cSMMVjgGq7tAyzkzXpx035scoxR1G6Bb/AqB2yog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759388807; c=relaxed/simple;
	bh=NhVhT2B4UKiS43mYhY/aWx5Y0RuS7Xqk9Lx6l8dJSlA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QN8HV1iavnuvmk+HE72UM3pUW7huwMZaSPMFOwAbz5c1e1BJ7YJqzY625DUK9hpDuRmsQnvyex6Akn888d1HhMKdA2emTZHNVgPqt1ae7Jt3rtU76zVVAksQjIf97QHrOiJsWTqPS+96YA3k1IY/44J/JEn4PZjRO8e4B+qaPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aveco.com; spf=pass smtp.mailfrom=aveco.com; dkim=pass (1024-bit key) header.d=aveco.com header.i=@aveco.com header.b=LCl6TZ3n; arc=none smtp.client-ip=195.250.128.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aveco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aveco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aveco.com header.i=@aveco.com header.b="LCl6TZ3n"
Received: from mail.aveco.com (mail.aveco.com [88.208.95.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp-out.dialtelecom.cz (Postfix) with ESMTPS id 4843F5A3F51E
	for <git@vger.kernel.org>; Thu, 02 Oct 2025 08:48:55 +0200 (CEST)
DKIM-Signature: a=rsa-sha256; t=1759387728; x=1759992528; s=major; d=aveco.com; c=relaxed/relaxed; v=1; bh=0uLZFGMJIyK6nPQVHq1CeHihbbgMibc3wBIsoQmzaJE=; h=From:Subject:Date:Message-ID:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
   b=LCl6TZ3no8IcOQ3FI4DCkzQdf+OgsBMiNzOQnauh79KrTVKlarFdRG4bkZ0mqt99CkmcpARZVVhlnq8noVindCGpnFN/MbK86OXEsxr4Jpqc1q2RY2RgIX5g6Ii8pKCmvbax/b9snofBJR0fHiHde8ZTyiucOFLUU1vz4vVx1zc=
Received: from JBLDDVDXQX3
        by mail.aveco.com (13.0.3 build 10 RHEL7 x64) with ASMTP (SSL) id 202510020848483812
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 08:48:48 +0200
From: =?iso-8859-2?B?Smn47SBCYbllaw==?= <jiri.basek@aveco.com>
To: <git@vger.kernel.org>
Subject: git whatchanged
Date: Thu, 2 Oct 2025 08:48:47 +0200
Message-ID: <003601dc3368$9ac8f9b0$d05aed10$@aveco.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdwzaHfRJslEV3m2SSm6/6idXeFKmQ==
Content-Language: cs
X-CTCH: RefID="str=0001.0A2D034B.68DE2050.0036,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Hi, 
I am still using this very convenient command.

Best regards,
Jiri Basek

> 'git whatchanged' is nominated for removal.
If you still use this command, please add an extra
option, '--i-still-use-this', on the command line
and let us know you still use it by sending an e-mail
to <git@vger.kernel.org>.  Thanks.
fatal: refusing to run without --i-still-use-this


