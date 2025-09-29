Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2FE14E2E2
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135347; cv=none; b=fYoAkqYJaALUDA+VBZevY9mTrY1gp2Qg+//yRwFw50eCnDNF6ZQdjteO1ZiCGWPkVAPUsAC2mdhWjQu5H39RiFHUt6ZZAhXnv9psVsCzhcLOxVG3kDjPXZaCOcNUQ+uiNqJ7kbmrKZ6vu1/PVBDSkx2kejDRO/oKIq4/SlDrg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135347; c=relaxed/simple;
	bh=/k9/eOmiH5QZDqkQ4GtQerCVlHMwpitJqCtEw3xApRc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=IBpzmQNI3S+KRZ/mfCQK2yWdrY0ycxfskE8Rieu4FJtIlVR+0QYq33Lht8JkJeRgfDRZHxVxRNgivY2dw3ovyowqvElEIyWGggK83ZPvfXmHzewWaoiKMTlinEfDun0EIOOQMWUlO0iAa1iIOoxXV3EixlYda7tBUcYMDj0hZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=henrik.bennin@gmx.de header.b=m/cfuuRe; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=henrik.bennin@gmx.de header.b="m/cfuuRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759135343; x=1759740143; i=henrik.bennin@gmx.de;
	bh=/k9/eOmiH5QZDqkQ4GtQerCVlHMwpitJqCtEw3xApRc=;
	h=X-UI-Sender-Class:From:Content-Type:Content-Transfer-Encoding:
	 Mime-Version:Subject:Message-Id:Date:To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m/cfuuRepMW3gZQX5WdaaP8enwsPKzQ6BzJj0MahF+3U+L3ln+TmVzZk+/qxed21
	 jkTVG7sJnMhCOmFQ7PMlZZfwYuVzHwksU2VTgfFDEv7mmmJw7UJRA2nLrO0NLKkH9
	 cBYnkWjTxCEyeMyq5FCJjItNPoqAW8mzqSbZdopKJoufptKfLFzBAQCLkxFkXrXAO
	 jJwwACuaW/aACteSRHmv5XCjaYC22VMSA4E/o/QeovmMc62YLMYitX/DCrpAbVCjV
	 57nbu+RNyCh00j5nGItvLrXYXyMeL5wyt61noA64YSAfm+Ug1gobPI2BWirnmdCPu
	 kIEeYNlZRuYrOdmsTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from smtpclient.apple ([208.127.57.20]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwfWU-1u5IXt0vCE-00zfpe for
 <git@vger.kernel.org>; Mon, 29 Sep 2025 10:42:23 +0200
From: Henrik Bennin <henrik.bennin@gmx.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: I still use git whatchanged
Message-Id: <FAF6A70E-D242-49BB-B303-A7859CAC8E11@gmx.de>
Date: Mon, 29 Sep 2025 10:42:12 +0200
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81)
X-Provags-ID: V03:K1:3xLoV9yWOOXgU5TZ2WLyqimNlIuwZrBocKGPpWszXS3j2AaTgzL
 5q8sgRVUJPPVTYC/9DiOIP5iDilFUEtVqi0BSuL6pHFap+JD5LuRAk6ywwTgYdBCLvtUmy2
 k9zqeH344PlQDXqrSM2EUu7Qr/AeozZxNTJykePsatqkhACMaejlRg0B5h0CCzaMi2Jdaah
 onAZn0SYJ0A6LMgAvqO7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ggZmOwlZIVY=;DYUQhXq/n/1QLQ/Dal4JzVGhu5C
 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
 QQmay91XaPa9q2pvmlomCyqucjpnesjQ==

May I ask not to remove git whatchanged because I still use it regularly?
