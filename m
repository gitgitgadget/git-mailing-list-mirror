Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CA1CD00
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720355952; cv=none; b=ACSHzkAj57oBjamDGRKRxqkk6Cw1eblqR/TLoj1j1rjaYWOMKRsmIPyvyMufCPvO02ckETAbAvuAaLGeDgbz3hUomX8hGvv1VkJe8DT5iN45EEfbobtKmX8/o35R7CgOqMkYGxXOkpu1awde0ypYoL+Nv7Id2V7spQAmpTleo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720355952; c=relaxed/simple;
	bh=eANGFvm9xCsM9ly2QDgdbuqSJzei2OPb/cy5UKhreKY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mFNJr0ZYN9hJyWNRqzrXDt6AnqjMCvk19QA4L6o0lXXYMHEZfR/+36py7fibms0OrRfkxZaWHnXnGHNNccMMjm8PFdhGs/zI3CMO3jI7uLEvCucz3qp6SlqtXMzWVS3loznVvBxqX2k8fs6SM5l+GxtNh/jdTkyZLWJSif5ohRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=OXql1Q3I; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="OXql1Q3I"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 5EABD240028
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 14:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1720355602; bh=eANGFvm9xCsM9ly2QDgdbuqSJzei2OPb/cy5UKhreKY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=OXql1Q3Ipb5MSpe5Q7dRj2hr08Kw9/RwUENeYm3PEy/WVMDLbWcef4oS1wU4XSiqU
	 4ir1wndwqMphVCI42v52CrvueNAu9U0O8Y5r9qftySfOQqtAoFKb2PrhUhsk7GuRe6
	 DGoRkHIrYgiBtMgSHDXccL7ulCJmQpAK4OJWCkigjrbRW4NyD36yHQVbl4b2lfX7yF
	 QEcGY2Sn+MDnd2kNmjBKam75SQjPPoc1Bccfjcf61bIdB1Fkjs5yVALAOx7gGY9D6T
	 zcAZTCUkf88Ps5uXAGxmEHElcJGZAMg1hG8b9g6V/JgR4VaK8wVsbKV8ZFxZGSeq8e
	 4IWXhF1l4P5nQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WH69Y5Yjdz9rxK
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 14:33:21 +0200 (CEST)
From: Tomas Nordin <tomasn@posteo.net>
To: git@vger.kernel.org
Subject: Unbalanced closing paren in help of git commit
Date: Sun, 07 Jul 2024 12:33:21 +0000
Message-ID: <87o7792xgu.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello List

The second line of the help message for git commit looks like this:

    [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]

See for example https://gitirc.eu/git-commit.html. It has two opening
parens and three closing parens. <commit> ends with a closing paren
before the closing bracket. Me and gsish (on IRC) suspect this is a
misstake.

What do you think?

Please reply all, not suscribed to the list.

Best regards
--
Tomas
