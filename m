Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734A60BA8
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932796; cv=none; b=hfKhLVFrtBqSdiSipNSOgrRTuRu4WTLGGE1ApExCcRtEfncjrm/IUNqxBA3ZdMjCRw6zrAnlPwYvs++YWEbE6Tv1uEW+1HYRC+PZTy/U5j5WnAnakXqNxQMUzcPDLhigeevbyO8cgzg1bqlNffuS1L07Q/eQVX/zqdHo59wFeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932796; c=relaxed/simple;
	bh=cje/oLFqZyUz/tfadzYQ4Ghn95+XEbs0Z4n70mm5R68=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKwc38xIbQmraPeErSxWGcOEFDprXcPQpGROumNzIcI1kCqaNQ22Uj/+wm6qkPC4uvtLhWlqchbxOHTDoWz1FIJ7riQoW+dnLkBcV4o1HulQ1lFpk1UOUXtN5drKPsKKr79huANLcSVKhttat/TqZDpEs43vv9vOjRI4a5kJ8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41EHkQvH4063301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 17:46:26 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [RESOLVED] 2.44.0-rc1 clears t0080 problem on NonStop
Date: Wed, 14 Feb 2024 12:46:20 -0500
Organization: Nexbridge Inc.
Message-ID: <024f01da5f6d$bb66a030$3233e090$@nexbridge.com>
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
Thread-Index: Adpfba57LCjFrJu7S2erOmpTHr0ajQ==
Content-Language: en-ca

Thanks everyone for getting this fixed.
Regards,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



