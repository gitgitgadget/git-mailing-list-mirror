Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB7B125A4
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URQDivI1"
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF8518E
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 07:44:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32df66c691dso4258617f8f.3
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698849852; x=1699454652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1y7PIuk3HdnqYA8MWrHCTSTFDl62JEQKpd/WePf+Fbs=;
        b=URQDivI1+Ui1Fej+YkB3OUscilptUb1HBxTbu+QfqMMJxllT8jJxiv2SUAfJndpRz0
         9gpoi76iL041Tvaxg9SgBpsPDYIKrsD5o2oMGtWHHLgCwsd5bI4G5Tot93W+sLxQoIde
         mm+Eoa6iTkQ3POhepoqSbszJeYUHdIUjcDkNuBw83q+jyGzAMyZuOCEceLM9PJK3IHo/
         UOT1H/pQ9+D8+4Se50sVzRokcGPjdtZaARC00JvUWVtmsOd9Pd7SNBxilxXIccjsO0/2
         P86IuGmo8F8ZVsCMY9aaOXNFirjVwi95SPEjmk26J+JD5e7VCo33MZpVZlXUfVB4BVg3
         Gk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698849852; x=1699454652;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1y7PIuk3HdnqYA8MWrHCTSTFDl62JEQKpd/WePf+Fbs=;
        b=FGZWDTdiFf+HBufhzzJGsqY2hj6PcAhPniIQE3M76xgkHxkLGAlA3/biET1VImqgbs
         nHOMa3y4/Fd+bTeLkatC2+/V5bZKaf+mpIr1yYSvGZFYnNFqPJdv045CflzEQa1IZCRI
         mFLTjNgP2UvBpN3adgkEtjnTM2vnr0gUumIrqa6ZUx8kwtDsf9QZ6Dmen3DMrw+4FGRq
         9d4djehptg9zxGFZdoQ3/ln5IDMzseBSxa9KmQjfQPQNZYQkalf+1yI1G1QthqZSn82k
         EE7np+/xpDQjTjmRIK9zKkLvLIThAKfnaGgqEJATJtXAbnwssdhjwoE/GQa8e1Ssyx+M
         ZTYw==
X-Gm-Message-State: AOJu0YzQYecMiabId0VgXfwVYznB6jiq8jV0QpsjBF0Y6fDckqQ3mvjQ
	JHx8G9fMlj8QgyCnzQDXYlg=
X-Google-Smtp-Source: AGHT+IFN65F1V3rWHaQ5HLC/BZ7oAh+sg4UhNuMIhEnQYwPjcLlUSBypBwQzrbbSlOKhGhwOG/ZXrg==
X-Received: by 2002:a05:6000:2c3:b0:32f:7c24:f02a with SMTP id o3-20020a05600002c300b0032f7c24f02amr10002589wry.58.1698849851880;
        Wed, 01 Nov 2023 07:44:11 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d480b000000b0032cc35c2ef7sm33934wrq.29.2023.11.01.07.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 07:44:11 -0700 (PDT)
Message-ID: <876dd6fc-b57b-479f-8ffe-fbd2a6979034@gmail.com>
Date: Wed, 1 Nov 2023 14:44:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] tests: teach callers of test_i18ngrep to use
 test_grep
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <881c7fea-47bb-45a9-b6e3-314f9ed9e0cd@gmail.com>
 <20231031052330.3762989-1-gitster@pobox.com>
 <20231031052330.3762989-3-gitster@pobox.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231031052330.3762989-3-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 31/10/2023 05:23, Junio C Hamano wrote:
> They are equivalents and the former still exists, so as long as the
> only change this commit makes are to rewrite test_i18ngrep to
> test_grep, there won't be any new bug, even if there still are
> callers of test_i18ngrep remaining in the tree, or when merged to
> other topics that add new uses of test_i18ngrep.
> 
> This patch was produced more or less with
> 
>      git grep -l -e 'test_i18ngrep ' 't/t[0-9][0-9][0-9][0-9]-*.sh' |
>      xargs perl -p -i -e 's/test_i18ngrep /test_grep /'
> 
> and a good way to sanity check the result yourself is to run the
> above in a checkout of c4603c1c (test framework: further deprecate
> test_i18ngrep, 2023-10-31) and compare the resulting working tree
> contents with the result of applying this patch to the same commit.
> You'll see that test_i18ngrep in a few t/lib-*.sh files corrected,
> in addition to the manual reproduction.

Thanks for working on this. I have checked what you have in seen by 
checking out the first parent of ce56983dd3 (Merge branch 
'jc/test-i18ngrep' into seen, 2023-11-01) and then converting 
"test_i18ngrep" to "test_grep" and diffing the result as you suggest 
above.  The diff looks good and shows that you've corrected the 
additional t/lib-*.sh files. Grepping ce56983dd3 for "test_i18ngrep" 
shows there is one instance of test_i18ngrep that has not been coverted 
in contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh.

Best Wishes

Phillip
