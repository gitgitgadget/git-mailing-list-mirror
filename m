Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1B91F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 21:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfANVi4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 16:38:56 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:33060 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfANVi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 16:38:56 -0500
Received: by mail-pg1-f181.google.com with SMTP id z11so239237pgu.0
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 13:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7gtxuaLG4UDLPzN4ZBz/We/1BJFK+SkO0Q8aoPDnYTI=;
        b=XdWxawDROWc/XzYVSaSShm53WmjAcicWi2mdnkSSj9BZNvfn8capoXXbE6FK5dARZ9
         otzbvalt7GGFm7LwgZR7wqt5mr4V3HCulQ1tKreQ0rmC73hE1Q6e4FwI0eKfiCW2+t0Z
         7QtQ2H99uL4e5CrGY5SuS8t7rcVZxS1J5NN74B1sWD71Mh3A9mNJMaDoUuY+9/Ja7yZR
         2HIbCi7kAbCVnLnDnenNKIWccCGlcg8KdFMKovRC5320nrkfem8G253e3KVWY1h0VgtH
         MpFJtgo6SM3ozL5v+ElWVCZDEe6kKCAUrq8MMu63QvNwELECbb0AFeduO31Bdg8TmdNv
         UuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7gtxuaLG4UDLPzN4ZBz/We/1BJFK+SkO0Q8aoPDnYTI=;
        b=dZpmAbBaZQ9p+bFgNKdGM4G81m2Wr4uJh0z8D0tBpiXC6gAGjHh+xFeajNeu/Vkpvz
         B0/1kSIXoZze4NCRxDa2FdBxN4eOMmM1Di//0siGhu8p+dwGfqR9s8ktAdTwjHrBVptW
         fIlWuqHR9+lpqSddMuIWscuVB7QVRnY57OMHJ8L4NgEh3cgHkLmwuBjBjj+7boxe2e0E
         elj8vyLfugVLpJKnPcS8rCi3BlAy17BwSoxosGAzbT2/m2oIvCIKHvBDJu2wfmbbCCYJ
         Ik4qbgUZxBepOgDTyIOYOjUh8duzNcDmkPYyE6QiYh+fVqV+UBY8ZXZKa6rW3ar9Mrxl
         yEUA==
X-Gm-Message-State: AJcUukcZh0XdOB+j+LcnznT7rCLX/2Y4YY9ZjNPor7jUX4gQe6m+BmMO
        wzK/UVkXmJGIZ/DsCeatUgciAVek
X-Google-Smtp-Source: ALg8bN7nrJAgvkZRJ7C7GoqV3klqT8XOJzpBkw/NbEwyYYNoFesnAPo0DhMGCANEb4vFrFBUA6sCNA==
X-Received: by 2002:a63:fc05:: with SMTP id j5mr563412pgi.434.1547501935100;
        Mon, 14 Jan 2019 13:38:55 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id i193sm3884632pgc.22.2019.01.14.13.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 13:38:54 -0800 (PST)
Date:   Mon, 14 Jan 2019 13:38:52 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Maris Razvan <razvan.alex.maris@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Gitignore documentation
Message-ID: <20190114213852.GD162110@google.com>
References: <CALZbgSQti+t2dA4nm+DCDGxQjsvNJy3UDdqAya16v+Mv5O4Xdw@mail.gmail.com>
 <xmqqzhs3uldb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhs3uldb.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

>                                  Patterns with slash is anchored at
> one directory, and that directory is the one that has per-directory
> .gitignore file.  Patterns without slash (including a pattern that
> ends with but otherwise has no other slash) are supposed to match at
> every level below the directory that the pattern is defined in.

I had a sense of deja vu, and found
https://public-inbox.org/git/20111107080926.GC30486@elie.hsd1.il.comcast.net/

Any idea what happened there?  Would it be useful for me to rebase
and revive that series?

Thanks,
Jonathan
