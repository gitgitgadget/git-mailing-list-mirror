Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07853C433EF
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 18:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiC0SaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 14:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiC0SaH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 14:30:07 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764D8DF09
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 11:28:26 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s11so10655537qtc.3
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 11:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=944724snp0b7wycsPP1hOyxxOFe9LDoaVqDDhSDKu2s=;
        b=gQ8BlZFfX6zQqhmBo0W2cHc1CNVSWTZNvLTwMrJZuz7Ds4qa3yri5Vk6E+2xUJaq/l
         3+ShMYn/HXVeZtNGNhqBV80LB3yYlylb9gpqVYKTC5idCaWCne1kjDWXt1+s2gKyLKrO
         A3lQ412awRiCr+C9K7bqdMuTMP2yupZEbVOsVUIFPz9w/i2MZ82X981PqRS0qbU66SZj
         IuIPg1FlzTjrTkdfqmnGEPplLlUGjuE65mBGTqRHeiCAFbiKGoeCHthP6+Yfy4HpF2Ze
         /y1cM2AIGsgt+bxEX9QmgS7qGYygB4WNEgbONUzXW7mh2rAZCjOpthZWlrHewgh7pP0k
         X0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=944724snp0b7wycsPP1hOyxxOFe9LDoaVqDDhSDKu2s=;
        b=6oVOj2vi0nRBpSwq3ItOL0EUa6IfmRMuxT0utGgk6XZk96Uzk/D8mCizvlmiLcNHv3
         EAITzghOQRW0jCz3brSesaFK3TOQjEkjgES+hj07X2F7+qonUHkPi/z1bF3hep66jQmZ
         5ztIRqvQ2Tkio9BztTUm4zdCxmrrgmnYS8OddVZtlX9AN/ScseYfaOXogjtO7Kk3ZzAl
         qyXKG1hbyVCypzybyUmT/jmcqARmqoQrv2NbVtjqyIU+HAECRzioEdB2dKxXuttOUWTa
         jPFvlVYTvpCJnlHKe+wz8FtIRZ3O8MWoV28+4uQ9p/5ERWRxehPB8WJSAeFQPo5oIHUn
         Fs2A==
X-Gm-Message-State: AOAM533MuauEB4wE+FnYKSoYbYsVPzCTLPQ7ZuLeQQ2ikJYBn1tQaMQd
        3af9GEHag1t0/W6zYbfw/k0=
X-Google-Smtp-Source: ABdhPJx9GVKmcCSgMzJmbJTRQAFNg6sfPv6bOPVBg/hkOpGO93qS3Y5CgJ5G+lfdp3PzfonNw1iHaA==
X-Received: by 2002:ac8:59c8:0:b0:2e0:6ae2:eb6f with SMTP id f8-20020ac859c8000000b002e06ae2eb6fmr18422009qtf.580.1648405705422;
        Sun, 27 Mar 2022 11:28:25 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id o13-20020ac87c4d000000b002e1e732dea5sm10703156qtv.70.2022.03.27.11.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 11:28:24 -0700 (PDT)
Subject: Re: [PATCH v6 3/3] vimdiff: add tool documentation
To:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org
References: <20220327112307.151044-1-greenfoo@u92.eu>
 <20220327112307.151044-4-greenfoo@u92.eu>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <001d3ecd-e1bd-39f4-5123-4a8b1bd1b5a8@gmail.com>
Date:   Sun, 27 Mar 2022 14:28:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220327112307.151044-4-greenfoo@u92.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fernando,

Le 2022-03-27 à 07:23, Fernando Ramos a écrit :
> Running 'git {merge,diff}tool --tool-help' now also prints usage
> information about the vimdiff tool (and its variantes) instead of just
> its name.
> 
> Two new functions ('diff_cmd_help()' and 'merge_cmd_help()') have been
> added to the set of functions that each merge tool (ie. scripts found
> inside "mergetools/") can overwrite to provided tool specific
> information.
> 
> Right now, only 'mergetools/vimdiff' implements these functions, but
> other tools are encouraged to do so in the future, specially if they
> take configuration options not explained anywhere else (as it is the
> case with the 'vimdiff' tool and the new 'layout' option)

This is a very nice addition, which should help new users understanding
what these merge tools are. I remember myself looking for executables
name 'vimdiff2' or 'vimdiff3' on my system and not finding them :)

> 
> In addition, a section has been added to
> "Documentation/git-mergetool.txt" to explain the new "layout"
> configuration option with examples.
> 
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  Documentation/config/mergetool.txt   |   5 +
>  Documentation/git-mergetool.txt      |   7 ++
>  Documentation/mergetools/vimdiff.txt | 182 +++++++++++++++++++++++++++
>  git-mergetool--lib.sh                |  14 +++
>  mergetools/vimdiff                   |   6 +
>  5 files changed, 214 insertions(+)
>  create mode 100644 Documentation/mergetools/vimdiff.txt
> 
> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> index cafbbef46a..5973ebd2dc 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -45,6 +45,11 @@ mergetool.meld.useAutoMerge::
>  	value of `false` avoids using `--auto-merge` altogether, and is the
>  	default value.
>  
> +mergetool.{n,g,}vimdiff.layout::
> +	The vimdiff backend uses this variable to control how its split
> +	windows look like.  See BACKEND SPECIFIC HINTS section of
> +	linkgit:git-mergetool[1] for details.
> +

I generated the man page for 'git-mergetool' and this bit is included in the 
Configuration section, that's great. However, it feels a little weird to read
"see BACKEND SPECIFIC HINTS section of linkgit:git-mergetool[1]" there, since
that's the help page I'm already reading. So maybe it would be nice to use an
Asciidoc 'ifndef::git-mergetool[]' directive here to hide the "of linkgit:git-mergetool[1]"
bit if the current page is git-mergetool[1] ?

>  mergetool.hideResolved::
>  	During a merge Git will automatically resolve as many conflicts as
>  	possible and write the 'MERGED' file containing conflict markers around
> diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
> index e587c7763a..6c6aa29c5a 100644
> --- a/Documentation/git-mergetool.txt
> +++ b/Documentation/git-mergetool.txt
> @@ -113,6 +113,13 @@ Setting the `mergetool.keepBackup` configuration variable to `false`
>  causes `git mergetool` to automatically remove the backup as files
>  are successfully merged.
>  
> +BACKEND SPECIFIC HINTS
> +----------------------
> +
> +vimdiff
> +~~~~~~~
> +include::mergetools/vimdiff.txt[]
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/Documentation/mergetools/vimdiff.txt b/Documentation/mergetools/vimdiff.txt
> new file mode 100644
> index 0000000000..296bc76e98
> --- /dev/null
> +++ b/Documentation/mergetools/vimdiff.txt
> @@ -0,0 +1,182 @@
> +Description
> +^^^^^^^^^^^
> +
> +When specifying `--tool=vimdiff` in `git mergetool` git will open vim with a 4

s/git/Git/, s/vim/Vim/  (here and below) ?

> +windows layout distributed in the following way:
> +
> +    ------------------------------------------
> +    |             |           |              |
> +    |   LOCAL     |   BASE    |   REMOTE     |
> +    |             |           |              |
> +    ------------------------------------------
> +    |                                        |
> +    |                MERGED                  |
> +    |                                        |
> +    ------------------------------------------
> +
> +"LOCAL", "BASE" and "REMOTE" are read-only buffers showing the contents of the
> +conflicting file in a specific git commit 

"in specific commits" would read sightly better, I think.

> ("commit you are merging into",
> +"common ancestor commit" and "commit you are merging from" respectively)
> +
> +"MERGED" is a writable buffer where you have to resolve the conflicts (using the
> +other read-only buffers as a reference). Once you are done, save and exit "vim"
> +as usual (":wq") or, if you want to abort, exit using ":cq".
> +
> +Layout configuration
> +^^^^^^^^^^^^^^^^^^^^
> +
> +You can change the windows layout used by vim by setting configuration variable
> +"mergetool.vimdiff.layout"

we prefer backticks for configuration variables: `mergetool.vimdiff.layout`

 which accepts a string where the following separators
> +have special meaning:
> +
> +  - "+" is used to "open a new tab"
> +  - "," is used to "open a new vertical split"
> +  - "/" is used to "open a new horizontal split"
> +  - "@" is used to indicate which is the file containing the final version after
> +    solving the conflicts. In not present, "MERGED" will be used by default.

s/In/If/

Also, I would use backticks instead of double quotes for the separator:

  - `+` is used to "open a new tab"

etc.

> +The precedence of the operators is this one (you can use parenthesis 

parentheses

> to change
> +it):
> +
> +    @ > + > / > ,
> +

I think it would be slightly better for the separators to be individually formatted, 
like this:

`@` > `+` > `/` > `,`

this way the angle brackets are typefaced differently (at least in HTML).

> +Let's see some examples to understand how it works:
> +
> +  * layout = "(LOCAL,BASE,REMOTE)/MERGED"
> +
> +    This is exactly the same as the default layout we have already seen.
> +
> +    Note that "/" has precedence over "," and thus the parenthesis are not
> +    needed in this case. The next layout definition is equivalent:
> +
> +        layout = "LOCAL,BASE,REMOTE / MERGED"
> +
> +  * layout = "LOCAL,MERGED,REMOTE"
> +
> +    If, for some reason, we are not interested in the "BASE" buffer.
> +
> +           ------------------------------------------
> +           |             |           |              |
> +           |             |           |              |
> +           |   LOCAL     |   MERGED  |   REMOTE     |
> +           |             |           |              |
> +           |             |           |              |
> +           ------------------------------------------
> +
> +  * layout = "MERGED"
> +
> +    Only the "MERGED" buffer will be shown. Note, however, that all the other
> +    ones are still loaded in vim, and you can access them with the "buffers"
> +    command. 
> +
> +           ------------------------------------------
> +           |                                        |
> +           |                                        |
> +           |                 MERGED                 |
> +           |                                        |
> +           |                                        |
> +           ------------------------------------------
> +
> +  * layout = "@LOCAL,REMOTE"
> +
> +    When "MERGED" is not present in the layout, you must "mark" one of the
> +    buffers with an asterisk. That will become the buffer you need to edit and
> +    save after resolving the conflicts.
> +
> +           ------------------------------------------
> +           |                   |                    |
> +           |                   |                    |
> +           |                   |                    |
> +           |     LOCAL         |    REMOTE          |
> +           |                   |                    |
> +           |                   |                    |
> +           |                   |                    |
> +           ------------------------------------------
> +
> +  * layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE"
> +
> +    Three tabs will open: the first one is a copy of the default layout, while
> +    the other two only show the differences between "BASE" and "LOCAL" and
> +    "BASE" and "REMOTE" respectively.
> + 
> +           ------------------------------------------
> +           | <TAB #1> |  TAB #2  |  TAB #3  |       |
> +           ------------------------------------------
> +           |             |           |              |
> +           |   LOCAL     |   BASE    |   REMOTE     |
> +           |             |           |              |
> +           ------------------------------------------
> +           |                                        |
> +           |                MERGED                  |
> +           |                                        |
> +           ------------------------------------------
> +
> +           ------------------------------------------
> +           |  TAB #1  | <TAB #2> |  TAB #3  |       |
> +           ------------------------------------------
> +           |                   |                    |
> +           |                   |                    |
> +           |                   |                    |
> +           |     BASE          |    LOCAL           |
> +           |                   |                    |
> +           |                   |                    |
> +           |                   |                    |
> +           ------------------------------------------
> +
> +           ------------------------------------------
> +           |  TAB #1  |  TAB #2  | <TAB #3> |       |
> +           ------------------------------------------
> +           |                   |                    |
> +           |                   |                    |
> +           |                   |                    |
> +           |     BASE          |    REMOTE          |
> +           |                   |                    |
> +           |                   |                    |
> +           |                   |                    |
> +           ------------------------------------------
> +
> +  * layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL/BASE/REMOTE),MERGED"
> +
> +    Same as the previous example, but adds a fourth tab with the same
> +    information as the first tab, with a different layout.
> + 
> +           ---------------------------------------------
> +           |  TAB #1  |  TAB #2  |  TAB #3  | <TAB #4> |
> +           ---------------------------------------------
> +           |       LOCAL         |                     |
> +           |---------------------|                     |
> +           |       BASE          |        MERGED       |
> +           |---------------------|                     |
> +           |       REMOTE        |                     |
> +           ---------------------------------------------
> +
> +    Note how in the third tab definition we need to use parenthesis to make ","
> +    have precedence over "/".
> +

This whole section above needs some indentation work to format nicely in Asciidoc/
Asciidoctor. I've fixed it and will send a 'fixup' patch as a reply.

> +Variants
> +^^^^^^^^
> +
> +Instead of `--tool=vimdiff`, you can also use one of these other variants:
> +
> +  * `--tool=gvimdiff`, to open gvim instead of vim.
> +
> +  * `--tool=nvimdiff`, to open nvim (`neovim`) instead of vim.
> +
> +When using these variants, in order to specify a custom layout you will have to
> +set configuration variables `mergetool.gvimdiff.layout` and
> +`mergetool.nvimdiff.layout` instead of `mergetool.vimdiff.layout`
> +
> +In addition, for backwards compatibility with previous git versions,> you can
> +also append `1`, `2` or `3` to either `vimdiff` or any of the variants (ex:
> +`vimdiff3`, `nvimdiff1`, etc...) to use a predefined layout.
> +In other words, using `--tool=[g,n,]vimdiffx` is the same as using
> +`--tool=[g,n,]vimdiff` and setting configuration variable
> +`mergetool.[g,n,]vimdiff.layout` to... 
> +
> +  * x=1 --> "@LOCAL, REMOTE"
> +  * x=2 --> "LOCAL, MERGED, REMOTE"
> +  * x=3 --> "MERGED"

This '-->' arrow also causes trouble with Asciidoc's HTML generator. I've also
fixed it in the patch I'll send as a reply.

> +
> +Example: using `--tool=gvimdiff2` will open `gvim` with three columns (LOCAL,
> +MERGED and REMOTE).
> +
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 542a6a75eb..956c276e1d 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -64,6 +64,12 @@ $(list_tool_variants)"
>  				fi
>  				shown_any=yes
>  				printf "%s%s\n" "$per_line_prefix" "$toolname"
> +
> +				(diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname") |
> +				while read -r line
> +				do
> +					printf "%s\t%s\n" "$per_line_prefix" "$line"
> +				done
>  			fi
>  		done
>  

I've tried the option and it gives something like this:

$ ./bin-wrappers/git mergetool --tool-help
'git mergetool --tool=<tool>' may be set to one of the following:
		emerge
		opendiff
		vimdiff
			Layout can be customized. Run 'git help mergetool' and check the 'BACKEND SPECIFIC HINTS' section.
		vimdiff1
			Layout can be customized. Run 'git help mergetool' and check the 'BACKEND SPECIFIC HINTS' section.
		# etc.

This is OK, but adds a lot of lines to the output. Maybe we could display the help
on the same line ? Something like:

$ ./bin-wrappers/git mergetool --tool-help
'git mergetool --tool=<tool>' may be set to one of the following:
		emerge
		opendiff
		vimdiff		Layout can be customized. Run 'git help mergetool' and check the 'BACKEND SPECIFIC HINTS' section.
		vimdiff1	Layout can be customized. Run 'git help mergetool' and check the 'BACKEND SPECIFIC HINTS' section.
		# etc.

> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index e3f442caf3..0380bff302 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -435,6 +435,12 @@ merge_cmd () {
>  }
>  
>  
> +merge_cmd_help () {
> +	echo "Layout can be customized. Run 'git help mergetool' and check the 'BACKEND SPECIFIC HINTS' section."
> +	return 0
> +}
> +
> +

Maybe a simple "Use Vim. " before "Layout can be customized." would 
be nice, as then other tools whose names in 'git mergetool' are not 
directly related to the executable named could then be listed similarly:

$ ./bin-wrappers/git mergetool --tool-help
'git mergetool --tool=<tool>' may be set to one of the following:
		emerge		Use Emacs' Emerge.
		opendiff	Use FileMerge.
		vimdiff		Use Vim. Layout can be customized. Run 'git help mergetool' and check the 'BACKEND SPECIFIC HINTS' section.
		vimdiff1	Use Vim. Layout can be customized. Run 'git help mergetool' and check the 'BACKEND SPECIFIC HINTS' section.
		# etc.
