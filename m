Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F01FA154
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881741; cv=none; b=nDQjPkK/mG+0Cq9sxQpBx3IoEbTAhEwumKegMCus3DeUO423Ld3jGXUStk7eo7pG/xZ4o70wfCFeKyD9JoUIgYTtii3VEzpQovay4p5hG5WUuKI6Ig/sQ+9duamw/x9LDfOB3LC5d8JeGsNprRKc64Xdl5B9O+eR2dZlSlMcoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881741; c=relaxed/simple;
	bh=bdzK5eMWuEUH+ZuFkI922VHdmIOtOZDwFageQizxDkM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Co3kqGkFMMnefw6xKr28CpsYR7VhTU/TKvJTdhIpFidhOBoowpz+0MpIMhsBNo2zf1GpNs0aM6XRGEKRl3yxdlF3HSQbgX+mMRb+sz5OyG2Bg2bcY2+JlAaQRGmx2WMudcaB3QC7ZwUzmfDVQX4yVGCE6yZFb9uGqnRxFwJUsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50EJ8qpU3103218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 19:08:53 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>, <git-packagers@googlegroups.com>
References: <xmqq5xmh46oc.fsf@gitster.g> <4a3c949a-416f-734d-f63b-cb1b7f9b362f@gmx.de>
In-Reply-To: <4a3c949a-416f-734d-f63b-cb1b7f9b362f@gmx.de>
Subject: RE: [ANNOUNCE] Git v2.48.1 and friends
Date: Tue, 14 Jan 2025 14:08:47 -0500
Organization: Nexbridge Inc.
Message-ID: <041901db66b7$c0c759a0$42560ce0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJA+s9gUSp+JMiiyH5dwYSAPcfMpgJ3TneHsje87YA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250114-22, 1/14/2025), Outbound message
X-Antivirus-Status: Clean

On January 14, 2025 1:44 PM, Johannes Schindelin wrote:
>To: Junio C Hamano <gitster@pobox.com>
>Cc: git@vger.kernel.org; Linux Kernel <linux-kernel@vger.kernel.org>; git-
>packagers@googlegroups.com
>Subject: Re: [ANNOUNCE] Git v2.48.1 and friends
>
>Hi Junio,
>
>my apologies, I only realized _now_ that I had forgotten to update
`GIT-VERSION-
>GEN` in v2.47.2, it still has `DEF_VER=v2.47.1` (but all other mentioned
tagged
>versions have a correct `GIT-VERSION-GEN`). I am very sorry about that.

Oh gosh. Glad I did not hit the "build" button. I will hold off packaging
that
version until this is resolved. It is definitely needed by the NonStop
community.

--Randall

