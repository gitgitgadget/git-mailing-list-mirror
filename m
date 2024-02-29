Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60C134435
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233739; cv=none; b=IjKxcB03e9I8CA/klrBlrs0UwpC1mYa0N6Kdp50geP9LS6XOr3tDoK158A4QpmSmdYikO4H9tgDd9tO6RsIrpw00qrGLk3WW5+7RWwVbdee0TsTwKK55cEO8Q5AwFnSovzL7HQkylarOsSM9WJd1WNNLzWMqdqupgHnzc3fY0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233739; c=relaxed/simple;
	bh=70I9inTMDsjOcLXHdck0Mu6fIWcHC+JxM7US0FKBsEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyzuTcFFxxzCRD3djqU6SBnL18yz/y03wiIXUwqADzmOQt4yBnTRcekpB4MGqwKr4jWNFuktsU1cqQI06GofZb5KXL1Qm/BhwN2T1pXxtWri1BPM2Zj56Y24GO/1UZCvsy48Mhd8fhhcHrU+eopzAp8mEj3XDdRQ/yRRp6LkBRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68f9c01a148so5707116d6.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 11:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709233736; x=1709838536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2G6w1FHWAgghJ6f4ki0NSKwoSXmGvvYQFhKJcxUBjs=;
        b=JnIkbez2L7viRdA7NZkkBciusGZHqHYcg2dKPtEcT+X3aiWckMFePjcRg5nO1IReH2
         6a0g1Yb6ZpuupUDkEzP0h+wc3caQSHiEtxDzzkvePSpgsT9gYLlQTqirqAghnQ6cQxt+
         61LAiBn9fGYUI5eOJNnW83pwfszlZty5jszHD8GbtwKhQBF3Lm/tynjLx7Q0w1g5Epr/
         Cc32/Enoyvqq9Ruo0iWq2S4HYZGQq84b2ntGWzolTn9G1cp0MpoqbVXAnBZ7LKajxCBH
         9o2oGKivRRm7LLuREYY8MBv6pzwULNVE0cuWMfOTfvGo0kJQgCluaieAK8YDCvzH87qQ
         wFkA==
X-Gm-Message-State: AOJu0Yy1WtI6egxQeKgOsJdx3R4VlnL9RAYn86J/WBvAE1z3Pk/a2pW3
	/ixCA2UaOMqnrwH0pfFDghNri5VihEJe3/Y/qM3BsnIyf55PusrGZKEX329B8z3MpYh8FGL1s38
	YcgS/D5lgG9ikh3pdq/aKH4afwvplDF/VuZI=
X-Google-Smtp-Source: AGHT+IHa3UozqRILrZEjosG9IYltExXm8SymbDOBQhrl3oSXPyR8XjJkvyIH70a7meOfV6BF7VrFX7CdSaX/XFMHdYI=
X-Received: by 2002:a0c:fa12:0:b0:68f:e924:ae08 with SMTP id
 q18-20020a0cfa12000000b0068fe924ae08mr3531931qvn.28.1709233736404; Thu, 29
 Feb 2024 11:08:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6139934.yKrmzQ4Hd0@nimes>
In-Reply-To: <6139934.yKrmzQ4Hd0@nimes>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Feb 2024 14:08:45 -0500
Message-ID: <CAPig+cSFW0MrAx6n3=142X64UraErTDHQxjGpgc6hy-=pbDSpQ@mail.gmail.com>
Subject: Re: git-config doc: variables sorting bug
To: Bruno Haible <bruno@clisp.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 5:15=E2=80=AFAM Bruno Haible <bruno@clisp.org> wrot=
e:
> In https://git-scm.com/docs/git-config the variables (advice.* ...
> worktree.guessRemote) are apparently meant to be in alphabetical order.
>
> However,
>   filter.<driver>.clean
>   filter.<driver>.smudge
> come after format.*. They should come before format.*, since 'i' < 'o'.

A possible fix has been posted here:
https://lore.kernel.org/git/20240229190229.20222-1-ericsunshine@charter.net=
/
