From: Stefan Beller <sbeller@google.com>
Subject: Re: RCS Keywords in Git done right
Date: Wed, 26 Nov 2014 13:15:14 -0800
Message-ID: <CAGZ79kZLAHDG8h5DMQdOH2cQtaMs_iCtC-xsoKst966a+jaBNA@mail.gmail.com>
References: <CAMsgyKbTRY5=cHj8Ar8zHDd5WdbcNwZC5caGV-snvZU4aek=YQ@mail.gmail.com>
	<CAGZ79kZz4_q+p91e7fn8uS--DRqEUPj_eeQPf2WPOWEk=R8fkw@mail.gmail.com>
	<CAMsgyKZywnac_b2RV0dGs9zOdemJDUQ8oR=bSydBuSxp1VDixQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Derek Moore <derek.p.moore@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 22:15:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtjvp-0007pq-KQ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 22:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbaKZVPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 16:15:19 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:61840 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbaKZVPO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 16:15:14 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so3441806ieb.31
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 13:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cU4wJOoDExJwOVVzFDttnlTxRs+F4MnbGBD5j+4qE98=;
        b=ggCtJPcWlkYSfuWLlvdZaP2JWttD+b+cn0H0s+ImNxE2Z64koYFoQr90sTQYUO4C3N
         duRTi+E3OUOcfkJPZAnMddPayKYBPbWKw/J1hsCIe7dzQK7lQC6ViaI00T+okSlwLAd8
         YOiuoinnxJ54Gpisw2f77J5Fh0Wk/r+h1ozB9EVI/CA3dPC8RJ6TV5zj1+kDXtOlh6+Q
         7KOKubj5fnHZNVmDyazP18H5GRP60KB6BypiU+7FVxiiVseILzg/WnZIoVTueIxbH3de
         +b97UfKL2BHJguS+V95uoA7D0xK/WhC5iypFiNOBlFqDtlZxqxbEENed+VbElzG9Zy6Y
         8Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cU4wJOoDExJwOVVzFDttnlTxRs+F4MnbGBD5j+4qE98=;
        b=mpp4MbIh8iwHWj3p8AQt8DgJMFAYsAacLaeulAYyEZL+YjhKhcGjt7VFLOqlBhCGWK
         KcuNU2TKl9mfu88/0iEbFk9FEG/musYg4hslJf0Djf1XKVoVgDa7fu/EWjbiejcFIlsf
         z4vcc0Etuph6baG2AuBL/lxG43wS3ty96nK9jfKJK/5RmxxT5tDQ78+TiQH5vqmQPXYX
         7ozHHHKl7RAuuZ5yeYG+U0xMfU21UtVh7YLAppCmX1FPy5zz+nsiuMGkYgYkAsPFUxPl
         iOnBp4pMftMiRioRgzTskjnuYyLY2smrbU2wIyr/DqHtLEZTM+twRyYFJyx023IOv7qi
         BkXA==
X-Gm-Message-State: ALoCoQkvs9vV52TCCKgWzL43stKfFoXQr6zyXLj0WhXcHqlzz+UHVousQi4lwyFS0d0w6Jc2QKHD
X-Received: by 10.50.137.65 with SMTP id qg1mr25035565igb.37.1417036514170;
 Wed, 26 Nov 2014 13:15:14 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Wed, 26 Nov 2014 13:15:14 -0800 (PST)
In-Reply-To: <CAMsgyKZywnac_b2RV0dGs9zOdemJDUQ8oR=bSydBuSxp1VDixQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260307>

On Wed, Nov 26, 2014 at 11:22 AM, Derek Moore <derek.p.moore@gmail.com> wrote:
>> Now knowing the edge cases won't work, I did not get an idea about the
>> standard case of what should work with this. Would you mind to write
>> a more detailed example or a more advertising paragraph of what this can do?
>> Not getting the big picture may be related to me having not worked with RCS yet.
>
> Stefan,
>
> RCS Keywords, while originating from RCS, are commonly used in CVS and
> SVN. A lot of LaTeX workflows in the scientific community, for
> example, use these keyword substitutions, trapping scientists in
> legacy SCMSes. In my environment, we do builds and deployments from
> within pristine working copies or "checkouts of trunk", we also have
> some deployments that are symlinks into live checkouts of trunk, and
> we have production support workflows where support personnel inspect
> files remotely and subsequent escalation procedures rely on the
> contents of the $Author$ substitutions, etc. As a result of this,
> projects that have migrated to git are demanding the restoration of
> their RCS keyword substitutions.
>
> In CVS/SVN, keywords are expanded on checkout, placing text related to
> the most recent history of a give file into that file. RCS has one
> keyword that takes action on check-in (or commit), being the $Log$
> keyword, which is a running commit log of the file in the file.
> Keyword expansions are not stored in the repo, but are substituted on
> their out of the repo into the working copy, and substitutions are
> reversed on their way from the working copy into the repo.

Thanks for the explanation!


>
> Git's export-subst feature in git-archive is very similar to RCS
> Keywords. What I'm providing here is a mechanism to enable
> export-subst functionality throughout normal git workflows and not
> just during builds that employ git-archive, as if export-subst worked
> alongside git's ident feature.
>
> Perhaps described the known issues I've found will also help towards
> understanding...
>
>
> Known Issues
> ------------
>
> Edge Case #1 (aka, modified smudge filter)
>
> 1. create new branch
> 2. edit smudge filter
> 3. commit
> 4. switch back to previous branch
> 5. smudge filter is temporarily disappeared at the moment the smudge
> filter wants to run
>
> This edge case is a side-effect of the order in which git performs
> deletions in the worktree and extractions from the index and
> executions of the filters. This edge case is related to a similar to
> one seen in older git versions where the smudge is disappeared during
> a "git checkout-index -a -f", but the sequence of operations has been
> fixed in more recent gits, so the smudge does not disappear during a
> checkout-index.
>
>
> Edge Case #2
>
> 1. create branch B from branch A
> 2. make changes in branch A, commit
> 3. checkout branch B
> 4. git merge A
> 5. while editing commit file, file being modified lacks keywords (expected)
> 6. delete commit message, cancelling commit
> 7. file remains w/o substituted keywords
> 8. cancel merge w/ git reset --merge ORIG_HEAD & restored original
> file is w/o substituted keywords
>
> Reason: no available state transition on reset --merge
>
>
> Edge Case #3
>
> 1. create branch B from branch A, checkout B
> 2. modify file, commit
> 3. checkout A
> 4. make conflicting edit to same file
> 5. git rebase B, rebase will conflict
> 6. git rebase --abort
> 7. file will be w/o substituted keywords
>
>
> Known Unissues
> --------------
>
> Not-an-Edge-Case #1
>
> 1. create branch B from branch A, checkout B
> 2. modify file, commit
> 3. checkout A
> 4. git merge --squash B
> 5. file as modified from B is w/o substituted keywords
> AS EXPECTED - that version of file does not yet contain history in A,
> file will gain substitutions following commit
