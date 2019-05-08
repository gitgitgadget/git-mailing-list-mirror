Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3BE11F45F
	for <e@80x24.org>; Wed,  8 May 2019 18:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfEHS6O (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 14:58:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45088 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHS6O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 14:58:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id a5so5410069pls.12
        for <git@vger.kernel.org>; Wed, 08 May 2019 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SqHFd7LcWwnFO23XVOTu4AzpZB9TDmr3PwrGZxlO/qA=;
        b=QbIXnUmEXE+igJD3gLDzy4fB8S6m7pKgykxoHy7qrETx4R8ghEAS4BJxnqcFfbSjAN
         zyHZeQ9yFa/KSHqgFE6EaajHIZtYz9qZ/WwsoZw2l09YU3IVPEPD8yz+QFANqaqcXA+W
         At7//mqbuvefo20llqEf5+XZ/xe4vDD5F9vlC/v7FeixQ8NcGdJ0BUcwudR+0kXgtKh9
         XJhG/4GV/xOUWvoTqmDyBrKFangcfQjLEkgj83G1IjUvrmXWSpsw+bHrwpCPwfroivi4
         5WybxSYX0Cb+HPMdpKeyFd9hnqMUsnSYgn62Dogxs4i4Cgw/MleJda2Qpx1e4vwo4cZu
         5w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SqHFd7LcWwnFO23XVOTu4AzpZB9TDmr3PwrGZxlO/qA=;
        b=NHwD6EAIB3RneuAkP5fF7FejUUWCUAUZ8x8Rjk2y6A6rxJsVGFrmBCsClsTWvfu0BY
         FWr1xxSsSw1LeampFr1YprlQaD5X1opJpJJPIX8m8DwQxdDF1awx9JIIwDKevDOU6k+s
         zbIrwzrxcGzDFwAIXV/abLQ2hYID23sTA+0Un2WIlp+3iGw2BiknrXkxMjBP0NkQUYB1
         VtIK2qTfY+p+EE9447/lOe8YIPx+ruZ3iWybxStEG9pSeor8Eh2swJddZhZW5/JEl4mc
         4IeUlb8xR8tJu6d6MJRl7sz0R/7ZheQ3K72IuvlYqzsuhc8ijyufv2ji12/ElW+8umNP
         zXbg==
X-Gm-Message-State: APjAAAWqucKSlov1+p0Qh7j/2I/1n0Xmo+SKlFj1sXzA3+c2p6fLPA93
        Qaq03Hcum6M1Mj6d1/VagCMc2A==
X-Google-Smtp-Source: APXvYqyTn6NBrdqYFuFafsFB0CyjMWTBNhxM1BsU8R/zxcR63FcWZ4CeCtwQ0MHwjKXzMoNBAZB+Zw==
X-Received: by 2002:a17:902:7c93:: with SMTP id y19mr16086628pll.268.1557341892838;
        Wed, 08 May 2019 11:58:12 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id k7sm20509173pfk.93.2019.05.08.11.58.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 11:58:11 -0700 (PDT)
Date:   Wed, 8 May 2019 11:58:07 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v5 1/2] documentation: add tutorial for first contribution
Message-ID: <20190508185807.GA14000@google.com>
References: <20190423193410.101803-1-emilyshaffer@google.com>
 <20190507213040.151799-1-emilyshaffer@google.com>
 <20190507213040.151799-2-emilyshaffer@google.com>
 <xmqqimulip5k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimulip5k.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 08, 2019 at 12:46:47PM +0900, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +=== Clone the Git Repository
> > +
> > +Git is mirrored in a number of locations. Clone the repository from one of them;
> > +https://git-scm.com/downloads suggests one of the best places to clone from is
> > +the official mirror on GitHub.
> 
> I didn't want to have to get into fine-grained wordsmithing (let
> alone bikeshedding) this late in the iteration of the topic, but
> "the official mirror" is not something anybody suggested in the
> recent reviews (JTan's rephrasing, which I already said that I am OK
> with, said something like "one of the many mirrors").

I should have waited longer on sending this round of patch out; as it
stands I sent the patch with this fix a few hours before your response
to JTan came out. Sorry for the confusion.

> And "official" is a phrase I have trouble with in this context.  A
> mirror does not have to be blessed as official; that's the point of
> a mirror---anybody can make one to help users with better
> connectivity or availability, as long as its users trust the mirror
> maintainer for mirror's correctness and freshness.

You're right and I'll remove it. However, I've seen at least one
instance of confusion over Git's lack of an "official" mirror (over on
#git on Freenode). I'd like to rephrase this to explain the reasoning
behind having multiple mirrors, none of which are official.

To that end, I propose replacing the phrase with "one of the best places
to clone from is this mirror on GitHub." followed by the clone command
to git/git, then followed by:

	NOTE: As Git is a distributed version control, the Git project also
	follows a distributed model. There is no central official mirror; any
	mirror which you can reasonably trust is being kept correct and fresh to
	the Git source distributed by the Git maintainer is fine to work from.

What do we think?

Alternatively, if the desire is to just be done with it, I have no
problem with Junio rewording however he feels is best and otherwise
applying this patch - if there is value in reducing the churn on the
mailing list for this patch.

> So perhaps "... clone from is the mirror maintained by GitHub folks"
> or just simply "is the mirror on GitHub"?
> 
> > +$ git send-email --to=target@example.com
> > +		 --in-reply-to="<foo.12345.author@example.com>"
> 
> Very nice attention to the detail here.  I like it (the earlier
> round did not have dq around the message ID).
> 
> > +		 psuh/v2*
> > +----
> 
> All other edits relative to the previous round look very sensible to
> me.  Thanks.
