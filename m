Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF213D296
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.253.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726208134; cv=none; b=e8hOIZb5uKzmSVjYDOZYPwYgQnvthTbGRdaSAdscJ7Q1ZNG+8LRB3xofHqrMzSHuIOVGhlT7Kp+dysstecghqGVI3/IPqRrkKU7WX7t2mAO8U/bPPrWi8oV9Upcz4v/cBdvN+XAoOfAkTABJr9Zf5sp1SZ084Gw59yQt6iTPmcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726208134; c=relaxed/simple;
	bh=SO8kGcf21YBZBOh6v8F9ilf6wxtTC5PUA3AF5Le99AM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eOASbY3Fzq0+gC2197HbgZw0RkcT49VAQ8884o5K9TUYRiw+oxBeAFU5uQaMvyWqp7ahttP1DUGDc8stIDyADTtNGJupBahMR75t7pOiB5+B8owHYHYigAxObw/hI7yi74dmrn8ijdoYLyNg4yDGG/ttN+iFduetWEMTsSMIZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se; spf=pass smtp.mailfrom=haxx.se; arc=none smtp.client-ip=159.253.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haxx.se
Received: by silly.haxx.se (Postfix, from userid 1001)
	id 95EF466356; Fri, 13 Sep 2024 08:15:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by silly.haxx.se (Postfix) with ESMTP id 951757E8E7;
	Fri, 13 Sep 2024 08:15:28 +0200 (CEST)
Date: Fri, 13 Sep 2024 08:15:28 +0200 (CEST)
From: Daniel Stenberg <daniel@haxx.se>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: curl 8.10.0 regression breaks uploads with HTTP/2 and
 http.postbuffer
In-Reply-To: <q7soppq5-nsor-4qq9-801n-oq3461n3r889@unkk.fr>
Message-ID: <85nsns3n-n4q8-n1op-5on3-0p4r95sr7485@unkk.fr>
References: <ZuPKvYP9ZZ2mhb4m@pks.im> <q7soppq5-nsor-4qq9-801n-oq3461n3r889@unkk.fr>
X-fromdanielhimself: yes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 13 Sep 2024, Daniel Stenberg wrote:

> We already fixed one 8.10.0 regression for HTTP/2 uploads with this PR:

I should also probably mention that we plan to ship curl 8.10.1 on September 
18, addressing this and a few other regressions.

-- 

  / daniel.haxx.se
