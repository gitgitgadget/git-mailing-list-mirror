Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954223B5F59
	for <git@vger.kernel.org>; Sun, 16 Aug 2026 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786923492; cv=none; b=ru70KmifK89jujVkVH5jtvcqzm+mVU/Th5555PtIFTsjxf75y8jO4ac0l6YIRDAZvlbF48XLWQPcx7uc555SvOXObnziNE1RWzcobuRi/RXDxE4Du+2XfbDyR2rHTfWnvIHJaNF82C2PSnGAifkDz7k7B5kkaGxqjGkzKJBrUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786923492; c=relaxed/simple;
	bh=XWb8bXLcY0cHx8H6RoqUzvDwTTqn2W8VtbDocPkK24c=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=OAKlQwtvXPl9tgLaxvUqCUi2bFlqr/Ud5l173pbIJ8S5To94WK/G70W7W7T4F8WPnx6yMcoJgPPoMsZjLVc7OH2/YR/5xmRBGFDQgdiKnPPSaw5BDU1LYzqQD16RPIYi1WNnBi0wrinC5ObOostlgtdsicYKHzDyNMfuwdNFbOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=HGFBQF45; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="HGFBQF45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786923485;
	bh=XWb8bXLcY0cHx8H6RoqUzvDwTTqn2W8VtbDocPkK24c=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=HGFBQF45VoS1lS343Hs4Gay6H1kUPZHG6T96wHpUiCqHhRqWWePKyi1Cg51Vm1Myp
	 XWAwCv0MvNzlBA1yz+VWaHftCXdNgnC3NCA03QiSIeMLLwbe0XgksLLCuqBmblrkKr
	 1DOzJ12ThLL6etEJLentOZT3/O+o4VzltuBvxYzs=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hNXT936KFz10nG;
	Sun, 16 Aug 2026 23:38:05 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hNXT90Cltz10mt;
	Sun, 16 Aug 2026 23:38:04 +0000 (UTC)
Date: Mon, 17 Aug 2026 00:38:05 +0100
From: Bradley Morgan <include@grrlz.net>
To: mdujava@kocurkovo.cz
CC: git@vger.kernel.org, thesupertechie1@gmail.com
Subject: Re: Add a git squash function?
In-Reply-To: <aoIxALomheh-3N44@kocurkovo.cz>
Message-ID: <86884685-B682-445B-B57B-113A0D00DF41@grrlz.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

Yes, absolutely yes a squash function would be useful, anyone developing
it, please do.

I get annoyed with rebase headaches.

Thanks!
