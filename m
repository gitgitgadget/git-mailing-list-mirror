Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A3C1F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 23:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfJGXS2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 19:18:28 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52811 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfJGXS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 19:18:28 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4289DC0004;
        Mon,  7 Oct 2019 23:18:23 +0000 (UTC)
Date:   Tue, 8 Oct 2019 04:48:21 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] git-gui: add a readme
Message-ID: <20191007231821.mlaqhobojfca7fgv@yadavpratyush.com>
References: <20191004221052.23313-1-me@yadavpratyush.com>
 <20191006220935.31766-1-me@yadavpratyush.com>
 <xmqqimp149mb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimp149mb.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/19 10:39AM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
> >     -+# Git Gui - A graphical user interface for Git
> >     ++# Git GUI - A graphical user interface for Git
> >      +
> >     -+Git Gui is a GUI for [git](https://git-scm.com/) written in Tcl/Tk. It allows
> >     -+you to use the git source control management tools via a GUI. This includes
> >     ++Git GUI is a GUI for [Git](https://git-scm.com/) written in Tcl/Tk. It allows
> >     ++you to use the Git source control management tools via a GUI. This includes
> 
> (ignore me if this has been discussed already)

It hasn't been.
 
> The first sentence looks overly repeticious (it just looks to me as
> if saying "Git GUI is a Git GUI written in Tcl/Tk").  Saying
> 
> 	Git GUI allows you to use the [Git source control management
> 	tools](https://git-scm.com/) via a GUI and is written in
> 	Tcl/Tk.  This includes ...
> 
> may reduce the repetition somewhat.  Also if I were writing this
> intro, I'd move "writtein in Tcl/Tk" to a lot later or perhaps just
> drop the phrase from here; what the users can gain from the tool is
> much more important to the readers of this document than its
> implementation detail.  "Written in Tcl" is given in the installation
> section anyway.

Will fix.
 
> >      +staging, commiting, adding, pushing, etc. It can also be used as a blame
> >      +viewer, a tree browser, and a citool (make exactly one commit before exiting
> >      +and returning to shell). More details about git-gui can be found in its manual
> >      +page by either running `man git-gui`, or by visiting the [online manual
> >      +page](https://git-scm.com/docs/git-gui).
> >      +
> >     -+Git Gui was initially written by Shawn O. Pearce, and is distributed with the
> >     -+standard git installation.
> >     ++Git GUI was initially written by Shawn O. Pearce, and is distributed with the
> >     ++standard Git installation.
> >      +
> >      +# Building and installing
> >      +
> >     -+Most of Git Gui is written in Tcl, so there is not much compilation involved.
> >     -+Still, some things do need to be done, so you do need to "build" it.
> >     ++Most of Git GUI is written in Tcl, so there is no compilation involved. Still,
> >     ++some things do need to be done (mostly some substitutions), so you do need to
> >     ++"build" it.
> 
> It is a good thing to say that it is written in Tcl for two
> reasons..  The users need to know (1) they need to know Tcl/Tk to
> hack on it, and (2) they need to install "wish" as a prerequisite to
> run it.  
> 
> Does the document mention the latter explicitly?  If it does not, it
> probably should.  Also it helps to have msgfmt installed when
> building git-gui.  That also should be mentioned.

No, it does not.

I'll also check if there are any other dependencies. I installed git-gui 
from my distro's package manager, so I got all the dependencies pulled 
in automatically, and don't remember if there was something other than 
Tcl and wish needed.

-- 
Regards,
Pratyush Yadav
