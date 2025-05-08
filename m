Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131124AEE0
	for <git@vger.kernel.org>; Thu,  8 May 2025 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685654; cv=none; b=KBi7BvceoywBju8tu5ngWjxqZ6UPSCHAm0vRKF0PukNGiFbW7YT8Xx9/zXWlYGerfd36nCMd3W292toSVF7RHtm5Xw+0tmWla6ff9+0ByJcsNaOhogNMLx+uJo5b6YCNn125qX90xD8LWqw54EERTtJ3TLsBBLy4z+ZrtphcThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685654; c=relaxed/simple;
	bh=p9zVYjrhMwPlkKvRjUZADEWhPhGxjgfvqfWaoPQclsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=sRYzrn7RiRfm85HxY37RzPe9QSNV6q6XKw/3L26M39dv3sVsjX5MyUUNYjOSvjiXgWmknM44BNFLwV7Dr39M3aqDVj26ktF8lmDa1mwvBLonhSuEnJAaonH9EoA7tjKhM5LmRsdpvDvFhzgW0h3NelgLEY99XnlicKMPuZ8YNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4ZtMcg0DdhzRq29;
	Thu,  8 May 2025 08:27:30 +0200 (CEST)
Message-ID: <d80dd1db-de81-4e5e-9d82-70794783780c@kdbg.org>
Date: Thu, 8 May 2025 08:27:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (May 2025, #03; Wed, 7)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
References: <xmqq5xibao5s.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>, Moumita <dhar61595@gmail.com>
In-Reply-To: <xmqq5xibao5s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 08.05.25 um 03:26 schrieb Junio C Hamano:
> * md/userdiff-bash-shell-function (2025-04-01) 1 commit
>  - userdiff: extend Bash pattern to cover more shell function forms
> 
>  The userdiff pattern for shell scripts has been updated to cope
>  with more bash-isms.
> 
>  Comments?
>  source: <20250330134018.9662-2-dhar61595@gmail.com>

This round has room for improvement. I posted a review yesterday:
https://lore.kernel.org/git/9d548d94-eed8-434a-a9ef-67df694c5c79@kdbg.org/

-- Hannes

