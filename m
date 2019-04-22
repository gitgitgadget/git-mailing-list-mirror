Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34CE1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 07:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfDVHjj (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 03:39:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34500 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfDVHji (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 03:39:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so5335789pfd.1
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 00:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zDP2Za7zvcf1mCQ6MOKgqTHwfCJjZgHz2bDCmykirSk=;
        b=prikyaywyvwKXTJc+cH34juRoW+1Q4Rp9Wvhn25fm3l3KSvpUUF52sF7P4I2/p3plr
         Qr0CkM3zIRRSqQ9NbV5/3yZ5Kh2Q4Gy3TsXXv/J3gQW0TpVGJ7JHSwF7wAQQgUqGDGCj
         M1GYUpQ1uc5yHu+25RSX0k+QHhnKbbmxxbK+rmrpNbqcHFOGS7nQEqNds6TBRGE6LJa8
         oxQolE0cvoGhizNk/5qk7Aza3ZdGQ89UqcpUFaKNolcImYezUXqUvv7inPB4i43j66BB
         UUKIVRWrFGXrPa2VJX2TtVAvlFUSllC7kuNGvrIDVDyYMXwzb4lLQgj8J19kzjTo4gxc
         Qe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDP2Za7zvcf1mCQ6MOKgqTHwfCJjZgHz2bDCmykirSk=;
        b=otNPQLa714fVh6guHoZZ47Y4KFJvjR+YsrkqXiuzDljm7gE8Gza196HfkXi5FajaaU
         MlpXk5T/oIsAwxETy7IeBk+BRlwQ5LB0tIrat6g3400XWAGNKhuQeP3S6rkYD/+9hJkS
         jnBVhfmpVEXxYHFj80mAdKhZHC4zbRDB4tvm4ruGCJlq7zuFGgoKsDPKiRgNKkbVOsiG
         YTnDfiVVZudq+sfOAebU0uPffNY4yH9/NWvKzosJoZlad+rrx2jvmWeSWzV9JQI1YSQw
         F7U7zNZ8zTSZCMnmFgZ4rXCGd37fIQSMZb2tMgiCIrFQSNZYlUfWz2ZfwrqIYDYV0uM7
         SxIg==
X-Gm-Message-State: APjAAAXh+a3pWYH5Onbf0yxDxACB5ZIfmAJlT+xld3JcqeS88PmxlNpf
        WIPRDgAMm5s2Y1UtxaKwCxWvMWdQ
X-Google-Smtp-Source: APXvYqza0BOiX3J69L8PxGUYm3p9OUDsO+2/q9ZGGXmJ2VSTTO6FpfNjoLjE0d+7Q9IQMgTqafHo6Q==
X-Received: by 2002:a63:6888:: with SMTP id d130mr17587410pgc.451.1555918777894;
        Mon, 22 Apr 2019 00:39:37 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id n5sm13526650pgp.80.2019.04.22.00.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 00:39:36 -0700 (PDT)
Date:   Mon, 22 Apr 2019 00:39:35 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] revisions.txt: mention <rev>~ form
Message-ID: <20190422073935.GA7660@archbookpro.localdomain>
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
 <xmqqv9z67doq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9z67doq.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 03:32:21PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > @@ -139,7 +139,9 @@ thing no matter the case.
> >    '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
> >    object name of a tag object that refers to a commit object.
> >  
> > -'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
> > +'<rev>{tilde}[<n>]', e.g. 'HEAD~, master{tilde}3'::
> 
> Why doesn't this example say "HEAD{tilde}, master{tilde}3" instead,
> I wonder?

According to the doc-diff, it doesn't really make a difference:

	diff --git a/14c0f8d3ab6c36672189cd2dd217f4617d12ccba/home/denton/share/man/man7/gitrevisions.7 b/18c8ed70602271a28c93df922eb3da8fb7563e2e/home/denton/share/man/man7/gitrevisions.7
	index 6f0dc7b8fb..ef23d49e00 100644
	--- a/14c0f8d3ab6c36672189cd2dd217f4617d12ccba/home/denton/share/man/man7/gitrevisions.7
	+++ b/18c8ed70602271a28c93df922eb3da8fb7563e2e/home/denton/share/man/man7/gitrevisions.7
	@@ -146,19 +146,20 @@ SPECIFYING REVISIONS
				This suffix is also accepted when spelled in uppercase, and means
				the same thing no matter the case.
	 
	-       <rev>^, e.g. HEAD^, v1.5.1^0
	+       <rev>^[<n>], e.g. HEAD^, v1.5.1^0
				A suffix ^ to a revision parameter means the first parent of that
				commit object.  ^<n> means the <n>th parent (i.e.  <rev>^ is
				equivalent to <rev>^1). As a special rule, <rev>^0 means the commit
				itself and is used when <rev> is the object name of a tag object
				that refers to a commit object.
	 
	-       <rev>~<n>, e.g. master~3
	-           A suffix ~<n> to a revision parameter means the commit object that
	-           is the <n>th generation ancestor of the named commit object,
	-           following only the first parents. I.e.  <rev>~3 is equivalent to
	-           <rev>^^^ which is equivalent to <rev>^1^1^1. See below for an
	-           illustration of the usage of this form.
	+       <rev>~[<n>], e.g. HEAD~, master~3
	+           A suffix ~ to a revision parameter means the first parent of that
	+           commit object. A suffix ~<n> to a revision parameter means the
	+           commit object that is the <n>th generation ancestor of the named
	+           commit object, following only the first parents. I.e.  <rev>~3 is
	+           equivalent to <rev>^^^ which is equivalent to <rev>^1^1^1. See
	+           below for an illustration of the usage of this form.
	 
			<rev>^{<type>}, e.g. v0.99.8^{commit}
				A suffix ^ followed by an object type name enclosed in brace pair

That being said, this is a typo on my part and it should really say
{tilde}.

> 
> > +  A suffix '{tilde}' to a revision parameter means the first parent of
> > +  that commit object.
> >    A suffix '{tilde}<n>' to a revision parameter means the commit
> >    object that is the <n>th generation ancestor of the named
> >    commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
