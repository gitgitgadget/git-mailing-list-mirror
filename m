Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD510F1
	for <git@vger.kernel.org>; Fri, 30 May 2025 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748606717; cv=none; b=CobhI3lFYKRwiwB/sAb5o6D9EJl8EvLWpPYKfqnJhKqG6rw3M6l61jeFukc7ln8l+xoFvmr3qZllNYU1vrxdqAuXPt+ddok004LSN1o7qVVlpyEZll8hlYgQQOz/zWisb/hBM8MwAylkaFHcnGMYTUCCoUm14BF/yCh6CzK4lD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748606717; c=relaxed/simple;
	bh=lQPPaEMuJb34sh2ouW9z6nRTxCvDc8HILxmGasvonug=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bWkPwf6UyY1h7k3tIxMKjIukBdfgXHwMoFs1D8Vbf0aMwS+Qeqn6FF5hYJQFiFUQQEetM6KCq8ajUYCymY5iAejwyxGM0pKdVI/zefCaKKQJ5X9vNwMFvRkx1SaQjkhvRG5zF1vfUGR8DmT0wuVKP/wIF7AsA9KyN1OMn7BIQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (ec2-99-79-55-121.ca-central-1.compute.amazonaws.com [99.79.55.121])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 54UC55203329145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 12:05:06 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <rsbecker@nexbridge.com>, <git@vger.kernel.org>
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
In-Reply-To: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
Subject: [Bug] Build Failure: Git 2.50.0-rc0 on NonStop
Date: Fri, 30 May 2025 08:04:47 -0400
Organization: Nexbridge Inc.
Message-ID: <055d01dbd15b$14d4c880$3e7e5980$@nexbridge.com>
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
Thread-Index: AdvRWvSsnnzSi6fgTISx/BhEDlwU7g==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250529-4, 5/29/2025), Outbound message
X-Antivirus-Status: Clean

On May 28, 2025 2:59 PM, I wrote:
>To: git@vger.kernel.org
>I encountered the following failure of rc0:
>
>static void file_release_data(void *b REFTABLE_UNUSED, struct
>reftable_block_data *dest REFTABLE_UNUSED)
>                                        ^
>"/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/reftable/blocksource.c"
,
>line 105: error(112):  expected a ")"
>
>
>I am not at all sure why this is failing at this point. Compiler is c99.

Looking for help on resolving this before rc1.

Sincerely,
Randall

