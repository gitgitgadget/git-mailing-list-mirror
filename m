Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6BC01F463
	for <e@80x24.org>; Tue, 17 Sep 2019 22:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfIQWvx (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 18:51:53 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:46331 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfIQWvw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 18:51:52 -0400
Received: by mail-pg1-f181.google.com with SMTP id a3so2762209pgm.13
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dg7TdMHVi7MulKGf+na3FqJUzIQnCFif6jbixNL2Crg=;
        b=CiYD8Rj3fHecMu2368zPZg3Gt17QuCWLTKEY2iAcQES+ZmK7TYSbwQ5I7pUoggyAC+
         PPg7hR5+aWJyh0+Wx98PuD/NjT/+sNAsHMl34/rz0/jMwyJen7AlJRcwn8iFdC4z57ZJ
         f7VDiTPs9BaN+XWPB6ZVb8ApKFBYs7ormP3MDi+t7dXBDh5JN5L8uNJ3iJJ5Z/GYOIyK
         Fm0C1AGn47L47pWmGSqu9ouwi6Koj1rDiLdrkY2MOzcU5JdZ5ReHdxRxM2Ive5Sfr6lL
         1nbUQQpbGRY27J5ylulZXK+meifpphfEvJeDZmSfv1oQjSB1Xl1B2kaLzfKv2q5C0TCz
         aHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dg7TdMHVi7MulKGf+na3FqJUzIQnCFif6jbixNL2Crg=;
        b=qeIvt2u7VFrso7c0c8ka5+QrZCZCm2yGQndhnvPOMu5NotTwlVpxea8cA005gbTXxE
         nFJYaokTXWvmCSSurRa15ajQldMMlwi27eV4dZ6joNRrv9oSrgpTNGlviyQira4OVDas
         5pXaLamDiLVDr00CFG3yxvdcuIQkTm5I8V29jerYyHfFjNNLg0i6VbVFxcY6zBW1A0yg
         kE0zzbtcSzRIvcUsITJaWGve3wcG4OXPJU9oivVsyAib4R9y88Lo2XJ4UgouUUO++8O9
         DGq4cAOKcREVKanO9pkZ/Se+8SLPvScVuKUB7rFNQsVDaC1uht6M90FAhduKia2u1AX/
         BHjQ==
X-Gm-Message-State: APjAAAVmGn30kT/S7pRbYKV9EP3GUHOhzmJr04EcwVvJGoar+brkj+lE
        bo/Lxq+brE3uo4SQVTLH52cHPooHiZ8=
X-Google-Smtp-Source: APXvYqwJ2DUKulzWtwp4XWIIbSCTIKufN+tb/1bJe5oecb6mEGcl0wlB9nGrphXGSIiOE11UsHiN4w==
X-Received: by 2002:a17:90a:af8d:: with SMTP id w13mr468831pjq.141.1568760711725;
        Tue, 17 Sep 2019 15:51:51 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id t8sm176096pjq.30.2019.09.17.15.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 15:51:50 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:51:48 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [GIT PULL] git-gui pull request
Message-ID: <20190917225148.GA80152@dentonliu-ltm.internal.salesforce.com>
References: <20190917201334.hfbvuisdwkwgvwg5@yadavpratyush.com>
 <20190917205051.GA63601@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917205051.GA63601@dentonliu-ltm.internal.salesforce.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 17, 2019 at 01:50:51PM -0700, Denton Liu wrote:

[...]

> > ----------------------------------------------------------------
> > Bert Wesarg (2):
> >       git-gui: convert new/amend commit radiobutton to checkbutton
> >       git-gui: add horizontal scrollbar to commit buffer
> > 
> > Birger Skogeng Pedersen (2):
> >       git-gui: add hotkeys to set widget focus
> >       git-gui: add hotkey to toggle "Amend Last Commit"
> > 
> > Pratyush Yadav (9):
> >       git-gui: allow reverting selected lines
> >       git-gui: allow reverting selected hunk
> >       git-gui: return early when patch fails to apply
> >       git-gui: allow undoing last revert
> >       Merge branch 'bp/widget-focus-hotkeys'
> >       Merge branch 'py/revert-hunks-lines'
> >       Merge branch 'bw/amend-checkbutton'
> >       Merge branch 'bw/commit-scrollbuffer'
> >       Merge branch 'bp/amend-toggle-bind'
> 
> Seems like this list is missing
> 
> 	Pat Thoyts (1):
> 		  Merge remote-tracking branch 'philoakley/dup-gui'
> 
> 	Philip Oakley (4):
> 		  git-gui: remove duplicate entries from .gitconfig's gui.recentrepo
> 		  git gui: cope with duplicates in _get_recentrepo
> 		  git gui: de-dup selected repo from recentrepo history
> 		  git gui: allow for a long recentrepo list
> 
> which should be in your PR but aren't in mainline Git yet.

Sorry, my mistake. Turns out these were merged a couple of years ago in
90dbf226ba (Merge branch 'js/msgfmt-on-windows' of ../git-gui into
js/git-gui-msgfmt-on-windows, 2017-07-25).

> 
> > 
> >  git-gui.sh          | 140 ++++++++++++++++++++++++++++++++++++++++------------
> >  lib/checkout_op.tcl |   6 +--
> >  lib/commit.tcl      |   4 +-
> >  lib/diff.tcl        |  96 +++++++++++++++++++++++++++++------
> >  lib/index.tcl       |   8 +--
> >  5 files changed, 199 insertions(+), 55 deletions(-)
> > 
> > -- 
> > Regards,
> > Pratyush Yadav
