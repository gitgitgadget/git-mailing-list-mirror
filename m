Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218D61FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 18:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935250AbeAKSRn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 13:17:43 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:40226 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934034AbeAKSRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 13:17:42 -0500
Received: by mail-qt0-f171.google.com with SMTP id u42so2928220qte.7
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 10:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S175D/1W+oyW/srjnumi2iYerThvL/97y9ffeeb+xkQ=;
        b=HcbQkhIQ6LKuRknQL1Uog76lSNgCijwhtXz/mRvbRm61OJs1Kq8V38YptPhPJetZk/
         gUPLT7Ezw3W6rFi+fCu1v2BprQrJgczeRakBaYjome/Bwrvo7Zw5+KMMWEjbNJhQ2O3G
         06rygARJTMcVbenNRUVqkuv5KGkomTtAby7nb3Z7S/ApEuTyDcqKw8QvllogU3ZHmx3z
         939mDI7clO75D0oqSbF2alvxOCpfuu1DBJke8E7yDSDWllCRhG1oBo41Vo0AJzxxhB64
         BDsUcPvylBcO8Jlms5F8f53v7K+Rc/7YaIHtOPqyHvjmjeV4gOy6Z6HPFPP1zGioHbWR
         DsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S175D/1W+oyW/srjnumi2iYerThvL/97y9ffeeb+xkQ=;
        b=ClS8Qyv3bg8c6NU32RUQyAKWOuEBSWDqZwPgJV9mr+dbgj4hh/bDI40rkBh9kePZjO
         /p5xBEKmJ86Q92R7AsK2EvuYWLz9KhZkH+Mkog1tKPKtBzZWPp1KXmcKTb6sfD/Cqwui
         dgcC49tth5WL4EO6hQ5oVxhuwwUWjomceGnINWfKJaX/NT6jHkNjUxMpuXPcFFZ2ohuP
         HDdZlnxHTls7L1m8/Vg+pWspiHVHY/82jqM7fJrV/EXTYYoVpUM2cpePUGFE4X24JPJ1
         GRznF4epB+0EOjq1KM2DqGPcgyrV67JZGYStP9xuYo6cc7LKomVEt81MPsg3YdMp8ec7
         KMIA==
X-Gm-Message-State: AKwxytfnc4CQseb3WJIIoe0vZgRbtcK26fAZruTShNsCctRPjkZ/2mrD
        jbzZn4IGdp9+AhtdtRwzfTDicAIBYEXQjL2MqRDFZOhPOvg=
X-Google-Smtp-Source: ACJfBosp1xCf3cBfMuwu5Nw6S/p56MDBezxciTS+CcxbTGEOdY6x0y2Z3U4HWw4dOKaz1No3LRh9jDpiX9lWoTVzXZ4=
X-Received: by 10.237.38.3 with SMTP id z3mr2529765qtc.180.1515694661580; Thu,
 11 Jan 2018 10:17:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 11 Jan 2018 10:17:40 -0800 (PST)
In-Reply-To: <87k1woa3i9.fsf@evledraar.gmail.com>
References: <87k1woa3i9.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 Jan 2018 10:17:40 -0800
Message-ID: <CAGZ79kajv9Pf4qc_1wgDD=NTimT1Ss7Wz-8fNNbmkgLO40VVGg@mail.gmail.com>
Subject: Re: Unable to de-init stubborn submodule
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 6:12 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> What if we wanted to drop sha1collisiondetection/ as a submodule and
> replace it with a copy of what's now in sha1dc/? I ran into this with
> another project, but here's a way to reproduce it on git.git:
>
>     (
>         rm -rf /tmp/git &&
>         git clone git@github.com:git/git.git /tmp/git
>         cd /tmp/git &&
>         git tag nuke-before &&
>         git submodule update --init &&

At this point
    $ tail -n 3 .git/config
    [submodule "sha1collisiondetection"]
        active =3D true
        url =3D https://github.com/cr-marcstevens/sha1collisiondetection.gi=
t


>         git rm -r .gitmodules sha1collisiondetection &&

no need to delete the .gitmodules here. Git detects you're deleting a submo=
dule
and adjusts the .gitmodules file (it is empty after just "git rm sha1coll..=
.")

>         git commit -m"Nuke sha1dc submodule" &&
>         cp -Rvp sha1dc sha1collisiondetection &&
>         git add sha1collisiondetection &&
>         git commit -m"Now it's not a submodule" &&
>         git tag nuke-after &&
>         git reset --hard nuke-before &&

As bmwill said, you may want to reset with --recurse-submodules here,
"git ls-tree HEAD |grep sha1c" will show commit and "git status" thinks
everything is fine on disk. I have no suspicion to believe otherwise.
But we digress, you chose to not use that flag.

>         git submodule update --init && # skip this and the below won't fa=
il
>         git reset --hard nuke-after && # Emulate someone doing a pull

$ git reset --hard nuke-after
warning: unable to rmdir 'sha1collisiondetection': Directory not empty
HEAD is now at f683a1b81 Now it's not a submodule
$ git reset --hard nuke-after --recurse-submodules
HEAD is now at f683a1b81 Now it's not a submodule


>         git ls-tree HEAD | grep sha1collisiondetection && # OK, shows "tr=
ee" not "commit"
>         test $(git rev-parse HEAD) =3D=3D $(git -C sha1collisiondetection=
/ log -1 --pretty=3Dformat:%H) && echo OK || echo WTF
>     )
>
> This results in a really bizarre state where according to ls-tree
> sha1collisiondetection is a tree at the current commit:
>
>     040000 tree 81583289d96bdde4b366c243ab524ea28d895ea5    sha1collision=
detection
>
> But git still believes there's a submodule there for some reason, and
> shows the log for the upstream sha1collisiondetection project:
>
>     git -C sha1collisiondetection/ log -1

(A)
That is because the reset without flag do touch submodules kept the
submodule in place and the -C in this command tells git to cd into that
directory, (which is the submodule, an 'independent' repo) and shows the
log of said repo.

>     commit 19d97bf (HEAD, origin/master, origin/HEAD, master)
>     Merge: 3f14d1b c93f0b4
>     Author: Dan Shumow <shumow@gmail.com>
>     Date:   Sat Jul 1 12:36:15 2017 -0700
>
>         Merge pull request #37 from avar/fixup-pull-request-34
>
>         Fix endian detection logic for Sparc, little endian BSD etc.
>
> Doing:
>
>     git submodule deinit sha1collisiondetection

Doing this after you reset to nuke-after, there are no submodules from
the superprojects point of view, hence no submodule is touched/modified. :/
(There just happens to be a stray repository at a place where we'd want
to have a tree).

> Does nothing to help, then I thought it might be:
>
>     git config -f .git/config -l|grep ^submodule
>     submodule.sha1collisiondetection.active=3Dtrue
>     submodule.sha1collisiondetection.url=3Dhttps://github.com/cr-marcstev=
ens/sha1collisiondetection.git
>
> But running:
>
>     git config --remove-section submodule.sha1collisiondetection

This made the submodule not active any more, (note that at the current
tree there
is no submodule to begin with... so what effect to we want here?)

> Doesn't help either, neither does removing the index:
>
>     rm .git/index &&
>     git reset --hard
>
> If you then do:
>
>     rm -rf .git/modules

Getting out the big hammer, eh?

instead of deleting the submodules git repo, remove its worktree:

    rm -rf sha1collisiondetection

(This is best done at time (A) above)

>
> You'll get this error:
>
>     git -C sha1collisiondetection/ log -1
>     fatal: Not a git repository: /tmp/git/sha1collisiondetection/../.git/=
modules/sha1collisiondetection
>
> But I can't see what's still referencing it.

$ls -la /tmp/git/sha1collisiondetection
...
-rw-r--r--  1 sbeller eng    47 Jan 11 10:02 .git
...
$ cat sha1collisiondetection/.git
gitdir: ../.git/modules/sha1collisiondetection

This is a crucial file, telling you there is a repo with the worktree
at the place where
.git lives and the git dir is at the location indicated (which you removed)

> This problem is avoided if, as noted with a comment I skip:
>
>     git submodule update --init
>
> But I shouldn't need to remember to de-init a submodule before moving to
> a new commit that doesn't have it, least I end up in some seemingly
> unrecoverable state.
>
> Am I missing something obvious here?

The "git submodule update/init/deinit" is a "raw" command,
(not to be confused with plumbing, I just made up "raw commands" ;)
that is very good to deal with submodules, but that tool has sharp edges.
Try this:

  $ git clone --recurse-submodules=3D. git@github.com:git/git.git testgit
  $ cd testgit/
  $ git config --list |grep submod
submodule.active=3D.
submodule.sha1collisiondetection.url=3Dhttps://github.com/cr-marcstevens/sh=
a1collisiondetection.git
  $ git config submodule.recurse true
  $ git tag before-nuke
  $ git rm sha1collisiondetection/
  rm 'sha1collisiondetection'
  $ git commit -a -m delete_sub
  $ git tag after-nuke
  $ git checkout before-nuke
  $ git status # and more checks
  $ git checkout after-nuke
  $ git status # and more checks
