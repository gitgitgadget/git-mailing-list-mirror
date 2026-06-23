Received: from a48-89.smtp-out.amazonses.com (a48-89.smtp-out.amazonses.com [54.240.48.89])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90D1F5821
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219092; cv=none; b=UaPu1PL18XpuDJshtLsPV4d2hdh5SQgp4wegkdNcoJVx0nZ01UO2uzynJYovms6co3Z/267Ku0xoYHkN3s+nB+K4dFX1ZnLhO5j0a1QL2xOpZXrxFlkEkWusQQTfPpJ3Q3I/1+K5JBfmIwX7bVaiG5XJAV/gHTPQD1olTjKL3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219092; c=relaxed/simple;
	bh=Dh0CGHni99hA74VEHdFWgrZxJcpmMdtFL+83/afJHPk=;
	h=From:To:Subject:Content-Type:MIME-Version:Message-ID:Date; b=MTEpZp7sQ6ay3+4huUCqzfW/ExWHjhBvFbaqkl6j0tY7hTudlPzxl+LiixH5A2nQ81v3m6N2dxqeaJyS/yEOKZMVFos7aUWNxUh/Fuy9X/MycThHRaVYej7ANMj8AnWbxy1fy3BsUkxUvXnx1b4uf5K1PJ+2dU1Knuix+Uj7GoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bounce.afw-concept.eu; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=bounce.afw-concept.eu header.i=@bounce.afw-concept.eu header.b=i9tf0BbY; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=HDv3RU4i; arc=none smtp.client-ip=54.240.48.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bounce.afw-concept.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bounce.afw-concept.eu header.i=@bounce.afw-concept.eu header.b="i9tf0BbY";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="HDv3RU4i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=7xkwt3kpzwlktuvfehl2bk6ewxrgngeu; d=bounce.afw-concept.eu;
	t=1782219090;
	h=From:To:Subject:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date;
	bh=Dh0CGHni99hA74VEHdFWgrZxJcpmMdtFL+83/afJHPk=;
	b=i9tf0BbYCySOTIVvO/eS1v62zbgLBHld5FO+klMXW7/eDR9zDCNX5wnKXlIXuSk6
	tojxV8NHZhDl/YfdFlLeL8oBvDnTCwaZBi/1sX0b5HArNqMI0peXnrWoeB/Srptd/Bx
	4rFCrY2kHqpC6+ihUy5LlpmJ7/TbXMuA5LLl2cwFD7SZzjpV77ZAL/8KcCcr+euPZOG
	RcVAMPLlcRNPbUKRTOuelQGchaNldXmqm6h+yGH/g/imf3mxVBcZimOJpMpNr7Fb8/j
	1l/yEXw884OJ/JM9Y+IukgJoaGxgIq61yusjfSLu7HfNZ9rTe568kX5TEgPyAcLvJ5Z
	RIeSxfxuOg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1782219090;
	h=From:To:Subject:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Feedback-ID;
	bh=Dh0CGHni99hA74VEHdFWgrZxJcpmMdtFL+83/afJHPk=;
	b=HDv3RU4iTe2AGCxrHwB/e+imMEV2+/7wCQhzBL+2PPTXCXXcndZwVXa6R7Eqjyo2
	QBNJnU4wt5iXNEbuIsstWA8L0G5Cm9hP8DdjZ/fDfG2FucRSslUjPg0ttO0TCrRL3i6
	OKS0AZaGpRyjT6ZH3qUpbgbqHXmadZQpw+CfF/9k=
From: Verification <verif@bounce.afw-concept.eu>
To: git@vger.kernel.org
Subject: Controle de votre adresse e-mail
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <0100019ef48928fd-2503d781-f214-44d5-b3ab-1dcefb7ed885-000000@email.amazonses.com>
Date: Tue, 23 Jun 2026 12:51:30 +0000
Feedback-ID: ::1.us-east-1.7oaSqgVUepwYMlXuw0raJW3QbVwOLLB4zcfVw3oT7gk=:AmazonSES
X-SES-Outgoing: 2026.06.23-54.240.48.89

Bonjour,

Ceci est un message automatique de controle d'adresse e-mail.
Aucune action n'est requise de votre part, vous pouvez l'ignorer.

Pour ne plus recevoir ce type de message, repondez STOP a cet e-mail.
