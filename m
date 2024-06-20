Received: from vps7.jsvi.net (vps7.jsvi.net [81.7.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946CC8FB
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.7.6.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718927557; cv=none; b=ZNrvh20Y/XtoPOhk5V8R0qCs6gSmBWBgcEXUisc03hi+YyT32Xog2ymTKzUovIOypZbJoXCMvZyu/j7fy8Wvo7TMgzPkkzJODoEfmVkUPboS5WzuyE672o4gfn6ir4Z00PTpL7pZ1mnvspmyTT+A/VMLhMWMZIkmgGX2+jniyA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718927557; c=relaxed/simple;
	bh=LBwaLr+wlbr8N/ILBVAzTSG0uUZeAj3452+lutsr+lA=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=o1AGBZVh2bOVIO/Y3h4Xk9uZP+fLWFznAreZ9K1VPzwL7U8WAjY1tazmHcWHbb6Dbc6A59Mc5jcOe7cPH94uBUtyULHqWfdPtq22jRzB5mDbOccqdwDDmCEjpxe9cXj4gVBMoaoFVNo/tmTqhn4g2tIV4upnqA67qkwdG6wgF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jsvi.net; spf=fail smtp.mailfrom=jsvi.net; dkim=pass (1024-bit key) header.d=jsvi.net header.i=contacto2@jsvi.net header.b=fpqoix4P; arc=none smtp.client-ip=81.7.6.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jsvi.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jsvi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jsvi.net header.i=contacto2@jsvi.net header.b="fpqoix4P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=jsvi.net;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=contacto2@jsvi.net;
 bh=LBwaLr+wlbr8N/ILBVAzTSG0uUZeAj3452+lutsr+lA=;
 b=fpqoix4PHgJpjc7bJenpVdaztEgMcQEbQ5b2CzROaMB8hssKFxH+LX5j2r2CuIrz3Uvbc8AY2h2C
   Z+He7Its83DTHYCx8YS5aN7HAAt8VjXGFcqzSiSiLvo4UUp7N3Z6coFR4xSHKW9AmDVg408W26xh
   tGXmjJqstcoastTgXD4=
Message-ID: <20f4bd164fe2c8c90550e64da5113007a4cfd7@jsvi.net>
From: Paty <contacto2@jsvi.net>
To: git@vger.kernel.org
Subject: hola
Date: Thu, 20 Jun 2024 18:35:40 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1";
Content-Transfer-Encoding: quoted-printable

Saludos a todos
