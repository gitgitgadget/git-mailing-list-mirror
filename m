Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4D30CF6
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2MGJoLf"
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96363AB
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 11:31:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c603e235d1so12265966b.3
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698258666; x=1698863466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCaJjfCrHYbbT+BGpHraUxr4S1v/+e/xNNJPVOOs9uo=;
        b=m2MGJoLfp6Gq1B00wh7vaMlt+UJJWgx7FwNuplqgTSai9WqptaRig+/MtevOY+m1fo
         BNbKD/FxfTVrm1I1ODu4mLb+NYbF35SViZeDZRLWDLBZ7+orhepyxBgYAXroLXnVuPj/
         QFEGfUpsZ+8k1p/QEVEjNhAU3jcwmQOMcYwqf5h0/eBmup+urVkMPKqdYQh4lzEMtOC6
         ZzfTZm/ZWLWXcN9RxwEqxMysc67qdMq93PTF5vZoLt91Ghgj3wjHmpCIRDMjf0r8ESe3
         VK5pSMkV1MacuwaAR1MsfKgqn8TBAVHT6KOJE4C7UMsfJPIxeetEXj4j9DPJWEKW6E7B
         joKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258666; x=1698863466;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCaJjfCrHYbbT+BGpHraUxr4S1v/+e/xNNJPVOOs9uo=;
        b=kPAuT9XpRuvF5hFl2KTYRmDIUvPnQZ6azpFCyx8FxJ3pMhpdzoLQZqSI2SrqHgSvTr
         Joi33TZcrQ7/FCXhlq7IUbg0Z5zpN4bKR6jLhXkm7h34aqNVj4dA+x+n8FDVoGo38zMb
         rSZiA4qo9n5RbHfs0pLO4uILxZGaTsmpfK9G3hxvxl47v8eZSdAmqQFmF4SzFB3Kxtq/
         hhmGBKkAUwSA2iXjTRFSharERHLoeA9tTJ2mwfXwr1NtS6SxE+0Ad31UuWIy2us9zXiQ
         /jpVf/lD1PAZ+cgY3ktaJfxquPbZWXpCekiSCtULoSMteqc5qvgE2yJ7C9LPcBLh4PO4
         ipfw==
X-Gm-Message-State: AOJu0Yw3pW7teTKgiRN3X9EJFMrk1tbbu8WFT66xB4/hiMUBMboAzYWs
	DCPngnm7S4uRG02z/jnoR9XFMu0Emz6X7hh5xwF3CA==
X-Google-Smtp-Source: AGHT+IFg8HLcih/DIOhnXQHWDCkn4UN6u88JfeQwq4hTQiWfK39PvQzKr6LbMaky8qtPpFigO13tnA==
X-Received: by 2002:a17:907:3688:b0:9c2:a072:78bf with SMTP id bi8-20020a170907368800b009c2a07278bfmr12479700ejc.26.1698258665881;
        Wed, 25 Oct 2023 11:31:05 -0700 (PDT)
Received: from [192.168.192.11] (mm-143-13-127-178.mogilev.dynamic.pppoe.byfly.by. [178.127.13.143])
        by smtp.gmail.com with ESMTPSA id h16-20020a170906111000b009c7518b131dsm10253102eja.196.2023.10.25.11.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:31:05 -0700 (PDT)
Message-ID: <e38ebf04-cf92-c80b-3432-bf86ecda1054@gmail.com>
Date: Wed, 25 Oct 2023 21:31:03 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
Content-Language: en-US
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
 <da246287-8530-4680-8fcc-f68f881bc24b@app.fastmail.com>
From: Ruslan Yakauleu <ruslan.yakauleu@gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <da246287-8530-4680-8fcc-f68f881bc24b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

If we use squash we will lose some context and occasionally, we need
multiple small features combined into one big release. We would rather
not mix it into one monolithic non-readable blob. For us, sometimes it
is better to rebase something to make history more accurate than squash
everything into one commit. We can use squash only for one story.

Anyway, squash is a different feature.
Same as rebase (of course we're doing the rebase before merge to clarify
history and to make some regression tests)

Then we have a set of branches. Some branches contain only one commit.

For example, we have 4 branches:
- two commits
- one commit
- one commit
- three commits

With --no-ff (only merges) we have next graph with extra merges (E', F')
for branches with one commit

   B---C   E   F   G---H---I
  /     \ / \ / \ /         \
A-------D---E'--F'----------J

With --ff (fast-forward everything) we miss merge branches (D, J) and
it's harder to fast revert some problematic releases properly, because
it's not clear that commits G-H-I - is one release

A---B---C---E---F---G---H---I

Story which --ff-one-only should build without manual control

   B---C           G---H---I
  /     \         /         \
A-------D---E---F-----------J

There we have merge commits (D, J) only for complex branches.
Branches E and F fast-forwarded to prevent extra merges.

Sorry if my explanation isn't clear enough

--
Ruslan
