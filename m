Received: from cicero10.metanet.ch (cicero10.metanet.ch [80.74.152.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6672018E00
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.74.152.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706349122; cv=none; b=drBYrX0CV18kzqvwmKmHSFh2aIYL/x2dZ4OR+AKepXw6/0ShN1ZQsA8Sy/a/mt05BSB27Wqm9lG60nUURxdqJJJCo9JLHZSiseowW1TqrZjNnvshxb+VXOj2/NF880cHBOv4te+B+FRlwuSwi2JWslaHiywpe89MQezhUb1DVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706349122; c=relaxed/simple;
	bh=X++s468mVsEuUMVE+lJZ77QTXgkoYWAavuTVZLID1ec=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kCBqsiN+ipioHCicugqcFTjnnoJa/H7AODz/o18s27+VuocUsYZEsCLd9BINzuevf5zIwSlOZ/kDkJ1/WRxNdUUPVFldFuJIhSqTUbSXOTImL2ZPs/lBPeHgt/rXynUatSc7VYiOykayNKLfYrVKXt0QlNSUW/PntYlIjxZJzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=king.ma; spf=pass smtp.mailfrom=king.ma; dkim=pass (1024-bit key) header.d=king.ma header.i=@king.ma header.b=mNLHttPj; arc=none smtp.client-ip=80.74.152.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=king.ma
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=king.ma
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=king.ma header.i=@king.ma header.b="mNLHttPj"
Received: from [192.168.111.16] (localhost [127.0.0.1]) by cicero10.metanet.ch (Postfix) with ESMTPSA id 1027D74904C6
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 10:43:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=king.ma; s=default;
	t=1706348620; bh=hcKjhkB20xvAFjmSTuwllANTwLrYqfu+x+hzpVr4Ed8=;
	h=To:From:Subject;
	b=mNLHttPjMZjuDj4XF9wjiaqLiKitH020/QoJ7jLIHMAo60euT4hP3IoOJXe4gzJOd
	 GfqiZqMhZUt0jSVPLV+L8S86HBgcUjDJ1hxE06k4uLt97LypkIT7usHnny0z+L1PCc
	 z8z47u8e1p+lXiEhI5PSxAGWrgBTk7JuYNTUEdk0=
Authentication-Results: cicero.metanet.ch;
        spf=pass (sender IP is 83.97.87.43) smtp.mailfrom=johannes@king.ma smtp.helo=[192.168.111.16]
Received-SPF: pass (cicero.metanet.ch: connection is authenticated)
Message-ID: <66e4baf4-439a-4a1b-ba95-1f9ed222d42a@king.ma>
Date: Sat, 27 Jan 2024 10:43:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Johannes Kingma <johannes@king.ma>
Subject: add two steps
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

For git to work at least a user.name and user.email globals are needed. 
would it make sense to include this in the installation process?

