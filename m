Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8802E20437
	for <e@80x24.org>; Mon, 16 Oct 2017 18:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754216AbdJPSdn (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 14:33:43 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:46546 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752994AbdJPSdl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 14:33:41 -0400
Received: by mail-wr0-f176.google.com with SMTP id l1so3879173wrc.3
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gNeDO0NI3Pdti3C1tD58w9w69Fvy2nYgDs59DEJHnzU=;
        b=b6fwm4CwCrouSB4BEAIfQb54Zmv6YO0DU26GfnN4G6eIclfh1oJxTIU9SiBDUczQD/
         PA/NCXY26mryNjm85zNxVMYI7nMPgne6wOh9jiX6y3Vt400qoZRuGp30+WKZXJFiIIN2
         tYt/rI8fgINjU3n7LSHB996B3t9rjigylKGiUYgyJem0ZYxQA9Nzo+pnzGqtjIEHSvih
         O1NUjmy3KWNi92V+lzC0wWzB63BHTuhCd48GBOl5bygmzXZelYp9BiqRtLev6NiNPbYw
         l3GAXSMzIBo3gotv3g0tOAKMXAP+pgVdm/aI34Is78XbpTtc6xQ32NjSHXaxvdMYb1tf
         KILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gNeDO0NI3Pdti3C1tD58w9w69Fvy2nYgDs59DEJHnzU=;
        b=soNaeCern6MFEMSvyQXZow4Xs2b3I17NMKqYgWRfuncf6crQ1Y5fu+eSdQYIgZqale
         sgBfr5iuCzlGVsaTRPyEA47nrnAEkOOWtHOaSgqO2+VFdu/E4d4TBxMeqciv7bwFw/GB
         KuhlWtt+XKSHIa1BDEZPKCEwv8EKwGHU2SpgpNa87m53LW+bLtLZSp12mEAxvus9UCMD
         4Wd50obAyDN67rwh65jWW0JAkydH6edUpa69cx8diCnqnxgyvlJBuWizaf1xvkbI+V34
         S9694Cp7zrfC9Xz0RKG5Idtkpy5Y12dFHIqSBn2onUisg2Xza6azlisKgnrG5q/j47xK
         uF2w==
X-Gm-Message-State: AMCzsaW44bzT/dxxBt5+mpniyGhDeGGTuAWh3T4tJ9RCWHyRpA5s87XA
        dEuUNc0ZGkJ8P252VFAQR6/DEZao
X-Google-Smtp-Source: ABhQp+Q39JvVF862MjioxugEuxGiWJegOHipNSGn3zHbjOA8El/tMV0vxAhVd9CtiwHQSTYPsVIBTw==
X-Received: by 10.223.166.181 with SMTP id t50mr1304947wrc.251.1508178820136;
        Mon, 16 Oct 2017 11:33:40 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m64sm7132445wmb.10.2017.10.16.11.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Oct 2017 11:33:39 -0700 (PDT)
Date:   Mon, 16 Oct 2017 19:34:39 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: slight addition to t.gummerer's proposed "git stash" patch
Message-ID: <20171016183439.GF15399@hank>
References: <alpine.LFD.2.21.1710110454240.11490@localhost.localdomain>
 <20171011192109.GC15399@hank>
 <alpine.LFD.2.21.1710111523510.4185@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710111523510.4185@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11, Robert P. J. Day wrote:
> On Wed, 11 Oct 2017, Thomas Gummerer wrote:
> 
> > On 10/11, Robert P. J. Day wrote:
> > >
> > >   was perusing thomas gummerer's proposed "git stash" patch here:
> > >
> > > https://www.spinics.net/lists/git/msg313993.html
> > >
> > > and i'd make one more change -- i'd separate the OPTIONS entries for
> > > "git stash push" and "git stash save" so they don't end up being
> > > rendered all crushed together when displaying the man page:
> >
> > I for one would like that.  I sent a patch recently [1] that would
> > show git stash push first on the man page, which didn't seem to get
> > much traction.  This goes a bit further than that, which I'd be happy
> > with.
> >
> > [1]: https://public-inbox.org/git/20171005201029.4173-1-t.gummerer@gmail.com/
> 
>   ... snip ...
> 
> if you want, just crush my suggestion into your earlier patch and
> resubmit it.

Thanks, before doing that let me see where that discussion goes.  My
plan was to be a bit more careful and first get rid of mentions of
'git stash save', and mark it deprecated as a next step.  In which
case I'd submit a patch with your suggestions in a few cycles.

> rday
> 
> -- 
> 
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                         http://crashcourse.ca
> 
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================
