Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC7177634
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872394; cv=none; b=BmCRYMCaEg3PMJ5EN1eb7KVXhxuyPsDfwkx6Sr+aaoQAQa7FEOV4IL4WDVd4OB1ERpufvXcahUXM8wRbS0gl/V8K8Ta/lKQmqVhQX/PCZD1IZ/NOOp/WMef0QrHKtXVTAD69ckH0ALEHfDo043vRA44mwf/9pjcsQHmMwTAc8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872394; c=relaxed/simple;
	bh=WVsGQfibFZ3y+WZBJVva9VXxXfa903nnxYXaWkP/XpU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QY3WPuAv72T1twBe48GJ/dvsp93piJFxxyY4OoqryULYJ2yLeTJg8vKxgUGS/YCvaYwzhxD5dK/exrPN+M94x4tADWn4Ie/15RLer1+0z22yqh5yN7qPrwckKi06CXRDEBgoRFJe8EZR0Avyx8cVlS07mlI2xv0tXOxX/Ut6p2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oanuo1LS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oanuo1LS"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706872389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqmggZYZCzjWrcd1vW4fUcG2BQCsnUe7BmVpdAaBkwo=;
	b=oanuo1LSnArkfvkCWSfxuSLE5y4mWkSB92eBxFuk9b/I6UR8h6PpZLW3ctkbqFH1/jfFEC
	GDzydDDyeqPZ9QBTIVXT40r4espykjIJCmixZpUvqqBGitdFAzKUm4eJB7bToxCREWWk70
	5jgDBOv+KorFDTGtYM1XTQ2bcZW3kYR9N8p98ml3DzYrW/PijZn0kD5ZSxpafs+zG2azvg
	3Z9uTEM7yGodZh0D1cYEU/mifLORM3djggyQD3KoxMLn9ZkGdN3gnegzIVG2Hd/wo/n8mw
	9XdrmISsDgIdEGWSYmxkZl8ZT312GRDbVStbFfzoY8BZKwcvuxXZfR3LeZ2LsQ==
Date: Fri, 02 Feb 2024 12:13:05 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: phillip.wood@dunelm.org.uk
Cc: Hans Meiser <brille1@hotmail.com>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <6b34d999-3da2-42ef-bfff-37c8f592347f@gmail.com>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
 <6b34d999-3da2-42ef-bfff-37c8f592347f@gmail.com>
Message-ID: <8f5ca8f5dfd465fea0a53dabc81a58cd@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-02 12:07, Phillip Wood wrote:
> On 01/02/2024 19:00, Dragan Simic wrote:
>> On 2024-02-01 19:36, Hans Meiser wrote:
>> Please keep in mind that editing the git man pages requires very
>> intimate knowledge of the related git source code.  Many times even
>> small changes to the language style can change the meaning and diverge
>> the man pages from the source code, making the man pages useless.
> 
> While there are some aspects of the documentation that require a
> familiarity with the source I don't think that is true in general. If
> someone has a suggestion to improve part of the documentation that
> they found hard to understand we should be encouraging them to
> contribute a patch. There is no doubt that there are places where our
> documentation could be improved and it is not necessary to be a C
> programmer to contribute improvements to it.

Sure, but there has to be someone with intimate knowledge of the git
source code in the entire chain, if you agree, to make sure that 
improving
the readability or style doesn't diverge the man pages from the truth.
