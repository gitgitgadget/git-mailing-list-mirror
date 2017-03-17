Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4ED720951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbdCQX3K (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:29:10 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35419 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdCQX3K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:29:10 -0400
Received: by mail-pf0-f174.google.com with SMTP id x63so38071483pfx.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2ymkGytZjN9SV+tkdT3BQt9b7oB/UWPZ5rFNbl/HDg0=;
        b=ggdOnct3tqX2YGRcWgEe5qmy3yXNnknYOfb3Wz/5X+KbhNPkKfB/e+ba0SNr3kxSQg
         cx61B1d3BfXYCZwPVlX/r/8UPRVwjDisNJggCe9crPq/IH4EDEjQ1m6eeNdY2O0gYhpu
         TA/8/Wrej/1/6B5T17hyg6vsXNofJVq/MzYzKdzqpLUEe1r6iE3IX52x9jCKYzVfLfSs
         bHZJs5hSgjo4uiQoNp4HTdiIy9gGuNiWKRbOhZXr2ZKhNHQYHCcgk28YLNc4ueU3GXl5
         8cEp03tkxRiyy4jqhCmE2dO5ANZG8Fdd0nXmYZ+lMHs+uoO6kSdakWhPwBnJDlw6QdWa
         ReTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2ymkGytZjN9SV+tkdT3BQt9b7oB/UWPZ5rFNbl/HDg0=;
        b=PTkeBslQcpkw3Atcerj+57Eml9a1xR4jZ6dOxhr058He3D0ueTu4wiLxLG3ITEc2Tw
         7f2wK6mSJfMQM7E4Av1tPZcs2QscyTsGIYH/79QydK9/Q3+VIoIlOneswfYcTuIiF9l6
         PU08ZcAO7LkUPFNVxrE//8aw3m0A0SKo098WDxYz0l3F98ad8CBLgs5ojMo6gkGSdPaj
         HfwxJhZTV9I68jdAXs9OyPQXz+0U61penvfCyksD28cbRpB+QjE2k+tqXaY7wXa6VHs1
         n/q56d69lWGGHe88c6bDRpRRFZ1MjARi9Z02rQk/mDTKzv721phzIp2rjj63VI/ZZrOM
         8GeQ==
X-Gm-Message-State: AFeK/H1x55L3TpxvHYYAJ5f0gqsMH1NkLoX0QxjwSLQydyx5eW/DjQ6/G+WainV43zPKauzbsDxrZhJjDoxTqA4c
X-Received: by 10.84.172.193 with SMTP id n59mr23007843plb.63.1489791850094;
 Fri, 17 Mar 2017 16:04:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 17 Mar 2017 16:04:09 -0700 (PDT)
In-Reply-To: <20170317225532.GR26789@aiede.mtv.corp.google.com>
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
 <20170317225110.13417-1-sbeller@google.com> <20170317225532.GR26789@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Mar 2017 16:04:09 -0700
Message-ID: <CAGZ79kaL=mHsqURqrnUMav8W=Hr960PHw6WDoBncVZA4AjmsJA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on
 the file system
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 3:55 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> If I recall correctly, "worktree" is the feature/command, and
>> "working tree" is an instance in the file system, even when you only
>> have one working tree.
>
> I'm not sure I agree with this distinction.  "worktree" is just a
> short name for "working tree".
>
> Unfortunately gitglossary(7) doesn't make this clear at all --- it
> uses the term worktree a few times (and appears to mean "working tree"
> when it does --- e.g.
>
>         Pathspecs are used on the command line of [...] and many other
>         commands to limit the scope of operations to some subset of
>         the tree or worktree.
>
> ) but never defines it.
>

So maybe it's time to look for volunteers for a cleanup patch. ;)
I tried finding the discussion on worktree vs "working tree"
and did not succeed. :/

Maybe Duy has a better memory there.

Thanks,
Stefan
