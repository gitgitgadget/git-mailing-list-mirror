Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95F6FB2
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 05:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711083935; cv=none; b=IvcPIod56484/bhLlNzwreAEulqlkAMI/6niZhlmzPZtuYdt+qBC8nYJCcGDrJv+KKcvAbRZ+/hjVn9eVr2RU+SyReok3JwQp4iE8E7mBYfMZPkBKwZy98xogmdo7kcn6wrqnJQcqHKzBAJrn/QxqwVHE0TTnXo2Y3A31Ulg874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711083935; c=relaxed/simple;
	bh=yTvXYQgAhrh5LmkA4P/lbjyvE/ly+Fv0BsewkBntt/k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Q4KrDJXkjk29zWGNazvolLyuzVixTsz74DXtf++kpqSWggRkWq6NGBm6E6pse9RSlvLKYg770qHOM/UD2FnXTru6fIa6HStPM2XqW9efj3wnjFu7pupWydZzDGw5mCXk03Qrz1e+ewESAuiBOWvyY4hV0R+NDnMEjUqX+Lxq7zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rq5a7cBH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rq5a7cBH"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711083929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgSDCedXPxFJ8xyACYdi15QVZcK0yVUB+RPTEc9M5Y8=;
	b=rq5a7cBH1aJsMM+UsPCU2h26kmJt/+h3xORKG+JV/6VZVghTJWHuZPYCdx4xk3arhHnM/9
	xP3KY5x4+eNDzJ0irAhnFVpIz3w+I6UPq7aEGWDVjBOfxF44qXifgsQ0bvvYSn2m0sbdXq
	la+iUcJcJnarFtn2Sj+HIx7DQEVaxuI7dLEACK2Mssewal8r7Y0Gd32K4Ftw1X15YaZ/y8
	DdmdkvPJjbF5aW+CQY/PQei431QTLXgfi9egTocTDz7FRLMQOaiqMGQC7FKeN3MqStCwU8
	Gr0etg65i70RdmohUnLmpKO8goiDUd77rBxH5BICKDgPxCu6KgcZkJi2U5sgCQ==
Date: Fri, 22 Mar 2024 06:05:29 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org,
 phillip.wood123@gmail.com, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?=
 <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
In-Reply-To: <xmqqcyrn58mf.fsf@gitster.g>
References: <17bef197ac874ae6.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
 <xmqqcyrn58mf.fsf@gitster.g>
Message-ID: <18052bdadfc3dd54aaaff5aa68063702@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-22 02:59, Junio C Hamano wrote:
> +[[a-paragraph-summary]]
> +
> +*This is EXPERIMENTAL*.  When sending a topic, you can propose one
> +paragraph summary that appears in the "What's cooking" report when it
> +is picked up to explain the topic.  If you choose to do so, please
> +write 2-5 lines of a paragraph that will fit well in our release notes
> +(see Documentation/RelNotes/* directory for examples), and put it in
> +the cover letter, clearly marked as such.  For a single-patch series,
> +use the space between the three-dash line and the diffstat, as
> +described earlier.

Looking good to me.
