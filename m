Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EB27B519
	for <git@vger.kernel.org>; Tue, 27 May 2025 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362153; cv=none; b=SrkpV6d1rpGEbDJE6EgcfMvoFHPbFAk1EXjIqymmvgidAEyEtMSnf/cN2lUHcvHgMgpzBrCTBW2Cn8bRjXsbQaY0S1XU1IP/idyHSyWeeSiebXinZg+QtkrBu93vzVi+7zlPvFTP/P/+sK5j0Ly2l1ry4vU0bvBS08LpLklWldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362153; c=relaxed/simple;
	bh=71fAzAXOC55uLX0+5Ep9hohb2GWUJc7sfaLMl17OvOQ=;
	h=To:From:Subject:Date:Message-ID:Mime-Version:Content-Type; b=UDMDgF4kLFS5I1wjGIX4kPj0uLD2jPKTY5lQcjIFQp/K4numynlW8QA7Y+dxs54U9V1WN+Kvg1WsZeHaCiXBbWB8sjY7EyxvwAYgJj9PP/zfRAZp71Junpybh4i6Up7lSciUC6WtN8UFyMeHD7EU2bQo5tB7MADuhf43mQr6tMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcvg-git-3@m.gmane-mx.org>)
	id 1uJwmW-000262-JC
	for git@vger.kernel.org; Tue, 27 May 2025 18:04:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
From: Jon Forrest <nobozo@gmail.com>
Subject: "git commit -a" Doesn't Add New Files. Why?
Date: Tue, 27 May 2025 09:03:55 -0700
Message-ID: <1014npb$rbl$1@ciao.gmane.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Content-Language: en-US

The documentation clearly says that running "git commit -a"
doesn't add new files to the index. I wonder why that choice
was made.

Would the addition of "git commit -A" (note the capital letter)
that works the same as "git commit -a", except that new files
are also added be something you'd consider?

Cordially,
Jon Forrest


