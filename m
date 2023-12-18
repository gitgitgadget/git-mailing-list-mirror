Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C641DFF9
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQFi/+fm"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336437ae847so3392295f8f.2
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702917154; x=1703521954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lWj0dIqT+s+2GOdbd4i8m30BcCYWKxKjyq2+1uAYkVU=;
        b=OQFi/+fmbc2/vHLMARW8kmBMNiOj47kU4tWEMgoVHgNEUwadCLb/FDERZc6w3rG2QZ
         nRBOSpGmfh4ktTXyBKOFAp35X+E1R0FCvmbpq2kFlX+UvL6ttVI75ep+vef3ufpt0Adj
         uMNdBNYiL4em/4D2oRIKFy+72je3lHUyWjLwCfT76T5rT+TezEw0H0CHBpTj4VcmEqFY
         JikhnvtDbHTf1UTPJ3DqzXziU4XQYxhYH/v78pdFsTbtt6wPPYm8INBnJ0vVF8CJE7ZK
         owlaXqLqHJA87kXISjdatOW+N39VIIGw0zstx8e1V8Px7+mVltVYFXVkzgenkOX6G1w0
         Yp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917154; x=1703521954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWj0dIqT+s+2GOdbd4i8m30BcCYWKxKjyq2+1uAYkVU=;
        b=nVfwqtiI1KCy6uEFkRtFzyAzqKk49lSneuDrUKRjxrQDiZAY1pEULUYpfS6l9ImU+9
         R2Z9Ek34+QLJ2nbDeb4GJLk8EaLGdrxM/jG2saxKAIZgVPRjftZaF7/zt0zbID6g9xDj
         tRI3zG7xhBqHT+I9mUkuKVS4JzTSGDrxr/136ph7ab0aosO85WqCynvsyyhsi3hzBH4s
         wJLJKD3KujQc2OQpChnFVUl6Uea2/eEhZRnNsEGteA0Y2l2p+uXn6xwplyIuhhBGTTvR
         NRejrR25zy3Ns7gpOynL0X7aom99kzKtdvBpTBOZ2oSzZqKhOP75EavrS9NhYJQx8XZf
         4J7A==
X-Gm-Message-State: AOJu0Yz/+cxNgVKKpv5GJPORGR+bsSh2RkxPEo3QgL5RefCzl7jtc9MD
	phjFV1Qv9K5gmuEzF0zChl4=
X-Google-Smtp-Source: AGHT+IEJn6p3EUbv6HTyCT9Oz22SZmsSPN3E2n7QL1p+NR0lMnRkQ43ZjOgnG7LzmrueNnCIqHBmEQ==
X-Received: by 2002:a5d:4943:0:b0:336:4fe5:6068 with SMTP id r3-20020a5d4943000000b003364fe56068mr3281648wrs.137.1702917153590;
        Mon, 18 Dec 2023 08:32:33 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id z1-20020a056000110100b0033668b27f8fsm2932045wrw.4.2023.12.18.08.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:32:33 -0800 (PST)
Message-ID: <c2489476-f23b-4c03-8651-d6a8799ff67c@gmail.com>
Date: Mon, 18 Dec 2023 16:32:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase-interactive: show revert option and add single
 letter shortcut
Content-Language: en-US
To: Michael Lohmann <mial.lohmann@gmail.com>, git@vger.kernel.org
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <3e71666c-22a0-f52b-4025-dddb096e7e6c@gmx.de>
 <20231218152313.72896-1-mi.al.lohmann@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231218152313.72896-1-mi.al.lohmann@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael

Thanks for the patch, I'm wondering why you want to revert a commit when 
you're rebasing. I think it would be helpful to explain that in the 
commit message. In particular why it is necessary to revert a commit 
rather than simply dropping it (presumably you're using rebase to do 
something more that just rework a series of commits)

Best Wishes

Phillip

On 18/12/2023 15:23, Michael Lohmann wrote:
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> ---
>   Documentation/git-rebase.txt | 3 +++
>   rebase-interactive.c         | 1 +
>   sequencer.c                  | 2 +-
>   3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 1dd6555f66..75f6fe39a1 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -911,6 +911,9 @@ commit, the message from the final one is used.  You can also use
>   "fixup -C" to get the same behavior as "fixup -c" except without opening
>   an editor.
>   
> +To revert a commit, add a line starting with "revert" followed by the commit
> +name.
> +
>   `git rebase` will stop when "pick" has been replaced with "edit" or
>   when a command fails due to merge errors. When you are done editing
>   and/or resolving conflicts you can continue with `git rebase --continue`.
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index d9718409b3..e1fd1e09e3 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -53,6 +53,7 @@ void append_todo_help(int command_count,
>   "                   commit's log message, unless -C is used, in which case\n"
>   "                   keep only this commit's message; -c is same as -C but\n"
>   "                   opens the editor\n"
> +"v, revert <commit> = revert the changes introduced by that commit\n"
>   "x, exec <command> = run command (the rest of the line) using shell\n"
>   "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
>   "d, drop <commit> = remove commit\n"
> diff --git a/sequencer.c b/sequencer.c
> index d584cac8ed..3c18f71ed6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1767,7 +1767,7 @@ static struct {
>   	const char *str;
>   } todo_command_info[] = {
>   	[TODO_PICK] = { 'p', "pick" },
> -	[TODO_REVERT] = { 0,   "revert" },
> +	[TODO_REVERT] = { 'v', "revert" },
>   	[TODO_EDIT] = { 'e', "edit" },
>   	[TODO_REWORD] = { 'r', "reword" },
>   	[TODO_FIXUP] = { 'f', "fixup" },
