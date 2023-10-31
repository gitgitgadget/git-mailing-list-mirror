Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABDC156C1
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxXwcoAi"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF759C1
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 04:27:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso38509725e9.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 04:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698751647; x=1699356447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j+9DKRHQ+hhpiqD5I9WZzzxasx3PryycSltQr2y9lSY=;
        b=XxXwcoAi3Smo8/bOjq1OvFS0s4DenPivRGdpdjZxHXJALocY1B/mIFJJtjqx2tEdtX
         gfiOgTraCDj4vJUKArG3oMdDx51yndXeM197MD+UzqtfavfdHVfFX6ba1l9bDm1uRDWX
         G3kgbe/d4fGcd88qr2r0/CtM4Gz5be43qaAppt6cQ74PjBdnrcRU8aYxw4kvPMuuguMI
         LZ/bVo5xWT8i9oNcfI/AtXdsTH080ikqDOCAe3Sb4hFeCsKsAaTXvkJoODpXs3MPAzL5
         H/nIfXslOi2q5oDpEMYzhyuIqw25ha6DvkeyjYpiAYuqleU8VbtDE98hn1ZA2gGCJUCJ
         NfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698751647; x=1699356447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+9DKRHQ+hhpiqD5I9WZzzxasx3PryycSltQr2y9lSY=;
        b=bQGAXflo5+mQ4PD7PPgghY0N8+eU3FcY4nsaEtSn1Oe/nrPzf0XzgJe8Oaca+iU8YS
         YFLUi60AXpPINWBvp2a6cnWDY5JNGHLxec71DKpch5WgGxq57LsBdQq33QUQdL0COlzs
         bKcMQCNg7sRdEXA+vjpKBkOHqzXE9q/Dpt3w0FRUPmd+zEOfaPkTrdVaPw9QVXo304rC
         hYpyg7bWrQPypW32tVKh0LqIv34AsiVM7vr8MKj7YXa593LiwbiUcXohjEsfx35iTijm
         4EFImhap8NgsGZ0Tqu9FO8KcObSNSovJRfA5pcBddqx+7ezu6N3m5Y/SDX/3a6ygbo/5
         oHzw==
X-Gm-Message-State: AOJu0Ywow4dknP4oqEVNTsIOHe8sJghUP7A+x+UVjhQEl4kV0g3qQVyB
	Ug6gdyBI+5WUFOA3j7YUfSg=
X-Google-Smtp-Source: AGHT+IEpHmb0dgsur79f2iqmFx/kEGgc9gTGbQjvCyMzJOGQUk0Mw7+MVvdzLMmarfkzTm1kpp49Jw==
X-Received: by 2002:a05:600c:5387:b0:408:33ba:569a with SMTP id hg7-20020a05600c538700b0040833ba569amr2769033wmb.8.1698751647022;
        Tue, 31 Oct 2023 04:27:27 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id q6-20020a05600c46c600b004063c9f68f2sm1455517wmo.26.2023.10.31.04.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 04:27:26 -0700 (PDT)
Message-ID: <2e0a9d0f-e801-42a5-aad8-f336bd023295@gmail.com>
Date: Tue, 31 Oct 2023 11:27:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] sequencer: fix remaining hardcoded comment char
Content-Language: en-US
To: Tony Tung via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Tony Tung <tonytung@merly.org>
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
 <pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
 <c9f4ff34dbdb7ba221e4203bb6551b80948dc71d.1698728953.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <c9f4ff34dbdb7ba221e4203bb6551b80948dc71d.1698728953.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tony

Thanks for working on this. When you're submitting patches please try 
testing them locally and check the CI before doing '/submit'. In this 
case all the jobs that try to compile git are failing - see 
https://github.com/gitgitgadget/git/actions/runs/6702301267/job/18211090139?pr=1603#step:4:260 
for example.

On 31/10/2023 05:09, Tony Tung via GitGitGadget wrote:
> From: Tony Tung <tonytung@merly.org>
> 
> Signed-off-by: Tony Tung <tonytung@merly.org>
> ---
>   sequencer.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 8c6666d5e43..bbadc3fb710 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1893,8 +1893,14 @@ static void update_squash_message_for_fixup(struct strbuf *msg)
>   	size_t orig_msg_len;
>   	int i = 1;
>   
> -	strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_str));
> -	strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_msg_str));
> +	strbuf_commented_addf(&buf1,
> +			      comment_line_char,
> +			      "%s\n",
> +			      _(first_commit_msg_str));

This is what is causing the compilation the fail. It should be

	strbuf_commented_addf(&buf1, "%c $s\n", comment_char_line,
			      _(first_commit_msg_str));

> +	strbuf_commented_addf(&buf2,
> +			      comment_line_char,
> +			      "%s\n",
> +			      _(skip_first_commit_msg_str));

This needs changing in the same way.

It would be nice to add a test for this. I think we can do that by adding

	test_config core.commentchar :

To the beginning of the test '--skip after failed fixup cleans commit 
message' in t3418-rebase-continue.sh and changing the expected message 
so that it uses ':' instead of '#' for the comments.

>   	s = start = orig_msg = strbuf_detach(msg, &orig_msg_len);
>   	while (s) {
>   		const char *next;
> @@ -2269,8 +2275,9 @@ static int do_pick_commit(struct repository *r,
>   		next = parent;
>   		next_label = msg.parent_label;
>   		if (opts->commit_use_reference) {
> -			strbuf_addstr(&msgbuf,
> -				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> +			strbuf_commented_addf(&msgbuf,
> +					      "%s",
> +					      "*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>   		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
>   			   /*
>   			    * We don't touch pre-existing repeated reverts, because
> @@ -6082,7 +6089,8 @@ static int add_decorations_to_list(const struct commit *commit,
>   		/* If the branch is checked out, then leave a comment instead. */
>   		if ((path = branch_checked_out(decoration->name))) {
>   			item->command = TODO_COMMENT;
> -			strbuf_commented_addf(ctx->buf, comment_line_char,
> +			strbuf_commented_addf(ctx->buf,
> +					      comment_line_char,
>   					      "Ref %s checked out at '%s'\n",
>   					      decoration->name, path);

This hunk is unnecessary - it is just changing the code you added in the 
first patch.

Best Wishes

Phillip

