Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBB2C43460
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EFE6135F
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhDSXLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 19:11:32 -0400
Received: from omta015.useast.a.cloudfilter.net ([34.195.253.206]:56168 "EHLO
        omta015.useast.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232461AbhDSXLb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 19:11:31 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 19:11:31 EDT
Received: from cxr.smtp.a.cloudfilter.net ([10.0.16.209])
        by cmsmtp with ESMTP
        id YYMClAejg8ZfxYcvmltSPm; Mon, 19 Apr 2021 23:03:51 +0000
Received: from thunderbird.smith.home ([68.3.0.229])
        by cmsmtp with ESMTPSA
        id YcvjlDMFvSBdlYcvkl2It9; Mon, 19 Apr 2021 23:03:50 +0000
Authentication-Results: cox.net; auth=pass (PLAIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.4 cv=Kf0XDSUD c=1 sm=1 tr=0 ts=607e0c56
 a=6gJgLgZylzTWeuChIFeG9A==:117 a=6gJgLgZylzTWeuChIFeG9A==:17
 a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=-mUlzGMA1ef-VhCND9MA:9 a=CjuIK1q_8ugA:10
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 1FF522E0013C;
        Mon, 19 Apr 2021 16:03:47 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     Sebastian Schuberth <sschuberth@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
Date:   Mon, 19 Apr 2021 16:03:47 -0700
Message-ID: <3913391.baLtWKaSvh@thunderbird>
In-Reply-To: <20210419214921.afurkxy7oru6bny6@nitro.local>
References: <YHaIBvl6Mf7ztJB3@google.com> <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com> <20210419214921.afurkxy7oru6bny6@nitro.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CMAE-Envelope: MS4xfCEF0F6066bcUlFsl5I1ovAeA3wkZ9TvkdXu7AwLwSOTRkJ3XTQNwcloIAs65UdtrqWmoiNR6gaZgdyPZDrkJqUbuPDgVx5cxLP/HqjTo+AxEV8VQ5kM
 pJl0qLdf/fjIhkB0YNIphHryz7d3tL43AA3CCJT/RQhUHcS/Dqs+a+TqiYZ1YaHxPU2nMdNl29bE77xkmZMuHugH5Bb00/RvMR+56Nao+Vg9HR5W9jQG53jm
 yQ5S4z7LKczAAA/Ln9VuJ/6n8SC9mdjTwFugYw1byqI+ps2ukzwQ8yfzwl0koAdZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, April 19, 2021 2:49:21 PM MST Konstantin Ryabitsev wrote:
> On Mon, Apr 19, 2021 at 07:54:37AM +0200, Sebastian Schuberth wrote:
> > That's a good point, I admit I haven't thought of that. Probably
> > because I also don't care much. So *does* it really matter? What
> > exactly concerns you about a "centralized entity"? Is it the technical
> > aspect of a single point of failure, or the political / social aspect
> > of being dependent on someone you do not want to get influenced by? I
> > guess it's a bit of both.
> 
> It's all of the above, and really should not be discounted. Let's take what
> Russian government is doing lately as an example. In its effort to control
> social dissent, Russian censorship organization RosKomNadzor (RKN) has taken
> steps to deliberately break internet operation -- in a very ham-fisted way.

It can be other things too.   

For instance a corporation that for a variety of reasons has an urgent need to 
restrict internet traffic.   Email will usually get through, but web site traffic 
may not.

While Github is unlikely to get taken offline, other sites that hold data may 
not be so lucky.   Think bankrupcy or other issues.   

Email traffic allows for routing around such issues.





