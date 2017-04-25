Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E161207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 22:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1431398AbdDYW6h (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 18:58:37 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33020 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1430014AbdDYW6g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 18:58:36 -0400
Received: by mail-io0-f196.google.com with SMTP id k87so55264822ioi.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 15:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TO2/K4epSgPI9+2PrkWSRV3BfNFEaEZm5fSOEJIblTY=;
        b=tBR1GIZob8iz4oWeErT3vM4DhpVmKRLOniT4X28L+prGKW5Nj7eMM3KbSjcW+Ij0Hf
         PblUIA7BrH+ZAJw2EF2m5ZpXDnUZX2g1g2DRtgVbM4evvr27sN8hwTbbTgBnZrPYTXAK
         kdhi4ExS6DoTRIuj1NtRr3MVg2ICze0Ag01SU0giq0m98i5PlFFpDKLmo8Iq4ApCZ9fh
         npbctbBzAQr/zMHrqmgdetpIk4maJouR9y3L59Tc5iu7ejWok4r6yQS5+chZcYC1a5iL
         O0QA2pTsPntwxI7VFwohIC+wOR60fY768w1GsQuq4wEknAWw6s3FnQkO4koWoZTgyYIs
         jNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TO2/K4epSgPI9+2PrkWSRV3BfNFEaEZm5fSOEJIblTY=;
        b=M23YTYJRyYiDEQLefMyc9YO69jr3yBaceNTMWqS1EDKdD349wwoAOEM2RciAzSwUY+
         MEdw60MkRuWstlK646nKv6X2JWATsTK8SbEnwliVgYM2JZKDWiR8OLUqlf/xmMm2At/R
         WR7Hah32SptL6960HDdmfnnX4+qO8c7KSSNrSuhQEnHeFTncoJ4SRq844jfz/45mWeW6
         GRhXLVHkO4PxYgvyr87Ev3+SMy7XlYUH4WnmwtLt4F6X7c6XL6kModEjZ91EvnzL46u2
         6lR1+U71jwNL1Qm5t5MIuldIegaVwsvpW4hDHat6UTGbgA8C/FGesPEpJQ6Rso6J5Ylp
         D+Ug==
X-Gm-Message-State: AN3rC/5ECJ1OzjsYp12wGyOrAwKKZ6QGgkKgVR4beZDrIf4wYctIZbQb
        KlpsXhRpAzYrw8VW4gQ=
X-Received: by 10.107.170.80 with SMTP id t77mr18106010ioe.113.1493161115324;
        Tue, 25 Apr 2017 15:58:35 -0700 (PDT)
Received: from atris (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.googlemail.com with ESMTPSA id c84sm813984ioj.8.2017.04.25.15.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Apr 2017 15:58:34 -0700 (PDT)
Message-ID: <1493161101.29673.27.camel@gmail.com>
Subject: Re: [PATCH] rebase -i: add config to abbreviate command name
From:   liam BEGUIN <liambeguin@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Date:   Tue, 25 Apr 2017 18:58:21 -0400
In-Reply-To: <alpine.DEB.2.20.1704252143520.3480@virtualbox>
References: <20170424032347.10878-1-liambeguin@gmail.com>
          <alpine.DEB.2.20.1704241225300.3480@virtualbox>
         <1493089056.29673.21.camel@gmail.com>
         <alpine.DEB.2.20.1704252143520.3480@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.5 (3.22.5-1.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Tue, 2017-04-25 at 21:45 +0200, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Mon, 24 Apr 2017, liam BEGUIN wrote:
> 
> > On Mon, 2017-04-24 at 12:26 +0200, Johannes Schindelin wrote:
> > 
> > > On Sun, 23 Apr 2017, Liam Beguin wrote:
> > > 
> > > > Add the 'rebase.abbrevCmd' boolean config option to allow the user
> > > > to abbreviate the default command name while editing the
> > > > 'git-rebase-todo' file.
> > > 
> > > This patch does not handle the `git rebase --edit-todo` subcommand.
> > > Intentional?
> > 
> > After a little more investigation, I'm not sure what should be added for
> > the `git rebase --edit-todo` subcommand. It seems like it uses the same
> > text that was added the first time (with `git rebase -i`).
> 
> Well, it uses whatever the user may have edited. It may surprise users
> that their `pick` does not get converted to `p` like all the original
> commands.
> 

It makes more sens to me now, I'll add it in next patch

> Ciao,
> Johannes

Thanks, 
Liam
