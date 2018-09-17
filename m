Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D42571F404
	for <e@80x24.org>; Mon, 17 Sep 2018 13:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeIQTP3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 15:15:29 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:55424 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQTP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 15:15:29 -0400
Received: by mail-it0-f43.google.com with SMTP id d10-v6so11131937itj.5
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wHpWmWXqRmr/Zmi4V62kq1G0xxnfzZrUwE374hKCeY0=;
        b=Mlb1bTdGJol6+/ORvVHbFXozytxzaQ02Ri22Lm59r6QeIXkD5VTXIeQvDcTC7FJLld
         MzlHjbtwSuYuZvZixgjc8ccuxgVjqV2SRSHBrjRTlloolBguqhuF2EiAQ+uK4scajuv3
         eEE/Xtjfgy361ufx5c3n4R7MDiD9L7GVjA7nOrm9WXuEYXRYy/EZGcaUCOMZ+4Yosjyg
         jjJpTG4JQcmmlyuY7AvS8/SOb5pVNZ2/rCt9zIkqp02yjHavStuIZLDhoGP/6EnsTbBc
         SvYvrWDRr9tQNHzOKBY9s+DHHTEVu3dxXR00btXmGU3fUdEq252o9iILj29kyBoXBKua
         woZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wHpWmWXqRmr/Zmi4V62kq1G0xxnfzZrUwE374hKCeY0=;
        b=BXKgv2wfFHK6UQIeiAfycwGORTv6CKAcXOzqkhzaImlRVoeCEynVhXFTkq2V7Y4a1I
         Nlm7XKcyFRGyEwSCotua+A1zUQqMqEf/QbYA1slxKcOVVVITq8JhqBNEvD9CMyrXVjsq
         L+SX6ddjvnc9v8+zxJj7bK1ZNdv4an3Gw1gp/gn8FaYwkafvEk2AyOAwTF+mMVaQzsfd
         20AiHIZ+E3+T18pEAY0YeFCUDBkXO3SgMn4siKw4k29dRp6RrMkjCA+VqKPSbhYcbfFy
         YL9NhpkhhWPvDWAVeyXaKoikhQx6XZfczjJgx5jMQCNhcl68oy9tLCoMEhnDCm97Vy9p
         WStg==
X-Gm-Message-State: APzg51CrIGvXkroC8PFSNt/KQ0JcZIaS8Jc6fq6JGuZPIvu7zfSqx9AL
        9Kpt7e2C8833vHSB5LRdab+lqAGyk6k=
X-Google-Smtp-Source: ANB0Vdb1IFXuJUo3F0kHgVFAstqnCo85Vqj8MbrWCxbl4yrSH+DtvEWckGF7ICjPVYyo977CgEH9iA==
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr12066069itb.95.1537192082963;
        Mon, 17 Sep 2018 06:48:02 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id n187-v6sm7854267iod.66.2018.09.17.06.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 06:48:01 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 17 Sep 2018 09:48:02 -0400
To:     David Aguilar <davvid@gmail.com>
Cc:     John Austin <john@astrangergravity.com>, me@ttaylorr.com,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        larsxschneider@gmail.com, pastelmobilesuit@github.com
Subject: Re: Git for games working group
Message-ID: <20180917134802.GE71477@syl>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl>
 <CA+AhR6crT2AoJcoGAGA0_c_XdL-0ozHUXTuDrS67tzrTvRLQZw@mail.gmail.com>
 <20180916075604.GB18517@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180916075604.GB18517@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 16, 2018 at 12:56:04AM -0700, David Aguilar wrote:
> Combining changes is inherently file-format specific, and I suspect
> that native authoring tools are best used in those scenarios.
> Maybe LFS can help deal with binary conflicts by having short and sweet
> ways to grab the "base", "their" and "our" versions of the conflict
> files.
>
> Example:
>
> 	git lfs checkout --theirs --to theirs.wav conflict.wav
> 	git lfs checkout --ours --to ours.wav conflict.wav
> 	git lfs checkout --base --to base.wav conflict.wav
>
> Then the user can use {ours,theirs,base}.wav to produce the
> resolved result using their usual authoring tools.

That's a good idea, and I think that it's sensible that we teach Git LFS
how to do it. I've opened an issue to that effect in our tracker:

  https://github.com/git-lfs/git-lfs/issues/3258

> One thought that comes to mind is diffing -- I imagine that we
> might want to use different diff tools depending on the file format.
> Currently git-difftool uses a single tool for all files, but it seems
> like being able to use different tools, based on the file type, could
> be helpful.

We have had some internal discussion about this. I think that we had
landed on something similar to:

  1. Teach .gitattributes a new mergetool= attribute, which would
     specify a reference to a mergetool driver, and

  2. Teach .gitconfig about a way to store meregtool drivers, similar to
     how we name filters today.

Upon my re-reading of this proposal, it was suggested that we implement
this in terms of 'git lfs mergetool', but I don't see why this wouldn't
be a good fit for Git in general.


Thanks,
Taylor
