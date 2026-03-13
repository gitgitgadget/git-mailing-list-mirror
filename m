Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A0C2FFDCB
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407685; cv=pass; b=Wop3PxspiiI0/7AcsYEnB+/r9uxrWMZb13oCWF4iDu8rqwh3a3UoiPEU3xL/biZKV0n6OdRC2L3xGMYx+3H0Ds/H0UNnMHe2tJD93wwPlkSHfsRUwjrioO+Ozy4P6llKlkskagxl1X1UNGjZK4+FwmJd4489oWQ5YFq7qnC/s/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407685; c=relaxed/simple;
	bh=ItRQSOMqXnyyRUA1J7qXO2WAd5285bjIcrs938sHwEo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ouA74XXXR524+sZwvnHrxg2ujeO+w8y8Qn/2aMIIRbHm6eOWnODCyFDStQzstyV2u6FzvD7tOaNs/0TDlpxR1+tokHvQTo264NC4zZbbD1e6uhesJFviKyLVoSPKMcG1uJhmwvbEgGdAHhO9o6UeD1tDbMJYzmRKaq7ImvifQAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
ARC-Seal: i=1; a=rsa-sha256; t=1773407681; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mUguOwZit59P4MfeH3vAhaFhfAI2AACFBO4PZGfEX3iLPDr95TSB02EfckCYe35QGOIHZQYMotRwf1SCkW3s9jLO2b0DXkgfkwFDeOjPNXqPYA2iTLhnXZB/ZJoc9MJ83NVQslgioRbA/brH01mwz7P6Dwb1TDJAsON+96R0Chk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773407681; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ItRQSOMqXnyyRUA1J7qXO2WAd5285bjIcrs938sHwEo=; 
	b=WCWhdO6YyVpTskqR61tPsb97iRZQKjLo6eAI3lhMsbxYjMVreA5Eq5LmwIG1Ydb/l/B0GJ3IPv6l0QAaiwbg5h3WsCVYr6Zi5TCQ4baP3GZXfMF/sUwS8O6tM058qs7aeMLzjWhkR3dcmbn3NSAOjlfiupRx0yQwuy8fyzEEYA4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
Received: by mx.zohomail.com with SMTPS id 1773407680137326.2586756308589;
	Fri, 13 Mar 2026 06:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 09:14:38 -0400
Message-Id: <DH1OK0NDO2D5.1BKGX8J7KWW52@ritovision.com>
Subject: Re: GitGitGadget's website is responsive, how about kernel.org?
Cc: "Rito Rhymes" <rito@ritovision.com>, <git@vger.kernel.org>
From: "Rito Rhymes" <rito@ritovision.com>
To: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>, "Johannes
 Schindelin" <Johannes.Schindelin@gmx.de>
X-Mailer: aerc 0.21.0
References: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>
 <20260313-loose-whale-of-speed-ccdbe2@lemur>
In-Reply-To: <20260313-loose-whale-of-speed-ccdbe2@lemur>
X-ZohoMailClient: External

Thanks Konstantin, I appreciate it.

I'll send the patch series in a separate thread shortly for review.

Rito
