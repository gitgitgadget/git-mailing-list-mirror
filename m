Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93DD620282
	for <e@80x24.org>; Wed, 21 Jun 2017 03:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbdFUDps (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 23:45:48 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36822 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbdFUDpr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 23:45:47 -0400
Received: by mail-wr0-f179.google.com with SMTP id c11so60977737wrc.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=csXVC3k06f+M/KwXjY7b1Cq6NV2vJFFz2VYFIX1lBL4=;
        b=SQ+xQ0+/mA+5OI2i2IYrl4OwWHszRUG5nmaZRv9Yx8bDIyQjtj4Vqmr8na+sq66u5E
         tkK/XC/x/mH1AhfuOC5hqgRuZmquui7N2rcEt9C8gaywMKH0csA2bcs4G9sgW7Q9y0z/
         iaVP8sjDwX8bynXHk9YUkreN0mBzVdC2nTdyfJgczxrL/fAssz35oEE5vJeUrAa9BFc+
         T0zKfRhh3N5wQwGgQYA7PuaNPa4b/9CFrRlsNe1adFBpYEG+eoi3thceiWNEn5wWVUuR
         p7+ij2jPNgaTBK7Cd8RJerXMf7GMIOZ9Yh+tMk035lci/YgjPIRKBU4L5KuXaHgcdPuR
         oYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=csXVC3k06f+M/KwXjY7b1Cq6NV2vJFFz2VYFIX1lBL4=;
        b=PMrNZHc6nYpa2i5Y7T8znajZ1gZLipezP6oavO8JEDIlLa1C41b580EKHHc1vs3hRv
         QDjXTrWFIxLoIfHlEQqNMRzDzhwuS4f3sEinWhRUdOGA90x7kW9zeKNFZERlsL1W7BJv
         zgVRJu3kBZa4gOknJGAbxLJ8cn2EibmwP7gSnxHatbwZSHIQA08cF3iVJWI/25kl14G4
         67hvVLqtQXVXrcSqa9ad/4Q5YnaaMWSkWgLEQUNJ4Ihqp+0MozO2NMhmC8+qucbbGkzp
         DCBz9SBaaihGDl8jU89X9emTEMzM/aPHEChvzJWHQsm3j6jyGjufi2FVvYvK9dsosBny
         QLfg==
X-Gm-Message-State: AKS2vOz9GOn2zusMcpz2slyf4A1zUW9e6BdMEuAcA4g0s7DCFuFlR9kz
        znjep7VMNAVk9/wL65q6BQmNMixAFCf1
X-Received: by 10.28.126.67 with SMTP id z64mr4861550wmc.65.1498016745612;
 Tue, 20 Jun 2017 20:45:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.133.200 with HTTP; Tue, 20 Jun 2017 20:45:44 -0700 (PDT)
In-Reply-To: <20170620225650.7573-1-sbeller@google.com>
References: <20170607185354.10050-1-sbeller@google.com> <20170620225650.7573-1-sbeller@google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 20 Jun 2017 20:45:44 -0700
Message-ID: <CAGf8dg+f-RzcT15zofB9xbgEE6nTK+T7awjOHY+KEx7KZ-cPXg@mail.gmail.com>
Subject: Re: [PATCHv2] submodules: overhaul documentation
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, this looks like a good explanation. Some more nits, but
overall I feel like I understand this and have learned something from
it.

On Tue, Jun 20, 2017 at 3:56 PM, Stefan Beller <sbeller@google.com> wrote:
> +A submodule is another Git repository tracked inside a repository.
> +The tracked repository has its own history, which does not
> +interfere with the history of the current repository.
> +
> +It consists of a tracking subdirectory in the working directory,
> +a 'gitlink' in the working tree and an entry in the `.gitmodules`

Probably should be `gitlink` (the special quotes), and (optional)
s/`gitlink`/`gitlink` object/ because it might not be apparent that
gitlink is a type of object.

> +file (see linkgit:gitmodules[5]) at the root of the source tree.

After reading below, maybe we should mention the Git directory in
$GIT_DIR/modules/<submodule name> as part of what a submodule consists
of too.

> +The tracking subdirectory appears in the main repositorys working

s/repositorys/repository's/ (apostrophe is also missing in some other
places below)

> +tree at the point where the submodules gitlink is tracked in the
> +tree.  It is empty when the submodule is not populated, otherwise
> +it contains the content of the submodule repository.
> +The main repository is often referred to as superproject.
> +
> +The gitlink contains the object name of a particular commit
> +of the submodule.
> +
> +The `.gitmodules` file establishes a relationship between the
> +path, which is where the gitlink is in the tree, and the logical
> +name, which is used for the location of the submodules git
> +directory. The `.gitmodules` file has the same syntax as the
> +$Git_DIR/config file and the mapping of path to name

Capitalization of $GIT_DIR

> +is done via setting `submodule.<name value>.path = <path value>`.

(Optional) I would prefer <name> and <path> to be consistent with the
following paragraph.

> +The submodules git directory is found in in the main repositories
> +'$GIT_DIR/modules/<name>' or inside the tracking subdirectory.
> +
> +Submodules can be used for at least two different use cases:
> +
> +1. Using another project while maintaining independent history.
> +  Submodules allow you to contain the working tree of another project
> +  within your own working tree while keeping the history of both
> +  projects separate. Also, since submodules are fixed to a an arbitrary
> +  version, the other project can be independently developed without
> +  affecting the superproject, allowing the superproject project to
> +  fix itself to new versions only whenever desired.
> +
> +2. Splitting a (logically single) project into multiple
> +   repositories and tying them back together. This can be used to
> +   overcome current limitations of Gits implementation to have
> +   finer grained access:
> +
> +* Size of the git repository
> +  In its current form Git scales up poorly for very large repositories that
> +  change a lot, as the history grows very large.
> +  However you can also use submodules to e.g. hold large binary assets
> +  and these repositories are then shallowly cloned such that you do not
> +  have a large history locally.
> +
> +* Transfer size
> +  In its current form Git requires the whole working tree present. It
> +  does not allow partial trees to be transferred in fetch or clone.
> +
> +* Access control
> +  By restricting user access to submodules, this can be used to implement
> +  read/write policies for different users.

The bullet points should probably be indented more.

[snip]

> +Deleting a submodule
> +--------------------
> +
> +Deleting a submodule can happen on different levels:
> +
> +1) Removing it from the local working tree without tampering with
> +   the history of the superproject.
> +
> +You may no longer need the submodule, but still want to keep it recorded
> +in the superproject history as others may have use for it. The command
> +`git submodule deinit <submodule path>` will remove any configuration
> +entries from the config file, such that the submodule becomes

s=config=$GIT_DIR/config= (since there are multiple relevant config files)

> +uninitialized. The tracking directory in the superprojects working
> +tree that holds the submodules working directory is emptied.
> +This step can be undone via `git submodule init`.
> +
> +2) Remove it from history:
> +--
> +   git rm <submodule path>
> +   git commit
> +--
> +This removes the submodules gitlink from the superprojects tree, as well
> +as removing the entries from the `.gitmodules` file, but keeps the
> +local configuration for the submodule. This can be undone using `git revert`.
> +
> +
> +3) Remove the submodules git directory:
> +
> +When you also want to free up the disk space that the submodules git
> +directory uses, you have to delete it manually as this
> +step cannot be undone using git tools. It is found in `$GIT_DIR/modules`.
