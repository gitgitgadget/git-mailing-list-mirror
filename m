Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/fmATkF"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17DFCB
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 06:58:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-407da05f05aso22941625e9.3
        for <git@vger.kernel.org>; Tue, 21 Nov 2023 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700578732; x=1701183532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ls1u31GAOpjQf6NcUIQdLGtecselsdmDzxZaz7JJO3I=;
        b=m/fmATkFBt7BDN53I3JcaXPTDNXhx+VyqyuDl+kSGGDwd1WzMupgZ/U0O2rbLjG+sr
         OVzz/3pQGMAQxo4EAsvdq8mQS6GlrpOsNIcN3qnbZ2FU2UnHnodFBY8+nkWLiyuurk2C
         ZAc3u9RcJveckcM5LrGedkXgtnerxa6XefyE7apt586LQEx8vPndOIrMuf5Y9Ge9amjH
         wPPS2BjtXDiuNTSp6XVCj+NXvGjRPndP5M6ibLqJqq7eQr5K8hIsAtmDiFqSTSBakqsI
         Q39oMpxkpUtNM0Cb7wjX1qeE8wpnB2jatVIQJ+2gPTPC0yHFAXg9kPnncyw4xySx4U5W
         PaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700578732; x=1701183532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ls1u31GAOpjQf6NcUIQdLGtecselsdmDzxZaz7JJO3I=;
        b=uh6Ac3P7V6Fr7YQCoNjXXcJLE68xR9xgRoTZBbZshH37CvdX8pUexTmhFsKZynhxyc
         NIWGNJpB31+8s6c35dA6i2PF8Jaj4nzCm2VP6IO9vil8Cqg+z7M5u9r93ymW3dgm99h7
         YOlOvvDjchNIiR9brAhoOpQfXuiI9erGbx1dfNQVXPDuulat6y/1UiYBr9tVvCFmMBZ2
         EyovCXYdJ2xt2EEsax46T1f8mleCOXDOb0lfPqmLV4QOJRbxP1759Qgw9wbpiJaaiJ2f
         ANIVlgTaeN1fPio7mqeZBQLFm6/Gyo0c81+ZsjfSvWbsTCQHt2oXycKRvKSLj1+/F8mk
         I4pA==
X-Gm-Message-State: AOJu0YywobFB7dnoD53PLmwFYpqeWJ0bc641wG8fnh3THnTBslvfw/Ii
	kC1tL4GJQtDj7MoV2okr/bk=
X-Google-Smtp-Source: AGHT+IGIvPdp7TLa0G1choYyQEkxiRILihirgwWfiF/vCjdVuf/TMUeXlzTYQArsD/Fzr+hbyAtneQ==
X-Received: by 2002:a05:600c:a41:b0:3f6:9634:c8d6 with SMTP id c1-20020a05600c0a4100b003f69634c8d6mr8551630wmq.18.1700578731662;
        Tue, 21 Nov 2023 06:58:51 -0800 (PST)
Received: from [192.168.1.212] ([84.64.93.134])
        by smtp.gmail.com with ESMTPSA id y15-20020a05600c364f00b004060f0a0fd5sm16868587wmq.13.2023.11.21.06.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 06:58:51 -0800 (PST)
Message-ID: <4e06a674-e7b6-4be4-8f69-a8e83cce1bbb@gmail.com>
Date: Tue, 21 Nov 2023 14:58:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] merge-file: add --diff-algorithm option
Content-Language: en-US
To: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Antonin Delpeuch <antonin@delpeuch.eu>
References: <pull.1606.git.git.1699480494355.gitgitgadget@gmail.com>
 <pull.1606.v2.git.git.1700507932937.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1606.v2.git.git.1700507932937.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonin

On 20/11/2023 19:18, Antonin Delpeuch via GitGitGadget wrote:
> From: Antonin Delpeuch <antonin@delpeuch.eu>
> 
> This makes it possible to use other diff algorithms than the 'myers'
> default algorithm, when using the 'git merge-file' command. This helps
> avoid spurious conflicts by selecting a more recent algorithm such as
> 'histogram', for instance when using 'git merge-file' as part of a custom
> merge driver.
> 
> Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
> Reviewed-by: Phillip Wood <phillip.wood@dunelm.org.uk>

This version looks good to me. Thanks for adding the tests and well done 
for finding a test case that shows the benefits of changing the diff 
algorithm so clearly.

For future reference note that the custom on this list is not to add 
"Reviewed-by:" unless the reviewer explicitly suggests it. In this case 
I'm happy for it to be left as is.

Best Wishes

Phillip

> ---
>      merge-file: add --diff-algorithm option
>      
>      Changes since v1:
>      
>       * improve commit message to mention the use case of custom merge
>         drivers
>       * improve documentation to show available options and recommend
>         switching to "histogram"
>       * add tests
>      
>      I have left out:
>      
>       * switching the default to "histogram", because it should only be done
>         in a subsequent release
>       * adding a configuration variable to control this option, because I was
>         not sure how to call it. Perhaps "merge-file.diffAlgorithm"?
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1606%2Fwetneb%2Fmerge_file_configurable_diff_algorithm-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1606/wetneb/merge_file_configurable_diff_algorithm-v2
> Pull-Request: https://github.com/git/git/pull/1606
> 
> Range-diff vs v1:
> 
>   1:  4aa453e30be ! 1:  842b5abf33c merge-file: add --diff-algorithm option
>       @@ Commit message
>            merge-file: add --diff-algorithm option
>        
>            This makes it possible to use other diff algorithms than the 'myers'
>       -    default algorithm, when using the 'git merge-file' command.
>       +    default algorithm, when using the 'git merge-file' command. This helps
>       +    avoid spurious conflicts by selecting a more recent algorithm such as
>       +    'histogram', for instance when using 'git merge-file' as part of a custom
>       +    merge driver.
>        
>            Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
>       +    Reviewed-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>        
>         ## Documentation/git-merge-file.txt ##
>        @@ Documentation/git-merge-file.txt: object store and the object ID of its blob is written to standard output.
>         	Instead of leaving conflicts in the file, resolve conflicts
>         	favouring our (or their or both) side of the lines.
>         
>       -+--diff-algorithm <algorithm>::
>       -+	Use a different diff algorithm while merging, which can help
>       ++--diff-algorithm={patience|minimal|histogram|myers}::
>       ++	Use a different diff algorithm while merging. The current default is "myers",
>       ++	but selecting more recent algorithm such as "histogram" can help
>        +	avoid mismerges that occur due to unimportant matching lines
>       -+	(such as braces from distinct functions).  See also
>       ++	(such as braces from distinct functions). See also
>        +	linkgit:git-diff[1] `--diff-algorithm`.
>         
>         EXAMPLES
>       @@ builtin/merge-file.c: int cmd_merge_file(int argc, const char **argv, const char
>         		OPT_INTEGER(0, "marker-size", &xmp.marker_size,
>         			    N_("for conflicts, use this marker size")),
>         		OPT__QUIET(&quiet, N_("do not warn about conflicts")),
>       +
>       + ## t/t6403-merge-file.sh ##
>       +@@ t/t6403-merge-file.sh: test_expect_success 'setup' '
>       + 	deduxit me super semitas jusitiae,
>       + 	EOF
>       +
>       +-	printf "propter nomen suum." >>new4.txt
>       ++	printf "propter nomen suum." >>new4.txt &&
>       ++
>       ++	cat >base.c <<-\EOF &&
>       ++	int f(int x, int y)
>       ++	{
>       ++		if (x == 0)
>       ++		{
>       ++			return y;
>       ++		}
>       ++		return x;
>       ++	}
>       ++
>       ++	int g(size_t u)
>       ++	{
>       ++		while (u < 30)
>       ++		{
>       ++			u++;
>       ++		}
>       ++		return u;
>       ++	}
>       ++	EOF
>       ++
>       ++	cat >ours.c <<-\EOF &&
>       ++	int g(size_t u)
>       ++	{
>       ++		while (u < 30)
>       ++		{
>       ++			u++;
>       ++		}
>       ++		return u;
>       ++	}
>       ++
>       ++	int h(int x, int y, int z)
>       ++	{
>       ++		if (z == 0)
>       ++		{
>       ++			return x;
>       ++		}
>       ++		return y;
>       ++	}
>       ++	EOF
>       ++
>       ++	cat >theirs.c <<-\EOF
>       ++	int f(int x, int y)
>       ++	{
>       ++		if (x == 0)
>       ++		{
>       ++			return y;
>       ++		}
>       ++		return x;
>       ++	}
>       ++
>       ++	int g(size_t u)
>       ++	{
>       ++		while (u > 34)
>       ++		{
>       ++			u--;
>       ++		}
>       ++		return u;
>       ++	}
>       ++	EOF
>       + '
>       +
>       + test_expect_success 'merge with no changes' '
>       +@@ t/t6403-merge-file.sh: test_expect_success '--object-id fails without repository' '
>       + 	grep "not a git repository" err
>       + '
>       +
>       ++test_expect_success 'merging C files with "myers" diff algorithm creates some spurious conflicts' '
>       ++	cat >expect.c <<-\EOF &&
>       ++	int g(size_t u)
>       ++	{
>       ++		while (u < 30)
>       ++		{
>       ++			u++;
>       ++		}
>       ++		return u;
>       ++	}
>       ++
>       ++	int h(int x, int y, int z)
>       ++	{
>       ++	<<<<<<< ours.c
>       ++		if (z == 0)
>       ++	||||||| base.c
>       ++		while (u < 30)
>       ++	=======
>       ++		while (u > 34)
>       ++	>>>>>>> theirs.c
>       ++		{
>       ++	<<<<<<< ours.c
>       ++			return x;
>       ++	||||||| base.c
>       ++			u++;
>       ++	=======
>       ++			u--;
>       ++	>>>>>>> theirs.c
>       ++		}
>       ++		return y;
>       ++	}
>       ++	EOF
>       ++
>       ++	test_must_fail git merge-file -p --diff3 --diff-algorithm myers ours.c base.c theirs.c >myers_output.c &&
>       ++	test_cmp expect.c myers_output.c
>       ++'
>       ++
>       ++test_expect_success 'merging C files with "histogram" diff algorithm avoids some spurious conflicts' '
>       ++	cat >expect.c <<-\EOF &&
>       ++	int g(size_t u)
>       ++	{
>       ++		while (u > 34)
>       ++		{
>       ++			u--;
>       ++		}
>       ++		return u;
>       ++	}
>       ++
>       ++	int h(int x, int y, int z)
>       ++	{
>       ++		if (z == 0)
>       ++		{
>       ++			return x;
>       ++		}
>       ++		return y;
>       ++	}
>       ++	EOF
>       ++
>       ++	git merge-file -p --diff3 --diff-algorithm histogram ours.c base.c theirs.c >histogram_output.c &&
>       ++	test_cmp expect.c histogram_output.c
>       ++'
>       ++
>       + test_done
> 
> 
>   Documentation/git-merge-file.txt |   6 ++
>   builtin/merge-file.c             |  28 +++++++
>   t/t6403-merge-file.sh            | 124 ++++++++++++++++++++++++++++++-
>   3 files changed, 157 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
> index 6a081eacb72..71915a00fa4 100644
> --- a/Documentation/git-merge-file.txt
> +++ b/Documentation/git-merge-file.txt
> @@ -92,6 +92,12 @@ object store and the object ID of its blob is written to standard output.
>   	Instead of leaving conflicts in the file, resolve conflicts
>   	favouring our (or their or both) side of the lines.
>   
> +--diff-algorithm={patience|minimal|histogram|myers}::
> +	Use a different diff algorithm while merging. The current default is "myers",
> +	but selecting more recent algorithm such as "histogram" can help
> +	avoid mismerges that occur due to unimportant matching lines
> +	(such as braces from distinct functions). See also
> +	linkgit:git-diff[1] `--diff-algorithm`.
>   
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
> diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
> index 2c92209ecab..fb872c5a113 100755
> --- a/t/t6403-merge-file.sh
> +++ b/t/t6403-merge-file.sh
> @@ -56,7 +56,67 @@ test_expect_success 'setup' '
>   	deduxit me super semitas jusitiae,
>   	EOF
>   
> -	printf "propter nomen suum." >>new4.txt
> +	printf "propter nomen suum." >>new4.txt &&
> +
> +	cat >base.c <<-\EOF &&
> +	int f(int x, int y)
> +	{
> +		if (x == 0)
> +		{
> +			return y;
> +		}
> +		return x;
> +	}
> +
> +	int g(size_t u)
> +	{
> +		while (u < 30)
> +		{
> +			u++;
> +		}
> +		return u;
> +	}
> +	EOF
> +
> +	cat >ours.c <<-\EOF &&
> +	int g(size_t u)
> +	{
> +		while (u < 30)
> +		{
> +			u++;
> +		}
> +		return u;
> +	}
> +
> +	int h(int x, int y, int z)
> +	{
> +		if (z == 0)
> +		{
> +			return x;
> +		}
> +		return y;
> +	}
> +	EOF
> +
> +	cat >theirs.c <<-\EOF
> +	int f(int x, int y)
> +	{
> +		if (x == 0)
> +		{
> +			return y;
> +		}
> +		return x;
> +	}
> +
> +	int g(size_t u)
> +	{
> +		while (u > 34)
> +		{
> +			u--;
> +		}
> +		return u;
> +	}
> +	EOF
>   '
>   
>   test_expect_success 'merge with no changes' '
> @@ -447,4 +507,66 @@ test_expect_success '--object-id fails without repository' '
>   	grep "not a git repository" err
>   '
>   
> +test_expect_success 'merging C files with "myers" diff algorithm creates some spurious conflicts' '
> +	cat >expect.c <<-\EOF &&
> +	int g(size_t u)
> +	{
> +		while (u < 30)
> +		{
> +			u++;
> +		}
> +		return u;
> +	}
> +
> +	int h(int x, int y, int z)
> +	{
> +	<<<<<<< ours.c
> +		if (z == 0)
> +	||||||| base.c
> +		while (u < 30)
> +	=======
> +		while (u > 34)
> +	>>>>>>> theirs.c
> +		{
> +	<<<<<<< ours.c
> +			return x;
> +	||||||| base.c
> +			u++;
> +	=======
> +			u--;
> +	>>>>>>> theirs.c
> +		}
> +		return y;
> +	}
> +	EOF
> +
> +	test_must_fail git merge-file -p --diff3 --diff-algorithm myers ours.c base.c theirs.c >myers_output.c &&
> +	test_cmp expect.c myers_output.c
> +'
> +
> +test_expect_success 'merging C files with "histogram" diff algorithm avoids some spurious conflicts' '
> +	cat >expect.c <<-\EOF &&
> +	int g(size_t u)
> +	{
> +		while (u > 34)
> +		{
> +			u--;
> +		}
> +		return u;
> +	}
> +
> +	int h(int x, int y, int z)
> +	{
> +		if (z == 0)
> +		{
> +			return x;
> +		}
> +		return y;
> +	}
> +	EOF
> +
> +	git merge-file -p --diff3 --diff-algorithm histogram ours.c base.c theirs.c >histogram_output.c &&
> +	test_cmp expect.c histogram_output.c
> +'
> +
>   test_done
> 
> base-commit: 98009afd24e2304bf923a64750340423473809ff
