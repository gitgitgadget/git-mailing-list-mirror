Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F641DED7B
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124141; cv=none; b=ju4MpCmEUOQaZzMVK9KaaapO1c6JlUt4zqVXsVpGHjI0mYYcWCPwPA5XFXekoAWSvkCy0q7qqCxWMNlKR3hNYKdG3nDZju0/uzPO/xsctp7NJmCzaiDM/ko5Vs79ylDMcoYEheffKgH5kJXsa3Ynnq1Ky34GKx9h6dZSYodTPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124141; c=relaxed/simple;
	bh=s2hggFDt7s7xy2H4d+OrftWTkUFGEUVrbweCBcDPlcM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qppkEdRZoxOXjl3WuLf3j4RYdVZJfyV+li6vel/yUbgotrxgfirnRiyJ/HsEt4u6UKOaaOWG6HpaRnHQu292u/Q3AlrEz87H+TQ5Cq91kCSiPan5YHhMyx85WGg5slW5lixiOPHjrLp9OoHW8LJH6o83hMz3kITew5HaE+yKax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1thBdI-005She-Oz; Sun, 09 Feb 2025 19:02:16 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id C4DE460117; Sun,  9 Feb 2025 19:01:50 +0100 (CET)
Date: Sun, 9 Feb 2025 19:01:50 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250209180150.GP30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de>
 <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <20250208205709.GH30202@raven.inka.de>
 <20250209092514.GM30202@raven.inka.de>
 <20250209111406.GA12069@tb-raspi4>
 <20250209150924.GN30202@raven.inka.de>
 <20250209175450.GO30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209175450.GO30202@raven.inka.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Feb 09, 2025 at 06:54:50PM +0100, Josef Wolf wrote:

Upps. That's probably an ordering problem:

>   *.store     -filter -text  # <--- this is the problematic file
> [ ... ]
>   */P-*   filter=etsfile

Later line overrides first line.

Please ignore my last mail.

-- 
Josef Wolf
jw@raven.inka.de
