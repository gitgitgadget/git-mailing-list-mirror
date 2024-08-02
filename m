Received: from smtp-out-b2-9.tor.pathcom.com (smtp-out-b2-135.tor.pathcom.com [207.188.95.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A61E522
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.188.95.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624623; cv=none; b=Oclt55qt7ZcP1HIln3LBPXt6zAyf9f6gNdZqfOLWJyAYKtExBsytLEwMIExHWwsjWXnpWp6e8KKwJoD3CTFQ7w3s8eLPb504h9GrUbYkwne4goFOb9AgZe1KMvpCv8qVpxfSf3RA8tORfv9cPJtOnRLqdm54DHEGo0x11Ajgfkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624623; c=relaxed/simple;
	bh=jU70uVUirDVYbXupDtP5cxnadpRp9vObxOMz5tPGh6A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=u04ZeDVWtTJirUunRZHrTHy5jyC2dn3S968a8AtN8ap4Tjymi238+QGK2tIYy03sGcLUrZ5YTnMy/obZ/T1rnqSdiUaaD2ueaBcDPQlEH2DuNZx5YxWSSqsnKLpNd10zw07grESzs75GlNiNWnlvb/crDf2l2iHml56Kp5qLego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pathcom.com; spf=pass smtp.mailfrom=pathcom.com; dkim=pass (1024-bit key) header.d=pathcom.com header.i=@pathcom.com header.b=OUh6spp8; arc=none smtp.client-ip=207.188.95.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pathcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pathcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pathcom.com header.i=@pathcom.com header.b="OUh6spp8"
Received: from smtp-auth08.tor.pathcom.com (localhost [127.0.0.1])
	by smtp-auth08.tor.pathcom.com (Postfix) with ESMTP id 36D26540C64
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 14:38:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pathcom.com;
	s=default; t=1722623912;
	bh=jU70uVUirDVYbXupDtP5cxnadpRp9vObxOMz5tPGh6A=;
	h=Date:To:From:Subject;
	b=OUh6spp8mcYlZMDIaiRP8rPTYH+D5i08dV55x+18SAFhTO761AwdNVnMzyhUK5JbV
	 rZMsAiL4c/AaMjfss57rkcCuZkgQxSn3lPIOJ1BT1D/3Rg8EiCCDGBZ7hgU3wEen55
	 Gfk17AbaEED6dvyF2YcNvZAP//RKYsSgQeZQxQQ4=
X-Spam-Level: 
Received: from [192.168.10.2] (rdsl-0145.tor.pathcom.com [207.188.64.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mjsalman@pathcom.com)
	by smtp-auth08.tor.pathcom.com (Postfix) with ESMTPSA
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 14:38:32 -0400 (EDT)
Message-ID: <3db395fe-8d32-4a33-8f16-7df95f3ff194@pathcom.com>
Date: Fri, 2 Aug 2024 14:41:48 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
From: Michael Salman <mjsalman@pathcom.com>
Subject: Merging problem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I am new to using git and I encountered the following problem

1) Created a repository using Notepad added a file (FileA.txt). Put one 
line of text in the file. Did a git commit -a. so far so good.

2) I created a branch (my-branch), did a git checkout my-branch

3) Using notepad loaded FileA and changed the first line of text to 
something else. Gave command git commit -a no problems

4) Git checkout master looked at FileA nothing changed

5) Did a git merge my-branch. No conflict reported

6) Loaded FileA in master the text of the first line had changed to what 
is in FileA from the branch

Your help with this problem would be appreciated. I hope this is not due 
to my lack of understanding

Mike
