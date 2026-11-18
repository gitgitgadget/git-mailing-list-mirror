Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017251;
	b=e8B0JoDBzIzKZHD4/v9Mx/0fBK2vuMq3UTx0uyk1kMbDz6LehIL4CUxREQcDVDkYBCpF
	 m/x/aqJidq3sye4iE2nxZ6ryOkDCrJpBlSCcHwiN+A+Qb8XXf6qajKNgEsOAubRFzydbv
	 cp858wHErvu55QEVEjV7GDcU7lRxTTWZtmaIXxA9ufVqc4ILbtWjAnF8iioSbqf7jNmcs
	 7LqY3esJZYUuO5FWgqs51EyRgPc1P+3KQvpuAQrRERig8kpJ80oO1z1e3OgD3LMAFAiTB
	 Bp5jRc/I2nvWSyTRFOTMUawKF3d9Fwj7fwPtxs7ryTptDjnpE5KeqK5FxclekFzbUXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017251;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=OhLtdNvIIznCMAxrzWRNWKaMFFmpDOHWF1NtL7+eGk8=;
	b=O8CChRujYss0qNYmZ5Cn1ZTtqkMgPAeKGDBsmQW3ah5gXvFowcdAqKV4LDOXWGWn76FJ
	 vmwPdW7hKK1gtDp/FroXW7lKoN8TIqb/3VLjt63pJBA1rsCLuSQVW++CUmrnNAbdgoPJL
	 jQhPyFScQoMVs1hzVTnwwCzyrslaIkuL9+8W91lF9eftlpHlx8CBigLafIY4xjIFVB5rO
	 BlECw6F3A6JK5KBeNP5AA1H3/ET9U+q2rvICSfgU6y9UG+wQQSlZQGpELMLZFBoZf904a
	 M1OE3l5efCuoxfLkcpnkQM4ITVDitAnfvP7VIsE8njUfjjfX4h9hrRpGC2UiJFRkPRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=A4QYvOwg;
	arc=none smtp.remote-ip=95.215.58.26
Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B89606A337
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65B89606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=A4QYvOwg
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6MUKhT1HRKYt0aPhLSfOjbbxVWJldWthMz3kop2RWcI=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795017247; v=1; x=1795622047;
 b=A4QYvOwgwqadPr4txBc4ql2UGfktWqNaey7OyPmcUiD0en95/ZbY3+dsjBK3XnDAR5IPLfho
 D+YC3E06RZ5PF8vyfF/kdn3qXbIt0hNvCR82kLkQ/IOC15VthwK+opuSECoksQTy0Y3h6ohMdfG
 Tr+TPKmVbwz+6SKamZ+SLdGU=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 5407fdd004547dfc;
	Wed, 18 Nov 2026 15:54:07 +0000
X-Mizu-Trace-ID: 5407fdd004547dfc
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] Documentation/config: fix typo in
 "maintenance.reflog-expire.auto"
In-Reply-To: <20261118-pks-reflog-expire-performance-v1-4-10b9263566a8@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
 <20261118-pks-reflog-expire-performance-v1-4-10b9263566a8@pks.im>
Date: Wed, 18 Nov 2026 16:54:05 +0100
Message-ID: <87eccijftu.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In the documentation of "maintenance.reflog-expire.auto" we accidentally
> refer to "maintenance.loose-objects.auto" instead. Fix this.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/config/maintenance.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
> index 165102518ce..7066fe0e168 100644
> --- a/Documentation/config/maintenance.adoc
> +++ b/Documentation/config/maintenance.adoc
> @@ -116,7 +116,7 @@ maintenance.reflog-expire.auto::
>  	negative value will force the task to run every time. Otherwise, a
>  	positive value implies the command should run when the number of
>  	expired reflog entries in the "HEAD" reflog is at least the value of
> -	`maintenance.loose-objects.auto`. The default value is 100.
> +	`maintenance.reflog-expire.auto`. The default value is 100.

:) Whoops. Good find.

-- 
Laters,
Toon
