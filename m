Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A233EE
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395988; cv=none; b=eYeCwWt9Ns5rzuYv2OgMSrgKNd0wKB6uVLyelUpfTSjMTsRAK0KAM1AkuTdcRdAKcZISzBTCaM5TjfRsFDbt6VZW/X/fMI5MBWin2LAa8Aa9STgm6rtm4aY7d33j0XwgXYS2itp4jWe2+5Jg5vZUrKZn5o+drF/rtcfuQsSOL8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395988; c=relaxed/simple;
	bh=r/7R+VevxettFN0VHWatWQ4WnqDHlvxkH8JfRdeku04=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JemBUMIKliTqgaYlFJIrXvmaEtOJkNAfOHkGmn8x08OFnPsqZB1ACi6oO9jEhSUhRldMtOrqOfTS6/DNaRn/kFf+v56kxB25gdeM3XEOE+VxX52SLdjnPr/xk09EhB6gE9CpbfsIQSbeZP2btzNXeqJwtF3AWsefF+izGP6dw3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aSNm4t6s; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aSNm4t6s"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711395982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIlmgy02H5vM8LFB50NJqbEO/0feODUfkvwWf3syzDc=;
	b=aSNm4t6sNuf0ttxX3mWg8TbitNQQpTKfFcKKQOwcufWi7DEsWqTHWkOMR5fHAQoDxPQhlZ
	+0Y+hNJqX0N5Ea1Bt47PNu4qIFdZ+3OTyoTFZ6IPo/OHX0bcZDl8/Z1UM7IboTQErulXIK
	Aw8om+iP09Nihnf40kHQ+TMyLIXTanTdMfFzZjTRL/6A7dT5aIECrWnBz07F6dflJw60IG
	IoWnqx7uU3ShFyBFinus3QNMz9CrMePbLCK6JRgdzYgj9y3/XVZzKIjfbKEAc/tKBPBShT
	O2QmDo7vuthDXZpggNVGQ60mqCb08aLHZ9Bd0FsTSlOAAKolk0YIWM/89dLV2w==
Date: Mon, 25 Mar 2024 20:46:21 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jn.avila@free.fr
Subject: Re: [PATCH v2 2/3] grep docs: describe --recurse-submodules further
 and improve formatting a bit
In-Reply-To: <xmqqo7b2jfms.fsf@gitster.g>
References: <cover.1711302588.git.dsimic@manjaro.org>
 <cf9d3f4833f121b271fd8aacf4c0e2e4a9920585.1711302588.git.dsimic@manjaro.org>
 <xmqqo7b2jfms.fsf@gitster.g>
Message-ID: <b9001537c3cdd44ef91d323f2b54cae7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-25 20:06, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Clarify that --recurse-submodules cannot be used together with 
>> --untracked,
>> and improve the formatting in a couple of places, to make it visually 
>> clear
>> that those are the commands or the names of configuration options.
>> 
>> While there, change a couple of "<tree>" placeholders to "_<tree>_", 
>> to help
>> with an ongoing translation improvement effort. [1]
> 
> These are all clear improvements.  Will queue.  Thanks

Great, thanks.
