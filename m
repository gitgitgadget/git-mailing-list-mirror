From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] environment: add GIT_PREFIX to local_repo_env
Date: Fri, 8 Mar 2013 16:44:04 -0500
Message-ID: <20130308214404.GA9723@sigill.intra.peff.net>
References: <20130308092824.GA9127@sigill.intra.peff.net>
 <20130308093025.GB1923@sigill.intra.peff.net>
 <CAPig+cRUCnWJLeuXL=LLk7kUkwPnHqaL_KGcSdq3yO+YZ345tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 22:44:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE55f-0005iW-1v
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 22:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631Ab3CHVoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 16:44:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41225 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522Ab3CHVoH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 16:44:07 -0500
Received: (qmail 19243 invoked by uid 107); 8 Mar 2013 21:45:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 16:45:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 16:44:04 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cRUCnWJLeuXL=LLk7kUkwPnHqaL_KGcSdq3yO+YZ345tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217684>

On Fri, Mar 08, 2013 at 04:39:02PM -0500, Eric Sunshine wrote:

> On Fri, Mar 8, 2013 at 4:30 AM, Jeff King <peff@peff.net> wrote:
> > The GIT_PREFIX variable is set based on our location within
> > the working tree. It should therefore be cleared whenever
> > GIT_WORK_TREE is cleared.
> >
> > In practice, this doesn't cause any bugs, because none of
> > the sub-programs we invoke with local_repo_env cleared
> > actually care about GIT_PREFIX. But this is the right thing
> > to do, and future proofs us again that assumption changing.
> 
> s/again/against/

Yep, thanks.

-Peff
