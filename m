Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068ABE5D
	for <git@vger.kernel.org>; Sun, 19 May 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716130365; cv=none; b=m2+w2kFXDPOA/Kk7K9439c61d3Aid0v9k5Vw8w9Q97m1nKN1ZmuyLuIERKNA2g6CKK6GVZ8S37V+xz3ek5d4ER0YtooeKSu+IoWedLptmsXklZZLnpezMSiNyevRTSdn7rNsgORl9nirLtXACEeasrn6iy7GkpHgSckHgtWnIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716130365; c=relaxed/simple;
	bh=yuWlQAvSLPGW/dyORDYkBGpVu1zrNxuOrzRWf9948lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ms9ZF+kGzyibaAWtgqWZGk2LQwmM3aMjEOR0Fozls9sICkJci+kmsM3dSrnbJ+0bj97RssCcsNVvNAQnzL1G4VDAgRzR3rtxCb1NhESnkzJj6bld0REc3p1vLyaeeWGBofpvsqmhq+esaIlyaDVST7mnYl4Ju/pKlqyemukx9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email; spf=pass smtp.mailfrom=iee.email; dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b=QelmQcs0; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iee.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="QelmQcs0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2024022300; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=Qg7c2AvsLrnwID+CDWGgzidfmIiobt+21iqoXXHmwZU=; b=QelmQc
	s0Ho/zEGzHyqYlHmNHbCS6Epn5g9bEaTfJoeSAG1Q3rErsKs1B2/v8cFq3FrLLoRGCDxdaTDr4EhR
	BmaJ1EXSJ5cO9BeX605j6OBVQFfsIX8FlBCZz64TqsN78uCC/jswEEMkHF2TAkxku8r4dTysVbKtw
	2GfqjGKcta4=;
Received: from host-78-146-11-207.as13285.net ([78.146.11.207] helo=[192.168.1.57])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1s8fon-000000000xk-7yU5;
	Sun, 19 May 2024 13:39:14 +0100
Message-ID: <b4d653e9-11a9-46fe-bb5d-3a01756c4454@iee.email>
Date: Sun, 19 May 2024 13:39:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: subscribe
To: Kevin Gale <s7g2vp2@yahoo.co.uk>, git@vger.kernel.org
References: <AA7553D9-B385-4745-8AA8-31BBFEF6A818.ref@yahoo.co.uk>
 <AA7553D9-B385-4745-8AA8-31BBFEF6A818@yahoo.co.uk>
Content-Language: en-GB
From: Philip Oakley <philipoakley@iee.email>
In-Reply-To: <AA7553D9-B385-4745-8AA8-31BBFEF6A818@yahoo.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kevin,

On 16/05/2024 12:02, Kevin Gale wrote:
> 
> 

If you haven't already realised, the registration/subscription requests
go via 'majordomo' as detailed at:
 http://vger.kernel.org/vger-lists.html,
in particular, http://vger.kernel.org/vger-lists.html#git

The archives are also available at https://lore.kernel.org/git/, which
used the public-inbox mechanism.

Philip
