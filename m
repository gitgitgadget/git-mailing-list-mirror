Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CF7C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 12:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EE720663
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 12:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfL3MXQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 30 Dec 2019 07:23:16 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.113]:18218 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727376AbfL3MXQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Dec 2019 07:23:16 -0500
X-Greylist: delayed 1388 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Dec 2019 07:23:15 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 40EB01AC3
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 06:00:06 -0600 (CST)
Received: from gator4087.hostgator.com ([192.185.4.99])
        by cmsmtp with SMTP
        id ltiPimKbtW4frltiPi3wq5; Mon, 30 Dec 2019 06:00:06 -0600
X-Authority-Reason: nr=8
Received: from mail-qk1-f171.google.com ([209.85.222.171]:37285)
        by gator4087.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <xda@abalgo.com>)
        id 1iltiP-003U97-I6
        for git@vger.kernel.org; Mon, 30 Dec 2019 06:00:05 -0600
Received: by mail-qk1-f171.google.com with SMTP id 21so26115234qky.4
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 04:00:05 -0800 (PST)
X-Gm-Message-State: APjAAAWIOvuNppcAa3pvsZxKR4nzKn5sf1yy0B77+S14mLMvYrpH2shs
        RGhfsXC3B3SJ3oA5LEdtb0Ok5Lazij0GLtxCdQs=
X-Google-Smtp-Source: APXvYqymPmI+cokre8YhSXLdKXw9k5dAeDfQMuOJ+Qk6L2pfNcAxWYdrIj3F/6e806fjY5793egZplDmuwKOvHEEbMc=
X-Received: by 2002:a05:620a:91c:: with SMTP id v28mr54229105qkv.248.1577707204937;
 Mon, 30 Dec 2019 04:00:04 -0800 (PST)
MIME-Version: 1.0
References: <CAEW0o+jV+r1UMZReRXa3g_fyqCYxHTVYVf6pWvjB7_isofbBaw@mail.gmail.com>
 <xmqqd0c6iuw0.fsf@gitster-ct.c.googlers.com> <CAEW0o+g7vXj841h+4nNK8iSoO758Uh9fLKMCN87RE2w2Nd=CRg@mail.gmail.com>
 <20191230041517.GA84036@mit.edu>
In-Reply-To: <20191230041517.GA84036@mit.edu>
From:   Arnaud Bertrand <xda@abalgo.com>
Date:   Mon, 30 Dec 2019 12:59:52 +0100
X-Gmail-Original-Message-ID: <CAEW0o+gtya5tm6Wb474Srmb2j4E9ocm9p75=aZWjTASbApsb1A@mail.gmail.com>
Message-ID: <CAEW0o+gtya5tm6Wb474Srmb2j4E9ocm9p75=aZWjTASbApsb1A@mail.gmail.com>
Subject: Re: Feature request: add a metadata in the commit: the "commited in
 branch" information
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Arnaud Bertrand <xda@abalgo.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4087.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - abalgo.com
X-BWhitelist: no
X-Source-IP: 209.85.222.171
X-Source-L: No
X-Exim-ID: 1iltiP-003U97-I6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: mail-qk1-f171.google.com [209.85.222.171]:37285
X-Source-Auth: abalgo
X-Email-Count: 4
X-Source-Cap: YWJhbGdvO2FiYWxnbztnYXRvcjQwODcuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le lun. 30 déc. 2019 à 05:15, Theodore Y. Ts'o <tytso@mit.edu> a écrit :
>
> On Mon, Dec 30, 2019 at 12:53:56AM +0100, Arnaud Bertrand wrote:
> > Hi Junio,
> >
> > It really depends how git is used. With big collaborative project
> > (like git or linux kernel), you are totally right.
> > for development limited to a company that has developments with team
> > of 10-20 developers and that uses
> > a correct SCM plan, the name of the branch is regulated and is
> > meaningful, mostly  linked to a bug tracking system
> > system. For audits and  traceability, the branch name is really
> > important... certainly more than the email of the developer ;-)
> > So the "contamination" is negligible compare to the bentefit in this context.
> > It will also helps the graphical tools to have a comprehensive
> > represeintation which can do git even better.
>
> Why does it need to be the branch name?  You can add your own extra
> metadata to the git description.

That's typically my problem.  It is not possible "by default", I mean
- It is only possible if the developer configure something
- or if there is an upper layer that guarantee this
By default, there is no hook embedded with the clone. So, as far as I
know (and I hope I'm wrong!), you have to use upper layer tools or to
change environment variables to activate this feature. Furthermore, it
will never be used by third party tool to beautify the branch
representation.

I think that the major problem is that git calls "branches" what it is
not. Git branches are, in reality, "dynamic tags". In other words,
when you are on this tag and you perform a commit, this dynamic tag
moves with your commit. So it is not really a branch as clearcase,
mercurial, svn or cvs defined it.


> So for example, I might have a git
> commit that looks like this:
>
>     ext4: avoid declaring fs inconsistent due to invalid file handles
>
>     If we receive a file handle, either from NFS or open_by_handle_at(2),
>     and it points at an inode which has not been initialized, and the file
>     system has metadata checksums enabled, we shouldn't try to get the
>     inode, discover the checksum is invalid, and then declare the file
>     system as being inconsistent.
>
>     ... <details of repro omitted to keep this email short>
>
>     Google-Bug-Id: 120690101
>     Upstream-5.0-SHA1: 8a363970d1dc38c4ec4ad575c862f776f468d057
>     Tested: used the repro to verify that open_by_handle_at(2)
>        will not declare the fs inconsistent
>     Effort: storage/ext4
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>     Change-Id: Iafb6da7c360a4c34b882f7fd6a91e3bb
>
> The tie-in to the bug tracking system is done via "Google-Bug-Id:".
> The Effort tag is used to identify which subteam should be responsble
> for rebasing the commit to a newer upstream kernel.  (E.g., how to
> account for all of the patches made on top of 4.14.x when you are
> rebasing to the newer 4.19 long-term-stable kernel, to make sure all
> not-yet-usptreamed commits are carried over during the rebase
> process.)
>
> The Upstream-X.Y-SHA1: tag indicates that this is an upstream commit
> that was backported to the internal kernel.  If the commit isn't an
> upstream backport, we have a policy (which is enforced via an
> automated bot when the commit goes through Gerritt for review) that
> there must be an "Upstream-Plan: " tag indicating how the committer
> plans to get the change upstream.
>
> The automated review bot also enforces that a Tested: tag exists,
> describing how the developer tested the change, and Change-Id: is used
> to link the commit to Gerrit, which is how we enforce that all commits
> have to be reviewed by a second engineer before it is allowed into the
> production kernel sources.  We also maintain all of the Gerrit
> comments as history and so we can have accountability as to who
> reviewed a commit before it was submitted into the release repository.
>
> We also have automated bots which will run checkpatch and note the
> warnings from checkpatch as Gerrit commits; and if the kernel doesn't
> build on a variety of architetures and configurations (e.g., debug,
> installer, etc.) a bot can also report this and add -1 Gerrit review.
>
> See?  You can do an awful lot without regulating and recording the
> branch name used by the engineer.  We have full audit and traceability
> through the Gerrit reviews, and we can use the Google-Bug-Id to track
> which release versions of which kernels have which bugs fixed.
>

You have convinced me that Gerrit is a very nice tool that complete git  ;-)
However, one of the main point of git is that it is easy to setup
(once the tool is installed, it is one second to setup a new
repository and track files)
So, I certainly don't want to reduce this strong point of git!

> The bottom line is each company is going to have a different workflow
> for doing reviews, linkage to bug tracking systems, auditability, etc.
> If everybody were to demand their unique scheme was to be supported
> directly in Git, it would be a mess.

Include the name of the branch is not harmless or fanciful, it is
something important in most of the workflows.
For example:
If you check this article:
https://nvie.com/posts/a-successful-git-branching-model/
The branchname is fundamental and the pictures he shows in its article
will never be achieved without keeping track of the branchname.
Git lightened the notion of branch and therefore its use, which is a
good thing but on the other hand, why forget the branch history? And
certainly if it is only a light metadata in the commit ?
Don't you agree that the branchname where modifications were done
could give really precious information ?
Don't you agree that a representation like it is in the article above
is more clear than the standard git representation ?

I think that add the branchname as "weak" metadata, invisible except
with a dedicated request like specific placeholder in git log could be
a real big added value compared to the inconvenient of its absence.

Cheers,

Arnaud

> The scheme that I've described
> above needs no special git features.  It just uses some git hooks as a
> convenience to to developers to help them fill in these required
> fields, using Gerrit for commit review, and some bots which submit
> reviews to Gerrit.
>
> Cheers,
>
>                                                 - Ted
