Received: from glass.ash.relay.mailchannels.net (glass.ash.relay.mailchannels.net [23.83.222.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED718488
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740010077; cv=pass; b=iR5v2w4xFltCYzUoevYnCT3eNx6bz3RZZFlU6R6s+yuSMAeRDi+S6++qVxPgt0Y8pq43kFZVNP6/yPD2QF147+Lga3sPOQUG8Oi25PVmai0GjvW7sKGmR3yVIwFzCPmnO0/PNqB49Atj8ynJwQkDWL60T0uxqWUUjxnD2qsQw4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740010077; c=relaxed/simple;
	bh=F/AN/fd/ai5/WxlS1DIpyh1SFJSm/jK+yhw6iptOcUs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BffReRaxCxVxzeTFIKiYs00gYbUUcnZnhcMTCDBfw4tqXXgT394m+Fv22nTaZf5pErwb4gc1yapVms9a1qo8yu3YOf71smf7jqHRSRsLjp7eaX8CCeo1h1H/ncGX5LQUtULofU7g6QoISFZXeE4WpsUWMijTzqXj5wO++RSQAI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.222.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1D0C016507E;
	Thu, 20 Feb 2025 00:07:54 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-1.trex.outbound.svc.cluster.local [100.105.230.78])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5F83D165207;
	Thu, 20 Feb 2025 00:07:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740010073; a=rsa-sha256;
	cv=none;
	b=AOtZd2HprpttscD9vcflf/LIbzfKyC0HS0rpN44d+9k96ky0Gez5M6CoSbl2dhmZ1I2F/U
	PJC+POCW8NbuFxlQw/+fQ+sshydbROnlpuehckr8OSqr+TFV/3vENYbbw0zV9oMVwrYy6c
	B2oFDWkcM/6JdgeFoVgU3honuEPjRUfvv7M6ayuK6y2+Kex2TVyWaCimSD6LgI0xU8iL6L
	n+pzJa8giDcB9lRF2Z6PLTJYZGy/l4ZkCLXtt3OIQGpbvRroha6BBvoh/cFdC2TU44pTeP
	YNAr4d5r62R8xVeD/A+PqHGJvdCnx/ZV8A//LPPujk5gsdlgsSgMvo+/0xLgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740010073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/AN/fd/ai5/WxlS1DIpyh1SFJSm/jK+yhw6iptOcUs=;
	b=n+VPe7tE6OJz5IrHtsniDRLFRVm3PjBftYxzD7pFWC3j4I1luij/8P+GS6yVj4yLk8BGN7
	6ReHPC7fOAhW3EKw+fj4SQWq1Zl7wTMYLaxIuNmW3fHOjnbzgjSOc5dOU/o+EhkmEcmrB4
	Mom1LHRxmL6oUzpFOpHC/gew8+K4agi3wzloOC4Mv/uNN6MaUgY5dFylriZ8yOm6ak7wgz
	io/qSZwTjaAhITyKrLyk+LJYt6uIi7YDwgJ60dTGu6r437nHc9rpFyMsyU5FekJ3YuhgQf
	gsln23Oma9gc7zAF08xA4ZbnajjaGEtS5csk8q/MgUQdThgtCPdiwSZ9qpv/VA==
ARC-Authentication-Results: i=1;
	rspamd-78ddd997cc-lht22;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Fearful-Slimy: 0f40e8c7678246a6_1740010073976_1028762893
X-MC-Loop-Signature: 1740010073976:3499793109
X-MC-Ingress-Time: 1740010073976
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.230.78 (trex/7.0.2);
	Thu, 20 Feb 2025 00:07:53 +0000
Received: from p5b0ed060.dip0.t-ipconnect.de ([91.14.208.96]:59620 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <calestyo@scientia.org>)
	id 1tku6a-00000005dHj-31ka;
	Thu, 20 Feb 2025 00:07:51 +0000
Message-ID: <70b4a0b71bb6a68c0ef53dc776349927b6fd6799.camel@scientia.org>
Subject: Re: free(): invalid pointer, error: git died of signal 6 and error:
 git died of signal 11
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Christian Couder <christian.couder@gmail.com>, l.s.r@web.de
Cc: git@vger.kernel.org
Date: Thu, 20 Feb 2025 01:07:50 +0100
In-Reply-To: <CAP8UFD0aZ-Ea96n1Tk9i2dS6ECoCFpyW_FQUVOP8Z2z8_=xXwA@mail.gmail.com>
References: <1480fc360e9afd4e2d381e1506624df058355ae6.camel@scientia.org>
	 <CAP8UFD0aZ-Ea96n1Tk9i2dS6ECoCFpyW_FQUVOP8Z2z8_=xXwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.55.2-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey Christian, Ren=C3=A9.

Indeed, testing 1:2.48.0~rc1+next.20250101-1 from experimental, and the
issue doesn't show up anymore :-)

Thanks,
Chris.
