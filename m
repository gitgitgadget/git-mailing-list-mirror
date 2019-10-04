Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92FA21F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 08:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbfJDIuK (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 04:50:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:53693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbfJDIuK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 04:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570179007;
        bh=LbklikQr5ymBKQk8Zoj4KBPEcfztPQE/76Fq41gk0Y8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MomPfZemG9SkWkXwjo8/Zn+lc5uGZhFPbfdSD0pRDfe0jVQhrRZxKjk8TkOO60Ku3
         qoDfSwVjdyix1gKFRkPuEEK42BqJDW8foSD4zQ1geylv6pqun8XHoYEVj+02yaoyTE
         zdsOKQkJ8oRy51Bvl+21zjYwkDWYgQVpH/3b8KFs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.189]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1hrBfH0Nki-00lTGx; Fri, 04
 Oct 2019 10:50:07 +0200
Date:   Fri, 4 Oct 2019 10:49:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     harish k <harish2704@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
In-Reply-To: <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com> <20160331164137.GA11150@gmail.com> <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com> <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
 <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dVF9c/Hs/bpdcaKujiPcFOThtZ6ouEkXh/yxncsOnjfqkpU3cts
 7+QlZbKzrVrlaY+TlQCvYvsTD3ahSg1Cjbsh7xsyTRfIX/dgONQsEVLQgPauqPk+wIjVzLP
 Q23Jl1ygcLiD9w8w7obbpzlZgqw/iDyO9dgWYY1XTTc3NOvf9rumbpETmopZz5n6fXlGLJi
 X4uEZGp3Cdn/leK47T1iA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JfesbYwFxiw=:XqoNpamOEIDBbZmpPlduuQ
 zrNwpkFglCUSGODbzMYNN2RAwQ05JyBikXDTg0d2dN4GLWfoji948ytJS/dBQxS/zSnhX5b7p
 7GMtpRrTRgSQkwmYbIgYZxO0bbIYzsIGTB9Zlwe8qEoWTe6c6VGx2pc6ms/fRScLJHcp4NHUf
 XIcvzhelvE9V6qFbdcQ5FXN1A+XoZABbqRyPnYiwa8pQiaY3qVjzZTPUwfKmxp3CkHgf7rBGu
 jogCMl9KtmM5invz8S1ni3AioBRqagUEch9cdhKm9S0v15CScF63+KpBQocCxpWPnrm7IMkU/
 rUEUEDYs0TUlFv1YMRZXWwZgyLea+flamZrRNT7GgCdtO1rkY8Qj7LtZZ7nuabkCbjQqGMr6f
 vJ4lS28ab+Pkml85fQhr0kuRpFjzChwR8M0Icc66WvURbV8O8kUyinT8vYEAZ4WenKO3xqE5x
 xWERIHMmPUQOZZkP4WjWAgXiT9SgpMYJ+kec8xi9qxojSpBZVV7bHLccP3FtZcz4CrCwFv/RM
 KT1aR4OfDt4CcBaJjAxuVONwQb4yNmkBV0dHXkuFhcA44YzXxaeC0oCkB1lZHQtvS5qX5FZFC
 E0tgxdBywPGk1KwlDPd94QWRx7MLt3FoBztnfGO03wpXSwdCJ/tNalt6KvnK9B5CkabGwhkpU
 mkFKAGvR0T6Vbsyj4fGU8SJKSUq2yiK/m19strbus1YqR6hGvONBeB20QIW8fQ4zmVzJkpSqs
 aI/ZiGcN+1nxetaeRwqLc47JRTmfmT4Clvmz/e0NzUpS97vI7jy4xWdMHWYvxCsX8bKsbmn3N
 L33FygkSHhKnNO1BF1FAN9BlDBMeF7odLa9SRlNIvJ74iayjPiGEhUcYuWHtEsEfStTTsIWGC
 +4JMgPOCdecyFte48oGC1tAliQjTpNtLBskugsB3yImUr3wVNbIf9FHodKn0etHDi5nEGvj+c
 ioCfuomGh/K32pjO+/SXPD2IqYMy9Hs1F4hb31oXXyUH6UYhhrv0i7fcJafCV4SBQD0fkobWy
 HZQJrMAVjsiiD5ZnNCn2x9pLWDLte0gjQpgtjlm84ZPnN1IFnRZxXv6B/gttMkBEjcx+sWqJw
 TIx4uisoJvGeYh44CzxC+fNxH5sZs2FFf+OXjSi/tP75QmYKRt/dlCOLtH6Haio6ISY97rhqi
 glBm0EbD/pJyBX7lYtxc07ZydzTRrPfBaSTY8yWhIigozvuA/jiw9pLJxTgZJt+06YFtOaNRA
 W4S/+SmgnyLRUtw/pQZwtxlKbbntMviCzFQpx7hnQ1z7HkoLokgTZzQ11N/c=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

please don't top-post on this list (yet another of these things
requiring extra brain cycles in the mailing list workflow).

On Fri, 4 Oct 2019, Pratyush Yadav wrote:

> Hi Harish,
>
> Thanks for the patch. Unfortunately, it seems your mail client messed up
> the formatting, and the patch won't apply. I'm guessing it is because
> your mail client broke long lines into two, messing up the diff.
>
> We use an email-based workflow, so please either configure your mail
> client so it doesn't munge patches, or use `git send-email`. You can
> find a pretty good tutorial on sending patches via email over at [0].
> The tutorial is for git.git, but works for git-gui.git as well.

Ah, well. Mailing list-based workflows are so easy, amirite? They are so
welcoming and inclusive, yes?
</sarcasm>

> If you feel more comfortable with GitHub pull requests, please take a
> look at Gitgitgadget [1]. Johannes (in Cc) has used it recently to send
> patches based on the git-gui repo (AFAIK, it was originally designed
> only for the git.git repo). Maybe ask the folks over there how they do
> it.

Harish, it is actually relatively easy to use GitGitGadget: just add a
remote like this:

	git remote add gitgitgadget https://github.com/gitgitgadget/git
	git fetch gitgitgadget git-gui/master

and then rebase your patch on top of that branch:

	git rebase -i --onto git-gui/master HEAD~1

Then force-push your branch to your GitHub fork of git.git and open a
Pull Request at https://github.com/gitgitgadget/git/pulls, targeting
git-gui/master.

GitGitGadget will welcome you with a (hopefully) helpful message ;-)

Ciao,
Johannes

>
> One more thing: your patch is based on the main Git repo. That repo is
> not where git-gui development takes place. The current "official" repo
> for git-gui is over at [2]. Please base your patches on top of that
> repo.
>
> [0] https://matheustavares.gitlab.io/posts/first-steps-contributing-to-g=
it#submitting-patches
> [1] https://gitgitgadget.github.io/
> [2] https://github.com/prati0100/git-gui
>
> Now on to the nitty gritty details.
>
> I like the idea. In fact, there were some discussions recently about
> having configurable key bindings for _all_ shortcuts in git-gui. Nothing
> concrete has been done in that direction yet though. But I feel like
> this is a pretty good first step.
>
> On 03/10/19 08:18PM, harish k wrote:
> > Hi All,
> > I', Just reopening this feature request.
> > A quick summary of my proposal is given below.
> >
> > 1. This PR will allow an additional configuration option
> > "guitool.<name>.gitgui-shortcut" which will allow us to specify
> > keyboard shortcut  for custom commands in git-gui
>
> A pretty nice way of doing it. But I would _really_ like it if there was
> an option in the "create tool" dialog to specify the shortcut. People of
> a gui tool shouldn't have to mess around with config files as much as
> possible.
>
> > 2. Even there exists a parameter called "guitool.<name>.shortcut"
> > which is used by git-cola, I suggest to keep this new additional
> > config parameter as an independent config parameter, which will not
> > interfere with git-cola in any way, because, both are different
> > applications and it may have different "built-in" shortcuts already
> > assigned. So, sharing shortcut scheme between two apps is not a good
> > idea.
>
> David has advocated inter-operability between git-gui and git-cola.
> While I personally don't know how many people actually use both the
> tools at the same time, it doesn't sound like a bad idea either.
>
> So, sharing shortcuts with git-cola would be nice. Of course, it would
> then mean that we would have to parse the config parameter before
> feeding them to `bind`. I don't suppose that should be something too
> complicated to do, but I admit I haven't looked too deeply into it.
>
> I'd like to hear what other people think about whether it is worth the
> effort to inter-operate with git-cola.
>
> > 3. New parameter will expect shortcut combinations specified in TCL/TK
> > 's format and we will not be doing any processing on it. Will keep it
> > simple.
>
> Are you sure that is a good idea? I think we should at least make sure
> we are not binding some illegal sequence, and if we are, we should warn
> the user about it. And a much more important case would be when a user
> over-writes a pre-existing shortcut for other commands like "commit",
> "reset", etc. In that case, the menu entires of those commands would
> still be labelled with the shortcut, but it won't actually work.
>
> Yes, your current implementation keeps things simple, but I think some
> light processing would be beneficial. And if we do decide to go the
> inter-operability with git-cola route, then processing would be needed
> anyway, and we can validate there.
>
> > ---
> >  Documentation/config/guitool.txt | 15 +++++++++++++++
> >  git-gui/lib/tools.tcl            | 15 ++++++++++++---
> >  2 files changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/config/guitool.txt b/Documentation/config/g=
uitool.txt
> > index 43fb9466ff..79dac23ca3 100644
> > --- a/Documentation/config/guitool.txt
> > +++ b/Documentation/config/guitool.txt
> > @@ -48,3 +48,18 @@ guitool.<name>.prompt::
> >   Specifies the general prompt string to display at the top of
> >   the dialog, before subsections for 'argPrompt' and 'revPrompt'.
> >   The default value includes the actual command.
> > +
> > +guitool.<name>.gitgui-shortcut
> > + Specifies a keyboard shortcut for the custom tool in the git-gui
> > + application. The value must be a valid string ( without "<" , ">" wr=
apper )
> > + understood by the TCL/TK 's bind command.See
> > https://www.tcl.tk/man/tcl8.4/TkCmd/bind.htm
> > + for more details about the supported values. Avoid creating shortcut=
s that
> > + conflict with existing built-in `git gui` shortcuts.
> > + Example:
> > + [guitool "Terminal"]
> > + cmd =3D gnome-terminal -e zsh
> > + noconsole =3D yes
> > + gitgui-shortcut =3D "Control-y"
> > + [guitool "Sync"]
> > + cmd =3D "git pull; git push"
> > + gitgui-shortcut =3D "Alt-s"
>
> The "Documentation/" subdirectory belongs to the Git project, and not to
> git-gui, so if you want to see this change, you'd have to submit a
> separate patch for it.
>
> As far as git-gui's documentation is concerned, unfortunately there is
> none yet. I have been meaning to start working towards it, but just
> haven't found the time or motivation to do it yet.
>
> > diff --git a/git-gui/lib/tools.tcl b/git-gui/lib/tools.tcl
>
> Like I mentioned before, please base your patches on the git-gui.git
> repo, and not git.git. So, this should read "a/lib/tools.tcl" instead of
> "a/git-gui/lib/tools.tcl".
>
> I haven't looked at the contents of the patch because I can't apply it,
> and I'd prefer to tinker around with it before commenting. So please
> re-send the patch in the proper format and we can discuss the
> implementation :).
>
> > index 413f1a1700..40db3f6395 100644
> > --- a/git-gui/lib/tools.tcl
> > +++ b/git-gui/lib/tools.tcl
> [snip]
>
> --
> Regards,
> Pratyush Yadav
>
