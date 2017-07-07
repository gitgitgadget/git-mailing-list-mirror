Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 902A22035A
	for <e@80x24.org>; Fri,  7 Jul 2017 18:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbdGGS17 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 14:27:59 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36261 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbdGGS16 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 14:27:58 -0400
Received: by mail-pg0-f66.google.com with SMTP id u36so4939582pgn.3
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SOWOvTgjvZV6elwK71OzL45EZ6kkeXsx2p1cr1OhiqQ=;
        b=O5xO9XcBtHzIkURToJgJ3PdSipGa7Si8mZwRHPvhkt3c3/mY+rKSeRrlb25vV572bH
         0Z7roHQ9/DNILIDDaywa6/n3vewBFXLCqpUDFiYn3Afm4N32WzeI5/AFnQhzyaUpEzKj
         JBb5JK7a62xfRLkUhAi+vpM+SbVTobzoG9F/3psPqEgC8TI3Ub/riZQODHw8aOLyA6D9
         r8qGVnLmYmuT2JT7QkrJT9u/4PeoERnElLNBJxydgR5mdSg/2FHz6ApyakmOCIpRneda
         sjCh+8hRlGCHDGRcCvoPjECflbQDUT8odNp1xNlUNf2MOLvKtpsXouk0Q9172ttQ1g38
         T93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SOWOvTgjvZV6elwK71OzL45EZ6kkeXsx2p1cr1OhiqQ=;
        b=WZg+RfeUySVp3YkThSTejtn826KpuhAloYuxlp5JV0eLjKq8fBppWFrYBI1DF5dBo0
         h0DnGLaYl7wH+7d16Q9Eh4kv8byj3qIJ7CJPWE2pmZwNa2PkPaB4ryLmspSaNAMuEc03
         S9sYb5XKn2zJrEH5RGz1GfV4QMaQSOg5WbKV2Y/ARoTbf48DF5YrhJ6ex6EuLVs/7efi
         psYCKQEIOTniuF3HV+zUjpEPrwgvGNd4N0/AZQN7CRU0N+7hTYGcfU68sdaoe/j6wlZl
         +V+lGlAFfoGxl0y1gR5sI2QaiUI6LoN8/v4IP1ZqegBfb2mfMbgCZIJxoxDMw6Qo5mvq
         oslA==
X-Gm-Message-State: AIVw110TvGYLNKuFHimDhpBUS3nz112AasGQMgZHwEbPzxdlE0WuvlOY
        bHja6Nw03M3Fnw==
X-Received: by 10.101.72.207 with SMTP id o15mr2828665pgs.73.1499452077766;
        Fri, 07 Jul 2017 11:27:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id t78sm8961644pfa.48.2017.07.07.11.27.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 11:27:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] hooks: replace irrelevant hook sample
References: <1499441062.6829.1.camel@gmail.com>
        <20170707160740.9748-1-kaarticsivaraam91196@gmail.com>
Date:   Fri, 07 Jul 2017 11:27:56 -0700
In-Reply-To: <20170707160740.9748-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Fri, 7 Jul 2017 21:37:39 +0530")
Message-ID: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The pre-commit-msg hook sample has an example that comments
> the "Conflicts:" part of the merge commmit. It isn't relevant
> anymore as it's done by default since 261f315b ("merge & sequencer:
> turn "Conflicts:" hint into a comment", 2014-08-28).
>
> Add an alternative example that replaces it. This ensures there's
> at the least a simple example that illustrates what could be done
> using the hook just by enabling it.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  I have made the second patch depend on the first one to avoid
>  conflicts that may occur. Further, it was meaningful to join
>  the two patches as they would go together (or) not at all.

Whether the two samples these patches implement are useful ones or
not, the early part of 2/2 that starts using named variables instead
of positional ones is an improvement.  It makes it easier to see
what is going on.

Patch 2/2 as posted forgets to update some references to $1, $2 and
$3, both in the actual code and also commented out part, e.g.

    sed -e ... "$COMMIT_MSG_FILE" >"$SED_OUTPUT_TEMP" && mv "$SED_OUTPUT_TEMP" "$1"
    # case "$2,$3" in

In the first one, $COMMIT_MSG_FILE and $1 refer to the same thing;
they should be consistent.

If these updates were to be done as multiple patches, the change to
use named not positional variables, without changing anything else,
should come second, I think, after the one that simply removes the
now-useless "Conflicts:" sample from the script, as a preparatory
clean-up step.  You can build other things like hints-removal and
sign-off with interpret-trailers on top of these two steps.

Have you considered using "@PERL_PATH@ -i" instead of "sed" in this
step, by the way?  That would allow you not to worry about the
temporary file left behind (e.g. what happens when somebody else
runs this in a shared repository setting, creating and leaving the
temporary file that you may not be able to write into later because
her umask is tighter, and then you try to make a commit).

Thanks.

>  templates/hooks--prepare-commit-msg.sample | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
> index 86b8f227e..5a638ebda 100755
> --- a/templates/hooks--prepare-commit-msg.sample
> +++ b/templates/hooks--prepare-commit-msg.sample
> @@ -9,8 +9,9 @@
>  #
>  # To enable this hook, rename this file to "prepare-commit-msg".
>  
> -# This hook includes three examples.  The first comments out the
> -# "Conflicts:" part of a merge commit.
> +# This hook includes three examples.  The first one removes three
> +# comment lines starting from the line that has the words
> +# "# Please enter the" in it's beginning.
>  #
>  # The second includes the output of "git diff --name-status -r"
>  # into the message, just before the "git status" output.  It is
> @@ -20,17 +21,16 @@
>  # The third example adds a Signed-off-by line to the message, that can
>  # still be edited.  This is rarely a good idea.
>  
> -case "$2,$3" in
> -  merge,)
> -    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
> +sed -e '/^. Please enter the commit message /,/^#$/d' "$1" >'.sed-output.temp' && mv '.sed-output.temp' "$1"
>  
> +# case "$2,$3" in
>  # ,|template,)
>  #   @PERL_PATH@ -i.bak -pe '
>  #      print "\n" . `git diff --cached --name-status -r`
>  #	 if /^#/ && $first++ == 0' "$1" ;;
> -
> -  *) ;;
> -esac
> +#
> +#  *) ;;
> +# esac
>  
>  # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
>  # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
