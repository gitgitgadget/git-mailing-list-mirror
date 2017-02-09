Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739EA1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 23:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbdBIXdm (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 18:33:42 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34931 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdBIXdk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 18:33:40 -0500
Received: by mail-pg0-f65.google.com with SMTP id 204so1470752pge.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 15:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+u+x78QrLRatT/vNvTof84Cpbo63ys1g6tKQUqeQ19A=;
        b=mGGaGEmC98yri12EXYxhBLDX2Tw0je5yluRnvTkh+PfouNBZB+Zd8NLYkVPJCTJXJF
         NrCH968qHOYFa8pLF3tL6s0M7FA1Kz/jDRrHAtvYyhp1TEXTMNuWKLjQxBvAaEfq1YBv
         v5yVogzcoF7CdbS1mX0miKO3MolewT4IB5yf4DU7CzPx+5ly2Np5vV4S0vo0GNz75AIQ
         qdK35bKqAYwgf0jlTMfWVfeesGBFLfcMS+CB0lN3v0gqUTmH6B6YJQQ/6cyYtRTG6UnY
         HTFQ2VrQcHEfKWcISN696fl/MpBNBT9sXPNB2xBJkwfzi0TuiAE3tOtRbSyZpTNGnlrZ
         IkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+u+x78QrLRatT/vNvTof84Cpbo63ys1g6tKQUqeQ19A=;
        b=FgSvSIt7OdsXg42vMV94nXmd5eJtlofKcVkvbAx6mojqU+gr19evcUavZ7wzicqRZj
         R89bG7OXUveW1VJjcSujDb//PrnbJqyngnJi0X5W2Yf0vQAsSEKpJnGBPYm3gdwN85Ju
         Io0RgCcnicrSqCpB+aNAkJY1EJ1+pH6vojlWhRQTuwyYRpnUTxMzYniUIFVYPOFvEbre
         KJX0eri9ZKUDI27zCE9AE9G4Z3/s9iNsJ7jcMOpJMxhmAcMGYY7PK28SC/nuuDnU3Srq
         tzaxqzf8hfwwiah9noGOO1x4knzDlNZetCyS4Zwfm1lnlKPDI64pUVKZnKeEqyggHAP2
         D4gQ==
X-Gm-Message-State: AMke39mQ9WK0LGeauW3EtT3hV9QlLyZT8unZfkKpt8JdyATwd/ofT/gVh4mmkQ0qEFmpGw==
X-Received: by 10.84.130.66 with SMTP id 60mr7415110plc.170.1486683170616;
        Thu, 09 Feb 2017 15:32:50 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id n28sm31783171pgd.5.2017.02.09.15.32.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 15:32:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     unlisted-recipients:; (no To-header on input) git@vger.kernel.org,
        bmwill@google.com
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)git@vger.kernel.org
                                                                     ^-missing end of address
Subject: Re: [RFC-PATCHv2] submodules: add a background story
References: <20170209020855.23486-1-sbeller@google.com>
Date:   Thu, 09 Feb 2017 15:32:48 -0800
In-Reply-To: <20170209020855.23486-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 8 Feb 2017 18:08:55 -0800")
Message-ID: <xmqqo9yblz33.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Just like gitmodules(5), gitattributes(5), gitcredentials(7),
> gitnamespaces(7), gittutorial(7), we'd like to provide some background
> on submodules, which is not specific to the `submodule` command, but
> elaborates on the background and its intended usage.
>
> Add gitsubmodules(7), that explains the states, structure and usage of
> submodules.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> This would replace the last patch of  sb/submodule-doc, though it's still
> RFC. In this revision I took care of the technical details (i.e. proper
> formatting, spelling), and only slight rewording of the text.
>
> The main issue persists; see bottom of the patch:
>
>   SAMPLE WORKFLOWS (RFC/TODO)
>   ---------------------------
>   
>   Do we need
>   
>   * an opinionated way to check for a specific state of a submodule
>   * (submodule helper to be plumbing?)
>   * expose the design mistake of having the (name->path) mapping inside the
>     working tree, i.e. never remove a name from the submodule config even when
>     the submodule doesn't exist any more.

I am not sure about the last item.  

Are you talking about a case where submodule comes and goes (think:
"git checkout v1.0" that would make submodules added since that
version disappar)?  .gitmodules that is checked out would not have
any entry, but .git/config needs to record the end-user preference
for the module, so that the user can do "git checkout -" to come
back, no?  IOW .git/config that mentions all the submodule the user
ever showed interests in is not a design mistake, so you must be
talking about something else, but I do not know what it is.

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 4a4cede144..d38aa2d53a 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -24,37 +24,7 @@ DESCRIPTION
>  -----------
>  Inspects, updates and manages submodules.
>  
> -A submodule allows you to keep another Git repository in a subdirectory
> ...
> -if you choose to go that route.
> +For more information about submodules, see linkgit:gitsubmodules[5]

OK.

> @@ -420,6 +390,10 @@ This file should be formatted in the same way as `$GIT_DIR/config`. The key
>  to each submodule url is "submodule.$name.url".  See linkgit:gitmodules[5]
>  for details.
>  
> +SEE ALSO
> +--------
> +linkgit:gitsubmodules[1], linkgit:gitmodules[1].

Are they both in section (1)?  I think the former (concepts) belongs
to section 7 and the latter (file formats) belongs to section 5.

> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
> new file mode 100644
> index 0000000000..3369d55ae9
> --- /dev/null
> +++ b/Documentation/gitsubmodules.txt
> @@ -0,0 +1,194 @@
> +gitsubmodules(7)
> +================
> +
> +NAME
> +----
> +gitsubmodules - information about submodules
> +
> +SYNOPSIS
> +--------
> +$GIT_DIR/config, .gitmodules
> +
> +------------------
> +git submodule
> +------------------
> +
> +DESCRIPTION
> +-----------
> +
> +A submodule allows you to keep another Git repository in a subdirectory
> +...
> +When cloning or pulling a repository containing submodules however,
> +the submodules will not be checked out by default; You need to instruct
> +'clone' to recurse into submodules. The 'init' and 'update' subcommands

I think this is not "You need to", but rather "You can, if you want
to have each and every submodules."

> +of 'git submodule' will maintain submodules checked out and at an
> +appropriate revision in your working tree.
> +
> +WHEN TO USE
> +-----------
> +
> +Submodules, repositories inside other repositories,
> +can be used for different use cases:
> +
> +* To have finer grained access control.
> +  The design principles of Git do not allow for partial repositories to be
> +  checked out or transferred. A repository is the smallest unit that a user
> +  can be given access to. Submodules are separate repositories, such that
> +  you can restrict access to parts of your project via the use of submodules.
> +
> +* To decouple Git histories.
> +  Decoupling histories has different benefits.
> +
> +** When you want to use a (third party) library tied to a specific version.
> +   Using submodules for a library allows you to have a clean history for
> +   your own project and only updating the library in the submodule when needed.

I somehow do not see this as decoupling; it is keeping what is
originally separate separate, isn't it?

> +** In its current form Git scales up poorly for very large repositories that
> +   change a lot, as the history grows very large. For that you may want to look
> +   at shallow clone, sparse checkout or git-lfs.
> +   However you can also use submodules to e.g. hold large binary assets
> +   and these repositories are then shallowly cloned such that you do not
> +   have a large history locally.

In other words, a better way to list these may be 

 1. using another project that stands on its own.

 2. artificially split a (logically single) project into multiple
    repositories and tying them back together.

The access control and performance reasons are subclasses of 2.
IOW, if Git had per-path ACL and infinite scaling, you wouldn't be
splitting your project into submodules for 2.  You would still want
to use somebody else's project by binding it as a subproject, instead
of merging its history into yours.

> +When working with submodules, you can think of them as in a state machine.
> +So each submodule can be in a different state, the following indicators are used:
> +
> +* the existence of the setting of 'submodule.<name>.url' in the
> +  superprojects configuration
> +* the existence of the submodules working tree within the
> +  working tree of the superproject
> +* the existence of the submodules git directory within the superprojects
> +  git directory at $GIT_DIR/modules/<name> or within the submodules working
> +  tree
> +
> +      State      URL config        working tree     git dir
> +      -----------------------------------------------------
> +      uninitialized    no               no           no
> +      initialized     yes               no           no
> +      populated       yes              yes          yes
> +      depopulated     yes               no          yes
> +      deinitialized    no               no          yes
> +      uninteresting    no              yes          yes
> +
> +      invalid          no              yes           no
> +      invalid         yes              yes           no

I do not have strong opinions on these labels; are submodule folks
happy with the above vocabulary?

"uninteresting" is not explained in the below?

> ...
> +SEE ALSO
> +--------
> +linkgit:git-submodule[1], linkgit:gitmodules[1].

Ditto.
