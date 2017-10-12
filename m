Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3158620467
	for <e@80x24.org>; Thu, 12 Oct 2017 09:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbdJLJGx (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 05:06:53 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:52584 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdJLJGv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 05:06:51 -0400
Received: by mail-wm0-f43.google.com with SMTP id k4so11355269wmc.1
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 02:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OZA//qE1k+nL6XcmpX8sP2JG3V+ljlnIowOlPu72QOA=;
        b=AWQZHWKlWwAc4QoAYSCCl3a8om3dFPtcRA7hsIbUQkmn28FgG2qKYaw0qc0NdVU0Bt
         +3FJjmOxW7uR+CgXd+5m90eu8YE8KMktk5h6uFXaQfprCEdMQySJsaQZjLOUR3R04GZ8
         2jRDsuf56Z1QRf0nPTMaBjuPSQCYjI4V6yWhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OZA//qE1k+nL6XcmpX8sP2JG3V+ljlnIowOlPu72QOA=;
        b=TZZJsjunWhfHEu1ro+FXsYu6HGscQ5Oc6Tz5H42oY/1sFwbemD01BTku8MzfIJxzhv
         EcnvSkMtx0LmDPv1L2+dsUQjgqPLiU2SfH0Kegn22KY/CTCwMRYpfBDS7oYm3va+UDIJ
         gUWmOOVQIxtGw4KlzpQGE9T5Ch9DhqJZkJy534fLrBXx4qnjbsfREYD3KNyNEzv19fgd
         4KT/5zG7WRGX+Ubenr09XDu39Lq64cpUfC+WrNHTm8cJCbY5C3ORy7WdWIB6OBPcgQ47
         ltIlDYFvZzK+RC/5xMYGGjeTiMFI7JnUJ3cTQOQAiTq2gCp8doOTww+K3Qg5WjSAFNDC
         NgYg==
X-Gm-Message-State: AMCzsaUMEFjy9oTW4UjOzi5Ou5tVqzvLagrE5F+dNLp/+HgtqKslD5ie
        9cL2I+IQerd4EbHNKrNJmxBNxVLp4pI=
X-Google-Smtp-Source: AOwi7QB5JNAyJ/7E8EDxhvRAwplgDLLyzzkTCobIpwlymv3Ye8LsQ/O6M7N3cPPGl5wVElJx27xr8A==
X-Received: by 10.28.184.141 with SMTP id i135mr1371405wmf.143.1507799210705;
        Thu, 12 Oct 2017 02:06:50 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id i76sm40114014wmd.2.2017.10.12.02.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Oct 2017 02:06:50 -0700 (PDT)
Date:   Thu, 12 Oct 2017 10:06:48 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: v2.15.0-rc1 test failure
Message-ID: <20171012090648.GB6079@dinwoodie.org>
References: <8dd12465-0dc2-340e-8db0-e37719f34efc@ramsayjones.plus.com>
 <20171011223433.GA6079@dinwoodie.org>
 <338656d4-182b-563f-9195-515d213d4b6d@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <338656d4-182b-563f-9195-515d213d4b6d@ramsayjones.plus.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 01:27:57AM +0100, Ramsay Jones wrote:
> On 11/10/17 23:34, Adam Dinwoodie wrote:
> [snip]
> > Hi Ramsay,
> > 
> > I assume, given you're emailing me, that this is a Cygwin failure?
> 
> Yes, sorry, I should have made that clear.
> 
> > t0021.15 has PERL as a requirement, and I see semi-regular failures from
> > Git tests that are Perl-based in one way or another (git-svn tests are
> > the most common problems).  I've not spotted t0021 failing in that way,
> > but it sounds like the same class of problem.
> 
> Yep, many moons ago, I used to run the svn tests (on Linux and cygwin)
> which would fail intermittently on cygwin. I didn't notice any problem
> with perl though.
> 
> > I dig into these failures when I see them, mostly by running the script
> > a few hundred times until I get the failure again, and they've always
> > been Perl itself segfaulting.  That points to the problem being in
> > Cygwin's Perl package rather than Git, and it's very unlikely to be
> > anything that's got worse in v2.15.0.
> 
> Since I stopped running the svn tests, the number of intermittent test failures on cygwin have dropped significantly, but haven't gone away
> completely.
> 
> I just finished the second test-suite run and, of course, t0021 ran
> without problem this time. Hmm, I don't think I have time to chase
> this down at the moment. I will keep your 'perl hypothesis' in mind
> for next time, however.

Evidence for my Perl hypothesis, which I offer at least as much so other
people can check my logic as anything else:

Here's a fairly typical set of verbose output from a test failing in
this way [0].  The critical bit is the line "error: git-svn died of
signal 11".  Since git-svn is a Perl script, and Perl is the sort of
interpreted language that would throw its own errors if it encountered a
script bug, the fact that it's hitting a segfault means there's a
problem of some ilk with the Perl interpreter itself.

[0]: https://github.com/me-and/Cygwin-Git/issues/13#issuecomment-211372448

Adam
