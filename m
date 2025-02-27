Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000CD21858D;
	Thu, 27 Feb 2025 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683079; cv=none; b=jx1SYyL2WirvHwmwjroOGyof/BvNIxlP/AaFnkXTsQoCjUn+XmKKgdMwtESBedCMoIkgir9vu2HAj99JUdJ04vhyo0utKpoDlJYPTGwa40Uok1JDwZFgNd8k4LKoHasHiC6v8mrxEil+wMO1HPoIZfetGpTKL6KuVtC+k3hCSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683079; c=relaxed/simple;
	bh=ebyszgBRpnFkGiV5rNnQfDL1xFflqvN9WXvQMomRTMg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=evUL90jqnKku/nLTCKcm1JhIQkElumXlmLEWvISe2YgfkrOhv43cpVomo4O4MChUXEVcwjSVWZx648sOYNPbOOZF7Gz6J541IDcFOjH0Jls4P1vyv0ak/jXsLCcfpvuqL2lLWABf3MKGcC63ATIk6X9eMY0YQ/HpgqjDueMZjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 51RJ011I3797100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:00:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqqzfi8bljk.fsf@gitster.g>
In-Reply-To: <xmqqzfi8bljk.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.49.0-rc0
Date: Thu, 27 Feb 2025 13:59:56 -0500
Organization: Nexbridge Inc.
Message-ID: <028c01db8949$ce664b70$6b32e250$@nexbridge.com>
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
Thread-Index: AQH3n4sZ6iMu0cE0lBPLVR1uSUVLC7MjVDTQ
Content-Language: en-ca
X-Antivirus: Norton (VPS 250227-10, 2/27/2025), Outbound message
X-Antivirus-Status: Clean

On February 26, 2025 1:37 PM, Junio C Hamano wrote:
>An early preview release Git v2.49.0-rc0 is now available for testing =
at the usual
>places.  It is comprised of 326 non-merge commits since v2.48.0, =
contributed by 65
>people, 15 of which are new faces [*].

Looks good on NonStop x86. Built/tested with OpenSSL 3.4 and 3.0. We =
might build with 3.5 if it comes out in the 2.49.0 cycle.

Thanks,
Randall

