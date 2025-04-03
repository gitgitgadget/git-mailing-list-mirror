Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6795E18DB29
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743713723; cv=none; b=NPJoapfQRxhS4qI3nuH0UeQO8o4eke7322fwQiiVSRiZsxvCWkk8KKuWqFis7cgiF7mS3LX6s36MrUIFmxWBtyy16ga4CsiwaVsoQ4qU75hwuGiKvWlI8F7EjCH5AYxt0UrI8DpRLLlDP3xoxtoMfdqcCd6yoWC2en8RueJ+Nq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743713723; c=relaxed/simple;
	bh=zQO6NYG2xpjBsAl0J1B1yd7IvWLTCou9sF5XTzGF4D0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=sIUqoSE51Os+t59tjIIKyhbpU8ChB4GQXKqH25ttoDhayi44MhUdDIV3D7puA5RTE1K5nOzh67U4tSmYDex56Zj4pwW1Gge+z+tKBNvhlq4p/da270BhH9SbmA4Dx//0/twdyy91Rg28vxlqkAGnoSnmkc/pZ5k9oQy8tQX/4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=CVNh78wQ; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="CVNh78wQ"
Received: from [IPV6:2a01:e0a:db3:aa10:912b:7cb5:e23b:991c] (unknown [IPv6:2a01:e0a:db3:aa10:912b:7cb5:e23b:991c])
	(Authenticated sender: sylvain.fardeau@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 4781D19F73C
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 22:55:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1743713711;
	bh=zQO6NYG2xpjBsAl0J1B1yd7IvWLTCou9sF5XTzGF4D0=;
	h=Date:To:From:Subject:From;
	b=CVNh78wQAFF4LXc/FiZVWvajU6eUjTGcDtwdQh+chHBUydyhA74blyohG8tebZnCe
	 BpItcjfUwrx6ytEGbFj0u6coNydbNeof8BfMPUU7nZyD4f85KaX9QmR94KyaayJz3S
	 FbTTY+hYuINrCkITLf8aCGzHmeXR9JtvVApByjvjKAPaC0AMokW+WQsxdZL7dTxEOP
	 CmMNCIzliTcNe3TluwfjT3hmUggZSmtUWIJ39hAP8yEoaN8CvQAJUViqoVeVncz6sE
	 +Noo4NbHzvhGsB4MFnnkSYC90z7SNSCJE7GH0CKAmxidnjVwg+B+BPREBmyaLenNhW
	 WwiUn6jwXxLBA==
Message-ID: <76775176-b7ee-4361-82a8-70b7d7701ee2@free.fr>
Date: Thu, 3 Apr 2025 22:55:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: fr
To: git@vger.kernel.org
From: Sylvain Fardeau <sylvain.fardeau@free.fr>
Subject: --filter=blob:none in GIT config
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear GIT team,

I was wondering if GIT roadmap plans to allow setting clone option 
"--filter=blob:none" as default in GIT configuration?

Didn't find a way in GITconfig, see :

https://stackoverflow.com/questions/76770003/is-there-a-way-to-configure-git-to-clone-with-filter-blobnone-by-default 


Would be very useful for developments using binary files :

https://stackoverflow.com/questions/79550931/cleanup-binary-files-in-git-repository-before-a-given-date

Thanks for your feedback & incredible work!

Regards,

Sylvain


