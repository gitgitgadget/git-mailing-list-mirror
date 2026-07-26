Received: from outbound.qs.icloud.com (qs-2007f-snip4-11.eps.apple.com [57.103.84.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91692BB13
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.84.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096093; cv=none; b=RgR4Y+Nt1lJQPLCdI2HUD5n6XXUnMhI/b/CWkSu91lkv8ObOU1Bl1NY0ApaJOEV8L9u4TrVhF5u4w5DLdGWe8r/eDVY2X1a+vgxOLrTCENUIR0i185rk/juosmjpHu6zYsWk3AdvwACjPnbfskqpGujadzinF64+NVqmNCK35+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096093; c=relaxed/simple;
	bh=UJuYdm0ffiPUJnob5ocgoPUz2FbgSNQQFgt++32SBoI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=gqHNv147rlL6cR6bg8W3ek+xNH38sxUVB3+u3LHGb3gMbFd+WcWzuh26bgPEpuR5gPAFCnyHNhxkkToAxvLqkuIDnAgOm5x4OVEOvh4BC9xuJEcnlsw39oXYKTlxfMfp0oujw1dypSVoKJE5xs5fZPgkXqzXDZszRmalvqZcpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=l5RDnmEL; arc=none smtp.client-ip=57.103.84.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="l5RDnmEL"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id 787B81800687
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 20:01:29 +0000 (UTC)
X-ICL-RepId: 019fa004-af42-719e-8a6c-8cf239140f6a
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQBBHV4PRQBCAFYBWARLVxQEEUEIUx1fMFAbXwJCDxwTVhUTC1NWWxNVF0YJGQhdHRkKUFAGS1oVVRcOAkIfUB9MFldDRhgcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKAlEcVg1XQ1QEX1BUEVdQC14ASAE5BSwBRnMyCkEeWQZecV14SQovGi5xNnpMCyx0WQQ2DDhaDlsERxQXG1wACUtGCUkdDgRUB10FXQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785096091; x=1787688091; bh=UJuYdm0ffiPUJnob5ocgoPUz2FbgSNQQFgt++32SBoI=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=l5RDnmEL30hQtAvWhqDliydmDe3Unmqhc7C18Xq4PlgZQGg2hNQvN926R3ry1GJvSKTOvHyslzElPE1hp/MFpPl5icEn47yyLkAVy/ynIDdcOzoAO8x1NpX53+4qBNmTub2DcLP7SaWo9H+lRdQjcEta0p/Y4tkNsFDREzYOYnOCELVsJuq/whZG6aA/qQho87/m+9WyKV5pKNrBHud0/SYGt99QfN6XT0p7hQe8qNY4mlAqWMv2Fbg6sdPvll8dZ86OH+cBtZp37M5/qWoJUZ0AmeG+K2GtsbWewKDAmtliCvRp4WyLOn+UqwUPU5g09ggYp01E7RybhEHWxvMzxg==
Received: from smtpclient.apple (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id 8D78418006AD
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 20:01:19 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: DANIEL CATONI <iredvm@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 26 Jul 2026 16:01:07 -0400
Subject: Hello my friend 
Message-Id: <5288A6A6-AB39-415C-A19B-ECFC48AC26F5@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23F84)
X-Authority-Info-Out: v=2.4 cv=ZfEQ98VA c=1 sm=1 tr=0 ts=6a666799
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=x7bEGLp0ZPQA:10 a=5owJUTMDJoYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=r8itkdL81-e9g45S_QUA:9 a=QEXdDO2ut3YA:10 a=P4FZZRP6rPu2-ETPHK1R:22
 a=ejlqsxI8fuF1w8N6ZzsM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDIwMyBTYWx0ZWRfX+ZKhem4cGpcv
 Uji1Hq9ag9f94xjnxP0ztarA6XzSYy54X5zDmOb5q5puhgB45T0zLHbR5gtgoIm9klpJ4Vyl3k7
 uzSazcPPuwgs8wfDWtXmW/qZrrNP3pWnWB2tITxFe1mg/Q5Wo0HUmWj1+mi4WN2AXMCLn+lVUkl
 0Kz1EyJbc0mU5FUkyHIhIrnNn7wPIW91aVmDgzf/Ek6OtIBY9wnJGuiCJ3rzEAJna5cqw5YzAnC
 5TADUHuij7PHerN15xalF2XQomrJpuZruj5JSw61f/lE+3NbBEgII5CP0BjkFNVig35wc7gFlOi
 TVpAq9BSfQkmk+h0qYO4xdB1NC2e2ndW0F6r3/GKzRPliawBuhE6Fli7QFegks=
X-Proofpoint-GUID: 2l_bIF0cT4m_ED1TgB6nLiG8etI1V_rZ
X-Proofpoint-ORIG-GUID: 2l_bIF0cT4m_ED1TgB6nLiG8etI1V_rZ

I=E2=80=99m a fellow code user and I=E2=80=99m getting started on this side o=
f git just wondering what=E2=80=99s the best advice you can give me starting=
 off with this kind of code repository and what=E2=80=99s issue that git mig=
ht having or lacking in or around the the code git itself
Sent from my iPhone=
