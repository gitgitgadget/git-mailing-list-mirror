Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D82620193
	for <e@80x24.org>; Thu, 27 Oct 2016 20:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934812AbcJ0U74 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 16:59:56 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38086 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbcJ0U7z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 16:59:55 -0400
Received: by mail-wm0-f41.google.com with SMTP id n67so73716902wme.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 13:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pelly-co.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=VjB+CKWjE1PAo4HlOljt/wW2TEK67gjekCYFhos5zpw=;
        b=EO0SYOyGba0VKWKFphRwe3Na+f6bCMXVj9uuvHxhTgd/1Hr02IrsWo2JXPi/wUHRlq
         8LOwsrz/LQ5jhyfYfDFhZbmCINTSgrE8DjC1H0bf7Bbebo0iPDNY7Lw+F3DUH+Fo+OpP
         FvqoXjrQOXShenqanIgPZbiIr67HRFx0ukv6nO/Xsr0gqstbOY2oD6qsDKIzLlIcdBfG
         l5hwg+qbT3gObvzX4BYOmY6ZZJFZHMtbX+Ypb+jKMCQVUPj3iGPIYuqpEt+Na3k7wC6j
         m+cnyoq03oCybR+zsWLxBg/rEn+S6GYB/im7I1vZD6cg3kd5Q2g8StSf3VmjOSBD5Ejb
         6TZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=VjB+CKWjE1PAo4HlOljt/wW2TEK67gjekCYFhos5zpw=;
        b=PUQ7W5fNUU2M7xnWkCoxeg0QBKvVrXlsmWCDP4S5g8oBl5qfMxq+r+RjArkhDfoo9/
         KiMs64hpPxW66SJZT49m+8VOF2whtCb9tSj3B0aq2keQzSq3uHcGTODZGCumK91iEuz9
         Oj/ADnn57pU4gNT3PVw5lMz8G2n6jvnbsojpg20qCdl+OHEPbuOd/jgAnFA1YdpJWu+X
         E3Z/i6Tc0D8RHsO0XZTtzMbmyn2wwh2Tdq8XFEHxFFvIH31RIiYuMVEOWBcz5iOQKjVq
         6oSSsPbwlgu7mCRtrfBvLF5wwbDFdis966kyGyPd/2e7QQ3UsJa4FrkbCAO/pOBLKZF8
         btvQ==
X-Gm-Message-State: ABUngvdfsLjfoLiD/DoO7wTBwf6+9ZMqu4RupA0hPaxwFS+BcMNx4UFgRPoeZeDqHM++cQ==
X-Received: by 10.28.146.143 with SMTP id u137mr594836wmd.57.1477601994052;
        Thu, 27 Oct 2016 13:59:54 -0700 (PDT)
Received: from [10.3.1.6] ([49.50.252.82])
        by smtp.googlemail.com with ESMTPSA id l6sm3642584wjc.7.2016.10.27.13.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2016 13:59:53 -0700 (PDT)
Subject: Re: Expanding Includes in .gitignore
To:     Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <CA+P7+xqmVM-bEc7sZcn+p3qhFUUJvC+rko7CYu+KgyTAeiOifw@mail.gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
From:   Aaron Pelly <aaron@pelly.co>
Message-ID: <067f4a57-2382-07e3-6873-79af78b4a9a1@pelly.co>
Date:   Fri, 28 Oct 2016 09:59:48 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xqmVM-bEc7sZcn+p3qhFUUJvC+rko7CYu+KgyTAeiOifw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/16 08:48, Jacob Keller wrote:
> I would strongly prefer rc.d style directories either with a "if the
> .gitignore is a directory treat it like rc.d" or even "add support for
> .gitignore.d as well as .gitignore"

I think adding .gitignore.d shouldn't break existing systems, is
intuitive, and solves my issue.

Does git know when it is in a repo that is too new to comprehend?

My current thinking is that anywhere a .gitignore can go, so can a
.gitignore.d (named appropriately of course.) Any existing .gitignore
should take precedence to the result of parsing the directory.

I haven't looked at the implementation of precedence yet, but I'd be
surprised if the existing mechanism can't be employed.

> One thing to keep in mind would be that we should make sure we can
> handle the .gitignore being a submodule or a git repository, so that
> users could just do something like
> 
> "git submodule add <repo> .gitignore and then track git ignore
> contents from a repository in a nice way.
> 
> By this I mean that the reading of files in .gitignore directory
> should exclude reading .git or other hidden files in some documented
> manor so as to avoid problems when linking to a git directory for its
> contents.

Nice! I like this a lot.

