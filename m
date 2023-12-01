Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWo8Rny6"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B5194
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 17:25:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-33332096330so3606f8f.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 17:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701393955; x=1701998755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EAVd1pclsuh6sWekql8Gc9TYsqhjVkoY7Q3OLVceKRM=;
        b=kWo8Rny67yscf9XvLE4qoB3DawjP5MMU6QCLorvsXUpdBSCKvX+jcgp6HDta2eRZZE
         yG3ykRqqWaAFQvpa225/Bw/tm1E5J3UzChqfmZKHmMj2o2zqv2l60uIm1xLtbAOB9REm
         Eip79vEhbhzwrFJ5YuAHOqx3TQQ1ciFbsnPJf9ZjPD7gR4SD5MHCCG1zTRhWggxOws6q
         4ljUt9LxVLKHP28mMaNhfb8cXX8c50MM2XEQJqUP7ae+hZzFEYxyE53Gbazqh5s/IW48
         9FE6UE1G5fUeebfJPgmP4Xl1SfscSZXkLCiPQWxk4n1Vn/6xZBZGj8M1Vk1uI7VubNLn
         JvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701393955; x=1701998755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAVd1pclsuh6sWekql8Gc9TYsqhjVkoY7Q3OLVceKRM=;
        b=spEV0UkoLF1Jo8SFaONXB6D2cCuSCKBwn0HT49GyrZcB1xduy055y45Qd/z2Ee8Mgo
         fKz2LmpzDFcdw5kIYw+kmBy/HjlFIcHADnX9TXLzSUy81me128Df6CFoU/6z5e8JguUF
         gvyzLngRLX92RYOTppFU/daxMkwm85y5fbFKdmmktx3w+eRC5NB59bKcmoe2ffDdRb6I
         P/EVtVnNpgN42Wt3+qWZ22DrSnW2bSnqSpgbSxobQGu4biUDOGPIySXTLFHkzptz10+z
         v3Kaf7TjnBD9mAT4I/F7xVie+P8LVt1FndArMPZed/DkJ2jWSYorWDjGEwx+jQFzxo1m
         PF5Q==
X-Gm-Message-State: AOJu0Ywl8SOejPY5/a6BbUXd+H7VHqdtWdA3VrQTbYvzAQX327mX8drF
	FsZ5xZGoE1cF5z7nGC99O3I=
X-Google-Smtp-Source: AGHT+IGVmDaa8Q9c398Tv0Q5sUTnvKTUMfAF9abiRlHLSeGO0glUFy0n4Degy0vkJtOaqlk6GU2Qgg==
X-Received: by 2002:adf:e3cb:0:b0:332:f501:8b56 with SMTP id k11-20020adfe3cb000000b00332f5018b56mr235440wrm.23.1701393954505;
        Thu, 30 Nov 2023 17:25:54 -0800 (PST)
Received: from gmail.com (254.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.254])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d53c7000000b00332ff21038fsm2803220wrw.106.2023.11.30.17.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 17:25:53 -0800 (PST)
Message-ID: <ba8c814c-cb93-49cb-9df0-8f4599e68e9e@gmail.com>
Date: Fri, 1 Dec 2023 02:25:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Mention default oldbranch in git-branch doc
Content-Language: en-US
To: "Clarence \"Sparr\" Risher via GitGitGadget" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Clarence \"Sparr\" Risher" <sparr0@gmail.com>
References: <pull.1613.git.git.1701303891791.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <pull.1613.git.git.1701303891791.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30-nov-2023 00:24:51, Clarence "Sparr" Risher via GitGitGadget wrote:
> From: "Clarence \"Sparr\" Risher" <sparr0@gmail.com>
> 
> `git branch -m` has an optional first argument, the branch to rename.
> If omitted, it defaults to the current branch. This behavior is not
> currently described in the documentation.

Good catch.

> While it can be determined
> relatively easily through experimentation, and less so through viewing
> the source code (builtin/branch.c:897)

Some people will find it easier by reading the code than through
experimentation ;-)

> it is not obvious what such a
> command will do when encountered in a less interactive context.

Certainly, I agree.

> 
> This patch adds one sentence to the git-branch documentation, with
> wording based on another optional argument described earlier in the
> same doc.
> 
> The same behavior applies to -M, -c, and -C

Good.

> 
> Signed-off-by: Clarence Risher <clarence@kira-learning.com>
> Signed-off-by: Clarence "Sparr" Risher <sparr0@gmail.com>

Are you both?  If that is the case, IMO it is unusual in this project to
have two different signatures for the same person in one commit.

> 
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 4395aa93543..affed1b17a4 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -73,6 +73,7 @@ overridden by using the `--track` and `--no-track` options, and
>  changed later using `git branch --set-upstream-to`.
>  
>  With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
> +If the <oldbranch> argument is missing it defaults to the current branch.

Sounds good.  But IMHO this information fits better below, where the
term "<oldbranch>" is described.  Something like:

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 4395aa9354..9c17df9f4d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -312,7 +312,8 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
        option is omitted, the current HEAD will be used instead.

 <oldbranch>::
-       The name of an existing branch to rename.
+       The name of an existing branch to rename or copy.  If this
+       option is omitted, the current branch will be used instead.

Completing while we're here, what we missed when -c was introduced in
52d59cc645 (branch: add a --copy (-c) option to go with --move (-m),
2017-06-18).

>  If <oldbranch> had a corresponding reflog, it is renamed to match
>  <newbranch>, and a reflog entry is created to remember the branch
>  renaming. If <newbranch> exists, -M must be used to force the rename
> 
> base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
> -- 
> gitgitgadget


Thank you for working on this.
