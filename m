Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA0B1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 22:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeI2E0x (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:26:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35377 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeI2E0x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:26:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id o16so7843134wrx.2
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=83sSKD7fQwv5oX77aSzA6YLBP2r1DswNcRDokvcBd0w=;
        b=W2fnm40EjxqlVbfDBPfQGxWZ7TbackwpJmka4WdjpMq400tYuN4sBfmjJvU/llivv5
         SKtroAtovfNMznZgBq9VIdH7enql/F/eVKq4sPDz4TeHJ2ZaiOnMm+XzHAMDEOw76XXg
         WskAvi/5NKfv+JfPmRMiAcmn8H11qDd3QdSRVN/vg2pZWZVDi21nvAhq6945wmC5D4g1
         bgeOO7KHA9AragxyZef6d85sckklWZ5v667UR7573vCBoDXWXOxUNtI49mOQG14rQmJK
         i1kaMGJezurxAF+6T8If/sRpUczlRrQ4xw540qALdsGbNkxWgpwhSDNq846Ju6Oxm//1
         8sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=83sSKD7fQwv5oX77aSzA6YLBP2r1DswNcRDokvcBd0w=;
        b=mR28EsM/TatjcABIPnwpQlDWWFSXSXm/0HGBftGsQGY1jLtyYWrdOQHDH+yB4qkON2
         P48zjty7AQnW93k/uAjmHNj45sG2ScrzpStwfh5RWAmQwd9IEtk0oVkzi5xt0y07K2ui
         PSj4ueVZ8ebUUvIHs0aC7S53cE33AnJgPS43XriHfqPINi0XafYyNTrM0TKjWdpttMkS
         EKSu8nQhdNkxdRn7cbOD38x7CyAIoTHINjDqV095MBM+7kDN3M39hK1RbeWZa2Ob2yOD
         Hk1V2L7UKvzuyJXqUC8OBsnWIrXvffy6LJjpa1JJr1mTINkL9WgGdVrfzvtQBN7t7kOe
         xhyQ==
X-Gm-Message-State: ABuFfogMFtvyer+cd7RghuzQSQviwpydDgbODHGNSQAaC4Hn8dhWooaU
        6bpdmjoe2E0npqGNn/0k+Wk=
X-Google-Smtp-Source: ACcGV60kUpt6hlTxhxc+rR4HfKuTVVa7lRMzZJ3fpK1yOWggF59Sx1RyNHNCI3bmJsnDmEeTbXmdvw==
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr370984wra.19.1538172067159;
        Fri, 28 Sep 2018 15:01:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h73-v6sm6721219wma.11.2018.09.28.15.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 15:01:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-rebase.sh: fix typos in error messages
References: <20180928192849.30792-1-ralf.thielow@gmail.com>
Date:   Fri, 28 Sep 2018 15:01:05 -0700
In-Reply-To: <20180928192849.30792-1-ralf.thielow@gmail.com> (Ralf Thielow's
        message of "Fri, 28 Sep 2018 21:28:49 +0200")
Message-ID: <xmqqzhw19t9a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  git-rebase.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This patch itself will soon stop mattering once the group of
rebase-in-c topics graduate, which hopefully will happen during this
cycle.  However, because the same mistakes are inherited to
builtin/rebase.c by these topics, we'd need a matching fix to
correct 07664161 ("builtin rebase: error out on incompatible
option/mode combinations", 2018-08-08) and either squash the fix
into that commit, or queue it on top of pk/rebase-in-c-5-test topic.

Will queue; thanks.

>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 7973447645..45b6ee9c0e 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -553,15 +553,15 @@ then
>  	# Note: incompatibility with --interactive is just a strong warning;
>  	#       git-rebase.txt caveats with "unless you know what you are doing"
>  	test -n "$rebase_merges" &&
> -		die "$(gettext "error: cannot combine '--preserve_merges' with '--rebase-merges'")"
> +		die "$(gettext "error: cannot combine '--preserve-merges' with '--rebase-merges'")"
>  fi
>  
>  if test -n "$rebase_merges"
>  then
>  	test -n "$strategy_opts" &&
> -		die "$(gettext "error: cannot combine '--rebase_merges' with '--strategy-option'")"
> +		die "$(gettext "error: cannot combine '--rebase-merges' with '--strategy-option'")"
>  	test -n "$strategy" &&
> -		die "$(gettext "error: cannot combine '--rebase_merges' with '--strategy'")"
> +		die "$(gettext "error: cannot combine '--rebase-merges' with '--strategy'")"
>  fi
>  
>  if test -z "$rebase_root"
