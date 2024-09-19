Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE75661
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726774540; cv=none; b=ME3iuT/PtSqEdmzU78h0SOjqIPa96NV46NpDLWqr7wlzv+wPzRPhmlmZDrSVooG1lHbf0oOgjH5b9wWI2/hoiklTLGav5yP2fSZpTtR594ozkspWRgOIOagpBEzVzzoBK11AFOD7wu+mcF8v8x+vu/g48OkXvxw5PIHrlS5wPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726774540; c=relaxed/simple;
	bh=T4QKAgXdPgRdLm6gIyMzXI3kP3jyptSMPGWE/eNHK4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBWWu+sOPrT4Lf301CDJSCBd3CJyPIA5TCzyd244yTPx1yPZv8ZiarEkNrxiFf7kELRUCQzD0RgsjWAUw0G/C0EVA4+nlhRI5LdF6qtC+gaVTwsIB7jZ7OHWLY+scHszLm2k+Yeu91hsgm30VVwb7E0GnGaroBZmBlALqyGIFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e047e96478so138239b6e.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 12:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726774537; x=1727379337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4QKAgXdPgRdLm6gIyMzXI3kP3jyptSMPGWE/eNHK4g=;
        b=Xcr/nS6vxZ42Us2jUlY97VWu6hPWEnw0bhm8Wkh/HtHtEzGENzLbSqJ7whVrez246l
         VUiJTVAvWtoiFRBBdShH4lTAKmQp8P7cm9sojb387/3LUS6QTIdS9nWnBkQtA2h/5ICI
         mhPUFqccf22nurj1kZwWuACQPY+4kJSjuWKZzvdwGzZhr/+jFui2D6oK8hsaDLRrja/A
         fXakpsJfPx7pmIv2yNJ11K9Szx+UT6Jc8d5+xWzyvPuE5H2aR31QyfK614T+utbendIg
         ZY7y/HhkPdB/SjILXBmv1UfhJqIDVqbAdNIHetjnDHHzUeTYbWdVp9F0Gq1SvdGT5jNt
         MpNQ==
X-Gm-Message-State: AOJu0YyhuDs+2/2VgGxGNpn/4c1uE2SNFwSs9HxrVi+6P5exQh2hlues
	gI26PBiTqNJktHCgMP81MopWF0FwD4d+ghgZTbPILPgUgYJ2RavSV9KqZpoP2EY6Cg5/d9FVB3E
	FXQoasXYQysMeXaVjpA0vYAVwKH0=
X-Google-Smtp-Source: AGHT+IG6ZxnBE3uqrhqJq/uE9ONThopAmfL5Z8d45U1KVWoQ+3m3EI/rRJEa2UeOkOvyTGKfW7Q789DN+6Hh7fSY+3o=
X-Received: by 2002:a05:6358:904e:b0:1ac:f436:c8d1 with SMTP id
 e5c5f4694b2df-1bc975c4dc9mr2755955d.1.1726774536896; Thu, 19 Sep 2024
 12:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 19 Sep 2024 15:35:25 -0400
Message-ID: <CAPig+cRhgf4pLycL7u9Zc13TXdN54ccv6xMQ9p6v8pvfRESTLA@mail.gmail.com>
Subject: Re: [PATCH 00/20] Fix typos
To: Andrew Kreimer via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Andrew Kreimer <algonell@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 2:35=E2=80=AFPM Andrew Kreimer via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Fix typos in documentation, comments, etc.
>
> Andrew Kreimer (20):

Thanks. These all look fine.

Out of curiosity, did you use a tool to discover these mistakes?
