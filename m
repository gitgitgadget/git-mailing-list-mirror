From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Use the word 'stuck' instead of 'sticked'
Date: Thu, 31 Oct 2013 12:35:33 -0700
Message-ID: <xmqqbo255j3u.fsf@gitster.dls.corp.google.com>
References: <xmqq1u39j9hw.fsf@gitster.dls.corp.google.com>
	<1383217709-5518-1-git-send-email-boklm@mars-attacks.org>
	<1383217709-5518-2-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:35:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vby1w-0007l7-LJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963Ab3JaTfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:35:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922Ab3JaTfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:35:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECFFC4D891;
	Thu, 31 Oct 2013 15:35:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T62Git3bL4atdgQEtRSRQg2KGY0=; b=HKjSDB
	acsrqqkF99tHZxooZRlgACpnG58okKcSuwTK+UEOq6VB+Kbk8BzRGsoJe0EC0DRd
	9eWTiFCyWKhtzcwSy//gHIi7K9xyb6OFeLf5WuO0R57G9HBPfK7nRNf6r2QAdrnu
	8XEF4JVOJ2Jo6cg+Wr+YQMxm7gbfvJ1+Q1+D0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C94aH6FZ6eEX1/vuALxLxBH6Qo0ZI9id
	2FPxRcXxVTY+cBsnEhfowN8Pz5mDJUdzBwR/yzH+NEPUZ1X92emzJypyVOliwNO0
	CtN8bonwyrlqG9MudtFU3Mjl1WWh5t2jl0kZU226f5f/TWIiWzRWlCyg9nJvCTFD
	nVxhvFJ1cv0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCC344D890;
	Thu, 31 Oct 2013 15:35:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2272B4D88A;
	Thu, 31 Oct 2013 15:35:37 -0400 (EDT)
In-Reply-To: <1383217709-5518-2-git-send-email-boklm@mars-attacks.org>
	(Nicolas Vigier's message of "Thu, 31 Oct 2013 12:08:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9E03D53A-4263-11E3-99FE-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237166>

Nicolas Vigier <boklm@mars-attacks.org> writes:

> The past participle of 'stick' is 'stuck'.
>
> Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
> ---

Thanks.

It was good that we caught this before introducing the option; the
documentation update does not hurt the users much, but if we unleash
a misspelled option in a release, it is much harder to correct it
later.

Will queue both patches.

>  Documentation/gitcli.txt                      | 6 +++---
>  Documentation/technical/api-parse-options.txt | 6 +++---
>  diff.c                                        | 2 +-
>  diff.h                                        | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> index 3146413cce0d..c87f0ae88d6c 100644
> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -72,11 +72,11 @@ scripting Git:
>   * splitting short options to separate words (prefer `git foo -a -b`
>     to `git foo -ab`, the latter may not even work).
>  
> - * when a command line option takes an argument, use the 'sticked' form.  In
> + * when a command line option takes an argument, use the 'stuck' form.  In
>     other words, write `git foo -oArg` instead of `git foo -o Arg` for short
>     options, and `git foo --long-opt=Arg` instead of `git foo --long-opt Arg`
>     for long options.  An option that takes optional option-argument must be
> -   written in the 'sticked' form.
> +   written in the 'stuck' form.
>  
>   * when you give a revision parameter to a command, make sure the parameter is
>     not ambiguous with a name of a file in the work tree.  E.g. do not write
> @@ -165,7 +165,7 @@ $ git foo -o Arg
>  ----------------------------
>  
>  However, this is *NOT* allowed for switches with an optional value, where the
> -'sticked' form must be used:
> +'stuck' form must be used:
>  ----------------------------
>  $ git describe --abbrev HEAD     # correct
>  $ git describe --abbrev=10 HEAD  # correct
> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> index 0be2b5159f1b..be50cf4de35c 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -29,9 +29,9 @@ that allow to change the behavior of a command.
>  
>  The parse-options API allows:
>  
> -* 'sticked' and 'separate form' of options with arguments.
> -  `-oArg` is sticked, `-o Arg` is separate form.
> -  `--option=Arg` is sticked, `--option Arg` is separate form.
> +* 'stuck' and 'separate form' of options with arguments.
> +  `-oArg` is stuck, `-o Arg` is separate form.
> +  `--option=Arg` is stuck, `--option Arg` is separate form.
>  
>  * Long options may be 'abbreviated', as long as the abbreviation
>    is unambiguous.
> diff --git a/diff.c b/diff.c
> index e34bf971207f..3950e0191067 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3394,7 +3394,7 @@ int parse_long_opt(const char *opt, const char **argv,
>  	if (prefixcmp(arg, opt))
>  		return 0;
>  	arg += strlen(opt);
> -	if (*arg == '=') { /* sticked form: --option=value */
> +	if (*arg == '=') { /* stuck form: --option=value */
>  		*optarg = arg + 1;
>  		return 1;
>  	}
> diff --git a/diff.h b/diff.h
> index e34232501ee8..1c05b3a6bec6 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -244,7 +244,7 @@ extern struct diff_filepair *diff_unmerge(struct diff_options *, const char *pat
>  #define DIFF_SETUP_USE_SIZE_CACHE	4
>  
>  /*
> - * Poor man's alternative to parse-option, to allow both sticked form
> + * Poor man's alternative to parse-option, to allow both stuck form
>   * (--option=value) and separate form (--option value).
>   */
>  extern int parse_long_opt(const char *opt, const char **argv,
