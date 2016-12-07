Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2695E1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933378AbcLGWgu (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:36:50 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36107 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbcLGWgr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:36:47 -0500
Received: by mail-pf0-f181.google.com with SMTP id 189so79546224pfz.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ypc4UpUdB6Ad/GbVdJ/x7XdrKjv4aITXbvEH9XzT0sA=;
        b=I/z2O6QIBiVcTAU/mCxiJbuTo8gG6Tp9qx/oIqNolqAm+tSnsXHD6J1p/OdqqWXH+q
         QVvUA+0kaF5EVAN+HYJ/YpmKm/5PQzGtFqKh+7qMy40CS6KnmBsyRDIalYFkiX6qGSeT
         jSQ+/S0JSm+rxgDSGocVCiwZvwQJgwh6qQA7V1mr3tKkeARHa1Z23o7MEObnyEEDP/da
         czyPmW2IjuM6qnIv3nJ+NZ6wi0aNq7v3QxfZow8Nno8a5leyqCzLxvYQ7YlMEGqKDmSU
         O8dbpZM0sV22pXMzJ3LF8rg2QSoZ7Xv16xRVaKkr4P2mUawF0VHbMtA/0EUy1mLIa4Dj
         gTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ypc4UpUdB6Ad/GbVdJ/x7XdrKjv4aITXbvEH9XzT0sA=;
        b=HmLrUVAfkVgvvQs7xanH50ISaNjzvZ1SgqFG21qpDTetk+5XRYioqSSbag6KUY/l/N
         IPbRPfagxdn7yPMNE9f0k0f3fAWaYkliuJCPb1yq322nyZbx3KgvJ9jgoI7b4cEoczHk
         4l93m9OtDnoPOOARiU5l9kMHWq+IYDLfrLx0eGQP7SaiK+ma601Z0lfv4PdavmXvlU6H
         LPQCYe4b1lHGydlrPIdBe3Hz1n8gnC9H0nUCCNrAdBUX/0lfzE+3XmoROThut4pyMglz
         EOonNq76YWZQSXVJQZR53vQQFS0lUXoG1GuUn78JzbVlnWCXU9eI94h9QdOR5arPxmIZ
         tpdQ==
X-Gm-Message-State: AKaTC01OIlc+nqQ1VrDMp4/o+AtjTc2imtmnLBDy/g9BbFa5M+B+KrvVdtRl9+49pLxH/S/7
X-Received: by 10.99.139.199 with SMTP id j190mr125378139pge.115.1481150206527;
        Wed, 07 Dec 2016 14:36:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id d1sm44822162pfb.76.2016.12.07.14.36.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 14:36:45 -0800 (PST)
Date:   Wed, 7 Dec 2016 14:36:44 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/17] pathspec: small readability changes
Message-ID: <20161207223644.GC116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-17-git-send-email-bmwill@google.com>
 <CACsJy8B6Mj-L1t-CETY5DWRyABHZsYZszwXD3dgUqChfXRB6FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8B6Mj-L1t-CETY5DWRyABHZsYZszwXD3dgUqChfXRB6FA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Duy Nguyen wrote:
> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> > A few small changes to improve readability.  This is done by grouping related
> > assignments, adding blank lines, ensuring lines are <80 characters, etc.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  pathspec.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/pathspec.c b/pathspec.c
> > index 41aa213..8a07b02 100644
> > --- a/pathspec.c
> > +++ b/pathspec.c
> > @@ -334,6 +334,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
> 
> btw, since this function has stopped being "just prefix pathspec" for
> a long time, perhaps rename it to parse_pathspec_item, or something.

I was thinking about doing that after I sent this out.  Glad you also
pointed that out.

-- 
Brandon Williams
