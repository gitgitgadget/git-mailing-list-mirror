Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA3E1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 16:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390415AbeIUWiL (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:38:11 -0400
Received: from ICGRIDDB04.SEAS.UPENN.EDU ([158.130.57.72]:40428 "EHLO
        ICGRIDDB04.SEAS.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390281AbeIUWiL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:38:11 -0400
Received: from [10.13.0.14] (helo=ofb.net)
        by ICGRIDDB04.SEAS.upenn.edu with esmtp (Exim 4.89)
        (envelope-from <frederik@ofb.net>)
        id 1g3ObS-0000Ik-Jc; Fri, 21 Sep 2018 12:48:26 -0400
Received: from localhost.localdomain (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id 683A73F1EA;
        Fri, 21 Sep 2018 09:48:21 -0700 (PDT)
Received: from frederik by localhost.localdomain with local (Exim 4.91)
        (envelope-from <frederik@localhost.localdomain>)
        id 1g3ObI-0004rZ-Fq; Fri, 21 Sep 2018 09:48:19 -0700
Date:   Fri, 21 Sep 2018 09:48:16 -0700
From:   frederik@ofb.net
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] git-column.1: clarify initial description, provide
 examples
Message-ID: <20180921164802.GB11082@ofb.net>
Reply-To: frederik@ofb.net
References: <20180919201231.609-1-frederik@ofb.net>
 <20180919201231.609-3-frederik@ofb.net>
 <xmqqo9ct2ivl.fsf@gitster-ct.c.googlers.com>
 <20180920162302.GB13379@duynguyen.home>
 <20180920174722.GH22921@ofb.net>
 <xmqqsh22x14v.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh22x14v.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Junio, maybe I will have another chance to get practice
sending a v2 patch.

On Fri, Sep 21, 2018 at 09:32:00AM -0700, Junio C Hamano wrote:
> frederik@ofb.net writes:
> 
> > On Thu, Sep 20, 2018 at 06:23:03PM +0200, Duy Nguyen wrote:
> >> On Wed, Sep 19, 2018 at 03:59:58PM -0700, Junio C Hamano wrote:
> >> > > @@ -23,7 +26,7 @@ OPTIONS
> >> > >  
> >> > >  --mode=<mode>::
> >> > >  	Specify layout mode. See configuration variable column.ui for option
> >> > > -	syntax.
> >> > > +	syntax (in git-config(1)).
> >> 
> >> I think we usually link to other commands with "linkgit", like
> >> linkgit:git-config[1]
> >> 
> >> Other than that, the rest looks good.
> >
> > Thank you, then do I edit the patch and resubmit as PATCH v2 with the
> > message ID and all that?
> >
> > Frederick
> 
> If this is the only change in the whole 3 patches, then I can just
> squash in the following to save one round-trip.
> 
>  Documentation/git-column.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
> index 5bbb51068e..763afabb6d 100644
> --- a/Documentation/git-column.txt
> +++ b/Documentation/git-column.txt
> @@ -26,7 +26,7 @@ OPTIONS
>  
>  --mode=<mode>::
>  	Specify layout mode. See configuration variable column.ui for option
> -	syntax (in git-config(1)).
> +	syntax in linkgit:git-config[1].
>  
>  --raw-mode=<n>::
>  	Same as --mode but take mode encoded as a number. This is mainly used
> 
