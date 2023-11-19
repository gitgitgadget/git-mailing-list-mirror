Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIU/wAkV"
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAF411D
	for <git@vger.kernel.org>; Sun, 19 Nov 2023 08:42:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-331733acbacso1127721f8f.1
        for <git@vger.kernel.org>; Sun, 19 Nov 2023 08:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700412174; x=1701016974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ydETNSYWSIzNJlXYN8I9eso69G5Ey6mJwPc2byEUIlw=;
        b=eIU/wAkVWS2czPxQmwmCAOqlV5aJJo6Khdl8B6HVMSFrUFpK4/YuheKwTVLHzWl/08
         hx7sbeGqR9He873PnP4Yk9UAhcTbdhQqiMaG/6gY5zmt91RiY3j5tEVpvLtDqzmOJwHR
         mtU5VmZIKBQhLiE4L2VKRzq9b4EQQa0aFp9LZ9hL6zuPwGctcSA85jmK52l28Jb7YBCE
         FDLcqsbU/RXUt7m7dHrGAeeLSaSFK3myD1uFNRoDjS4GUSgC/0URQgCkKlVzcxxkBKEg
         EwcS6GcrHX9kap05TA8YSP8WLgF7eKiW2U8xviG5DdoNIN+uGL0m5C5sPZUtLEw1bvJb
         jFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700412174; x=1701016974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydETNSYWSIzNJlXYN8I9eso69G5Ey6mJwPc2byEUIlw=;
        b=KvMx47h75Df7uWURwzokf+SfP6mTmlkAE3R9EUSIti1rvT3SeatcgBeRniE3t6aAIH
         xzlTxwUGZjlwLX5ABGjDuICCQrPtAJ3HxiRL99r2N5rR/sFYQ3RW1E0ZLtlajdXvcsW+
         xwp3dGTG41bWtbhokYqZ7fP0GIi0nxEr6zfcIhTp+Vwytdh/Llf/vqBtiPk7KReNIS52
         B+itIO3IRr7DWkuCdgXECc8tQo717dRr4lLDA1N2E2j0zUjS/hAfl1BG/DURHgS4oXrL
         08CJDz6yS0KazM3SUoP+ehC2vRVy7r0PBr8wF4H+HTKodNiANneqyJ2+sJzZJ62t6ZEI
         fNmw==
X-Gm-Message-State: AOJu0Yy9UuKfdkA0/vLXgGowXOnQ3Q1qEwg0FH8dkzy92jtSlIY0yFUU
	SqrKjh956Ye7DFHVBTXVvwo=
X-Google-Smtp-Source: AGHT+IEMHaHt25tDumAIz+77rssKS5ynEzyJmoADHWpPwcR/nnnmvC2EWJWkSJmLu3PfWH/T+4uRXA==
X-Received: by 2002:a05:6000:178d:b0:32d:a0d3:d681 with SMTP id e13-20020a056000178d00b0032da0d3d681mr3814859wrg.43.1700412174057;
        Sun, 19 Nov 2023 08:42:54 -0800 (PST)
Received: from [192.168.1.212] ([84.64.93.134])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b00331a55d3875sm4397122wrb.38.2023.11.19.08.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 08:42:53 -0800 (PST)
Message-ID: <a83321f0-7184-4779-82d2-854a1e324f92@gmail.com>
Date: Sun, 19 Nov 2023 16:42:53 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] merge-file: add --diff-algorithm option
Content-Language: en-US
To: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Antonin Delpeuch <antonin@delpeuch.eu>
References: <pull.1606.git.git.1699480494355.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1606.git.git.1699480494355.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonin

On 08/11/2023 21:54, Antonin Delpeuch via GitGitGadget wrote:
> From: Antonin Delpeuch <antonin@delpeuch.eu>
> 
> This makes it possible to use other diff algorithms than the 'myers'
> default algorithm, when using the 'git merge-file' command.

I think being able to select the diff algorithm is reasonable. I might 
be nice to mention the use of "git merge-file" in custom merge drivers 
as a motivation in the commit message.

> Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
> ---
>      merge-file: add --diff-algorithm option
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1606%2Fwetneb%2Fmerge_file_configurable_diff_algorithm-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1606/wetneb/merge_file_configurable_diff_algorithm-v1
> Pull-Request: https://github.com/git/git/pull/1606
> 
>   Documentation/git-merge-file.txt |  5 +++++
>   builtin/merge-file.c             | 28 ++++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
> index 6a081eacb72..917535217c1 100644
> --- a/Documentation/git-merge-file.txt
> +++ b/Documentation/git-merge-file.txt
> @@ -92,6 +92,11 @@ object store and the object ID of its blob is written to standard output.
>   	Instead of leaving conflicts in the file, resolve conflicts
>   	favouring our (or their or both) side of the lines.
>   
> +--diff-algorithm <algorithm>::
> +	Use a different diff algorithm while merging, which can help
> +	avoid mismerges that occur due to unimportant matching lines
> +	(such as braces from distinct functions).  See also
> +	linkgit:git-diff[1] `--diff-algorithm`.

Perhaps we could list the available algorithms here so the user does not 
have to go searching for them in another man page.

>   EXAMPLES
>   --------
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index 832c93d8d54..1f987334a31 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -1,5 +1,6 @@
>   #include "builtin.h"
>   #include "abspath.h"
> +#include "diff.h"
>   #include "hex.h"
>   #include "object-name.h"
>   #include "object-store.h"
> @@ -28,6 +29,30 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
>   	return 0;
>   }
>   
> +static int set_diff_algorithm(xpparam_t *xpp,
> +			      const char *alg)
> +{
> +	long diff_algorithm = parse_algorithm_value(alg);
> +	if (diff_algorithm < 0)
> +		return -1;
> +	xpp->flags = (xpp->flags & ~XDF_DIFF_ALGORITHM_MASK) | diff_algorithm;
> +	return 0;
> +}
> +
> +static int diff_algorithm_cb(const struct option *opt,
> +				const char *arg, int unset)
> +{
> +	xpparam_t *xpp = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	if (set_diff_algorithm(xpp, arg))
> +		return error(_("option diff-algorithm accepts \"myers\", "
> +			       "\"minimal\", \"patience\" and \"histogram\""));
> +
> +	return 0;
> +}
> +
>   int cmd_merge_file(int argc, const char **argv, const char *prefix)
>   {
>   	const char *names[3] = { 0 };
> @@ -48,6 +73,9 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>   			    XDL_MERGE_FAVOR_THEIRS),
>   		OPT_SET_INT(0, "union", &xmp.favor, N_("for conflicts, use a union version"),
>   			    XDL_MERGE_FAVOR_UNION),
> +		OPT_CALLBACK_F(0, "diff-algorithm", &xmp.xpp, N_("<algorithm>"),
> +			     N_("choose a diff algorithm"),
> +			     PARSE_OPT_NONEG, diff_algorithm_cb),
>   		OPT_INTEGER(0, "marker-size", &xmp.marker_size,
>   			    N_("for conflicts, use this marker size")),
>   		OPT__QUIET(&quiet, N_("do not warn about conflicts")),

This patch looks sensible to me, it would be nice to have some tests though.

Best Wishes

Phillip

> base-commit: 98009afd24e2304bf923a64750340423473809ff
