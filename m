Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897AE1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 21:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfDZVQS (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 17:16:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35275 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfDZVQR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 17:16:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so2298607pfh.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pl5qKP105DNgCgE2ZrEjMSH9jy+HW58WQYOJuCncr/E=;
        b=MMbWnlFMiZyBofhykJLLKTel5h5rC7HxhOaNz3mP3mcngDzffV7CmpmAHCRtvMkaAS
         xfvNBR9/jwGHFv3fp5RN5spbrs8Y9xL07fb/r1IMK8FdsfJgM4WcLHRaQKDGUDzQsyOG
         +T/bdio1KYeZMN+dfXimHqC5WheMD2lkZI+gkBJcUwY4khsZwHeIK+4nDOQYJgRbe8/j
         GeI9+IbEEH/DGTAt/PGf95qY4ITxhru+hw08qiZg79qQb6RDXYpKcYXdAgAaIxgMPVI1
         AEgo1/ujnfFpx7I08PK5Qd0h2Kr7NiLgdS86mv8n8fYyuSrm06ZQYgeaKRFOmPc1Whsj
         j3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pl5qKP105DNgCgE2ZrEjMSH9jy+HW58WQYOJuCncr/E=;
        b=FwsUdOTX3kal4m3ywGXDyaSe89nnrdPS7z9vVE1K3QDfBo2BSQbU6tnctJHyFlI/zP
         TOCGxry+rqYSOdBcwGZ1ZPuseBbPlr50tVfVGhEjz8A2OH50l1mQlVZ5XxICng5HF5wz
         EXiOmvNe1qVO+Zyb7hmx2FyHoe8VdDjmEgExJEbEuX5zaIU2dRAMmlY9+zm4aOm/an4s
         Xns4hb6GNA4GOBv/qVjIT2xDTDItlqhJxrIT66XmXU5W/O4p1RPwteW+Wt2em11ITkmi
         3K5iqGVJksk9HRrz8kxRy9bBmRp83LfSOdX/mXwpOg6aVoXQKh29d0ZkKXgCbHXekyKi
         BOhA==
X-Gm-Message-State: APjAAAXpS4/2dJPetTs+FXcQbCUPcLMOtT+vMWU230fpBtmHXschdVZ4
        VEt5yYWnMdg+OKoW7pTUj90=
X-Google-Smtp-Source: APXvYqyuTxCb512KEmWPyOXfogT76t6ZyGcf+uFKpWIHs61jGJ8MLWe8icx1XeuP8Hn91bo2wvjMtg==
X-Received: by 2002:a63:40c2:: with SMTP id n185mr12128838pga.364.1556313376489;
        Fri, 26 Apr 2019 14:16:16 -0700 (PDT)
Received: from dev-l ([149.28.199.249])
        by smtp.gmail.com with ESMTPSA id a10sm34267011pfc.21.2019.04.26.14.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 14:16:15 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:16:13 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] revisions.txt: mention <rev>~ form
Message-ID: <20190426211613.GA23370@dev-l>
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
 <1d84c3bc-4e18-450e-edc6-96ac34f61c7a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d84c3bc-4e18-450e-edc6-96ac34f61c7a@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 26, 2019 at 10:55:35PM +0200, Andreas Heiduk wrote:
> Am 22.04.19 um 08:12 schrieb Denton Liu:
> > In revisions.txt, the '<rev>^' form is mentioned but the '<rev>~' form
> > is missing. Although both forms are essentially equivalent (they each
> > get the first parent of the specified revision), we should mention the
> > latter for completeness. Make this change.
> > 
> > While we're at it, the brief form of '<rev>^' makes it seem as if no
> > numerical argument is accepted. Update documentation to make it obvious
> > that an optional numerical argument is accepted.
> > 
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  Documentation/revisions.txt | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> > index 2337a995ec..4ba7b4416a 100644
> > --- a/Documentation/revisions.txt
> > +++ b/Documentation/revisions.txt
> > @@ -131,7 +131,7 @@ from one location and push to another. In a non-triangular workflow,
> >  This suffix is also accepted when spelled in uppercase, and means the same
> >  thing no matter the case.
> >  
> > -'<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
> > +'<rev>{caret}[<n>]', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
> 
> This
> 
> >    A suffix '{caret}' to a revision parameter means the first parent of
> >    that commit object.  '{caret}<n>' means the <n>th parent (i.e.
> >    '<rev>{caret}'
> > @@ -139,7 +139,9 @@ thing no matter the case.
> >    '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
> >    object name of a tag object that refers to a commit object.
> >  
> > -'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
> > +'<rev>{tilde}[<n>]', e.g. 'HEAD~, master{tilde}3'::
> 
> and here: These would be the first and only places in revisions.txt
> where [] denote optional syntax. Since *exactly* this place is already
> riddled with special characters wich are either part of the syntax
> (e.g. @, {}) or not (e.g. <n>) this would be confusing.
> 
> In other places of the file optional syntax is *displayed* like this:
> 
>        <branchname>@{upstream}, e.g. master@{upstream}, @{u}

In that case, would it make more sense to add [] to optional parameters
across the whole file? The meaning of [] (like that of <>) is common
knowledge across all of Git's documentation. As a result, since
<branchname> is optional, this would mislead a reader unless they were
to further read the examples (which imo, they should not have to do to
fully understand it). In addition to this, since [] is not used in any
rev syntax, there would be no ambiguity.

Thus, we'd rewrite the above as

	[<branchname>]@{upstream}, e.g. master@{upstream}, @{u}

I'm not sure, what do you think?

> 
> in that spirit somethind like this:
> 
> 	<rev>~<n>', e.g. 'HEAD~, master~3', master~
> 
> would be better to read.
> 
> 
> > +  A suffix '{tilde}' to a revision parameter means the first parent of
> > +  that commit object.
> >    A suffix '{tilde}<n>' to a revision parameter means the commit
> >    object that is the <n>th generation ancestor of the named
> >    commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
> 
> 
> 
