Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3025A2DA
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640102; cv=pass; b=sHBdJXp3gR8k8oQowvcQOBHGoQ9oFJ7csjXPMwnxpDzKpQWklYCsrCJ67n4KPod32SMXzC71UuHv/OB8YAiC4O3WQj51OnagC0VtbmU2KLz1kdzvCQNSxFwF+CsCw3T2Xadjy9rKlPN7nW5V4chVvcl7i0h+tIV1iGuhI9KNaEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640102; c=relaxed/simple;
	bh=v8xUqR6GMJYFMJeV4p7Yi+58rqc3gaxy3aXCtphAVlo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LmcRxBqScFtg488gTukEX6pSRgrd4YzYACvW/VbSBbpgsk4Sdjglux/6gnfbJ2I2nCLEXagVzDZHjlxcfx7Ce51vlSFlmSo/HHM7UID0kGyu7++yXMOa9j00fJeICuCigpYqcWKbhhI2C8RD5+03feyO1cD5b3fuOegB2QoOM4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B7C8F164CBB;
	Tue, 19 Aug 2025 21:38:42 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-blue-4.trex.outbound.svc.cluster.local [100.99.47.133])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id A818716440F;
	Tue, 19 Aug 2025 21:38:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755639521; a=rsa-sha256;
	cv=none;
	b=P2E18dd9w+xlQnMXxf1Ep5H6WsC5tWKPkB5g4GslEVzTt0MO4f0s4ofvrrgCjOVSOaAWe0
	JctnSLvju8xW1bLe+3frTYryzcBhFb1A5CN3WCuZr5ndwnfd6og86XGRM2gwVwUMlyIENm
	tMPhTG6OdB34Mv/McEyHDSFr8qgUV5WgWztIpIKOfvIRPwT3UmjTf87nT6Qj2U3SgzTkAB
	RdOQ5HrtfR/U9FyzJijUQzwfYOC8Xi8N2JA5K8gb+5CjC8NdpOxyy2x/CDPvfmF6LcEH3L
	1/+8s0h9BcX0NefP4cV+4A0h4YSJbiS0vtpV9gcLNY8fSFAjL2sdsHChT2H2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755639521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8xUqR6GMJYFMJeV4p7Yi+58rqc3gaxy3aXCtphAVlo=;
	b=qpM87wreNtoiUVf2EAVO3SRNO+oPhj3wMPh6A/Gy9o+R7+A8NSv/Mi7vHpi/1Qqzz3x3U/
	J/AMEoRMZ74Lh31ZPhqnZjPFMM92imzc47SSw7stMRkO9z2Kyxb9KHrpsAxJACv+QcPP8+
	ptzjX4FLdH55UNxlJkoViJbTv0z6bhMSZfjVbl/A+enq8rW7Oy3P+jRsmusoZSlhFG90JZ
	xBmjWjoUQWZtypA+Ew2f3EVZTShTUytWgMhbu55A5J14OWkAt6Qjf1ENr/zs2vyalQpTXX
	2SK80E58knj2w+5xaJUPtGgPgI+8baW8MjaPPBxfYVNcv5s3lOZa6yxHiUTIcg==
ARC-Authentication-Results: i=1;
	rspamd-7dcc9cf4b4-sswr5;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Power-Versed: 1e54b66d5a52b68b_1755639521333_4090938867
X-MC-Loop-Signature: 1755639521333:1097599458
X-MC-Ingress-Time: 1755639521333
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.47.133 (trex/7.1.3);
	Tue, 19 Aug 2025 21:38:41 +0000
Received: from [79.127.207.171] (port=16159 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1uoU2Q-00000002eE0-3aka;
	Tue, 19 Aug 2025 21:38:39 +0000
Message-ID: <67090cec91d92af5616651de29950ecb3e8810f6.camel@scientia.org>
Subject: Re: why can't one alias `git stash`?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Date: Tue, 19 Aug 2025 23:38:35 +0200
In-Reply-To: <xmqqh5y4gm4v.fsf@gitster.g>
References: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>
		<xmqq7bz5v0mq.fsf@gitster.g>
		<16220ca65f1ae9883a2fa103e842cf0ffff43236.camel@scientia.org>
		<CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>
		<xmqqjz34txjg.fsf@gitster.g>
		<d8b279098a41949eef06f26d3f09c3950486380b.camel@scientia.org>
	 <xmqqh5y4gm4v.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Mon, 2025-08-18 at 18:01 -0700, Junio C Hamano wrote:
> As a program, how would you tell when you are run by a script?
>=20
> If you are a shell, you go into "interactive" mode when you are
> taking your command stream from a tty, and otherwise assume you are
> not interactive.=C2=A0 The same trick would not work at all for programs
> started by a shell, would it?

Not for all, but it might still give enough "teaching" to prevent
people from using aliases in scripts.

Checking whether the parent process is a well known shell would
probably not help, as it would also be for the interactive case, where
aliasing is wanted.


> Asking script writers to pass "--no-alias" option to all of their
> "git" invocation will probably not be a viable way forward, either.

Again at least not a safe one. And doing the opposite, i.e. requring --
enable-aliasing (which people would then have to set as shell alias),
would probably end up in generating quite a few annoyed people. ;-)

It could be made optional. E.g. some gitconf option that per default
enables aliasing always but allows to require a --aliasing option
(which then again is intended to be set via a shell alias) in order for
git aliasing to be enabled.

Whether it's worth the effort is of course another question.


Cheers,
Chris.
