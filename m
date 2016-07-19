Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F268F1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 14:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbcGSOOx (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 10:14:53 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35117 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708AbcGSOOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 10:14:52 -0400
Received: by mail-qk0-f181.google.com with SMTP id s63so16741763qkb.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 07:14:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GBQc7g8cP+cnBzCRD3AaPpzhHRrSEiVr4+ugygrWJOg=;
        b=DDA6/GTdEF72EO6uDZRkWPXqIUDTaZNi6GYK/vfZHCvxXHrRx5zaW3wE4scuuQBY5S
         o3uN1kZi9icH27UN87F62tHM+vjXQLaoEv89a8KKN5pzR+6emKyKIzTxW8tWYS+SLG9a
         Y3gSIiNWsYELDvvcb7FjtfM9FzcwOnawCx4+gK7kdXNxLuEo6DwsjhVrNtu19mpoF0SP
         fm2Zq3IRZdL5lpK+hcipTi/zQs6d3G05ld8lH9ehM+GIE2OTII5LUsuua1qPyLObkqNm
         3rEV797/VVeoNvu5Nmx/2s+kjUFFZKId1o95xuj9iDf6DnvFLMrh54wwTlKmCt7SSend
         01Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GBQc7g8cP+cnBzCRD3AaPpzhHRrSEiVr4+ugygrWJOg=;
        b=RqszEH/jDpgZmupCl+fRaVTAOniMzWEMewhUvHSV9cy4Wqga8eJcsyNveJW4QTXZUC
         OLn/J+a8lQOjSGrpeAuZWYBaCAm+GiN0SLWbO3ATqPyjUEwTtsPOL0EpUL9cxyOyyLiJ
         WgcEjmH6aOykfLgTKitOXsPzo3dBbjIZMKBEDe2mG6RUUQMjosp9e2cQiMQCGjSjmcB2
         vEzY2UYmI+hVLwKX79bZnhoslnLjvbZYVjad51w8SBI4BUAlkVwaxVrqir4kbqTKWbmL
         hK+MwMg5acMPn6LD+N4nYA8H6YTHJmvO2Ehg6bYJjXiNC+nuezdqiYLe07NY6702mGz5
         3R5Q==
X-Gm-Message-State: ALyK8tLQYhYzmFZBXlsRu9YFdEA2nknQ9zBsOZA1pt1KzqYSaUJEpYci5sRAkkWgad4Bl1X40tSAH8mSlGJABw==
X-Received: by 10.55.154.11 with SMTP id c11mr55727541qke.117.1468937691024;
 Tue, 19 Jul 2016 07:14:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.45.249 with HTTP; Tue, 19 Jul 2016 07:14:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607191323010.3472@virtualbox>
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
 <alpine.DEB.2.20.1607191323010.3472@virtualbox>
From:	Richard Soderberg <rsoderberg@gmail.com>
Date:	Tue, 19 Jul 2016 07:14:50 -0700
Message-ID: <CAEvc1UT_gmkmOjhs8PMH+vBRE1gku5yYRPhPfOL_B_vyeh23_g@mail.gmail.com>
Subject: Re: git-prompt.sh incompatible with non-basic global grep.patternType
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Aha! Yes, this works precisely as intended: the prompt works
correctly, and quickly, with this change in place.

 - R.

On Tue, Jul 19, 2016 at 4:24 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Richard,
>
> On Mon, 18 Jul 2016, Richard Soderberg wrote:
>
>> Hi, I wanted to report something interesting that I found while tracing
>> a severe slowdown in git-prompt.sh.
>>
>> https://github.com/git/git/commit/6d158cba282f22fa1548af1188f78042fed30aed#diff-f37c4f4a898819f0ca4b5ff69e81d4d9R141
>>
>> Way back in this commit, someone added a useful chunk of code that works
>> perfectly with svn+ssh:// URLs under basic regexes:
>>
>> + local svn_upstream=($(git log --first-parent -1 \ +
>> --grep="^git-svn-id: \(${svn_url_pattern:2}\)" 2>/dev/null))
>>
>> However, if I switch over to Perl regexes (or Extended):
>>
>> git config --global grep.patternType perl
>>
>> Then the command runs for one wall clock second and shows incorrect
>> results on my repository. I eventually traced this to an issue with the
>> regular expression provided, assuming the svn repository url is
>> "svn+ssh://...":
>>
>> git log ... --grep="^git-svn-id: \(svn+ssh://...\)" 2>/dev/null
>>
>> The + sign isn't escaped in git-prompt.sh, which under non-basic regexes
>> causes the match to fail entirely.
>>
>>  - R.
>>
>> ps. git log --basic-regexp does not fix the issue, as for unknown
>> reasons (I'll start another thread) the command-line option doesn't
>> override grep.patternType.
>
> Maybe this helps?
>
> -- snipsnap --
> diff --git a/contrib/completion/git-prompt.sh
> b/contrib/completion/git-prompt.sh
> index 97eacd7..74be907 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -143,7 +143,7 @@ __git_ps1_show_upstream ()
>                 # get the upstream from the "git-svn-id: ..." in a commit
>                 # message
>                 # (git-svn uses essentially the same procedure internally)
>                 local -a svn_upstream
> -               svn_upstream=($(git log --first-parent -1 \
> +               svn_upstream=($(git -c grep.patternType=default log --first-parent -1 \
>                                         --grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
>                 if [[ 0 -ne ${#svn_upstream[@]} ]]; then
>                         svn_upstream=${svn_upstream[${#svn_upstream[@]} - 2]}
>
