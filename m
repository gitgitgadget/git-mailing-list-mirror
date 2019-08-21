Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DFD91F461
	for <e@80x24.org>; Wed, 21 Aug 2019 21:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfHUVax (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 17:30:53 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:42331 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfHUVax (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 17:30:53 -0400
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B6098200002;
        Wed, 21 Aug 2019 21:30:50 +0000 (UTC)
Date:   Thu, 22 Aug 2019 03:00:48 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git-gui: Add ability to revert selected hunks and
 lines
Message-ID: <20190821213048.khhcauckhbdmwk3q@localhost.localdomain>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <CAKPyHN1M+8WNJXc15xQz4zCb70mW+Pomi6NzscSnvyDod2Z=Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN1M+8WNJXc15xQz4zCb70mW+Pomi6NzscSnvyDod2Z=Pg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/08/19 09:06AM, Bert Wesarg wrote:
> Dear Pratyush,
> 
> putting me in Cc would have been nice :(
 
I wasn't sure if you were interested in git-gui any more, so I decided 
to not bother you. I will Cc you when I send a re-roll.

> I will look into your patches in the comming hours.
 
Thanks.

-- 
Regards,
Pratyush Yadav

> Bert
> 
> On Mon, Aug 19, 2019 at 11:41 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > Hi,
> >
> > This series adds the ability to revert selected lines and hunks in
> > git-gui. Partially based on the patch by Bert Wesarg [0].
> >
> > The commits can be found in the topic branch 'py/git-gui-revert-lines'
> > at https://github.com/prati0100/git/tree/py/git-gui-revert-lines
> >
> > Once reviewed, pull the commits from
> > 832064f93d3ad432616e96ca70f682a7cfdcc3e0 till
> > 72eed27a29f1e71cbefefa6b19f96c89793ac74d.
> >
> > Let me know if there is some other way I'm supposed to ask for a pull.
> >
> > [0]
> > https://public-inbox.org/git/a9ba4550a29d7f3c653561e7029f0920bf8eb008.1326116492.git.bert.wesarg@googlemail.com/
> >
> > Pratyush Yadav (3):
> >   git-gui: Move revert confirmation dialog creation to separate function
> >   git-gui: Add the ability to revert selected lines
> >   git-gui: Add the ability to revert selected hunk
> >
> >  git-gui/git-gui.sh    | 39 ++++++++++++++++++++++++--
> >  git-gui/lib/diff.tcl  | 65 ++++++++++++++++++++++++++++++++++++-------
> >  git-gui/lib/index.tcl | 27 +++++++++++-------
> >  3 files changed, 109 insertions(+), 22 deletions(-)
> >
> > --
> > 2.21.0
> >
