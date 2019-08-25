Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3341F461
	for <e@80x24.org>; Sun, 25 Aug 2019 14:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfHYOjz (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 10:39:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33384 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfHYOjy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 10:39:54 -0400
Received: by mail-oi1-f194.google.com with SMTP id l2so10340982oil.0
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=orLxCC8y5xuw+RZIxY9K/7SwjPBcx9nK+dlwrozbjTY=;
        b=GgYgvnwIYu7Ys9k1E3BMkQ9PwZaeI6aDLveO1XiQBTQ8P8cV9w3Jz/VNIZbxPp42OV
         sx2yKu/tFLDDAEdfSuEyOW3E0BAN9OGl6tEw98bkLP/WLE/fl5dpPxyaVmp7yYHBZnKH
         jwO+q1JrcHxpj+mmqQHBFDvilsMVXhmmm3pLbx/jHx/ZrGZVfa2V/tyFRdxPC43jsx1O
         mRxaT4ubOiD37pPfLgyTuSxXqN+vaOpBDlvJnN8TniGQMIYJ7l8ooGP41PwPFbZducPU
         A3N33qIqtBs8i8Bzux8zslW8MGhQ/jQ91TdxWl3Nn5cfIv6K1TRCFOSEEQCmkNkNuhKB
         KFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=orLxCC8y5xuw+RZIxY9K/7SwjPBcx9nK+dlwrozbjTY=;
        b=Qew1RDxeA+osYDF1vL7QpwL9yGo80YUYDeLlH3caa6xEFP69cX0H2LU1WUkNDVFGKB
         g2yyiD7Ucj0ylv6wGojqVjhaSQB1jrPTSpmllRn6AlNFn5EspDYsqwtvDrAMadQT6trn
         vuGFDcdbrtNE8HsoUeHWNueMTvC1VU80qbc9seoO8kNncrMhJawEJWLzqG2sJj35If9K
         D3L45xysTEN9j1lXEcTkopnf8CFST9637ye/M5T0/7OvWZyFUSilqH+OsIt6zYSCaOnv
         M58qYQ7RJbpfaCx2zNIvVPDOQDK1UkEIxYRl73QXd3/Gnr+m7AthMOhjI2vODyEsoN3P
         /FQQ==
X-Gm-Message-State: APjAAAUQT8u3OaH4+XZtPUVsrGO+lG9aEHXHw2wmOh35pe6oBWg2bp8U
        IDWBSJDAVNNfOr1bkqySSd0W/O+uDWQgE85T7Jc=
X-Google-Smtp-Source: APXvYqyO1HlXJPMWIs8mv5kch1o+mluRl5PNOfC9W6px48IAkst0jwoOBypah2gpoL0QRJ8OwMEFejd2KKi+SS9OyXw=
X-Received: by 2002:a54:4f91:: with SMTP id g17mr9679100oiy.103.1566743993677;
 Sun, 25 Aug 2019 07:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
 <20190825115929.GA21463@alpha>
In-Reply-To: <20190825115929.GA21463@alpha>
From:   Albert Vaca Cintora <albertvaka@gmail.com>
Date:   Sun, 25 Aug 2019 16:39:27 +0200
Message-ID: <CAAQViEtpKprahB7AJKQNWDj=3EOeyRwshstcM7ZtQ88Ve934Ug@mail.gmail.com>
Subject: Re: [Feature Request] Option to make .git not read-only in cloned repos
To:     Kevin Daudt <me@ikke.info>,
        Albert Vaca Cintora <albertvaka@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 1:59 PM Kevin Daudt <me@ikke.info> wrote:
>
> On Fri, Aug 23, 2019 at 10:43:45PM +0200, Albert Vaca Cintora wrote:
> > Hi git folks,
> >
> > Honestly I'm not aware of the reason behind .git being read-only, but
> > I'm sure there is one.
> >
> > However, I'm sure that a large percentage of developers out there will
> > agree with me that having to use force (-f) to delete every cloned
> > repo is annoying, and even worse, it creates the bad habit of always
> > force-deleting everything.
> >
> > Would you find reasonable to add an option to keep .git writable on
> > cloned repos?
> >
> > PS: I'm not subscribed to the list, so please CC me on replies.
> >
> > Thanks!
> > Albert
>
> To clarify, you are probably referring to things like pack-files, which
> are created read-only. Most files / directories in .git are writable.
>
> It think this is already quite old behavior and I could not find any
> reference as to why this is done.

Indeed, not all files in .git are read-only. I'm talking about those which are.

On Sun, Aug 25, 2019 at 1:59 PM Kevin Daudt <me@ikke.info> wrote:
>
> On Fri, Aug 23, 2019 at 10:43:45PM +0200, Albert Vaca Cintora wrote:
> > Hi git folks,
> >
> > Honestly I'm not aware of the reason behind .git being read-only, but
> > I'm sure there is one.
> >
> > However, I'm sure that a large percentage of developers out there will
> > agree with me that having to use force (-f) to delete every cloned
> > repo is annoying, and even worse, it creates the bad habit of always
> > force-deleting everything.
> >
> > Would you find reasonable to add an option to keep .git writable on
> > cloned repos?
> >
> > PS: I'm not subscribed to the list, so please CC me on replies.
> >
> > Thanks!
> > Albert
>
> To clarify, you are probably referring to things like pack-files, which
> are created read-only. Most files / directories in .git are writable.
>
> It think this is already quite old behavior and I could not find any
> reference as to why this is done.
