Received: from smtp-out-b3-82.tor.pathcom.com (smtp-out-b3-82.tor.pathcom.com [68.68.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471539FD8
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.68.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722120585; cv=none; b=arlEgze1/7u+frCyPfwZc9OEEJPGr7MCC2EBmBhfGgyA7a0uj8yQFxpjiO2IwG6mcpxF8GaB8zd8gNUvJTECPysVlMOS5M4SfSP9s96mF7inPNEyYKAwNgSKkClWsnfBeL2aA/0kHqgY+KL+lh1Otj5qrbUSzJicclqDhaFTTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722120585; c=relaxed/simple;
	bh=q+JAn/wKhj/74mMK5vqNjGkfHV6aw/3/nOPvg9c8nk8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KDdW0Hkmaj1bZ4qqnh5TWuA5Tc0xOosZsX6osNVPn+UnsglBfbp2OuXTDfG0sNc/aSqsEuTd5ODmwJzzDBnVcaWBIXK3awpnNFEJaHzG7CWHfP3/3KRntNPEzceG8gixqgKVz3drqce+q1aWA6YhZPByoDcqVOkYcBOt7Xq4Shw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pathcom.com; spf=pass smtp.mailfrom=pathcom.com; dkim=pass (1024-bit key) header.d=pathcom.com header.i=@pathcom.com header.b=AeRqk2Wx; arc=none smtp.client-ip=68.68.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pathcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pathcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pathcom.com header.i=@pathcom.com header.b="AeRqk2Wx"
Received: from smtp-auth07.tor.pathcom.com (localhost [127.0.0.1])
	by smtp-auth07.tor.pathcom.com (Postfix) with ESMTP id 31202540C27
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 18:36:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pathcom.com;
	s=default; t=1722119815;
	bh=q+JAn/wKhj/74mMK5vqNjGkfHV6aw/3/nOPvg9c8nk8=;
	h=Date:To:From:Subject;
	b=AeRqk2WxZ9TnA+Z12RaB7bxAagxPoSF64txmiUER2xp+d/f7QN86uEUXTIJZxMr19
	 EMkVLZKHgxBO+fOGl4+K6cxVhmLcVIEaDTsQA7f7wFudNUkerl7f0dT4fB6pWS2XPt
	 P4nSfnl87fquX5Nwh4Hc95kDpwltOxjKXkxfLU+k=
X-Spam-Level: 
Received: from [192.168.10.2] (rdsl-0145.tor.pathcom.com [207.188.64.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mjsalman@pathcom.com)
	by smtp-auth07.tor.pathcom.com (Postfix) with ESMTPSA
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 18:36:55 -0400 (EDT)
Message-ID: <c35ed7ff-48b6-4555-baef-cccdc926e6ba@pathcom.com>
Date: Sat, 27 Jul 2024 18:38:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Michael Salman <mjsalman@pathcom.com>
Subject: Problem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Using visual studio created a project and initialized it. Git works fine 
under vs
What did you expect to happen? (Expected behavior)
Using a command prompt I cd to where the repository is and give the 
command git status.
What happened instead? (Actual behavior)
It reports that this is not a valid repository. I noticed that the 
repository does not have a .git file
What's different between what you expected and what actually happened?
Using command prompt if I cd to a different repository (which has a .git 
file) the git status command works fine
Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.45.2.windows.1
cpu: x86_64
built from commit: 91d03cb2e4fbf6ad961ace739b8a646868cb154d
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22631
compiler info: gnuc: 14.1
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
