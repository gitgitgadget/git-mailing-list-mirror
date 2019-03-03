Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD7B20248
	for <e@80x24.org>; Sun,  3 Mar 2019 16:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfCCQM5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 11:12:57 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33954 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfCCQM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 11:12:57 -0500
Received: by mail-wr1-f52.google.com with SMTP id f14so2864892wrg.1
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 08:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P3nDHymAboMUxxUkgcj+zxLWYKBG2SO7XpylI2uiOn4=;
        b=ZA6D0+XbVSjmFvWwLv3I1q7Outx6RaQgCDNEPKsFCiF4nVfUjzyuKGqe7OzAyswdAQ
         L1aYfjyCpZDlOIybiggLSFBOgyCPw0F7dxsSjsMZXyfwZnDp6YGyEhd2xEmT2DReuVnR
         j8zjhIWAAQNli1ars31VAvIZ28s2U/JuigbpEWIu1I6XkS2k7DnHpiCIlPsVX+QweUVQ
         As86kwi/5mqtmMDdYDwflDgU8z6mQQzC2gyZTIiFB1i+hOZIjDxwk0N2GKRsiCcS5WhR
         WRAfmVxv+u+HYB9YYmQUwl04mwVpIJaM6jlDvSQIszltV04Wxt21P3OQSJRL4c4fYm+9
         c14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P3nDHymAboMUxxUkgcj+zxLWYKBG2SO7XpylI2uiOn4=;
        b=EO4OVBFBXIxHme0EErXpwea3udQ/oIO2O22QIYREwp7ByLpYNOAGve8mou09rLorwj
         h8Y/Y+X88M+NWsr3iPlMJlkOrAmaPAqAvIxmO+Pnsd9ZIXQ/wazsBb92KovEF15b3+Tl
         56o7efqERLEVGmEP4uMm5I27XaXD9e3cFiLgYBDJAqq0oeuq/fr1kubTvtNBYXZ97qCW
         CAlVevEMwlwJ3tC1wpeAc++Lc3dHN7yvituoNcyDnApR3AF1HOfdGV36xfEglb6X4bJe
         XWFn5x3T8c22dAOO1DuLSNhJ5zyNKyVYPLa3hvuUSMcy0FSa2UkswMhqS/WYpmc9Soow
         nVHA==
X-Gm-Message-State: APjAAAXghSajaqfDgfdYHAjJ0Y9UWH7B3OVc3QE4/A3flmtAHDxNatHw
        741g1MvuIP13rRSojqfQyPY=
X-Google-Smtp-Source: APXvYqzNJyklkmEq4+Zd2iUS0psvchaO+sGtXi8FBbdZxFbAIulaplnFUo0yXaiRpkDtsfmXKwK5Ow==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr9640685wrv.323.1551629574996;
        Sun, 03 Mar 2019 08:12:54 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id o127sm6463843wmo.20.2019.03.03.08.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 08:12:53 -0800 (PST)
Date:   Sun, 3 Mar 2019 16:12:53 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
Message-ID: <20190303161253.GW6085@hank.intra.tgummerer.com>
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com>
 <CACsJy8COJg4jGRKFwyi5Fc374To8Z3g3wHx+SD7zQTL5m-TbCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8COJg4jGRKFwyi5Fc374To8Z3g3wHx+SD7zQTL5m-TbCg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Duy Nguyen wrote:
> On Sat, Mar 2, 2019 at 10:09 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > I'm not very familiar with what's required here, but reading the above
> > makes me think it's likely too much for a GSoC project.  I think I'd
> > be happy with a project that declares removing the global variables as
> > the main goal, and adding parallelism as a potential bonus.
> >
> > I'm a bit wary of a too large proposal here, as we've historically
> > overestimated what kind of project is achievable over a summer (I've
> > been there myself, as my GSoC project was also more than I was able to
> > do in a summer :)).  I'd rather have a project whose goal is rather
> > small and can be expanded later, than having something that could
> > potentially take more than 3 months, where the student (or their
> > mentors) have to finish it after GSoC.
> 
> This is why I'm not involved in GSoC. I often mis-estimate the size of
> work (and yes I would still like your tree-based index format in,
> can't remember why it never made it).

So do I, and that's why I'd like to err on the side of having smaller
projects :)

I think the main reason the tree-based index format never made it is
that the in-core APIs were not set up to make use of the new index
format.  I'm also still interested in getting it in, but I haven't
found the time for looking at making the index code pluggable yet.  It
would probably take a similar refactoring as with the refs code to get
this done.

All that said, GSoC was still a great experience for me, and I got to
learn a ton over the summer.  But I did feel like I let the people
that invested a lot of time in the project as well down a bit, by not
being able to finishing the project.  And having the feeling of
accomplishment of actually finishing a project would definitely have
been nice to have as well.  So for those reasons I think it would be
better for students to take on smaller projects.

> So yeah if you find removing global variables (which essentially
> identifies shared states, a prerequisite for any parallel work)
> reasonable for GSoC, I'd say go for it.
> 
> Be also aware that this kind of refactoring work could result in lots
> of patches and it takes time to get them merged, if your GSoC goal is
> to get merged.
> -- 
> Duy
