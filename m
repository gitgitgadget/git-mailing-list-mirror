Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7481F454
	for <e@80x24.org>; Thu, 20 Sep 2018 16:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbeITWHX (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 18:07:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42795 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbeITWHX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 18:07:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id d7-v6so5145590lfj.9
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V9gJWnqVldYA2kKKr8OWzaG1HCrU42y5qct2DMgA/WE=;
        b=u5Fpk92mv1Y2YuSQCQa2y6lS/lPyS5aeLoKpNZ62XRroIv+0qTyKTanf+3FhlRs6hT
         Nh2Z2e1T3XxXmuqILJkvKU+2NAieYrz172ixI3ndv5oRmBV/TwVrHqrZpj2Hf6M7vVJx
         9BRTwRynAIqfSM9/rXJiRBNSzTG+XyUtd9OJFhXvLYSd4zv9C+B58HsEXxhe1XtW9OfP
         Nx8ykciFX9ODiVjGfwULEW27g+DAhdCU1UaPhcrNaejRjMxgj5iQXjBkkiNzFeicbBFE
         KdEdoRHV34nyZOJemkMz5QfV9Yd3K4F50wJaS6Rxe2FwXZ9rYpQRk7wdmul5Za0rqlKo
         gZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9gJWnqVldYA2kKKr8OWzaG1HCrU42y5qct2DMgA/WE=;
        b=QMu1D4fSgGtPMWrqip1uptEL6zRr1sqTTEL4PTksCx2F7BsbrRWeeHPDa9UbBiSpWe
         zcUgYkJx+o0Hq9uue+yO0Ku+PHO4FZXuyWWlYZEtDBHhUQQ4GpMXv908jTn6Jc0T1weT
         FxaBfwd/TL6Sw9ntDoPiF6YgmGcOdXxR/PxMgPJlT4o9IeKUE5SDXH5wVW7fWrSqJ9+I
         9s9loMKTPxqFN4uIAdtgrlIkGJujiY/Yvhzgsnh34p6Uzga8xAxZNroCSPP/FvVx1GeW
         wmP3sMxVwiKR2/8RNNaynWCtCP9Kc3N3hl7tm7fbu/GJ2gMt/s6tR5gXjTNFR+icjmiX
         /PwA==
X-Gm-Message-State: APzg51Cfr3zj84itOsFs6OwX6uNTfpXQdkPaogdrnpxyUxRnLY50mKdO
        hqYWE1IcIcdq1q6IcrZ/ed4=
X-Google-Smtp-Source: ANB0VdZjo/EB1NdXf45aVzOtXKxI/cKn2mhRdm6BFd86zpzK9qeUi7PFSnDzXVL/+AF/rVDQ+65kXw==
X-Received: by 2002:a19:18e3:: with SMTP id 96-v6mr1798283lfy.133.1537460587285;
        Thu, 20 Sep 2018 09:23:07 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm4630990ljg.54.2018.09.20.09.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:23:06 -0700 (PDT)
Date:   Thu, 20 Sep 2018 18:23:03 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Frederick Eaton <frederik@ofb.net>
Cc:     git@vger.kernel.org, Frederick Eaton <frederik@ofb.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-column.1: clarify initial description, provide
 examples
Message-ID: <20180920162302.GB13379@duynguyen.home>
References: <20180919201231.609-1-frederik@ofb.net>
 <20180919201231.609-3-frederik@ofb.net>
 <xmqqo9ct2ivl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9ct2ivl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 03:59:58PM -0700, Junio C Hamano wrote:
> > @@ -23,7 +26,7 @@ OPTIONS
> >  
> >  --mode=<mode>::
> >  	Specify layout mode. See configuration variable column.ui for option
> > -	syntax.
> > +	syntax (in git-config(1)).

I think we usually link to other commands with "linkgit", like
linkgit:git-config[1]

Other than that, the rest looks good.
--
Duy
