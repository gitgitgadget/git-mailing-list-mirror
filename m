Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1219995E
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776387550; cv=none; b=MlhOOVDVjtI+5iBSECVf15Hjv/6JL8NE16rx9FXNWtSS+JYsIYbxwYQfDn/Aogkwt+6Oq7v5k0TwKBtB2bYNNxW8kvmClTanMQCLbF1hqwV6WpI7zLNvqgfa+fG2i7SOnhJbeoSL+8Wgu/psWxlajxncJVGXwBqkZMGCMLbwOx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776387550; c=relaxed/simple;
	bh=77u338QV0qac3LeyX8wOMoUAb6/n8IEvTp5efkCPsZM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FhBOZ2IE6ZBUDsQc/9YOANMqWaJE815vLSZOQVm1UeIws5L7ZVeHXkHYjgLfc/C0vZeh3jR0/pwZebQbKvDqcwop9/G7aDMoxLRLn+AphKBOu7wqOgZ6CZ91K6raGGcy+hW7L44PVsd4Os4drXhSX42EKW99hM6+pATAV2HXHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=G3TNb1t5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="G3TNb1t5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776387542; x=1776992342;
	i=johannes.schindelin@gmx.de;
	bh=77u338QV0qac3LeyX8wOMoUAb6/n8IEvTp5efkCPsZM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G3TNb1t5fehNyCTwQSVtpTVLrClyDC/ImAytK9LfCxTX/QJiZmyJ5b4hw00ZFd3Z
	 2mwKp7Uw/NJV3zW6Wi5wHMYqhgWboA8IO5g1R/RdNIWD5Rg2KBbZ+9rbyGEVliEAi
	 ptwbD0GzwmHl/apfR3YQ6WwyU4elTCviL7yeKv9bwSMUHWU9fth5SzJzgHf39nB2Y
	 pABbI2FR/I3oXGK7xZuE8MpVLxV2K34/ML36O5ax9wa4A1vMjEqS4f/GcxrULx7cY
	 Ou5RFhFh/xCWfFdyqrRHygDs9QZa9rhjcXHcAGqg1k82bQPUbHuChxDtr86ZhQ50h
	 Lr6i7UErUhlDAWUsCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1w6QHQ2bRO-005mFE; Fri, 17
 Apr 2026 02:59:02 +0200
Date: Fri, 17 Apr 2026 02:58:59 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: kawai-m@tr-advanced.co.jp
cc: git@vger.kernel.org, hattori-m@tr-advanced.co.jp
Subject: Re: Subject: Inquiry: Git versions you provide and Windows 11
 compatibility
In-Reply-To: <OSCPR01MB134507F2EDA90C775EF1DC571EC252@OSCPR01MB13450.jpnprd01.prod.outlook.com>
Message-ID: <57f4f6e7-f1ae-877a-8215-13e7dd5a18f1@gmx.de>
References: <OSCPR01MB134507F2EDA90C775EF1DC571EC252@OSCPR01MB13450.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:w5IeLhp+8Crm0rDfMc8BQz8EnWvXjF86DymYCvltdUyBXAbqdT5
 WAf911hPGXN8sT3TUl5ppskI3MZlVQgWZ0mav/nYMPN3dIfm5sH/3mpt7v9YlTdOBmEa2iS
 3DjS4D5ZLNqO5eBJs+u3R8ri3IQxY+Hr53+KNDVCkmhchbYMKCFHcZa0eNvhen9BYU3g79L
 gwtMc5RAFioKtcbOSzHPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yHQW/SAEhnI=;3sFM4HODFAQiPTYtg36O/rlvP3U
 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
Content-Transfer-Encoding: quoted-printable

Hi Kawai,

On Tue, 14 Apr 2026, kawai-m@tr-advanced.co.jp wrote:

> I would like to confirm the following regarding Git. As part of our
> migration from Windows 10 to Windows 11, we are investigating whether
> Git can be used on Windows 11 in the same way as before the upgrade.
>=20
> Could you please let us know whether the following software versions can
> be used on Windows 11 without any restrictions?
>=20
> Git version 2.51.1
> Git version 2.26.0
> Git version 2.29.2.2
> Git version 2.32.0
> Git version 2.32.0.2

All of these are expected to run fine on Windows 10 as well as Windows 11.
Do note, though, that all of the listed versions have known
vulnerabilities, both Windows-specific and non-Windows-specific.

Ciao,
Johannes
