Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1AD223C79
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029051; cv=none; b=DXAG0i9xWywiz9VNGSfymZVbX1XqgAWkltVs078/DcwGUYScLS4BlqB2+FZW//Ah3X9FsWoae+YmlH0wa8VKrTZ8tXStbFk4RAHI+cwHCbxEE6nJOUe73HykN38WFbvd2IOSms7Wm0lwIM8NNo8OKInl2KiwGavfReHbtzIvMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029051; c=relaxed/simple;
	bh=Hh1wqIrTNQE4zjp0fQxljlEYu6UB0OL4E2UF/Rbk+yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5yi/oZcNrf/NdxAgp066jgmy9OtIOeXW3y++t3H0ranBGoXMy6zTAwkaT/TZTM+jFOCieAbO6pPMtjnEYg6PYiyM9qKoykzwqt2STE7pQ8wlyDXY8e55FlLcO3mkg0Sl8DqUjY5hwBxlq3YJpCX1EYhoIanSBXVnYWRlVYRRrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Y8LwL0XRqz7QVcD
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 19:44:02 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4Y8Lw406MQzRmx1;
	Thu, 12 Dec 2024 19:43:45 +0100 (CET)
Message-ID: <9dd297db-1c87-455b-bb95-fbc174b8a6ca@kdbg.org>
Date: Thu, 12 Dec 2024 19:43:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gitk: make headings of preferences bold
To: Christoph Sommer via GitGitGadget <gitgitgadget@gmail.com>
Cc: Christoph Sommer <sommer@cms-labs.org>, git@vger.kernel.org
References: <pull.1835.git.1733767737.gitgitgadget@gmail.com>
 <d58ce9d609d8a5da3edd1e1061d84919af12b02d.1733767737.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <d58ce9d609d8a5da3edd1e1061d84919af12b02d.1733767737.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.12.24 um 19:08 schrieb Christoph Sommer via GitGitGadget:
> From: Christoph Sommer <sommer@cms-labs.org>
> 
> Make preference groups like "Diff display options" stand out more.

This is a nice and obvious improvement.

-- Hannes

