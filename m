Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF0411CA9
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770976; cv=pass; b=PNp3v2OJX274B3lGdnluBpvwcmyiHtgrIqJrc7kwML674X5G+GPQkHVu4y+2YpgODTw2TMxMTRuRwig8nzOMHs5+R0IO1Mf9rVckRTUwWe4uG6VjHLL/3nGi9RKxCAi0DtjT5aIROy9Df5/rR3TEddWvvRH5wVseJSk5OVW/pQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770976; c=relaxed/simple;
	bh=x8VscqDuCr8pzqZArf06SVla2qRzRXO95fkToF4sgLk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SZHcoEjZxOelkPGD42te7GpYagPVB36daMU8CgdTwC1+e7v5cxBfydo0js+OGUzazFIubexoN3q91SVBX3Zm2qdTu8dBQ4cuaqS3ukA1iMM17i8+hZNSeS801l6qdfiCxz0JsZH57K5rGFQF7seWS18FQkF6+3pu9OuBmD0K9fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.212.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2F3731839AF;
	Tue,  5 Nov 2024 01:03:25 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-103-134-71.trex-nlb.outbound.svc.cluster.local [100.103.134.71])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7395F183A53;
	Tue,  5 Nov 2024 01:03:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730768604; a=rsa-sha256;
	cv=none;
	b=j+Pc94b8HES91/7LEb4Hkq/fDjxOSyyD7wfIQYokJkmTbDNIYCup+KlS9ZG74V/rpa2Z2n
	i0b5AAyLLZ6QRQimcOq6Xc5jLN7O0NKHLklBWIg+rNOEWv4wbzpZyJ9P4UbPq/uh1bVZb5
	NlY7JE8FDCdV2QhlQAGrCguh1D8W/sr+h02zIYdBjayY5w4qFuX61MAmHDXqBZkQTv2pWt
	Q8kpatUZKZMm0iYEBor1LfqbOG8M8uk2Zhd4kdckKkrHJbAvovRSd2NNliMZDQQaa7HSID
	rNhOjPS+e5yooYr00gHI7bT2oa6BpAKI7W9kbEYMVIbvZW9kWrqdHOj/0zIdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730768604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8VscqDuCr8pzqZArf06SVla2qRzRXO95fkToF4sgLk=;
	b=8tf+8eJP7V7uYGbfQmFRPisGlS+9tIM152L1LiRaGU2ReS5cPNwJGv/aBqBlUSSK1zLAC5
	RiYRB7VHJTKdtJfmdXKAGEdrfeAej2GooiHS0u3J8yFzX8L74qZTlFc7v0GN3jKzC92pye
	qGhWi1TO7kjme8s7S5BHLildPOLvVpoeYf5OFL/2UXsbQ7x6RUSZa+mRA6/QhlnMQEQp08
	S3aNuhC2mv0rCQ69TSn67uid2lK5vhifq2BrPja03SFGcZQyk2xV6y6c+f9SFo2gRUU4ba
	Xxfr1TsV7kKUva+pP3N1OaNoQjNDUuGP30KZyuo/VZw/rqFLeJmiymVROXL3wA==
ARC-Authentication-Results: i=1;
	rspamd-696f47875-5sk66;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Arch-Eight: 4dc23822236442bb_1730768605090_2367769593
X-MC-Loop-Signature: 1730768605090:604836838
X-MC-Ingress-Time: 1730768605090
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.134.71 (trex/7.0.2);
	Tue, 05 Nov 2024 01:03:25 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:63324 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t87yc-00000005yHw-0U4b;
	Tue, 05 Nov 2024 01:03:22 +0000
Message-ID: <3a96888e76e4dd26a3b0a81a19cda8ec7de72662.camel@scientia.org>
Subject: Re: git format-patch escaping issues in the patch format
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Date: Tue, 05 Nov 2024 02:03:21 +0100
In-Reply-To: <20241104235432.GB3017597@coredump.intra.peff.net>
References: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
	 <20241104235432.GB3017597@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Mon, 2024-11-04 at 18:54 -0500, Jeff King wrote:
> As you note, the mbox format is not well defined. :) The variant with
> ">"-quoting of "From" lines is often called "mboxrd", and you can get
> it
> with the "--format=3Dmboxrd" option.

But as you've said below, here too, the receiving side most likely
doesn=E2=80=99t know that and then a wrong commit message would be applied
(with no unescaping being performed or it would simply break again when
the magic From is used).


Cheers,
Chris.
