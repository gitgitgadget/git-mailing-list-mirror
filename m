Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFA3446C8
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342114; cv=none; b=kklOp+pBxQyw6YcracjRIeR25+GH9WAwENUPpzrbi9fDjRVD+qCpzfFj8q5n9brSViph2BBLzfVQ27RMGSBPDpgdnonCVRggktyGoV1MExyEIvP0OudagUphCpBVRwb6quV7hUra+DaafCYs4xPmEw0Sq9jzmMLfEDMdlo5MVbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342114; c=relaxed/simple;
	bh=BSbkiyny6iRL5cHpj37OLDXvdxeU5Xciz6k7/H57Bfs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qax2pVwtR1HUYwV7VoNLUlaOynle5lo16ZcvtDVf+ADPfrEXsli/EWBfXp6cIM9+qBQYqDsl8iLFCK9IaErMKYCHqsETrmY90dcpszac1scEuHxsSfAwt2oAJgsrxPgPgGk9L4sCbrrUEgGNoKzJ9xagEqvHfN0r+ts4SsaD63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ekP7ou/e; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ekP7ou/e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710342104; x=1710601304;
	bh=BSbkiyny6iRL5cHpj37OLDXvdxeU5Xciz6k7/H57Bfs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ekP7ou/eu9+JsNn7ajyTsiuI5kZwajj+/0SwZeck6SKK6P+hu1G7HMig3tngsMdXf
	 nFrHg0kVxlZm7R5GCqKb5LDYA2YKscsEWRHmnYy5WhiM2YKGE/XyCVM5ZcsWK+v76H
	 V/NTDllnl6GnLetkJmrrB87GcK1hiqxyM8lUg40ZxBXp9lCCKuJ9RcWQ4Yz2BQD/9H
	 Id+FrjxR2Z85nxs+9k0MPT36Sm4oQ1wUn+rtkqMGOhQ0IVIXNw9ce+LXiT3S/RsI+5
	 12BotxRuOtUGXseyiuc+0HLpnzDivTZ/v9RpJuAkyuh610NZ0SQ6G6zJDP+vhHw4SU
	 63cxLPFhyLPrw==
Date: Wed, 13 Mar 2024 15:01:19 +0000
To: Mohit Marathe <mohitmarathe@proton.me>
From: Mohit Marathe <mohitmarathe@proton.me>
Cc: Junio C Hamano <gitster@pobox.com>, Mohit Marathe via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Mohit Marathe <mohitmarathe23@gmail.com>, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 2/2] patch-id: replace `atoi()` with `strtoi_with_tail()`
Message-ID: <boJAHbg3xUqJ1hriFJu3QNlF9CYWbP9x9zu9mcV1jk1SI2WGAOes-wU1MMBZBWvMxs6VTkhlfE59iMEnYcDTOUTxA-3M72kvOJN613jaygw=@proton.me>
Feedback-ID: 95862732:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

I am writing to inquire about the status of this patch.=20

As a contributor, I am curious whether the decision not=20
to merge this patch was intentional or if it might have been=20
overlooked. Could you kindly provide some clarity on this matter?
I tried finding this on "What's cooking in Git" but couldn't find it.

If there are any specific reasons for not merging the patch, I would=20
be grateful if you could share them. Additionally, if there are any=20
further corrections needed please do let me know.

Thanks,
Mohit

