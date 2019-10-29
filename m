Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655961F4C1
	for <e@80x24.org>; Tue, 29 Oct 2019 23:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfJ2Xwy (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 19:52:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39300 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfJ2Xwy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 19:52:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id t8so724736qtc.6
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 16:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lga3K07bB/OBNGgdI7slHDsPzdO/K1V18GZW4VHcl1s=;
        b=QXHRJ8wDh7f4z5s0XL2yg8vbwRD+vut+Ai54gTqdJSIiEtjlVOan2KgEY6T9c0G3a8
         NYaxLlorGP4noV8YvVYohVz7XBEXHnWNJ07lSss7Y/JMHKjSsy6Nn/iLdAXGIwGiuQ4O
         1dTEEiNZG3vg34SGRXun1xmWMpR1uoMdxeSuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lga3K07bB/OBNGgdI7slHDsPzdO/K1V18GZW4VHcl1s=;
        b=ZkmYUBnb017dLROVFp22bp3jY7IdkZ4+FnvjaRsD8lR3dZ/6tO5sIYv+q4GqEyA1Y+
         h5z2WbBtX6QvSDPPhWDQhEYCO+CI6PGsSaWgwkt8ufhaOAN4fhBUOTWZGfoPmqMK4BDS
         ekXJ14AOfEf1DUN5RUqBtLcdDC+AafUUtqNEDzEHws234vsFHlaADF1aYpQqixpVe71Y
         k+s4TYD4eGKAgR9xH3FJ6u1cuUZwvny+7uXb4ZQiddQewHHlkk9CE/YuJyxw9onzr04G
         DJzqGiHfoF531CtLEBjS2+1QSE6L3+jwztB4OJY0SLcVajRjCjcOfQKrYjKXP509XiG1
         K8BA==
X-Gm-Message-State: APjAAAUkwGHhYDo241ocBLlzCZf2glzmgtzHEJRlwyNTEJnG4t/elh/Z
        J5TVb2UPDIJDsP9sQKlXaBQl7te3MowocliJjndikg==
X-Google-Smtp-Source: APXvYqxBKcgp7OPj6ldyKRwnzppceu7k3PGuEtjws9COhDTjbJLeD9EjJwIbjl0jTktUhIjkNoU6uEn/wt2yFgiVUB4=
X-Received: by 2002:ac8:6a04:: with SMTP id t4mr2106034qtr.37.1572393167281;
 Tue, 29 Oct 2019 16:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.423.git.1572289087.gitgitgadget@gmail.com>
 <56faba848676ffc5441f373bc2105392fc2a3e11.1572289087.git.gitgitgadget@gmail.com>
 <20191029212734.luledidagh7dnx5y@yadavpratyush.com>
In-Reply-To: <20191029212734.luledidagh7dnx5y@yadavpratyush.com>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Tue, 29 Oct 2019 18:52:25 -0500
Message-ID: <CAPSOpYs7GX6Sg-rYCbhs-s8cTCLkUV=tsfx-JBQhCTP=nSr0_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-gui: Revert untracked files by deleting them
To:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reply :-)

> While git-gui is distributed in the main Git tree, the development
> happens on a separate repo, and the Git maintainer periodically pulls in
> changes from that repo. It can be found at [0]. For now, I munged your
> patch to apply on my tree, but please base it on the git-gui repo for
> your re-rolls or future patches. You can use GitGitGadget to do that
> [1].

Alright :-)

> Now, on to the patch.
>
> On 28/10/19 06:58PM, Jonathan Gilbert via GitGitGadget wrote:
> > From: Jonathan Gilbert <JonathanG@iQmetrix.com>
> >
> > My development environment sometimes makes automatic changes
> > that I don't want to keep. In some cases, this involves new
> > files being added that I don't want to commit or keep. I have
> > typically had to explicitly delete those files externally to
> > Git Gui, and I want to be able to just select those newly-
> > created untracked files and "revert" them into oblivion.
>
> I think the description of your workflow belongs in the cover letter
> more than here. The commit message should take a more neutral tone. So,
> describe the problem in an objective way that not only you, but other
> git-gui users might face.

That's totally fair, I was sort of shooting in the dark since this is
the first such patch I have made. I will reword the commit message.

> > +     # If an action is taken that implicitly unlocks the index, this gets cleared. Either way, it is executed at the end of the procedure.
>
> The convention is to wrap lines at 80 columns wherever possible. Please
> follow that. You can look at the rest of the code for examples.
>
> You have other lines too that are too long. The same comment applies to
> all those.

Roger.

> > +     set epilogue [list]
> > +     lappend epilogue {unlock_index}
> > +
> > +     proc already_unlocked {} { upvar epilogue epilogue; set epilogue [lsearch -inline -all -not -exact $epilogue {unlock_index}] }
>
> A procedure defined inside a procedure? Please don't do that. Define it
> outside.
>
> Also, what is this procedure supposed to do? It is not very clear at
> first read.

The name could probably be improved, but this procedure can't live
outside of the outer proc because it is lexically tied to it. It takes
an action on state that is in a local variable. If it's flat-out
disallowed to use a proc to abstract this, then every place that wants
to indicate that the repository is already unlocked and doesn't need
to be explicitly unlocked in the epilogue will have to repeat the code
inside the proc.

This becomes a non-issue if I rework the function so that it doesn't
end with a dynamic epilogue (see below).

> > +
> >       set pathList [list]
> > +     set untrackedList [list]
>
> Nitpick: Ugh! camelCase in a sea of snake_cases. What's even more
> unfortunate is that `pathList` itself is in camelCase, so that's
> probably the reason you went with camelCase in the first place. Maybe
> re-name `pathList` to `path_list` while we're at it, and then use
> snake_case everywhere?

Absolutely, yeah I was just copying what I already saw there, but I'm
all in favour of consistency. :-)

> > +     set numPaths [llength $pathList]
> > +     set numUntracked [llength $untrackedList]

Will fix this too.

> > +                                     try {
> > +                                             file delete -- $path
> > +                                     }
> > +                                     catch {
> > +                                             # This is just a best effort, don't annoy the user with failure to remove empty directories.
> > +                                             break
> > +                                     }
>
> The convention in this project is to just use `catch`, and not try. So
> something like:
>
>   catch {file delete -- $path}

I'm not super familiar with TCL, where does the `break` statement fit into this?

I did a Google search and saw that catch returns a value that you can
inspect, would I write this?:
```
if { [catch {file delete -- $path}] } {
  break
}
```

> > +                                     set path $directoryPath
> > +                                     set directoryPath [file dirname $path]
>
> I read this loop as "if all the paths in a directory are removed, remove
> the empty directory as well". Do I read correctly?
>
> Will there be problems in deleting the directory? What if the user wants
> to keep the directory, and just delete the files? Is that even a valid
> use-case?

Well, Git itself doesn't keep empty directories. As such, I wrote the
code with an (undocumented) assumption that if there is a directory
that contains only a single untracked file, then the directory was
probably created to put the file in it.

> > +                             }
> > +                     }
> > +
> > +                     lappend epilogue {ui_do_rescan}
>
> A rescan is an expensive operation, so we should use it judiciously. Are
> you sure it is really needed? The "Revert" code does not do a rescan but
> still manages to update the list of "unstaged files". How does it manage
> that? Can the new code do something similar?

I'll look into it, but I'm assuming it's happening as part of `checkout_index`.

> > +             }
> >       }
> > +
> > +     foreach epilogueCommand $epilogue { {*}$epilogueCommand }
>
> Why not use `eval` [2]? Are there any downsides to that compared to your
> way? If not, use `eval`. At least it means better readability if nothing
> else.

I wrote some TCL over a decade ago for Eggdrop bot scripts, and
haven't touched it until now, so my ambient knowledge of TCL is quite
limited. I'll look into how to use `eval` for this. :-)

> As far as I see, you use $epilogue for two things: unlocking the index
> and rescanning. Can you move the control flow around that both can be
> done in the "normal" way. That is, they are not a part of a list of
> things to do at the end, but instead are done when needed. For example,
> just move the call to `unlock_index` at the end instead of putting it in
> epilogue. Can the same be done for `ui_do_rescan` (if you do go with a
> rescan instead of doing it like the existing revert does)?

Well, `unlock_index` will presumably throw an error if
`checkout_index` gets called, but `checkout_index` only gets called if
the scan finds tracked files with changes _and_ the user opts to
revert them.

Similarly, `ui_do_rescan` wants to be done exactly once at the end,
but only if the scan finds untracked files _and_ the user opts to
delete them.

An alternative to the epilogue could be two booleans
`need_unlock_index` that starts out true and `need_rescan` that starts
out false, and then the function's epilogue, instead of being dynamic,
just checks the booleans and does the things.

> >  }
> >
> >  proc do_revert_selection {} {
>
> While I appreciate the idea of such a feature, I'm surprised by how
> complex the implementation is. I expected something much simpler. The
> complexity can probably be managed a bit better by moving the control
> flow around.
>
> I couldn't dive in the code as deep as I wanted to because I don't have
> too much time on my hands. But maybe I'll look further by the time your
> re-roll arrives. Thanks.
>
> [0] https://github.com/prati0100/git-gui
> [1] https://github.com/prati0100/git-gui#using-gitgitgadget
> [2] https://www.tcl.tk/man/tcl8.6/TclCmd/eval.htm
>
> --
> Regards,
> Pratyush Yadav
