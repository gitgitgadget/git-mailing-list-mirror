Received: from zucker.schokokeks.org (zucker.schokokeks.org [178.63.68.96])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2B1ABED8
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.68.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650035; cv=none; b=dZMf7UgZwIiBaOHyoXWd/uGDp3xt9kDlCUOLwnoJRtb9G2Ms323+BlSTu+JsgDRaAxzxlzVSFXx6ziIiv8oO1CSbqKKYNosP4GlXSS2SkC99RGUg9Z8xXvzvIVHuLUj6Dydo6qsQUmFxoy5JjaXkBuUzmLcmSAZuKyc0BkdThfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650035; c=relaxed/simple;
	bh=ZzPnyoijqJfyEmqtoymx0YVsnP9tXM97GSZo5znRDJM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=T+xro0tIEpLlu9iOXjDDO5bg0wq6GztPBbWSaxkXPq7VW+X/r6oz7KxFPKvifPNFDWM9KiYMoUBoE5tdOtkrS/c1sdNMMsp/2Z1mjT0/0VA9x/LQEm0UtLIidFCRjR3credg/IE5BsYDBkswC+9BHC3gNJaNzO5chm/ohbffyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=das-werkstatt.com; spf=fail smtp.mailfrom=das-werkstatt.com; arc=none smtp.client-ip=178.63.68.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=das-werkstatt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=das-werkstatt.com
Authentication-Results: zucker.schokokeks.org;
    dnswl=pass dns.zone=list.dnswl.org
    policy.ip=127.0.0.255
Message-ID: <5b4c09a9-64bb-e672-e604-120563fc1ad6@das-werkstatt.com>
Date: Tue, 26 Nov 2024 20:40:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From: "Peter B." <pb@das-werkstatt.com>
Subject: git support for "xattrs" (extended filesystem attributes)?
To: git@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone :)

I'm evaluating and testing extended attributes (xattrs) for professional 
archival collection use.
I couldn't find any proper documentation/information on how (well) git 
supports including xattrs in version control.

I assume behavior may be similar to any other property-change of 
files/folders?
Would it be possible to have bit-proof preservation of all xattrs? (even 
larger ones).

I'm grateful for any insights, pointers or comments. :D


Thanks in advance,
Peter B.

