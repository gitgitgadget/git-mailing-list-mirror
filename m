Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A030B1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 15:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbdLLPUP (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 10:20:15 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35220 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbdLLPUO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 10:20:14 -0500
Received: by mail-qt0-f171.google.com with SMTP id u10so48113728qtg.2
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 07:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dHga8agfqRyKnrbJkYb74Fz6R4bkkQGCuz/v4hxIRKo=;
        b=d8vhJJomAptBOWNFg49KER9Nd80zewYgYwYoL7DyIHnUPVxu+XugVIVa5uja9ttgdk
         ZGjahjHXuaJrYeMDp6WKRgcWIPZXVUaJpbL2/ZRoS7q9rxX2r84ZM6mROurn0JzXr9ic
         aua9nVtfmG3nGIFrBF7i6WVPXQH1t6X8hR7u0FUN94SvIGRzMngUQGGokUaoq29vLI5X
         oVeeAT6dRctbzUcktP/wZfiAfltGMNC/JdMbmKXggPc+MMg6QT0HiLx/YCgeFc1U4o4j
         f6sFD7dc8WlRpehO7aE6leRQjdMIJk8a0fu2cnLuf+cIe/jUhDHePF1APnrZUsYoPF3Z
         QXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dHga8agfqRyKnrbJkYb74Fz6R4bkkQGCuz/v4hxIRKo=;
        b=WHCO/5i5sLTTkrRDb+rOtSsRcyt5S26qYETHTTA7PWowEVGz5AEiKUs2xgDN4wCryz
         0aZxH+Ir6XSY8dA5s/ua2aHg6rJ7vYr89rK5RhIplQO5TeCNtR0R/oadFC/GdAR1UavF
         dRYRwGB9zYQqBXYgIUGqJJvDsl+4Nnil2uV7warTTW9QL/Wo2CqcanTHl9OgQGeu8OGo
         zPSGZmUibKLdK7KF3+SQjOQxQ549Lr+/RuHAwqI3Ik9dhgT+VgJO3QwsAxqPG6JKsQWH
         H8AzleXNfK4zFwawxaYF/fg+Y7v229gA3KXj8UaTBIUtTZg3Kn0RqKcbprWYm47yHYlx
         VBYQ==
X-Gm-Message-State: AKGB3mIFFlRHFuuUM6MwY5PZmxSmubYoxEmY8xeaQW10yT6C0O+usPvT
        64P2CH4qhR11zrVAWK9H8oQ=
X-Google-Smtp-Source: ACJfBousUGBiT4Hj/bxQHA37NtyjMGC6SxXIRaXsjn8qb5yMRjmKXhUtJyBvc6qALHf6RbRyhY/fKg==
X-Received: by 10.55.222.23 with SMTP id h23mr1853503qkj.225.1513092013580;
        Tue, 12 Dec 2017 07:20:13 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id b65sm7034840qkb.45.2017.12.12.07.20.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 07:20:12 -0800 (PST)
Date:   Tue, 12 Dec 2017 10:20:09 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: clarify usage of XDG_CONFIG_HOME config file
Message-ID: <20171212152009.GS3693@zaya.teonanacatl.net>
References: <1513077862-165-1-git-send-email-jacob.keller@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513077862-165-1-git-send-email-jacob.keller@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

Jacob Keller wrote:
> The documentation for git config and how it reads the user specific
> configuration file is misleading. In some places it implies that
> $XDG_CONFIG_HOME/git/config will always be read. In others, it implies
> that only one of ~/.gitconfig and $XDG_CONFIG_HOME/git/config will be
> read.
> 
> Improve the documentation explaining how the various configuration files
> are read, and combined.
> 
> Instead of referencing each file individually, reference each type of
> location git will check. When discussing the user configuration, explain
> how we switch between one of three choices. Ensure to note that only one
> of the three choices is used.

Perhaps it would read a little easier as "Make it clear ..."
rather than "Ensure to note that ..." ?

> +Note that git will only ever use one of these files as the global user
> +configuration file at once. Additionally if you sometimes use an older version
> +of git, it is best to only rely on `~/.gitconfig` as support for the others was
> +added fairly recently.

Is it really accurate to say these were added fairly
recently?  It looks like XDG_CONFIG_HOME was added in
21cf322791 ("config: read (but not write) from
$XDG_CONFIG_HOME/git/config file", 2012-06-22) and
0e8593dc5b ("config: write to $XDG_CONFIG_HOME/git/config
file when appropriate", 2012-06-22) which are in 1.7.12.

Would it be better to say something like "if you sometimes
use a version of git prior to 1.7.12" here?

Or maybe we can drop "Additionally ..." altogether now?
Someone using a 5 year old git version sometimes will
hopefully know to check the documentation for that older
version.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Now don't say you can't swear off drinking; it's easy. I've done it a
thousand times.
    -- W.C. Fields

