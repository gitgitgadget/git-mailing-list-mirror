Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887E41F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 23:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeJOHIG (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:08:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38407 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOHIG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 03:08:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id a13-v6so19157944wrt.5
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 16:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EOX+xCvfOriIsjKg9aBbzcl8pfo+sVVDjU+jqmqLJfg=;
        b=fI0K3WjTrhCXp4tVLLgnR0Hhy0NBbes6wkz8orVMDw90SKky1zq+/mriIDz3uCzMDD
         1uzMx30aBRSTX0rBEgs3/AJlzJCq0lxo+bPbaw5QoRRmBMmNngWX1iLqyc1T27XozH6u
         hkY8y7OGXWJGcD+UnqQxhqMYKbH+l0OnJ2P5gzX0qmfnFPftdLr1uyIRdlfSfgss6l/v
         ye3NsKvW2n5KEsNVGpSeu+GrZSjvGpuHEwsyI1fMIAmvciUHog5pQXhre9vVc1yYqR2Z
         SKPb7t2yrO2VmfbpglUZK5ezWdwynRrKTY7nxG7WlX52QJDWPm1OM+mF5i7sUIjGYw4h
         FmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EOX+xCvfOriIsjKg9aBbzcl8pfo+sVVDjU+jqmqLJfg=;
        b=icvQU1FyP9kWam+tHeoSptuONhquzfw+lMsoDmGZEXlPFdtx/WyQJGTqLah0IjTzb/
         AyFC7leo23yyEZNvTqIir2/Sx7E4CQn+SNKe+b6Kvt0gSRaDfAQFDbMjHwPJ6TCLqWFE
         ljsaoDlyP0ZPAyBMuXk8YAZs+qLXxes3A6NaPamhhbQ9Gpbqyo6iOqrEtsEvTeCldY9G
         3x1OgWqienG5BT/7ahxolxl4AQ9TbkfPRWhtmee1ADBOVTLBPblOOxACtVGMQxm4Yjcd
         0LrmVa2GVa2DVP7AVxh5jbu79oJ0amdxJo1Jst+BJzhmIFZ/bcWk20v5DZOvsET9g0if
         LC7w==
X-Gm-Message-State: ABuFfojYyKAABlQKKg4cPQRZWvYOZOrZYCWQdZwFnoWWHrmKAGBmq8fo
        ybJlWMVgO3XKqE+zl7jI/v4=
X-Google-Smtp-Source: ACcGV61G8cv4q6/SAQHQycrN2NY/du4dtAADZnAsTFxNRkrQGXBNzv9yUHacAa8inKTodGHkZbvGbw==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr12945125wrh.72.1539559527059;
        Sun, 14 Oct 2018 16:25:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w11-v6sm15611055wrn.65.2018.10.14.16.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 16:25:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [RFC PATCH 2/3] Documentation/git-rev-list: s/<commit>/<object>/
References: <cover.1539298957.git.matvore@google.com>
        <a1ddae16bae563dd904555661e2e916536f388d8.1539298957.git.matvore@google.com>
Date:   Mon, 15 Oct 2018 08:25:25 +0900
In-Reply-To: <a1ddae16bae563dd904555661e2e916536f388d8.1539298957.git.matvore@google.com>
        (Matthew DeVore's message of "Thu, 11 Oct 2018 16:09:01 -0700")
Message-ID: <xmqq4ldo861m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> -List commits that are reachable by following the `parent` links from the
> -given commit(s), but exclude commits that are reachable from the one(s)
> -given with a '{caret}' in front of them.  The output is given in reverse
> -chronological order by default.
> +List objects that are reachable by following references from the given
> +object(s), but exclude objects that are reachable from the one(s) given
> +with a '{caret}' in front of them.
>  
> +By default, only commit objects are shown, and the commits are shown in
> +reverse chronological order. The '--object' flag causes non-commit objects
> +to also be shown.
>
> +You can think of this as a set operation.  Objects given on the command
> +line form a set of objects that are reachable from any of them, and then
> +objects reachable from any of the ones given with '{caret}' in front are
> +subtracted from that set.  The remaining objects are what come out in the
>  command's output.  Various other options and paths parameters can be used
>  to further limit the result.

I am not sure if this is a good rewrite.  It gives a false
impression as if you'd not see anything if I did this:

	git rev-list --objects ^master md/filter-trees:t/valgrind

especially if you change the SYNOPSIS and make it claim that the
command takes <object> as starting point.  Updating <commit> to
<object> for those that are _shown_ is OK, but the s/commit/object/
for those that are given as the starting points is not a good change
at all, if I understand what the code is designed to do correctly.

It is more like "this is a set operation across commits.  We also
show objects that are reachable from the commits in the resulting
set and are not reachable from the commits in the set that were
excluded when --objects option is given".

