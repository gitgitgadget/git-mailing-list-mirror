Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80F771F453
	for <e@80x24.org>; Thu, 20 Sep 2018 17:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeITXcH (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 19:32:07 -0400
Received: from ICGRIDDB04.SEAS.UPENN.EDU ([158.130.57.72]:56172 "EHLO
        ICGRIDDB04.SEAS.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeITXcH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 19:32:07 -0400
Received: from [10.13.0.14] (helo=ofb.net)
        by ICGRIDDB04.SEAS.upenn.edu with esmtp (Exim 4.89)
        (envelope-from <frederik@ofb.net>)
        id 1g3332-0000Ua-NU; Thu, 20 Sep 2018 13:47:28 -0400
Received: from localhost.localdomain (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id 86DDB3E868;
        Thu, 20 Sep 2018 10:47:23 -0700 (PDT)
Received: from frederik by localhost.localdomain with local (Exim 4.91)
        (envelope-from <frederik@localhost.localdomain>)
        id 1g332w-0008Ns-QA; Thu, 20 Sep 2018 10:47:22 -0700
Date:   Thu, 20 Sep 2018 10:47:22 -0700
From:   frederik@ofb.net
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-column.1: clarify initial description, provide
 examples
Message-ID: <20180920174722.GH22921@ofb.net>
Reply-To: frederik@ofb.net
References: <20180919201231.609-1-frederik@ofb.net>
 <20180919201231.609-3-frederik@ofb.net>
 <xmqqo9ct2ivl.fsf@gitster-ct.c.googlers.com>
 <20180920162302.GB13379@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920162302.GB13379@duynguyen.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 06:23:03PM +0200, Duy Nguyen wrote:
> On Wed, Sep 19, 2018 at 03:59:58PM -0700, Junio C Hamano wrote:
> > > @@ -23,7 +26,7 @@ OPTIONS
> > >  
> > >  --mode=<mode>::
> > >  	Specify layout mode. See configuration variable column.ui for option
> > > -	syntax.
> > > +	syntax (in git-config(1)).
> 
> I think we usually link to other commands with "linkgit", like
> linkgit:git-config[1]
> 
> Other than that, the rest looks good.

Thank you, then do I edit the patch and resubmit as PATCH v2 with the
message ID and all that?

Frederick
