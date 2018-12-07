Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30FB520A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLGW7T (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:59:19 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42083 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGW7S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:59:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so4690077oiw.9
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1sstvZN5emKbH9kD7K5qtOaHpB0PVatlazriws+gFr0=;
        b=OkLdTCbChJaQqAgmyQAbGsyx9B17t/rmVRp92C27UddvViKiCEumWKYLdgFIAjlwvM
         uHmezKESO5McBrnVPv1w2rCAXpCy7PniVOQSH+krOzCFtnm6DwTGXjPvT7jRfyKoOHn9
         CO4Ks1GE5BPb9BGSYZn2P1Dk6+WQ3AYgCFC+DYNa0kQwNV32XzxFy5se14iGZcQ9GxKV
         B6EH3wIYy+q+XPvrW50zrjPgxZ+dipkIFgJVDL7My/m4r3OCMbH3Gq/qUU/4kPSV6v40
         rnrdRHE1gkR6fkE2VDSqqRu4EstXv5jcVkvksdcikQENLZPisnhQCOBeQ73r++ZQlr4y
         H/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1sstvZN5emKbH9kD7K5qtOaHpB0PVatlazriws+gFr0=;
        b=cG2dECidfgrg3yPlTF/G+bVdTGjZsadaRGFt88lKzRmuLIBYQwwFyEv8BAr8QF4imB
         TZv9PQ/gMUOVxjo/JnfdJ8TYSGHNWCoret26xv9B3Qz+biYIWBMttlbnHf2C+4L0wJC5
         KQYakYY/39hCfO7L/a09g4yk+rPgh3eAYIZN6dLEE7WBXV3YZR2SaiveQJ1tbDzHu0WG
         QwPRqZmdFSFpLI16wLEmKLUxyb8p1Jg/CtyRAq9Z+IHx6QIdK9tncSDgb4f4ddpDnv8E
         PI/fGAwTvJtVLA2Ntn3L/Z1f2f4IpPg2PgK6Ws+L9RZ4irstbyBuNspWPAhxsKksHTPw
         3CqQ==
X-Gm-Message-State: AA+aEWb/ricQvFIp6rtQdONWuqGhEXOKTrktHleQHzj+ndZIWL+dZjOe
        pDnEoa5j3FVmUwvOT73yvV5F1bL7eaqfXM7tvoyH
X-Google-Smtp-Source: AFSGD/W8SQuzTFa9gwwEyN/PiYJtEMURyXMiIKpdXMzt9CpVGZ4KON7xyk3viINvewWa/IrGNvBQAznthwDaxBpiHNg=
X-Received: by 2002:aca:cc0d:: with SMTP id c13mr2328082oig.150.1544223557703;
 Fri, 07 Dec 2018 14:59:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1539298957.git.matvore@google.com> <a1ddae16bae563dd904555661e2e916536f388d8.1539298957.git.matvore@google.com>
 <xmqq4ldo861m.fsf@gitster-ct.c.googlers.com> <CAMfpvh+CDc_jToDmZaAypqwXvrhJMO-_4sUWRcjXwwz6OHhAHA@mail.gmail.com>
 <xmqqo9bmyb56.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9bmyb56.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Fri, 7 Dec 2018 14:55:25 -0800
Message-ID: <CAMfpvh+6r65OqWpY-geOYHizs526A1004vakKSdxnO=fsahdAg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] Documentation/git-rev-list: s/<commit>/<object>/
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 21, 2018 at 7:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matthew DeVore <matvore@google.com> writes:
>
> >> It is more like "this is a set operation across commits.  We also
> >> show objects that are reachable from the commits in the resulting
> >> set and are not reachable from the commits in the set that were
> >> excluded when --objects option is given".
> >>
> > That would be correct though it wouldn't tell that you can use
> > "--objects ^foo-tree bar-tree."
>
> Yeah, but quite honestly, I consider that it is working by accident,
> not by design, in the current code (iow, you are looking at a
> behaviour of whatever the code happens to do).  "rev-list" is pretty
> much set operation across commits, and anything that deals with a
> non commit-ish given from the command line is an afterthought at
> best, and happenstance in reality.
>
> I do not mean to say that the code must stay that way, though.

I tried fixing the issue of "--objects ^commitobj treeobj" not
properly excluding objects reachable from commitobj, but this ended up
causing t5616-partial-clone.sh to fail. In the test labeled "manual
prefetch of missing objects", we create a clone of srv.bare without
blobs called "pc1", then push some new commits to srv.bare (via a
separate "local" repo), and try to fetch missing blobs with this
command:

$ git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids

Where observed.oids contains all the blobs that were missing. It tells
the remote that it already has the "refs/heads/master" commit, which
means it is excluded. Before, this worked fine, since it didn't mean
the blobs were excluded, only the commit itself. With the fix I
naively put together (and didn't share), because one of the blobs is
reachable from "refs/heads/master" it wouldn't pull it. I guess I can
change it so that items given directly to stdin or argv are always
fetched, though I'm not sure how easy that will be, and I'm not as
interested in fixing this as I once was. I just wanted the
documentation to outline the object-enumeration capabilities. So I'll
send a re-roll which makes much more modest changes to the
documentation.
