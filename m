Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B921F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 18:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756411AbcIFSlK (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 14:41:10 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33518 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756394AbcIFSlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 14:41:09 -0400
Received: by mail-vk0-f42.google.com with SMTP id f76so108303900vke.0
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=GTpqeRTbRZbpCQYqpjkBgOtnGQlqXbbQ38kox5sqV6Q=;
        b=v7bh1Xu/llIgvY2XEBW3XyRNj3eTkQtD20PoPo6a0tzIM9/lpQIWyrwrhAdUHEIoc1
         LM3NZRwU0PZD7DXI3+2KsY7FzDuFlj3fa1Xzukz42aCqY4Ubu/66slF0oAT+4EPhPlqp
         UDDeyFkiIbfKBXh+r6pzIB7ZGtOP/XbDZRujoTOnWECZ0gN84CDb8E9E7BZTX8PdZYwE
         9s8Pq7V9OYQDCpIU/nAJeMpRVxxIAhX/WK7M+qdEX4J5qZlYJW5uM6vWI9lzQovTH22R
         uwT+Pic8KxCN1u1aVfiyD2CiUpTQqH4AelE0rKKvjqRQIPGCleswIuQzmbL9WD8UFm9v
         XhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=GTpqeRTbRZbpCQYqpjkBgOtnGQlqXbbQ38kox5sqV6Q=;
        b=d61lYGPrreEiOMepgoDey+9PCuyGLdzx11k+5146TH98xEAbDgDrQ2zJpzDWLmeDgV
         EugkrZQFc+AWdVlQozC+BlNuBcIdYx+jv3lpRHE5gZF9f9DUmB9+j/zb+AHIHxsjpdnp
         mNm+/m+fAO8dC4a5txFcHSmOW1QV7Bu8k1W1Y71z9z3SoOv1Od6kri0shk/+ZyGQQK8d
         7UFff3wTtMJkrf3ejw6hzaZ71a/Pi3Sj0wcrdLq78Fejsdi5STvX69ESW4tm3jCHAqcg
         m2jk/3a7URnU/VyFZWxkgHRN8TX1JvCoVd6WesdDK0BzOgk8rxWYt6G1JtDj6nNl77LE
         Sz0g==
X-Gm-Message-State: AE9vXwOymk/8pINqQtgjOyReo25oAX6Vaxjpcs+vAhHM/8OdCkUkttFsUzjvtvy5kh8j+U0WjFPDHx9C6vqmQA==
X-Received: by 10.31.87.194 with SMTP id l185mr26582613vkb.32.1473187235644;
 Tue, 06 Sep 2016 11:40:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.50.213 with HTTP; Tue, 6 Sep 2016 11:40:35 -0700 (PDT)
In-Reply-To: <CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com>
References: <CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com>
From:   Dakota Hawkins <dakotahawkins@gmail.com>
Date:   Tue, 6 Sep 2016 14:40:35 -0400
Message-ID: <CAG0BQX=i6gcA0ba5T7vcnaDPucZDcTOZUEGr=fhgpcDrbvQ1+g@mail.gmail.com>
Subject: Re: If a branch moves a submodule, "merge --ff[-only]" succeeds while
 "merge --no-ff" fails with conflicts
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there any additional information I could provide that would be helpful?

Dakota

On Fri, Sep 2, 2016 at 3:22 PM, Dakota Hawkins <dakotahawkins@gmail.com> wrote:
> Below is a simple reproduction of the issue.
>
> The _real_ problem is that this is how our pull request merges work,
> they're not allowed to do fast-forward merges. To work around this we
> are having to split this up into two pull requests/merges: One that
> copies the submodules to the new location and includes any fixes
> required to support the move, and a second that removes the old
> locations.
>
> ## Setup steps
> git clone https://github.com/dakotahawkins/submodule-move-merge-bug-main-repo.git
> cd submodule-move-merge-bug-main-repo
>     ## How it was initially constructed
>     # git submodule add ../submodule-move-merge-bug-submodule-repo.git
> ./submodule-location-1
>     # git commit -m "Added submodule in its initial location"
>     # git push
>     # git checkout -b move-submodule
>     # git mv ./submodule-location-1 ./submodule-location-2
>     # git commit -m "Moved submodule"
>     # git push --set-upstream origin move-submodule
> git branch move-submodule origin/move-submodule
>
> ## Test fast-forward merge, this will work
> git checkout -b merge-ff-test master # warning: unable to rmdir
> submodule-location-2: Directory not empty
> rm -rf ./submodule-location-2
> git merge --ff-only move-submodule
>
> ## Test no-fast-forward merge, this will fail with conflicts:
> git checkout -b merge-no-ff-test master
> git merge --no-ff move-submodule
>     # Auto-merging submodule-location-2
>     # Adding as submodule-location-2~move-submodule instead
>     # Automatic merge failed; fix conflicts and then commit the result.
> git status
>     # On branch merge-no-ff-test
>     # You have unmerged paths.
>     #   (fix conflicts and run "git commit")
>     #   (use "git merge --abort" to abort the merge)
>     #
>     # Changes to be committed:
>     #
>     #         modified:   .gitmodules
>     #         deleted:    submodule-location-1
>     #
>     # Unmerged paths:
>     #   (use "git add <file>..." to mark resolution)
>     #
>     #         added by us:     submodule-location-2
>     #
>     # fatal: Not a git repository: 'submodule-location-1/.git'
>     # Submodule changes to be committed:
>     #
>     # * submodule-location-1 07fec24...0000000:
