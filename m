From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 00/21] replacement for dt/refs-backend-lmdb v7 patch
 04/33
Date: Thu, 31 Mar 2016 18:22:42 -0400
Organization: Twitter
Message-ID: <1459462962.2976.38.camel@twopensource.com>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
	 <1458802034.28595.8.camel@twopensource.com> <56F76E2C.5030700@alum.mit.edu>
	 <1459282370.2976.7.camel@twopensource.com> <56FB743C.3020902@alum.mit.edu>
	 <1459368315.2976.27.camel@twopensource.com> <56FD4CCB.1000205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:22:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alkzK-0001nX-BR
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 00:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092AbcCaWWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 18:22:46 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36040 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452AbcCaWWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 18:22:45 -0400
Received: by mail-qg0-f50.google.com with SMTP id w104so74357097qge.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=l5iRxYsiCN5m4kFwxyePe1DWRvkO25v0aKz4CejSbIw=;
        b=CXVNJ9U3cqEmbsLbxc2PKXqAJqhUpIg4LjbnnxYuyMFCLYC5Vq+R5gsT0TtpROn6JT
         lTrb7p4T9BXMPvtxUTdOj3pJHlhDfFsqXKjt9azQYqzFv+2xTfMrqIEtpDKHGrHINbnO
         JPOABiTh1mGGw3cVXvKiIeNFYHnQ9m6oykjuwzK2krqka4ghr1gkb0/7C9MLnSGyrXgP
         d641v9Xxc4D6nIC4OXeV47zsVOBKrEMkPmUgnHiL+6q7iOwCfxZXmtFNDI8zg8Ffcrtj
         BEkwWpcGmNpFlKGivSrLZzmla466hG1fXwtPuDL4GT+tHAUKp9Y6GS0PkyuLA2uEiA8B
         LbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=l5iRxYsiCN5m4kFwxyePe1DWRvkO25v0aKz4CejSbIw=;
        b=igDr8Wxe2Q87buIAZMJE9LOq2vjSZqa0+s6Zbxbb4/wEtMN+ZMHVGn5sIybznJCnma
         VYBV6TDFdaDi7aVxJyotvYFGuiDevP8reLDkswBY4mGUeqP54/8z8atuEeASQhIGPNPt
         eCeGQgAYmJl7GE2nA7tBshVAiafqkCSwYgOa9wisKmPr/MWjz5+QV4Qvcd2lqbyedWtx
         l5TwP1jCS8mTfMA6cpJ5NanpRNa847mq8MJlK3t3gyjMvJtKIfr4DGA+IdAGMTe6xbgE
         SQ0wbRJmBf/MRNRZU8cdNEtbZhNi5pzDQ1JYcJ3vM02rgYuI6eDL6XrX98U61AwzEKDf
         Z7VQ==
X-Gm-Message-State: AD7BkJJ+UjjXlO7nAMTba2VzunIyq/b8q7iHaIvIW96nVd10+DtcUIqyAzsiKqtf1eKVVg==
X-Received: by 10.140.128.21 with SMTP id 21mr2275848qha.59.1459462964548;
        Thu, 31 Mar 2016 15:22:44 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b85sm4822012qhc.23.2016.03.31.15.22.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2016 15:22:43 -0700 (PDT)
In-Reply-To: <56FD4CCB.1000205@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290478>

On Thu, 2016-03-31 at 18:14 +0200, Michael Haggerty wrote:
> On 03/30/2016 10:05 PM, David Turner wrote:
> > On Wed, 2016-03-30 at 08:37 +0200, Michael Haggerty wrote:
> > > On 03/29/2016 10:12 PM, David Turner wrote:
> > > > On Sun, 2016-03-27 at 07:22 +0200, Michael Haggerty wrote:
> > > > > On 03/24/2016 07:47 AM, David Turner wrote:
> > > > > > [...]
> > > > > > I incorporated your changes into the lmdb backend.  To make
> > > > > > merging
> > > > > > later more convenient, I rebased on top of pu -- I think
> > > > > > this
> > > > > > mainly
> > > > > > depends on jk/check-repository-format, but I also included
> > > > > > some
> > > > > > fixes
> > > > > > for a couple of tests that had been changed by other
> > > > > > patches.
> > > > > 
> > > > > I think rebasing changes on top of pu is counterproductive. I
> > > > > believe
> > > > > that Junio had extra work rebasing your earlier series onto a
> > > > > merge
> > > > > of
> > > > > the minimum number of topics that it really depended on.
> > > > > There is
> > > > > no
> > > > > way
> > > > > that he could merge the branch in this form because it would
> > > > > imply
> > > > > merging all of pu.
> > > > > 
> > > > > See the zeroth section of SubmittingPatches [1] for the
> > > > > guidelines.
> > > > 
> > > > I'm a bit confused because 
> > > > [PATCH 18/21] get_default_remote(): remove unneeded flag
> > > > variable
> > > > 
> > > > doesn't do anything on master -- it depends on some patch in
> > > > pu. 
> > > >  And
> > > > we definitely want to pick up jk/check-repository-format (which
> > > > doesn't
> > > > include whatever 18/21 depends on).
> > > > 
> > > > So what do you think our base should be?
> > > 
> > > I think the preference is to base a patch series on the merge of
> > > master
> > > plus the minimum number of topics in pu (ideally, none) that are
> > > "essential" prerequisites of the changes in the patch series. For
> > > example, the version of this patch series that Junio has in his
> > > tree
> > > was
> > > based on master + sb/submodule-parallel-update. 
> > > 
> > > Even if there are minor
> > > conflicts with another in-flight topic, it is easier for Junio to
> > > resolve the conflicts when merging the topics together than to
> > > rebase
> > > the patch series over and over as the other patch series evolves.
> > > The
> > > goal of this practice is of course to allow patch series to
> > > evolve
> > > independently of each other as much as possible.
> > > 
> > > Of course if you have insights into nontrivial conflicts between
> > > your
> > > patch series and others, it would be helpful to discuss these in
> > > your
> > > cover letter.
> > 
> > If I am reading this correctly, it looks like your series also has
> > a
> > few more sb submodule patches, e.g. sb/submodule-init, which is
> > responsible for the code that 18/21 depends on.  
> > 
> > I think jk/check-repository-format is also  good to get in first,
> > because it changes the startup sequence a bit and it's a bit tricky
> > to
> > figure out what needs to change in dt/refs-backend-lmdb as a result
> > of
> > it. 
> > 
> > But I can't just merge jk/check-repository-format on top of
> > 71defe0047 
> > -- some function signatures have changed in the run-command stuff
> > and
> > it seems kind of annoying to fix up.  
> > 
> > So I propose instead that we just drop 18/21 for now, and use just
> > jk/check-repository-format as the base.
> > 
> > Does this seem reasonable to you?
> 
> Yes, that's fine. Patch 18/21 is just a random cleanup that nothing
> else
> depends on. Will you do the rebasing? If so, please let me know where
> I
> can fetch the result from.

Rebased:

https://github.com/dturner-tw/git.git on branch
dturner/pluggable-backends
