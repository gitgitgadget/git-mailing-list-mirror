Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1E2F619B
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108237; cv=none; b=UsRaBrFUaNEBG5oRScMCifXp38wGqbAgu4k9eXTzTxtjWSablD6AWxtwIGlCnajiSQMI9eCyPWwdd/NFwSmFczj9P80gtVhZ0r6KVxLQiiOZb52vduHL18jZ3BKsEAtnyIBhuF5MiEiNOneyBVnL8jC8NGJpX8uXOf9bAw/cdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108237; c=relaxed/simple;
	bh=q1FB42B1wHWPNFmZlbreqqL5nrXFcBEPk2pYajyFtU8=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=EDyog1gPhX7mNn2Uy4tldO0v8mSOZPzySv5PNdHohJAyf57x6C4Bu7ba7NJeFQVHymF8WrG5YyiNIotqaRonsf81zi9miHU0xGp3kGzUSYx5tT4VKBUyfGTvKYRtoPvmstJZJLk7lyaRz7NCnaVcjUQO+igl2l8ybBYKT1RzVi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=y1qJ3asu; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="y1qJ3asu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1760108233; x=1760367433;
	bh=q1FB42B1wHWPNFmZlbreqqL5nrXFcBEPk2pYajyFtU8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=y1qJ3asuVLCnyXHx6x82dsvSti1ry6f8wDo6yLFC55KgcVg0uzKyp1lIWi45JCcqV
	 fatbhbKIeYxFMDXwfwO+4WeGIktnkXPPvFz0GP6x7Ctdp+dsoHRFI48rUfIaHBmf+c
	 7NqEMYGtC2qYHD5v7iruIfsafMMXZg4mtzVHgu7qavklsu7sCVZDefkkwapX1Er0+4
	 +tN/x13X5FruTU1K+tNQ85ecVj6cWXs8V4hR5aaXTKZPSNpkDrlt5X+1KNAufEkcop
	 B88uVPSuYRTE71/dXvWNoqals6Ka73/oWvKwYGHG0+r/+ld1+I5IMXP3H9sbvxvKId
	 s06JM+zwl/k8g==
Date: Fri, 10 Oct 2025 14:57:07 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Sruteesh Kumar <sruteesh.oss@protonmail.com>
Subject: Probable issue with code/documentation
Message-ID: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
Feedback-ID: 82334824:user:proton
X-Pm-Message-ID: 5aa48996d93099eef69d121eab1b905e49e5778a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Team

Someone rightly raised a concern on incompatibility between git and eclipse=
-jgit related to pattern matching. Please look at https://github.com/eclips=
e-jgit/jgit/issues/217


Look at the first scenario in the above link. Git is matching the path foob=
ar with the pattern foo**/bar which is against the git's official documenta=
tion (Look at the last point in the double asterisk section at the URL http=
s://git-scm.com/docs/gitignore#_pattern_format).=20

Is this an issue with the code or the documentation?
