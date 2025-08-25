Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4A22C355;
	Mon, 25 Aug 2025 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129182; cv=pass; b=lKTZjlgCidOI6Ho7vWKsftpKZSdCtdC7i0IeIUFLUIPNkfv9sFVs08a1QVh/b1yu1D4OLGZlqZGluVdxYS+77ps89z5XpdJX513v95NfWBkFo3cfdiBuJ3gKvfOl8io4ZaJiBdC62l4JsIyP0C2JW26h6VWV1PuS6ml3B8Ac4Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129182; c=relaxed/simple;
	bh=1th5xaXq+vxnxq7TV8vFCIuqpQijEUYAvV+e5m4TpJ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=n+KGsepAP+ttykZECWJeEqWgSGPJwGmB0qbi99KymCDtkw+xUh/t5sxMK/Ui/YM4N3CIPNY9n1ivDSNb9W717TijcrCsbTaeJWonaypxUDhEL3rYe1hArMSacqcR6royOW3Z2GC8vh+HI8hVIobb5wF+4uAg6YNJb8RawGeiCoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=Mp1DPvtF; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="Mp1DPvtF"
ARC-Seal: i=1; a=rsa-sha256; t=1756129146; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=II1IkQEYmuGQ6H7C+JNARmw9QnafOmirdeVPPxUK6sON3Bnjtk0Nc91QZKJo3EORS/WL5sHXxhYJY1/HMF3cIO1QKFfE/b5cxb9CPVOKic7hEJ2ls81KVG9WUUVNiqzpj7wVPJOPzPQURfHiDDq5PYH+2XfBrLquxT6WWfbkQ5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756129146; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FKk8F91MjrhdBrsJmWWDVqLiiajDBMNfHH23S0mJDh8=; 
	b=ash4lYSlIqWfCIqRN9ohKb/OQShYlRu6pvbZtAyucbQoC+FHM5dQlYdD60bilLOeYS22tR90Fvz6ROhEpz3kbd1VMGbzb5A9SbzRYgLzk3obCZ3WovZr9apZA1ZD7pfPiNC+q782Z2j+xhgTC1XtrSOZxvM2wYruRfeJf/afduU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756129146;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=FKk8F91MjrhdBrsJmWWDVqLiiajDBMNfHH23S0mJDh8=;
	b=Mp1DPvtF2z2av+wpSICYC3LAhaq2Z19UlVAoQapHyCcx2zqHqvVEbkM2UnsXo87C
	3QgBKcVXVXQOzxYYfucypFh6r163OEkjh2rWgc56B6pZi8IESSLvJ5zhkGkuYjcd19T
	tw3HFE5IHoyNMFuntQy7XGlp1Jz5I+n/o6Ng8lLc=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756129144652968.7641905688138; Mon, 25 Aug 2025 06:39:04 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 25 Aug 2025 06:39:04 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:39:04 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Bagas Sanjaya" <bagasdotme@gmail.com>
Cc: "git" <git@vger.kernel.org>, "gitster" <gitster@pobox.com>,
	"helpdesk" <helpdesk@kernel.org>,
	"kernelnewbies" <kernelnewbies@kernelnewbies.org>,
	"kernel-janitors" <kernel-janitors@vger.kernel.org>,
	"linux-doc" <linux-doc@vger.kernel.org>
Message-ID: <198e1742f3e.aebc766525693.2818180197972770618@zohomail.com>
In-Reply-To: <aKXXkvAOhStlS2_m@archie.me>
References: <198c29e9058.119e3a5c065010.5888624019176274871@zohomail.com> <aKXXkvAOhStlS2_m@archie.me>
Subject: Re: git: list of my complaints about future graft removal
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr080112272b2ecadc91e7eb1f0213f51d000075eb1957450486ecf383d1297a28c160ebd501c828707584c0:zu08011227ccefabf497ec7dbb2a0ff8ca0000ca41c970bf781c00f3da03182ce302cb27329ea33b4e7f2e7f:rf0801122bee689ede9ccfa43a3d8725da0000593d27f1e1f1162442177f917251759c21633ed1c5aa6ef2baac6497b9:ZohoMail

 ---- On Wed, 20 Aug 2025 18:11:30 +0400  Bagas Sanjaya <bagasdotme@gmail.com> wrote --- 
 > So shallow clones should use git-replace(1) under the hood (both on initial
 > clone, deepening with --shallow-since and --unshallow), right?

You are asking me? I'm not git developer.

What you mean? How git works currently or how it should work in 3.0?

I don't know how it works currently.

And I don't know how it will work in the future.

I just want "git clone --depth=1" to continue to work.
I. e. git developers should somehow take measures to
make sure "git clone --depth=1" will continue
to work even if grafts will be removed.

Currently "git clone --depth=1" seems to
be implemented using grafts, i. e. I see word "grafted"
in "git log" output if I use "git clone --depth=1"
(I just tested this on git 2.47.2)


--
Askar Safin
https://types.pl/@safinaskar

