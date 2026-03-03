Received: from mail.runxiyu.org (runxiyu.org [155.138.132.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEFB38D00F
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.138.132.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532250; cv=none; b=gD4gMeXRktf3CbJbE9qGDqU+aWqh+AGQqyJEUWx05Vej5nrIBBXQoJDYmFLL+XV/v/FlH4Q7PcoQY3tYD9523YDvtMObi1WdkDUhfS7a5GEE4pWYFO/zZ3NsvY6aflw/zIgOYxM6yUO4lZLwnm49PGD8IM3l112M+EkSzSpzSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532250; c=relaxed/simple;
	bh=6KCY32PBXAcr+mwOMd7RmYu0yB4lfABO0p6uvZOwlKo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ptq+0vtvkvUss97XsI4Dh6bfqJ70qgJ/h4+YAu6mBo4eRj7yz9JO+LivnC/cCeLA8Uj70HBF3ku3slFiYL0tbLRWksltjIzPb6KjVzVoYOMkSsLrdtAanW6NZkhjV+8Y4xAwSLHS0JvG99OTgtUicZ96LYcMQfz8uYzRDk7oqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=runxiyu.org; spf=pass smtp.mailfrom=runxiyu.org; dkim=pass (2048-bit key) header.d=runxiyu.org header.i=@runxiyu.org header.b=aBkm/AuB; arc=none smtp.client-ip=155.138.132.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=runxiyu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runxiyu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runxiyu.org header.i=@runxiyu.org header.b="aBkm/AuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=runxiyu.org; s=mail;
	t=1772532242; bh=6KCY32PBXAcr+mwOMd7RmYu0yB4lfABO0p6uvZOwlKo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aBkm/AuB/B3BQva9ru+sq+7SpYvaWRre49T4LG/hTaheH1iSpwp3FNbCerlJ41GsH
	 XcIkD6M/jwFhDFOAPk++14ggnz/KymAnbDz1yFUwn1qv9erOIBTmDdZTXH436+QyuT
	 S14zAIKHgr9HpIzOMH8BV3s7gP1Ptke3qMOuo3jCKV6flJMcFigDE/7+qdDNwn38o9
	 e0u40KhzAqJ0nmiwpcnSYcluggzlI0LTjq85YjfCTEooPiw/S27sbHpgeItWjSUi2I
	 DcbYRwIc/aGr2v4wcbRJ4rrsOXuRgVuG6cJEwo61a7tJLgalpEFsM6vcPenjZ7ZOag
	 Hfdde4GAz+s0g==
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 18:03:59 +0800
Message-Id: <DGT28LI984JN.2J085E2142YHO@runxiyu.org>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH git] t5516: test updateInstead with worktree and unborn
 bare HEAD
From: "Runxi Yu" <me@runxiyu.org>
To: "Runxi Yu" <me@runxiyu.org>, "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.21.0
References: <20260223141236.22476-1-me@runxiyu.org>
 <xmqq1pibnuej.fsf@gitster.g> <DGMWTSG72GEI.1TA0INKB1UHB6@runxiyu.org>
In-Reply-To: <DGMWTSG72GEI.1TA0INKB1UHB6@runxiyu.org>

I'd appreciate considering this thread again since it's been a bit more
than a week.

Thank you!!
