Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CCE30C62E
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849541; cv=none; b=BUTftFayYOqrzdSE8MpDceA8UTaByw6E3KPG51S0C2hNuuU25CULxfUeH6Y+GehdY/W58a3WTGFz/5YyozMd7rcwZxNi3gLl/omWdRCgNKzqmRzXVR8WBZPLPBBZWAxIin8dNGTzq03u4nhXwdZv+DI1leMF/QQxFaehOFX/pOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849541; c=relaxed/simple;
	bh=QRfeQmB6oGumBfdcNo3ua+k0Xg1XofDcFQ2KID2xcOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3fouSobaTlxv2a0I+IHA/K1nyCA1i+8L3CY0R7t1es69kAgT4iBtBnuR3Zqa0TA6jBDlUquJJv5vr9BB05Ec3myZTfU2QEUEO9AuOHsNihzyN4MKm0+tb85bFG848K2/qB80i3pmgM/8gjYBciQF23eRnCr3P5IJQj7IiMXa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4dw0K54vVKzRnlL;
	Mon, 19 Jan 2026 20:05:29 +0100 (CET)
Message-ID: <156396e7-7efe-4ed0-a217-c8c2539d9dcb@kdbg.org>
Date: Mon, 19 Jan 2026 20:05:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision: add --maximal option
Content-Language: en-US
To: Derrick Stolee <stolee@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
 <1da38e88-3f61-43df-9c75-5716d715bf80@kdbg.org>
 <b46885b1-5781-43d8-8751-d85048c45e5e@gmail.com>
 <1ce18cac-f988-4741-b9dd-6c1cf2d4e6af@kdbg.org>
 <3fab80c8-f602-44d5-8e7d-436982a5e3a8@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <3fab80c8-f602-44d5-8e7d-436982a5e3a8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 19.01.26 um 17:44 schrieb Derrick Stolee:
> When the argument is moved in the documentation into the set of
> filters, then the fact that --maximal restricts the set of commits
> makes any modifier such as "only" redundant.

Keep in mind that rev-list arguments are also understood by git-log.
Then one could expect --maximal to be somehow the opposite of --minimal.
(Which is badly named for the same reason, but that ship has sailed.)

-- Hannes

