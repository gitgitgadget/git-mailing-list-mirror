Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342961F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfIZVmG (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:42:06 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:32641 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfIZVmG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:42:06 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iDbWU-0006WE-8w; Thu, 26 Sep 2019 22:42:03 +0100
Subject: Re: [PATCH v2] doc: MyFirstContribution: fix cmd placement
 instructions
To:     Pedro Sousa <pedroteosousa@gmail.com>, git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, emilyshaffer@google.com,
        gitster@pobox.com, jonathantanmy@google.com
References: <20190919184634.8869-1-pedroteosousa@gmail.com>
 <20190926190522.3424-1-pedroteosousa@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <0a52455d-9859-587e-9c88-bf47676b9b28@iee.email>
Date:   Thu, 26 Sep 2019 22:42:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190926190522.3424-1-pedroteosousa@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/2019 20:05, Pedro Sousa wrote:
> Using the pull command instead of push is more accurate when giving
> instructions on placing the psuh command in alphabetical order.
>
> Signed-off-by: Pedro Sousa <pedroteosousa@gmail.com>
> ---
> Changes since v1: Addressed Philip's comments on making alphabetical
> sort instructions more explicit

LGTM. Thanks.
Philip
>
>   Documentation/MyFirstContribution.txt | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index f867037..5e9b808 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -97,8 +97,8 @@ int cmd_psuh(int argc, const char **argv, const char *prefix)
>   ----
>   
>   We'll also need to add the declaration of psuh; open up `builtin.h`, find the
> -declaration for `cmd_push`, and add a new line for `psuh` immediately before it,
> -in order to keep the declarations sorted:
> +declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
> +in order to keep the declarations alphabetically sorted:
>   
>   ----
>   int cmd_psuh(int argc, const char **argv, const char *prefix);
> @@ -123,7 +123,7 @@ int cmd_psuh(int argc, const char **argv, const char *prefix)
>   }
>   ----
>   
> -Let's try to build it.  Open `Makefile`, find where `builtin/push.o` is added
> +Let's try to build it.  Open `Makefile`, find where `builtin/pull.o` is added
>   to `BUILTIN_OBJS`, and add `builtin/psuh.o` in the same way next to it in
>   alphabetical order. Once you've done so, move to the top-level directory and
>   build simply with `make`. Also add the `DEVELOPER=1` variable to turn on
> @@ -149,7 +149,7 @@ a `cmd_struct` to the `commands[]` array. `struct cmd_struct` takes a string
>   with the command name, a function pointer to the command implementation, and a
>   setup option flag. For now, let's keep mimicking `push`. Find the line where
>   `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing the new
> -line in alphabetical order.
> +line in alphabetical order (immediately before `cmd_pull`).
>   
>   The options are documented in `builtin.h` under "Adding a new built-in." Since
>   we hope to print some data about the user's current workspace context later,
> @@ -167,7 +167,7 @@ Check it out! You've got a command! Nice work! Let's commit this.
>   
>   `git status` reveals modified `Makefile`, `builtin.h`, and `git.c` as well as
>   untracked `builtin/psuh.c` and `git-psuh`. First, let's take care of the binary,
> -which should be ignored. Open `.gitignore` in your editor, find `/git-push`, and
> +which should be ignored. Open `.gitignore` in your editor, find `/git-pull`, and
>   add an entry for your new command in alphabetical order:
>   
>   ----

