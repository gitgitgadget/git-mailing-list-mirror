Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623511F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfJEVKU (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:10:20 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:33405 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfJEVKU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 17:10:20 -0400
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5CD04100002;
        Sat,  5 Oct 2019 21:10:18 +0000 (UTC)
Date:   Sun, 6 Oct 2019 02:40:16 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: add a readme
Message-ID: <20191005211016.bsrnbwapyqvycygs@yadavpratyush.com>
References: <20191004221052.23313-1-me@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910052149490.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910052149490.46@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 05/10/19 09:56PM, Johannes Schindelin wrote:
> Hi Pratyush,
> 
> On Sat, 5 Oct 2019, Pratyush Yadav wrote:
> 
> > It is a good idea to have a readme so people finding the project can
> > know more about it, and know how they can get involved.
> >
> > Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> > ---
> >
> > I don't have much experience writing this kind of readme or
> > documentation, so comments are appreciated. Please feel free to chime in
> > with suggestions and things that can also be added.
> >
> >  README.md | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 128 insertions(+)
> >  create mode 100644 README.md
> >
> > diff --git a/README.md b/README.md
> > new file mode 100644
> > index 0000000..d76122d
> > --- /dev/null
> > +++ b/README.md
> > @@ -0,0 +1,128 @@
> > +# Git Gui - A graphical user interface for Git
> 
> Why not Git GUI? "Git" is a name, "GUI" is an abbreviation, and the
> convention is (at least as far as I can tell) to upcase abbreviations.

Well, the _appname global variable is set to "Git Gui". But I don't mind 
changing it to "GUI" either.
 
> > +
> > +Git Gui is a GUI for [git](https://git-scm.com/) written in Tcl/Tk. It allows
> > +you to use the git source control management tools via a GUI. This includes
>                   ^^^
> 
> I prefer to spell it as "Git", i.e. with an upper-case "G" because "Git"
> is a name. Lower-case "git" would suggest the command-line executable to
> me.

Will fix.
 
> > +staging, commiting, adding, pushing, etc. It can also be used as a blame
> > +viewer, a tree browser, and a citool (make exactly one commit before exiting
> > +and returning to shell). More details about git-gui can be found in its manual
> > +page by either running `man git-gui`, or by visiting the [online manual
> > +page](https://git-scm.com/docs/git-gui).
> > +
> > +Git Gui was initially written by Shawn O. Pearce, and is distributed with the
> > +standard git installation.
> > +
> > +# Building and installing
> > +
> > +Most of Git Gui is written in Tcl, so there is not much compilation involved.
> 
> "Most"? Are there parts that are not written in Tcl?

Well, there is the Makefile, which is a part of the project and not in 
Tcl. Also, if I open GitHub's "language stat bar" (the colored bar below 
"commits", "branches", "releases", etc), it says 96.4% Tcl, 2.7% 
Makefile, and 0.9% Other.

So _technically_ there is a small part not in Tcl.
 
> As far as I can tell, _no_ compilation is involved. Just a couple of
> substitutions, e.g. the version number.

Yes, correct. I suppose that was bad wording. Will fix.
 
> > +Still, some things do need to be done, so you do need to "build" it.
> > +
> > +You can build Git Gui using:
> > +
> > +```
> > +make
> > +```
> > +
> > +And then install it using:
> > +
> > +```
> > +make install
> > +```
> > +
> > +You probably need to have root/admin permissions to install.
> > +
> > +# Contributing
> > +
> > +The project is currently maintained by Pratyush Yadav over at
> > +https://github.com/prati0100/git-gui. Even though the project is hosted at
> > +GitHub, the development does not happen over GitHub Issues and Pull Requests.
> > +Instead, an email based workflow is used. The git mailing list
> > +[git@vger.kernel.org](mailto:git@vger.kernel.org) is where the patches are
> > +discussed and reviewed.
> 
> You might want to accompany this `README.md` with a
> `.github/PULL_REQUEST_TEMPLATE.md` that explains this, and discourages
> contributors from opening PRs (mind, some contributors will not even
> read this, let alone delete it nor refrain from opening PRs, but most
> contributors will read it and avoid unnecessary work).

Will do as a follow-up patch.

Thanks for the review.

-- 
Regards,
Pratyush Yadav
