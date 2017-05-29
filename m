Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D64C1FD09
	for <e@80x24.org>; Mon, 29 May 2017 01:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbdE2BDw (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 21:03:52 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33603 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2BDu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 21:03:50 -0400
Received: by mail-pg0-f51.google.com with SMTP id u187so15439830pgb.0
        for <git@vger.kernel.org>; Sun, 28 May 2017 18:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W23U69P+6GEqMH36Bc173l9Cda+Er9LbVVBXESRm1Is=;
        b=tfxEXOHKKCQZsHHCvCc3ACy+lRN7fPZe/BbJ8vipZizI1rLYxPEicNK6Cww2nJdey8
         2TKJx0rKEyC6+gRHZN42a4MkkisNqHCS6Zx/ofivvruhfsEc+94CoyhbVVLHs70wn/ti
         k+bwpBUQBzN1xteo2RcbPqcPrlVtBQB8YfBEQik76JRsHoc2ReiWXSY05B0t+HVVl6Hr
         RoK39BdyiFOEJ1MqcSXC1qNgP2dwoloZPBYi9h2CNK5UYpS9d/kAHHrk7XbP71z5Zbia
         ge4kFIfuVxHk8dcaFgjwoON/45MbRPv0Z2V3V6cjLwBVy06tS3WL/fkrbZDF0VfVWk3z
         gnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W23U69P+6GEqMH36Bc173l9Cda+Er9LbVVBXESRm1Is=;
        b=YLH1wqjbZcaXAtCTlxPwUQMXGGf/U+FxmXs1BcxjohX6W0PO7uaULv3g6a/vnHKic4
         B0j+Jm3zKq8Rv08S2Rrt6O49ITEQPVs0mTnyLzN4N0idT+XtH/fPDO3dAA1WvUZ/MmiX
         WmT/YycNR8nyMohEJmd062Gq8uRd6Ahp5iBetqXxjmXFNCg0wxQdY44ADzZ2ia8bdlYp
         5ZLzs0KPsn1UJA2Nt/6BG/vvi6R3KhONzbw37HiEP0B1DM3XQ+9FhWFlydKiYJnISREh
         +YMjvDg/ck7SQ/pK1aywk9AQN3emsyqdnGHlXOsJy5zWarxloordPe/po7QRKObJCbxZ
         VWUA==
X-Gm-Message-State: AODbwcDzVgHxa1MjHekl9CFfOWgJr8qfOHrJCT6flr2A1fGKwxICX2HB
        GG9675jX968wNL+hleI=
X-Received: by 10.98.73.214 with SMTP id r83mr15023801pfi.12.1496019830137;
        Sun, 28 May 2017 18:03:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id f72sm13616640pfe.62.2017.05.28.18.03.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 18:03:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adrian <forbesa06@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] change 'commands' to comments and improve wording
References: <0102015c4809f8c7-a5cb604c-782d-4a10-87e1-2fe23e9989ba-000000@eu-west-1.amazonses.com>
Date:   Mon, 29 May 2017 10:03:48 +0900
In-Reply-To: <0102015c4809f8c7-a5cb604c-782d-4a10-87e1-2fe23e9989ba-000000@eu-west-1.amazonses.com>
        (Adrian's message of "Sat, 27 May 2017 03:53:52 +0000")
Message-ID: <xmqq8tlga2yz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adrian <forbesa06@gmail.com> writes: (nothing)

Imagine a reader who finds the title of this commit in 3 weeks from
now among 200 other commits.  Do you think the reader can guess that
this is a documentation fix?  Can the reader tell this is about
"stash"?

    Subject: stash doc: write explanation as comments, not as commands

or something, perhaps.  This commit is simple enough that it may not
need the body but explaining why would not hurt.  Perhaps like this:


    In the illustration of workflows in "git stash" documentation,
    where it shows sequence of 'git' commands, there are a few steps
    that are not literal commands (i.e. "here, you would use your
    editor").  Clarify that these are not something the user can
    blindly cut-and-paste by turning them into comments.

would be clear enough.

> ---

And please sign-off (Documentation/SubmittingPatches) your patch.

Thanks.


>  Documentation/git-stash.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 70191d06b69e..3899d36b2bab 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -233,7 +233,7 @@ return to your original branch to make the emergency fix, like this:
>  $ git checkout -b my_wip
>  $ git commit -a -m "WIP"
>  $ git checkout master
> -$ edit emergency fix
> +# ... edit emergency fix ...
>  $ git commit -a -m "Fix in a hurry"
>  $ git checkout my_wip
>  $ git reset --soft HEAD^
> @@ -245,7 +245,7 @@ You can use 'git stash' to simplify the above, like this:
>  ----------------------------------------------------------------
>  # ... hack hack hack ...
>  $ git stash
> -$ edit emergency fix
> +# ... edit emergency fix ...
>  $ git commit -a -m "Fix in a hurry"
>  $ git stash pop
>  # ... continue hacking ...
> @@ -261,11 +261,11 @@ each change before committing:
>  # ... hack hack hack ...
>  $ git add --patch foo            # add just first part to the index
>  $ git stash save --keep-index    # save all other changes to the stash
> -$ edit/build/test first part
> +# ... edit, build and test first part ...
>  $ git commit -m 'First part'     # commit fully tested change
>  $ git stash pop                  # prepare to work on all other changes
>  # ... repeat above five steps until one commit remains ...
> -$ edit/build/test remaining parts
> +# ... edit, build and test remaining parts ...
>  $ git commit foo -m 'Remaining parts'
>  ----------------------------------------------------------------
>  
>
> --
> https://github.com/git/git/pull/361
