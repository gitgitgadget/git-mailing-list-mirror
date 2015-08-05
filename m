From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] clone: simplify string handling in guess_dir_name()
Date: Wed, 5 Aug 2015 05:09:47 -0400
Message-ID: <20150805090947.GA3847@sigill.intra.peff.net>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
 <0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
 <20150804043401.4494.43725@typhoon>
 <CAHGBnuMXkqhFUhen9tPfEsfFAHhbqMeFUxvePS_6A-TtMfZpzg@mail.gmail.com>
 <20150804224246.GA29051@sigill.intra.peff.net>
 <20150805060852.GA1103@pks-pc.localdomain>
 <20150805084147.GC28212@sigill.intra.peff.net>
 <20150805090603.GC1103@pks-pc.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Aug 05 11:10:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMuhy-000531-7g
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 11:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbbHEJJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 05:09:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:41029 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750989AbbHEJJv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 05:09:51 -0400
Received: (qmail 23358 invoked by uid 102); 5 Aug 2015 09:09:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 04:09:52 -0500
Received: (qmail 27599 invoked by uid 107); 5 Aug 2015 09:10:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 05:10:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2015 05:09:47 -0400
Content-Disposition: inline
In-Reply-To: <20150805090603.GC1103@pks-pc.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275360>

On Wed, Aug 05, 2015 at 11:06:03AM +0200, Patrick Steinhardt wrote:

> You're welcome. And yes, your tests help me quite a lot here. Got
> tedious to always set up the chroot. Guess I'll still send my
> fixes for the chroot-tests as a separate patch series, even
> though I don't require them anymore.

Yeah, fixes for t1509 are definitely welcome.

> Short question on how to proceed: should I mention that my patch
> series builds upon your patches or just include them in my
> series?

I think we'll want to merge my patches separately, due to the
regression, so you should not include them. So hopefully the sequence
is:

  1. Junio picks them up as jk/guess-repo-name-regression or similar.

  2. They are merged to 'next', and then eventually to 'maint'.

  3. Mention the topic branch name (whatever Junio ends up picking for
     it) when you post your patches. Junio can then apply on top in his
     repo.

  4. If re-rolls keep going past step 2, then it becomes a non-issue, as
     'maint' gets merged to 'master'.

-Peff
