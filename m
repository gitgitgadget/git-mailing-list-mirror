Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569F12F5A5
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673419; cv=pass; b=o0fPp5/CCR3h0wWFVaBg0FAnwU0h1Pnk9+9JKBpkSV48B4IWrho0toV2jCNX2HAKZVe0/l0FtGU/Lyg8qAs/IPODrBQ/6VFSaJH0Pc2jimhodyAuCVSIULTKl7ql7AEO8xzeBWyhO5dOfmhZwsN49uC+szH+Cxu0/fdq2cZAbWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673419; c=relaxed/simple;
	bh=rOash2+xMcyoKGoee4ZAJfscYggf1Grpxo2/PDWBTNA=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=DV7NB4ZkvL/VigGAjSi02eO4TxJdNPpMlgmi/+HDeEd33cODRqBsDYtz/8QfS2Kk2A7n/yUW19FLmjUMIAJZ8xcBK84K1VP7xRGzj5Pbmu+Tv7wzcZYjk0i5tDUSQrp9cOpp1Nduj2IZZ41T0+X8TWlAzRpKGmg8MBUKaDaIiA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=fQt1iEs0; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="fQt1iEs0"
ARC-Seal: i=1; a=rsa-sha256; t=1758673416; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=EflLouuREdI88fYeCyiRS7be48aPx827XnH7Tdk1AqhT3F5fcaO9y0wFh5cjc2v6W5lfN3WyvudnO+3dZ4m2IdxXwDBs6FXSKSmfYfLxqFp1vBhK3ZXouQdbYD0yMBXu8ZNHjOdRkxC3f8sm/UllT2WOFk2IvtXSjhY8j65yFG4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758673416; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=rOash2+xMcyoKGoee4ZAJfscYggf1Grpxo2/PDWBTNA=; 
	b=dspWkYku3OvwQgkKqfmyKoFAlnKIVsjPVjRdNLqcD6j97DVLkhTMN4WGPq6SqiSabm3v+YXeJsd71NScFD/aESQZG729N+9PTDuHYU88aqUq93WPeI19DjiTTQwpKNKynjr5HbrA05S1uP/gs7zzZSNLeI5xz8VANWNz4F3WrCA=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+95c399a0-98d7-11f0-8217-5254007ea3ec_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671215416908.7444865012585;
	Tue, 23 Sep 2025 16:46:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=fQt1iEs0Rt0fXdp+VXbV/zCkzQnQee6kJTbycphs1OUSk3D4e0r+hUFq1hpUMEA2qwYCAD/VP+SsNFmO7Ajh4y+o5ekspX2Z2MWJepRypaj88RU+iNSA06yncPe6wfRNcNJMeWPKcGSVlacoB2OdgS3i1JSv7ZsBFSYmABLr94A=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=rOash2+xMcyoKGoee4ZAJfscYggf1Grpxo2/PDWBTNA=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:46:55 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: git@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.95c399a0-98d7-11f0-8217-5254007ea3ec.19978f9183a@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.95c399a0-98d7-11f0-8217-5254007ea3ec.19978f9183a
X-JID: 2d6f.1aedd99b146bc1ac.s1.95c399a0-98d7-11f0-8217-5254007ea3ec.19978f9183a
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.95c399a0-98d7-11f0-8217-5254007ea3ec.19978f9183a
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.95c399a0-98d7-11f0-8217-5254007ea3ec.19978f9183a
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.95c399a0-98d7-11f0-8217-5254007ea3ec.19978f9183a@zeptomail.com>
X-ZohoMailClient: External

To: git@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director
