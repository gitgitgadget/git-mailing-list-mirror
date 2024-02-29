Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC016FF33
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240672; cv=none; b=NLtdnkmVqVrOM/tnovUzzIqSp6Y0y1jRFp0vqO9g8u4MXyrtOOeI+M7MJsiQRojyEP9DxkjgPpp/Q6K5PjZvWptgkW6VGFAMoHK6n/ZsHV7c27ytJCZafCGqPiZsoUneGlHIP5mSCGsVCZh1hhixYzHtlt0/lajVPN5Aqz8Y7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240672; c=relaxed/simple;
	bh=9m79XC7oj6DMryOpMgrXmZTwGe7XwFkWeZ9og1NNhuQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lg+6SjCVF61XwNW8aulFXDB+Xfasyt+F4ROB2DW9BOWyZYGLgHzBHVa/JNKGKDd37cKadjfe9rp70ETfG+HXgqQtDz5wBjrzqAeONO7TO0GZc/TwZDdy0NfIUd/Q6gmas7uhshuX4whNFvw96W3SDSNw/PhMjH9najI8SfX640E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=WsLioguW; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="WsLioguW"
Received: from localhost (ip-109-42-177-171.web.vodafone.de [109.42.177.171])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 41TL4JJD019792
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 22:04:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1709240660; bh=9m79XC7oj6DMryOpMgrXmZTwGe7XwFkWeZ9og1NNhuQ=;
	h=From:To:Subject:Date;
	b=WsLioguWjy5bqLHuKGvEaiH2TYN/nz4G5mu/g5YQQ0nwgIBqC9oSay6L57Ew6dj1w
	 9NsjhPn22/uCGiJUiq4eg9j1YVBiKsb4HiW9fsVNwmemLlurmj4ajyDm3TcSnbI3Rr
	 GhCuGXRB2US0+0fPo8dyhg5EdcVtoRuUdoem6dYo=
From: Dirk Gouders <dirk@gouders.net>
To: git list <git@vger.kernel.org>
Subject: [PATCH 0/1] Documentation/user-manual.txt: try to clarify on object
 hashes
Date: Thu, 29 Feb 2024 21:57:41 +0100
Message-ID: <cover.1709240261.git.dirk@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I'm not sure if such patches are welcome -- they could cause more work
than it's worth it.  On the other hand, the contradiction irritaded me
and I had to dig a bit and check it by example and writing this down
could perhaps help others who also stumble over this.

If someone knows the exact reasoning why the hashing changed from
_after_ compressed to _before_ compressed, we could perhaps add that,
too?

Dirk Gouders (1):
  Documentation/user-manual.txt: example for generating object hashes

 Documentation/user-manual.txt | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
2.43.0

