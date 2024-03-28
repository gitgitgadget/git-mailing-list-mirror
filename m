Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56761694
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620901; cv=none; b=iLjFpwoX5+8qlGm52dF11lW/utdn/7ZDADhve6oWR2C8kHfHQcc6x66FgvfJ3EpADs0symXPR8kvVpeKx+MsB8uqCmgte6eZX5rIbK6m5UD9TGnJ8FATOOWZaYlLGNnr+7FrdNGh/96NwYYH6JoXY8rK5MbQtV9kexYS/0yvhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620901; c=relaxed/simple;
	bh=tVE8Ss8YI8qZ4vAZiSpvZUd4FgUA/crhZh1nZgBAsbw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq5jxSE3PTmCyjZfMRJ0/Mx8pO0ggQPVR+i6/FVStnIO6i7hZ/FHzUIQZKK2UPQ6+HjfIEyZJjLUV2x3erNFpG/qkBSz3nsYDpZ/rqV0qrxp+RTRI2pBhtpyboqXR8W3J1aUSDy8dEKjuxC4PUDIABVsb29btDGjtS/6hQFHKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=Mc8V03zS; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="Mc8V03zS"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C7171F44D;
	Thu, 28 Mar 2024 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1711620899;
	bh=tVE8Ss8YI8qZ4vAZiSpvZUd4FgUA/crhZh1nZgBAsbw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Mc8V03zSWSmsl9yoGZ9VZNbmmw6kABdt9d+EcDTQMd7vb3XJzY1rE4jBNKr38/Ad/
	 xpRNKTVIUJ/Xop65jDhWip6MwY9zAVHzue8AYSTJ8zs28R5QjYHUkvLUa1kgkmbW0Z
	 UkOJAet99cINUXtHZUB5Gj2/9IPHMfFWnFr7MuPk=
Date: Thu, 28 Mar 2024 10:14:58 +0000
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: oops, forgot [v2]
Message-ID: <20240328101459.M24469@dcvr>
References: <20240328101356.300374-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240328101356.300374-1-e@80x24.org>

Sorry, been running on fumes all week :<
