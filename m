Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC052125AE
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 06:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="eLQgZQNB"
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w1.tutanota.de (Postfix) with ESMTP id 3B93BFBFB04
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 05:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1704606980;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=FA02WNxQOlI7+8DUmZ9UK8ZDuCndRXsaRPjHpnRS3oc=;
	b=eLQgZQNBAWUHYgdhtJpmblZCH9sgIsM7JIF1CsWFADjSaxM2Nt8rS5NJqNPhCpXz
	jsQ5/DwoDHFWLEDFaj80asUy0DMy6FT8l3VG+iDegv5mW6iaXxeMCTuzw40OEPpqEi/
	sr8x9UUGavAZGtaF785W2G2dpqYTMn2dDYlG2lnZJhmTqDI54rUP8ZCUOF3wgTBYcb3
	xlEoBT3NukFNpBOfEUcor6yMpqiRyrUuwaz0lqwFB2AfCDHITp8BFMmCeyFg0plCnUP
	Ed/EP8QFt4c0mDik30Rhe6VcVviEkvPLAF5o+levSp63IF/K/2FAXrCRdfAXC9Ou4vS
	JNLZKuQV9Q==
Date: Sun, 7 Jan 2024 06:56:20 +0100 (CET)
From: Trix Knotts <enderk@tuta.io>
To: Git <git@vger.kernel.org>
Message-ID: <NnXUPNo--3-9@tuta.io>
Subject: git config --global needs to be run in a git directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi! This is a minor issue, but I noticed when I ran `git config --global` from my home directory it gave me this error: `fatal: not in a git directory`. I was able to resolve this simply by moving to a git directory on my machine and rerunning it, so it is not really a big issue. However, I think for convenience it would be nice to be able to run global things like this anywhere. What do y'all think? Would this be easy to change?

BTW this is my first time emailing the git mailing list, so sorry if I did something wrong. Please let me know if so!

--
Trix Knotts (she/they)
