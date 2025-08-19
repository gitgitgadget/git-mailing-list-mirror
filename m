Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C9225A2DA
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640182; cv=none; b=ZPpvefwCPQZ3ZaOyc27hChqnKQr6Voczx1KL665T18o3YOCZB+SShBjPeBCwCjFOCDlTU0wS8x+I3f6ORt3bWbLH9wtRc2YB3oGo4AaI8JhL1TZOI9ye9f7vfJDAspYerrncNaRMJtvSpBtkF++bPbPUPHiKdHLk6JOYV2sWW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640182; c=relaxed/simple;
	bh=HFsPVZWAXZ1+YAeg2rH3OVgUoAy/jyTBqjk5MDHOk+c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=E36HQEgJEOJQ3Ci9QQ9uFD+eXRUcmvKV14nU4zGIiHqiFviDn0JWxX9YB6dk8WQL7+eW8FJiUapNHdEU4g7TL8C4gxJpyLwiEY8w7JLTTFYeG0ev7WGx6VH0J6x0RpX/9YARUFwIK1xiMJgacfbpfTzDtuKEPWmjTGMSZ2fXAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57JLnWol2461558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 21:49:32 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Junio C Hamano via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Chris Torek'" <chris.torek@gmail.com>,
        "'D. Ben Knoble'" <ben.knoble@gmail.com>,
        "=?utf-8?Q?'Jean-No=C3=ABl_AVILA'?=" <jn.avila@free.fr>,
        "'Julia Evans'" <julia@jvns.ca>
References: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>	<pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>	<c44beea485f0f2feaf460e2ac87fdd5608d63cf0.1755636370.git.gitgitgadget@gmail.com>	<011b01dc114d$201c45b0$6054d110$@nexbridge.com> <xmqqfrdnc7s2.fsf@gitster.g>
In-Reply-To: <xmqqfrdnc7s2.fsf@gitster.g>
Subject: RE: [PATCH v3 1/3] Git 2.51
Date: Tue, 19 Aug 2025 17:49:27 -0400
Organization: Nexbridge Inc.
Message-ID: <012001dc1153$2626ff80$7274fe80$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKdp5ENx7tSBkCH7zZAMPyaQM65SwErhmREAeX5BskBiUHuzQE/IgnjsriH46A=
X-Antivirus: Norton (VPS 250819-6, 8/19/2025), Outbound message
X-Antivirus-Status: Clean

On August 19, 2025 5:38 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> On August 19, 2025 4:46 PM, Junio C Hamano wrote:
>>>Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>>---
>>> GIT-VERSION-GEN | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN index
>>>be801415bddc..64cbc5833536 100755
>>>--- a/GIT-VERSION-GEN
>>>+++ b/GIT-VERSION-GEN
>>>@@ -1,6 +1,6 @@
>>> #!/bin/sh
>>>
>>>-DEF_VER=v2.51.0-rc2
>>>+DEF_VER=v2.51.0
>>>
>>> LF='
>>> '
>>
>> Will this cause a re-roll of the git 2.51.0 release?
>
>I don't know.  This is not something I did.

Thanks, though, for the info.

