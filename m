Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179E5C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 10:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350002AbiBCKIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 05:08:49 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:60630 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238482AbiBCKIs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 05:08:48 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nFZ2k-0004ym-5Y
        for git@vger.kernel.org; Thu, 03 Feb 2022 10:08:46 +0000
Message-ID: <a6eb7dae-f362-6027-0f96-1bb276618e5e@iee.email>
Date:   Thu, 3 Feb 2022 10:08:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] doc: check-ignore: code-quote an exclamation mark
Content-Language: en-GB
To:     Git List <git@vger.kernel.org>
References: <20220203095818.1927-1-philipoakley@iee.email>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20220203095818.1927-1-philipoakley@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oops finger trouble.  Will send V2.

On 03/02/2022 09:58, Philip Oakley wrote:
> The plain quoted exclamation mark renders as italics in the
> Windows pdf help manual.
>
> Fix this with back-tick quoting and surrounding double quotes
> as exemplified by the gitignore.txt guide.
>
> While at it, fix  the surrounding double quotes for the other
> special characters usages.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>
> This formating typo was noticed while investigating gfw issue #3679
>
>  Documentation/git-check-ignore.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> index 0c3924a63d..89c7e7410c 100644
> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -33,7 +33,7 @@ OPTIONS
>  	Instead of printing the paths that are excluded, for each path
>  	that matches an exclude pattern, print the exclude pattern
>  	together with the path.  (Matching an exclude pattern usually
> -	means the path is excluded, but if the pattern begins with '!'
> +	means the path is excluded, but if the pattern begins with "`\`"
Oops !
>  	then it is a negated pattern and matching it means the path is
>  	NOT excluded.)
>  +
> @@ -77,7 +77,7 @@ If `--verbose` is specified, the output is a series of lines of the form:
>  <pathname> is the path of a file being queried, <pattern> is the
>  matching pattern, <source> is the pattern's source file, and <linenum>
>  is the line number of the pattern within that source.  If the pattern
> -contained a `!` prefix or `/` suffix, it will be preserved in the
> +contained a "`!`" prefix or "`/`" suffix, it will be preserved in the
>  output.  <source> will be an absolute path when referring to the file
>  configured by `core.excludesFile`, or relative to the repository root
>  when referring to `.git/info/exclude` or a per-directory exclude file.

