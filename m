Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63B2BAFC
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710999071; cv=none; b=pmyeh1BX5B1vM+Rn5znk2SXnJV/r8QSQRnQaevjR6iJ/NssOMwG791Hwpv7Blqhi5fe70RkHLR507PWqYQEz/hCvUcyeTGZOfV5jYWWk0El5qug7zpeHMcDSqLSj5q+5Liif+EjA1azhE5f628+z8E7QsyogGsNuHAeYguZyjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710999071; c=relaxed/simple;
	bh=f9MkhBK442QPiGyLQj9b+MqF6mo4kDrxw9ffEW5IaPs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CLm4K/pcWKkYCO2857zd9W3EMyJ2KT19FPO/9wa3OdXJ/ussX3JiS1lPWbh9ZqXy6Dl8wAWRMY25jbyCB//v1pbsQnJIA7iy+Xc2X07FFapFO0S699lyYDCqAMmEgUCOWp5a7WeQt+6Y/vBdYNL4gtNdWhClE0eep5vi6uVtUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=eO1+cjoA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="eO1+cjoA"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710999066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJqQmW8tayZ7ESjn6PcxjVZn6rOYj2wVp4JzQLQMnDQ=;
	b=eO1+cjoAu1rHxQMJK+X38nxMtp2vH4OvDiOeFZ0EVj8V2E7ttvwM78xptLioQ0CsdHK3XI
	hFw54uMrdr9ZjkLJCwnpqzJs9jDLEZ9tv7I2OdQ4d8lesKTlMOX7JK/Btz0YBi5UDUxeeP
	dYxZitjx9CEtRtTMypbXOJJ7O6jtIl3VClQeqo6k/vB6QFh594uFyruvW7piY4KNSdH8r6
	zI2PpS3Ivgnl+Xh+MCTGF6NWMwr6LxeJwEI9gu2xiNhNp1oxyONU7KjD/Wljlxd8rKL5Gj
	QyoNBezLAgiAcSrm9VS60PB4hASlGSxKgfbPWvQUIcCtKnRpKZjadQ4kd0g3YA==
Date: Thu, 21 Mar 2024 06:31:06 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com,
 github@seichter.de
Subject: Re: [PATCH v4 4/4] config.txt: describe handling of whitespace
 further
In-Reply-To: <CAPig+cTgbjCg5jkidEufgHgpkPOZPhfSbd_gbBxOFK=B8mX+fw@mail.gmail.com>
References: <cover.1710994548.git.dsimic@manjaro.org>
 <f84c5e8e4a90be3f9fe3cc853e0d40aed4e58826.1710994548.git.dsimic@manjaro.org>
 <CAPig+cSYhYBa0NsvJCOYo4JsWzLJT9rU++U1QKA3jRB6Cptbhw@mail.gmail.com>
 <9a5217f7f7a35768a3eb45060fb3e4f4@manjaro.org>
 <CAPig+cTgbjCg5jkidEufgHgpkPOZPhfSbd_gbBxOFK=B8mX+fw@mail.gmail.com>
Message-ID: <fdaec126df16bf6fe1c1fca9698f7dcc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-21 06:21, Eric Sunshine wrote:
> On Thu, Mar 21, 2024 at 1:16 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-03-21 06:11, Eric Sunshine wrote:
>> > It should be possible to rephrase it to be more definite, while
>> > dropping the final sentence altogether. Perhaps:
>> >
>> >     Whitespace surrounding `name`, `=` and `value` is ignored. If
>> >     `value` is surrounding by double quotation marks (`"`), all
>> >     characters within the quoted string are retained verbatim,
>> >     including whitespace. Comments starting with either `#` or `;` and
>> >     extending to the end of line are discarded. A line that defines a
>> >     value can be continued to the next line by ending it with a `\`;
>> >     the backslash and the end-of-line are stripped.
>> 
>> Looking good to me, thanks.  I'll include it into the v5, with
>> a small grammar issue fixed.
> 
> For completeness, I should mention that I intentionally reordered the
> topics so that the most common/important ones are mentioned earlier
> rather than later; i.e. (1) surrounding whitespace ignored, (2)
> double-quoted value, (3) comments, (4) `\` line-splicing with.

Hmm, I just noticed that your proposed description actually contains
some issues, e.g. it implies that the value-internal whitespace is
retained verbatim only if the entire value is enclosed in double 
quotation
marks.  I'll try to reword it, so this is fixed.
