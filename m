Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CE51F453
	for <e@80x24.org>; Fri,  1 Feb 2019 00:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfBAAVS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 31 Jan 2019 19:21:18 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45451 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfBAAVS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 19:21:18 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so5582311qtr.12
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 16:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ct19eb2flueWbth08peQr9NQbw6W1o+3HHPzvhCjr+Q=;
        b=rjBenuQDTBygZed3xPOmn3p2YUYBsHALLSw+rahm8j6rUgaGCVRufbSuy9pR0UlrTP
         w9pFWuR9UFq1pgPG5wwdcEtr4cOzkdtxXCnGVZjD1AOP+rlj/mXUDKJ6F4Alz91SMLfJ
         pM3wXKfVS9QB9iPK44JJjLDIKF5IAf29zexSr6urqhoh1rucU4lZFqYnDkjMhtdV4o+9
         sc2LY2pPTykQ6ReQuchamH/RYb5pQBe/bTolA+JaB3pB/14oXrndeUVLRIShVhAO1ugX
         MR7l1YKrYnAj5VWdMYjLMiPr6qDvMDnO6LeIIXRRZFjXeIyz7TgheYtJaGnL/NXKlyC7
         rEMw==
X-Gm-Message-State: AJcUukePQ1AcOCvw4Mr7pnpnEz39su+mnf7R0XRHkBE4ipO1Bqybv1IR
        lrxeZbDx0tiOmPkx1TF8njYlemy7sfa3dBMa9PA=
X-Google-Smtp-Source: ALg8bN5/rd5PCC/x5FmlbCrv5Qs3ICysND9kbEXyp3kJG4FugfACb4pjfZNvI7EKMnDiom+PO5IXeZNd6wNoR/9MF1o=
X-Received: by 2002:ac8:2a81:: with SMTP id b1mr36753611qta.110.1548980476604;
 Thu, 31 Jan 2019 16:21:16 -0800 (PST)
MIME-Version: 1.0
References: <CACsJy8C2fx-+NxS+ahmmHDgLrwtyiCV6WEEfpmYwfcPM3kYVvA@mail.gmail.com>
 <20190131092112.6197-1-pclouds@gmail.com> <CAPig+cSzDSeJ7HypXTjMpn26LYygH_UFYwcPzthGLoEQYDNLcQ@mail.gmail.com>
 <CACsJy8D_3-SrxEAjrndieXhxu=mt6VUpDGTfVu2nrDW6USsgPw@mail.gmail.com>
In-Reply-To: <CACsJy8D_3-SrxEAjrndieXhxu=mt6VUpDGTfVu2nrDW6USsgPw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 31 Jan 2019 19:21:05 -0500
Message-ID: <CAPig+cS0MnYebOvVtEWZEJcNgOgNfHgUg1F35x=tzrK1D1X3+A@mail.gmail.com>
Subject: Re: [PATCH] git-commit.txt: better description what it does
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 6:04 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jan 31, 2019 at 5:49 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Thu, Jan 31, 2019 at 4:21 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > > +NOTES
> > > +-----
> > > +If a branch is associated with the working tree, 'HEAD' points to this
> > > +branch. When a new commit is created, the branch is updated to point
> > > +to the new commit. As a result, resolving 'HEAD' still gives the new
> > > +commit.
> > > +
> > > +If no branch is associated with the working tree (i.e. "detached HEAD"
> > > +as described in linkgit:git-checkout[1]), 'HEAD' records the object
> > > +name of the previous commit directly. When a new commit is created, it
> > > +will be updated to point to the new commit.
> >
> > I'm having a hard time figuring out what these two paragraphs together
> > want to say. I _think_ they want to say that HEAD is updated
> > automatically to point at the latest commit, and that if a branch
> > points at HEAD, then the branch is is updated along with HEAD,
> > otherwise if no branch, then it's a "detached HEAD".
>
> I felt some more explanation was needed when I mentioned about
> updating current branch in the description, but then what happens when
> there's no branch (aka detached HEAD)? There is still some updates. If
> you consider HEAD a branch, then it's ok, but otherwise something is
> missing. But perhaps this is the kind of details that could be left
> out?

It could be left out or incorporated directly into the DESCRIPTION
section with a link to the much more thorough discussion of detached
HEAD in git-checkout documentation. Here's my attempt at rewriting
DESCRIPTION (and dropping NOTES altogether):

    Create a new commit containing the current contents of the index
    and the given log message describing the changes. The new commit
    is a direct child of HEAD, usually the tip of the current branch,
    and the branch is updated to point to it (unless no branch is
    associated with the working tree, in which case HEAD is "detached"
    as described in linkgit:git-checkout[1]).

(I also streamlined the above a bit from what you had composed.)
