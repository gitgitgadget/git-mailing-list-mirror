Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764256448
	for <git@vger.kernel.org>; Sat, 11 May 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715441170; cv=none; b=pDyt9lQmZ1Rt0jGGy+As6qNqoqB5sFHMSab9JuvNHtxYV4d91Wwp3hNDlA7yyoaePOkJcXvm3l2ZbMUPhBXELkyLpwU+CRJzPI9bCX/UajMuB6/ZyD1JGW1OUHCHvFn23aQqw9f8gNzooK81Z1i7x1MCStYspoKPozlBaYD5jKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715441170; c=relaxed/simple;
	bh=RFw+uJJfQ3+2v5zllj7lpju4LVjoU90rvadle/c/cRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqPNZ7vsiAgnN8s0Eh7TzJ71PIC8QuytZ1l+0MBjnShz9hKBfdbNMdsOa9teGj+zvntydvJqDS0mI0/Xs5HJZuhN3dookt1Gcn8QcS6s4bxqdMxyNDNgcVqPTNO/Tt3uVaepTbfTu1KmQnSyRuU8f+z1xIPIXWMLvYE8bl4lZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Vc8j43Jmxz5vSt
	for <git@vger.kernel.org>; Sat, 11 May 2024 17:26:00 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Vc8ht73LXzRnmK;
	Sat, 11 May 2024 17:25:50 +0200 (CEST)
Message-ID: <25c0ec11-4b20-4c78-ba77-8d10ca2ef21b@kdbg.org>
Date: Sat, 11 May 2024 17:25:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git-GUI change of maintainership
To: Pratyush Yadav <me@yadavpratyush.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.org>
 <mafs0r0eob610.fsf@yadavpratyush.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <mafs0r0eob610.fsf@yadavpratyush.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 29.04.24 um 16:24 schrieb Pratyush Yadav:
> On Sat, Apr 27 2024, Johannes Sixt wrote:
>> Since Git-GUI is an important tool in my toolbox, I would
>> volunteer to pick up the task.
>>
>> Pratyush, please let us know if this would be OK for you.
> 
> Yes, certainly! Thanks for taking this up and thanks for your work on
> git-gui in the past :-)
> 
> Acked-by: Pratyush Yadav <me@yadavpratyush.com>
> 
>>
>> I will let you all know if and when I have set up a repository to pull
>> from or to fork.

The Git-GUI repository that I now maintain is at
https://github.com/j6t/git-gui. I have cherry-picked a few commits from
the Git repository so that at this time its master branch is
tree-identical to the version shipped with Git v2.45.0, i.e.,
v2.45.0:git-gui =~ 8c60bdfc0dce.

I am about to apply the patch below to note the new maintainer.

> Would also be good to send a patch to update Documentation/git-gui.txt
> and Documentation/SubmittingPatches.

I'll follow-up later this weekend.

----- 8< -----
Subject: [PATCH] git-gui: note the new maintainer

Pratyush Yadev has relinquished, and Johannes Sixt has taken over,
maintainership of Git-GUI.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 README.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index b460b64..948e925 100644
--- a/README.md
+++ b/README.md
@@ -42,8 +42,8 @@ You probably need to have root/admin permissions to install.
 
 # Contributing
 
-The project is currently maintained by Pratyush Yadav over at
-https://github.com/prati0100/git-gui. Even though the project is hosted at
+The project is currently maintained by Johannes Sixt at
+https://github.com/j6t/git-gui. Even though the project is hosted at
 GitHub, the development does not happen over GitHub Issues and Pull Requests.
 Instead, an email based workflow is used. The Git mailing list
 [git@vger.kernel.org](mailto:git@vger.kernel.org) is where the patches are
-- 
2.45.0.271.gd8a10d2f05

