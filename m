Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECC101F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfJ3UxJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:53:09 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37364 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfJ3UxI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 16:53:08 -0400
Received: by mail-oi1-f181.google.com with SMTP id y194so3253870oie.4
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qifX45wHpM7CEpLfScof+5NCs1h6tObfH+iqYxkottI=;
        b=XYiyrhNF7CnQk3k8UrHrFJB62BmXgdIKajBc8IOMNPaMz6bRmuNtYAOTOFSamInWpe
         56D87bFkKkCssPlSxxL+LWvarAuaybGx+au8cOjf9eDx2oIFm9eFxHSLKZfk4EPLyEZ1
         zptPJDOoWxR848XUDJcJocgx8cJrolJvveHwUWbOLXN9IkrlqH4mX7UhjUgqNDp2cWbk
         r2wftpD5dAT9wCOj37yYKFL1EHAPBPqymPQ+c33uuI/mbmD8BaV8zAUESQe/Am6qAc+n
         2XWQ9ZG74EZqSUoF0DJGp5pRd2VZcYMiAikDa0U3auMNX2uXET7mxDY58wNTj/M+vsLf
         J29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qifX45wHpM7CEpLfScof+5NCs1h6tObfH+iqYxkottI=;
        b=bwZPTYTfBBWBLdcSnwLcc4YHJLYuCwBaWHwFPtLDofNyyU6xMlr+IcLz0DZ/b8kwL3
         Pc/C0XM8BK7WfZhUqC0hn/GOijuuwrJ0Y9TEMtd97aULES6THwedZ7UEuy1JbszoyY59
         1nKplQxVLd9uAIZwY46o4YkwaHa31qAt+mEpR9vs57ZUL9xMJ02uvSCNsu5LasAQeA8/
         ASiqnWl++tdwAjDNanEjfsZuo4H9RhrJjTxXBIVRhoMYhbILGTP54123QqZ9gADj7Dkj
         dWBB+pcSCXwyCjwRPPx4dPwbg/ZLyyxkfMyA2+F9vRWMf/2Zl9WP4HzOU/pjadeeZodq
         3KCQ==
X-Gm-Message-State: APjAAAVlje2CVZvbpMFw2AidQB7q7yJgKgDmO3peOl2ajqK8m8BSWVA+
        9DsNd0sDW+Z5gQMTdqYlwoLU6YLRoGG1rtnbGxtLkEE2
X-Google-Smtp-Source: APXvYqwWHHn916IfqGwDKGld08qO8uqKuHCdlhXAnwhW35s6lqOVRdnPSoUGKXCQNuislPHIN8dX4gBb4ZUGGQYUQuk=
X-Received: by 2002:aca:dad6:: with SMTP id r205mr992138oig.6.1572468786000;
 Wed, 30 Oct 2019 13:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqeez2fzsy.fsf@gitster-ct.c.googlers.com> <CABPp-BGV=5FuMfq1pYbbHCMMvyVGQPS_8yTjqhKoqrm7O1KFow@mail.gmail.com>
In-Reply-To: <CABPp-BGV=5FuMfq1pYbbHCMMvyVGQPS_8yTjqhKoqrm7O1KFow@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Oct 2019 13:52:54 -0700
Message-ID: <CABPp-BEx1tdH53qPsvQrb7NzkTWWbUWwOfR7xjzCEb0JRiCxNw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.24.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 29, 2019 at 11:56 PM Elijah Newren <newren@gmail.com> wrote:
>
> Hi Junio,
>
> A couple questions on the release notes...
>
> On Thu, Oct 24, 2019 at 1:35 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Git 2.24 Release Notes (draft)
> > ==============================
> >
> > Updates since v2.23
> > -------------------
> >
> > Backward compatibility note
> >
> >  * Although it is not officially deprecated, "filter-branch" is
> >    showing its age and alternatives are available.  From this release,
> >    we started to discourage its uses and hint people about
> >    filter-repo.
>
> What do you mean by deprecation, then?
>
> My understanding has always been that deprecation meant "supported but
> discouraged", which is exactly what we're doing.  We also run the risk
> of people seeing "not officially deprecated" in the release notes,
> then being very confused why the documentation and the program itself
> is discouraging its own use and wonder if they configured things wrong
> or got the wrong version of git ("The release notes says it isn't
> deprecated, but whatever version I'm running definitely does have it
> deprecated.  What'd I do wrong??").
>
> >  * The merge-recursive machiery is one of the most complex parts of
>
> I fixed this "machiery" typo in en/doc-typofix but as that hasn't even
> merged down to next yet, I'm wondering if you're planning to include
> that in the release.  Should I provide a subset of those fixes in a
> separate patch for inclusion in the 2.24 release?  Which of the types
> of doc typo fixes would you want to see at this point for including?

Made a guess at the answers to my questions in the form of patches:
https://public-inbox.org/git/pull.440.git.1572466878.gitgitgadget@gmail.com/
