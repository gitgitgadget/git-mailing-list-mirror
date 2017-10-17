Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090961FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 21:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937726AbdJQVqS (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 17:46:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:52601 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934861AbdJQVqR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 17:46:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id k62so3116930wrc.9
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 14:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eFbUIxwmc2PdDJKmFW71pqDTAeNxi8Xl0StYbMl9fSA=;
        b=bptmytPITMyc/5s8S4AlmM2ykksL8urs9hANAtpr5DfDV9CJcvR2AtTa5Ri8rlEqX+
         wgYbEG7FtoMXSN9gK5E7Oq94yTIKN+hdSzVajx28LJu0ZeAvUBCff1Sv4CCVHlT/SOmE
         Cgh8fC5A3+d62W8OWb8XM/7CK2JpBEjjvct3iM9/OimAIo9HXQhBtiYqhu7GZUCKyzae
         hIAnvXY3IzT130be+yPSgKJ+Hfs613XuuKjJid1LZBkc1HHr8OaHfO5hMXMQagOGLmLA
         TAP0Hn3ii3IxlVxt8/ykr3ux2ta0r9qnKj07tFH197t4mPOoeRV+957+E2vwe4bZoari
         migQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eFbUIxwmc2PdDJKmFW71pqDTAeNxi8Xl0StYbMl9fSA=;
        b=PLsfzi7Kk9XVH1bQDH0IrXHDam1p6iNhp1NpWLcQlE2tOsQ7ko6HsqVPr2/k1TArY7
         faKLJ+RTGdlQblK5UOhiUI5aYpT7OO2SaaUzJ8KkZFAKXtb6qR9niSlJq30DhAqxAHOH
         9qw69Y0Ovqp/ZTeZgCKYhPl4nsmbJ9QYOJE30Dlxhz0M/jec+zpzmcvW29dFQ8UDoT/J
         KIFeOp2EW54RQYCGvqBtaYU+5UmSwBrV5cS10Ajs4HbD2s/kdmPG4o3q7uMj76cOJS5y
         a7M0sZqkqHWm0slY1D6uEvu1yXera8W9FnPCQxEeY2CVViNISnjQmDiD5ZnnB9vRSuvT
         viuA==
X-Gm-Message-State: AMCzsaVwKkCLxGP9gMuZryeCl09yFNJQ7IBkwphBdI5V5y6c2EasMhkT
        FIbghrAMqedx4zDEosVG4rk=
X-Google-Smtp-Source: ABhQp+QbyZ6XozTXnpSkCJFGVbwUV1cG08dCVm6gpC2KXqS/oU4DkYDtCYX89vwTH27oazS9Tt41lg==
X-Received: by 10.223.163.208 with SMTP id m16mr5410320wrb.63.1508276776523;
        Tue, 17 Oct 2017 14:46:16 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id l9sm9077878wrf.70.2017.10.17.14.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 14:46:15 -0700 (PDT)
Date:   Tue, 17 Oct 2017 22:47:16 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC] deprecate git stash save?  (was: Re: [PATCH 2/3]
 http-push: fix construction of hex value from path)
Message-ID: <20171017214716.GH15399@hank>
References: <20171005200049.GF30301@hank>
 <20171017041332.ooybecmonvssko2k@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017041332.ooybecmonvssko2k@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17, Jeff King wrote:
> On Thu, Oct 05, 2017 at 09:00:49PM +0100, Thomas Gummerer wrote:
> 
> > Since you were asking :)  With the introduction of 'git stash push',
> > my hope was always that we could eventually get rid of 'git stash
> > save' and only keep one interface around.
> > 
> > As there still many references to it around on the internet, it
> > probably requires a bit of a longer deprecation plan.  What do you
> > think about the following:
> > 
> > - Change docs/man pages to use 'git stash push' everywhere instead of
> >   'git stash save'.
> > - Mention the deprecation in the release notes and in the man page.
> > - Print a warning when 'git stash save' is used.
> > - Eventually get rid of it (maybe something for 3.0?)
> > 
> > The steps above would all occur sequentially with a few releases
> > between each of them.
> 
> That sounds like a pretty good plan.
> 
> > A patch for the first step below.  I think that even makes sense if we
> > don't want to follow through with the deprecation.
> 
> Agreed. The patch mostly looks good, except:

Thanks for the review.

> > diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> > index b4d88af133..1c4e44892d 100644
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> > @@ -1556,7 +1556,7 @@ so on a different branch and then coming back), unstash the
> >  work-in-progress changes.
> >  
> >  ------------------------------------------------
> > -$ git stash save "work in progress for foo feature"
> > +$ git stash push "work in progress for foo feature"
> >  ------------------------------------------------
> 
> This needs "-m", doesn't it?

Yeah, this definitely needs "-m".  Will change.

> >  
> >  This command will save your changes away to the `stash`, and
> > diff --git a/git-stash.sh b/git-stash.sh
> > index 8b2ce9afda..8ce6929d7f 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -267,11 +267,11 @@ push_stash () {
> >  			# translation of "error: " takes in your language. E.g. in
> >  			# English this is:
> >  			#
> > -			#    $ git stash save --blah-blah 2>&1 | head -n 2
> > -			#    error: unknown option for 'stash save': --blah-blah
> > -			#           To provide a message, use git stash save -- '--blah-blah'
> > -			eval_gettextln "error: unknown option for 'stash save': \$option
> > -       To provide a message, use git stash save -- '\$option'"
> > +			#    $ git stash push --blah-blah 2>&1 | head -n 2
> > +			#    error: unknown option for 'stash push': --blah-blah
> > +			#           To provide a message, use git stash push -- '--blah-blah'
> > +			eval_gettextln "error: unknown option for 'stash push': \$option
> > +       To provide a message, use git stash push -- '\$option'"
> 
> And here, too?

Indeed, thanks for catching these.  Will change and re-roll the
patches.

> -Peff
