Received: from vps39.purpod.org (vps39.purpod.org [91.143.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BC31898E5
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.143.85.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021879; cv=none; b=IiycN7d3X5T8IsMRqcoL8gDRhUzrYP/++SRElQ1SMyux5//XacxltAlrwKJciX1ST4Xjd2tuLEsNUYChqs98YXsH8EZ2+gHn4zGhxHucYDKD21BcuwCCdgs5SRF3uSij+1gtn78PT1gySU+id5aDN0CDi6mv4AMmt08eFr006cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021879; c=relaxed/simple;
	bh=LBwaLr+wlbr8N/ILBVAzTSG0uUZeAj3452+lutsr+lA=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=e96tCA4M1TjJqiVli09vp1M+hXI9QZb5QjJDaK8hYUDFTs6DXzxqLjAiV/Ccv4baGYcXHwkiw78c3MFDdvXNYF+DWr9W40IB5uMRA3XPP3N2oGNilO/6OKl3fC1///LYBFqAhyPoTAsBerqaQNyhhB0jeArgaTRqfpmZaoZBHdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=purpod.org; spf=fail smtp.mailfrom=purpod.org; dkim=pass (1024-bit key) header.d=purpod.org header.i=informes5@purpod.org header.b=O7ynO9V8; arc=none smtp.client-ip=91.143.85.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=purpod.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purpod.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=purpod.org header.i=informes5@purpod.org header.b="O7ynO9V8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=purpod.org;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=informes5@purpod.org;
 bh=LBwaLr+wlbr8N/ILBVAzTSG0uUZeAj3452+lutsr+lA=;
 b=O7ynO9V8oRSymMfxBGU0+nsVV5ZZYyA5HH09Yek+LbbAFWtXmf8JZddACzd4b1Xo8SRzEKOVVZSd
   hLsNI6P/lo7Z1EnQGdF0XmnfPelVGJ3aYQbrboqfz6oCSOqNQGlfEvTYCTlcdvkU1kFYqAspCzHS
   kzOmT+BsrtYi6TN5lXk=
Message-ID: <86cfd09c68ada2f3d070e6b2b97d4b30188eada514@purpod.org>
From: Mary <informes5@purpod.org>
To: git@vger.kernel.org
Subject: hola
Date: Fri, 30 Aug 2024 07:29:07 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1";
Content-Transfer-Encoding: quoted-printable

Saludos a todos
