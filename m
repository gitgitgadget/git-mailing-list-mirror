Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C36CC43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 04:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28C021D43
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 04:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgIIEvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:51:18 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42815 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgIIEvO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 00:51:14 -0400
X-Originating-IP: 103.82.80.62
Received: from localhost (unknown [103.82.80.62])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 32887FF804;
        Wed,  9 Sep 2020 04:51:10 +0000 (UTC)
Date:   Wed, 9 Sep 2020 10:21:08 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] style(git-gui): Fix mixed tabs & spaces; Prefer tabs.
Message-ID: <20200909045108.j5ovnbk35cmghgcz@yadavpratyush.com>
References: <xmqq7dtq7a7w.fsf@gitster.c.googlers.com>
 <20200822222431.35027-1-serg.partizan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822222431.35027-1-serg.partizan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Serg,

Thanks for the patch.

> Subject: [PATCH v2] style(git-gui): Fix mixed tabs & spaces; Prefer tabs.

s/style(git-gui)/git-gui/

On 23/08/20 01:24AM, Serg Tereshchenko wrote:
> Here is cleaned up version of the patch.

A line like this should not be a part of the actual commit message. It 
is some extra commentary for the reviewers. The way you have submitted 
this patch, this line would end up in the commit message. The usual way 
of doing something like this is to use "scissors".

You can add this line:

--- 8< ---

This "scissors" line can tell git-am (when the option --scissors) to 
ignore everything above it. That makes my job a little bit easier when 
applying your patch :-)
 
> Spaces replaced with tabs when possible. In some cases just replacing
> spaces with tabs would break readability, so it was left as it is.
> 
> Signed-off-by: Serg Tereshchenko <serg.partizan@gmail.com>
> ---
>  git-gui.sh | 154 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 77 insertions(+), 77 deletions(-)

Most of the changes here look good to me. One comment below.

> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 49bd86e..847c3c9 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -947,15 +947,15 @@ if {![regsub {^git version } $_git_version {} _git_version]} {
>  }
>  
>  proc get_trimmed_version {s} {
> -    set r {}
> -    foreach x [split $s -._] {
> -        if {[string is integer -strict $x]} {
> -            lappend r $x
> -        } else {
> -            break
> -        }
> -    }
> -    return [join $r .]
> +	set r {}
> +	foreach x [split $s -._] {
> +		if {[string is integer -strict $x]} {
> +			lappend r $x
> +		} else {
> +			break
> +		}
> +	}
> +	return [join $r .]
>  }
>  set _real_git_version $_git_version
>  set _git_version [get_trimmed_version $_git_version]
> @@ -967,7 +967,7 @@ if {![regexp {^[1-9]+(\.[0-9]+)+$} $_git_version]} {
>  		-type yesno \
>  		-default no \
>  		-title "[appname]: warning" \
> -		 -message [mc "Git version cannot be determined.
> +		-message [mc "Git version cannot be determined.
>  
>  %s claims it is version '%s'.
>  
> @@ -1181,44 +1181,44 @@ enable_option transport
>  disable_option bare
>  
>  switch -- $subcommand {
> -browser -
> -blame {
> -	enable_option bare
> -
> -	disable_option multicommit
> -	disable_option branch
> -	disable_option transport
> -}
> -citool {
> -	enable_option singlecommit
> -	enable_option retcode
> -
> -	disable_option multicommit
> -	disable_option branch
> -	disable_option transport
> +	browser -
> +	blame {
> +		enable_option bare
> +
> +		disable_option multicommit
> +		disable_option branch
> +		disable_option transport
> +	}
> +	citool {
> +		enable_option singlecommit
> +		enable_option retcode
> +
> +		disable_option multicommit
> +		disable_option branch
> +		disable_option transport
> +
> +		while {[llength $argv] > 0} {
> +			set a [lindex $argv 0]
> +			switch -- $a {
> +				--amend {
> +					enable_option initialamend
> +				}
> +				--nocommit {
> +					enable_option nocommit
> +					enable_option nocommitmsg
> +				}
> +				--commitmsg {
> +					disable_option nocommitmsg
> +				}
> +				default {
> +					break
> +				}
> +			}
>  
> -	while {[llength $argv] > 0} {
> -		set a [lindex $argv 0]
> -		switch -- $a {
> -		--amend {
> -			enable_option initialamend
> -		}
> -		--nocommit {
> -			enable_option nocommit
> -			enable_option nocommitmsg
> +			set argv [lrange $argv 1 end]
>  		}
> -		--commitmsg {
> -			disable_option nocommitmsg
> -		}
> -		default {
> -			break
> -		}
> -		}
> -
> -		set argv [lrange $argv 1 end]
>  	}
>  }
> -}

I'm not on board with this entire hunk. In many C projects (like Linux, 
Git, etc) the "switch" and the "case" are on the same indent level. I 
can see instances of this in almost every switch-case block in 
git-gui.sh as well. We should stick to the local convention here and 
drop this hunk.

I can make these changes locally and merge them so no need to re-roll... 
unless you have any counter points that is.

-- 
Regards,
Pratyush Yadav
