Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4C81F42D
	for <e@80x24.org>; Fri, 18 May 2018 10:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeERKxB (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 06:53:01 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:55616 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeERKw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 06:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tw+V6T5VJzb5dfALOuXGkV6gFXVa6xGTJ9bATBpCs1I=; b=ghSFh5zF5unGQ3OVTmZN2Uk5s
        nKrus7gx9WoadDRYnTKjCL2DC5NbH5aZ56XjgZqbegwvAgN0bv0vWTwNpIURtNtfFIl+NKUot5Wv0
        7tITYpzwg61txlPtkIwHly227Tc//w6LL/+pDYzAXuqK6OWSKP1PBvG17ejcbHsX9luT+cenjePvp
        /dIZu1SmZdpNbgwYBydKRxWg+H+8IvnZ8rwtScQ7sRF5K26m+YDieGJIW1nPURRFQZ2HdylSSoCi8
        QwmtvCptMlIKY7i3XwvPiB2rwE2q1xtNa0bqupDp8GtSDj1LzohucdZXdZzo39D714FoNYN384dIW
        7nmZoCiLg==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:47828 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fJd0I-00EJ6a-Sq; Fri, 18 May 2018 06:52:57 -0400
Date:   Fri, 18 May 2018 06:51:27 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     =?ISO-8859-15?Q?Martin_=C5gren?= <martin.agren@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: error(?) in "man git-stash" regarding "--keep-index"
In-Reply-To: <CAN0heSrJMFij9xt6RstLD16+2CxJ_HALer4iRL74AZQvH0VWRQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1805180648020.10270@localhost.localdomain>
References: <alpine.LFD.2.21.1805180534170.6786@localhost.localdomain> <CAN0heSrJMFij9xt6RstLD16+2CxJ_HALer4iRL74AZQvH0VWRQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1579388346-1526640690=:10270"
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1579388346-1526640690=:10270
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 18 May 2018, Martin Ågren wrote:

> On 18 May 2018 at 11:37, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   toward the bottom of "man git-stash", one reads part of an example:
> >
> >   # ... hack hack hack ...
> >   $ git add --patch foo            # add just first part to the index
> >   $ git stash push --keep-index    # save all other changes to the stash
> >                                               ^^^^^ ???
> >
> > i thought that, even if "--keep-index" left staged changes in the
> > index, it still included those staged changes in the stash. that's
> > not the impression one gets from the above.
>
> So would the error be in the part of the man-page quoted below?
>
>   If the --keep-index option is used, all changes already added to
>   the index are left intact.

  no, that part is correct, it clearly(?) states that staged changes
are left where they are, in the index. i submit that the misleading
part is in the example i quoted, which suggests that only the "other"
changes are saved to the stash -- that is, the changes other than what
is already in the index.

> That is, this doesn't say *where* things are left intact (in the
> index? in the working tree?).

  in that case, that's something that could obviously be clarified.

> The man-page does start with
>
>   git-stash - Stash the changes in a dirty working directory away
>
> which to me suggests that "leaving something intact" refers to
> precisely this -- the working directory.
>
> Or is it the name of the option that trips you up? That is, you read
> the name as `--keep-the-index-as-is-but-stash-as-usual`, as opposed
> to `--keep-what-is-already-in-the-index-around`?
>
> While I'm sure that some clarification could be provided, I'm tempted to
> argue that is exactly what the example provides that you quoted from.

  i guess we can agree to disagree, since i think the snippet of the
example i provided gives a misleading explanation.

rday
--8323328-1579388346-1526640690=:10270--
