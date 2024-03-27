Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54DF17571
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711523019; cv=none; b=un+F0hM6kM4BGA/sHF2vOlzWs/aJDtRxPK3W60CCb64rGf9GS/JfurmXa0FsqcC+QO1yjVJStFqgvtCE5rb8jLWV4UslVjStkZV75wNbrf2LInD9yvJVAb2+juqIww88ZwrJIRRNVCaC+52X40GZ4CWfJ9zaGDsq2TquS9TvzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711523019; c=relaxed/simple;
	bh=eU96bzodwfNXDS4avEC6a6Vm81h9wU1qohUg5CiwEPo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=advid0mIHPB5OSn0Cs1O2w6GMoN8yV2kcnWLV0DFJ/sQh4lYz9DncYvLKexsYhqmYOf14tyFC+LxwRzMKBY3F85/nRRDiAJsgqP1+wjI+bTM4tc7HkvPdbwH7y5Rh66YdcafRclwquN0QsGuP7EuYJcwUMGrw+5rIxFilld4qOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UZHB8AJ1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UZHB8AJ1"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711523010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDX2uJEfeaURmige7seCTIl4vQMor4o7aGjivyCzMhI=;
	b=UZHB8AJ1bO0xCawZ4HytLMbWcz3fumHynYUz2yO11vgrTVQZhw5aiUZo9EwvzYzoL0VH2D
	8oC34eOkQhUcQ6LPX++0kwtvH4YLvvyWxwaIk6tjH2Ad2KoD9Y2VqUG9GR3lrGomcudyEa
	v68PbiGGuhCIa51aOqvTQ9X34Op2ZO7/fh2v4wIjmrjr+HR7jF1w+cf+rc1kjTeGeQKSM2
	9AG07U/+HoIzdQTcEjyj2QFcYX7CIr2iBqXdqi3WAcsfZbI9zZK9Cz4A76ibpL8WANY7jv
	hkjX+naFx7eizl5o4Dy6ZZ0RSTjlBLVUScu5FzpAwmtJGRr3z9prlO2GFCQXGw==
Date: Wed, 27 Mar 2024 08:03:30 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config.txt: perform some minor reformatting
In-Reply-To: <xmqqa5mk5i6m.fsf@gitster.g>
References: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>
 <xmqqa5mk5i6m.fsf@gitster.g>
Message-ID: <035e4b4ca40afdabbe475ed4ae02db61@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-27 06:59, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Reformat a few lines a bit, to utilize the available horizontal space 
>> better.
>> There are no changes to the actual contents of the documentation.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
> 
> I've marked this for "Comments?" in a few issues of the What's
> cooking report, but it seems we do not have much appetite in this
> particular one, so I'll drop it.

Another lesson learned.
