Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917201F453
	for <e@80x24.org>; Tue, 30 Apr 2019 11:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfD3LPl (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 07:15:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45872 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfD3LPl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 07:15:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so20495210wra.12
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fOMEoMkXn50RBkmUoPY+9lHkqvrVRQlppjhB2l9eHBk=;
        b=oBisz4EH7Lifwp1/BlxtO0OctxYv5x/sw26M2a+yscmBmY9ZJwng1DHxn2pb7TynUY
         yhbtngLr0TUNjotP1OlBbovpfatJb9kvzTsQVl30iAycWVwbWy0MSkh2flHO5P6OrzD/
         AAyve5bBUNU+X7jZkjtzWdNRMQxqV9GrrVvYg8bu+1RPRDkqr2oeiGO+GgibYWEtaejg
         2mdURAah6cKo5vNH7H+UFoSKSDaAnDeA0F5bSTr/IJJRyu+MbwK0a8OFPy78oTHC0P2k
         aGHMSW+tvP4rqiGaiTpKe7qUyvNTy8frrNU+OyQzDzYXrhw/Po+2LvtUussSWi6Sg1p+
         MXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fOMEoMkXn50RBkmUoPY+9lHkqvrVRQlppjhB2l9eHBk=;
        b=UCwl1Rdispbr+T+Seyux2GozD5oh+3+14xRyuAUO1RQDrRIP9tu4TLjscI3KBtjyif
         B5J2gWGsve7QVlWS4CDKnVIrLHFoHjAJwJtYfZ29FxzkHhul/TK0VZz4yiMPD4EnbCb5
         P6pB/8WQprosPHio5lttW599aZgmuMCwkAK9vCaKDqtghKeC5ga8B3Ou5CMxBmdFge4m
         YmdWZ9PBMed3jrHnMbxhqd5OpmlYqoId4BiE/45Ytz3RZjxv2lVIzFhdaIyr4x1rCLkU
         Lx6a6n2HcnXZoQbSrzIf+hnPyHjx9BqWgGb+Vet892CZY246QWzXIL8vIQI6WZ3ujtf/
         dQkQ==
X-Gm-Message-State: APjAAAWSEFItFP4kYBebf0VKxSeb/sjMQiE7WFp6nzFbR8lbjhBIIsHT
        eR9IMXCpWfn/wxguqucqd6hKQva/
X-Google-Smtp-Source: APXvYqx/I2v+XvvXISF1UiE4+o6Z92wdEA3aUdmGITr8kws7adkJYz3H3P0UyhJy7yBu0AEhRxnshA==
X-Received: by 2002:a5d:4805:: with SMTP id l5mr23567870wrq.279.1556622939029;
        Tue, 30 Apr 2019 04:15:39 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id o1sm2625498wmh.47.2019.04.30.04.15.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 04:15:38 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
To:     John Lin <johnlinp@gmail.com>, git@vger.kernel.org
References: <20190430060210.79610-1-johnlinp@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
Date:   Tue, 30 Apr 2019 12:15:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430060210.79610-1-johnlinp@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 30/04/2019 07:02, John Lin wrote:
> When typing "git status", there is an empty line between
> the "Changes not staged for commit:" block and the list
> of changed files.

I'm a bit confused by this as you change a status test below by 
inserting these blank lines into the expected output, implying they are 
not there now. I think maybe the blank line is only shown when status 
prints advice.

> However, when typing "git commit" with
> no files added, there are no empty lines between them.

I have to say looking at the changes to the output I prefer the 
original, the lists are nicely indented so there is no need for a blank 
line to separate the header from the list and having the header 
immediately before the list means the blank line at the end of the block 
makes the extent of the block clear. It also saves screen space which is 
useful for small laptop screens. I can see why one might want a blank 
line to separate the advice and list of changes (though even there the 
indention of the list and advice is different) but for a one line header 
I think it is better to start the list on the next line.

Best Wishes

Phillip

> This patch adds empty lines in the above case and some
> similar cases.
> 
> Signed-off-by: John Lin <johnlinp@gmail.com>
> ---
>   t/t7500-commit-template-squash-signoff.sh |  1 +
>   t/t7508-status.sh                         |  5 +++++
>   t/t7512-status-help.sh                    |  1 +
>   wt-status.c                               | 12 ++++++++----
>   4 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 46a5cd4b73..0423e77d1d 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -345,6 +345,7 @@ cat >expected-template <<EOF
>   #
>   # On branch commit-template-check
>   # Changes to be committed:
> +#
>   #	new file:   commit-template-check
>   #
>   # Untracked files not listed
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index e1f11293e2..949b1dbcc4 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -204,12 +204,15 @@ Your branch and 'upstream' have diverged,
>   and have 1 and 2 different commits each, respectively.
>   
>   Changes to be committed:
> +
>   	new file:   dir2/added
>   
>   Changes not staged for commit:
> +
>   	modified:   dir1/modified
>   
>   Untracked files:
> +
>   	dir1/untracked
>   	dir2/modified
>   	dir2/untracked
> @@ -449,9 +452,11 @@ Your branch and '\''upstream'\'' have diverged,
>   and have 1 and 2 different commits each, respectively.
>   
>   Changes to be committed:
> +
>   	new file:   dir2/added
>   
>   Changes not staged for commit:
> +
>   	modified:   dir1/modified
>   
>   Untracked files not listed
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index 458608cc1e..0a29fa66a2 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -714,6 +714,7 @@ rebase in progress; onto $ONTO
>   You are currently rebasing branch '\''statushints_disabled'\'' on '\''$ONTO'\''.
>   
>   Unmerged paths:
> +
>   	both modified:   main.txt
>   
>   no changes added to commit
> diff --git a/wt-status.c b/wt-status.c
> index 445a36204a..0766e3ee12 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -175,7 +175,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
>   	}
>   
>   	if (!s->hints)
> -		return;
> +		goto conclude;
>   	if (s->whence != FROM_COMMIT)
>   		;
>   	else if (!s->is_initial)
> @@ -193,6 +193,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
>   	} else {
>   		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
>   	}
> +conclude:
>   	status_printf_ln(s, c, "%s", "");
>   }
>   
> @@ -202,13 +203,14 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
>   
>   	status_printf_ln(s, c, _("Changes to be committed:"));
>   	if (!s->hints)
> -		return;
> +		goto conclude;
>   	if (s->whence != FROM_COMMIT)
>   		; /* NEEDSWORK: use "git reset --unresolve"??? */
>   	else if (!s->is_initial)
>   		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
>   	else
>   		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
> +conclude:
>   	status_printf_ln(s, c, "%s", "");
>   }
>   
> @@ -220,7 +222,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
>   
>   	status_printf_ln(s, c, _("Changes not staged for commit:"));
>   	if (!s->hints)
> -		return;
> +		goto conclude;
>   	if (!has_deleted)
>   		status_printf_ln(s, c, _("  (use \"git add <file>...\" to update what will be committed)"));
>   	else
> @@ -228,6 +230,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
>   	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
>   	if (has_dirty_submodules)
>   		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
> +conclude:
>   	status_printf_ln(s, c, "%s", "");
>   }
>   
> @@ -238,8 +241,9 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
>   	const char *c = color(WT_STATUS_HEADER, s);
>   	status_printf_ln(s, c, "%s:", what);
>   	if (!s->hints)
> -		return;
> +		goto conclude;
>   	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
> +conclude:
>   	status_printf_ln(s, c, "%s", "");
>   }
>   
> 
