From: Jeff King <peff@peff.net>
Subject: Re: Local tag killer
Date: Wed, 25 Sep 2013 04:22:52 -0400
Message-ID: <20130925082251.GB23238@sigill.intra.peff.net>
References: <52327E62.2040301@alum.mit.edu>
 <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>
 <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com>
 <523D3FD2.4090002@alum.mit.edu>
 <20130924075119.GD7257@sigill.intra.peff.net>
 <52419218.3020902@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 10:23:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOkNB-0005I2-N3
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 10:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab3IYIW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 04:22:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:35378 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832Ab3IYIWy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 04:22:54 -0400
Received: (qmail 22974 invoked by uid 102); 25 Sep 2013 08:22:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Sep 2013 03:22:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Sep 2013 04:22:52 -0400
Content-Disposition: inline
In-Reply-To: <52419218.3020902@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235336>

On Tue, Sep 24, 2013 at 09:22:32AM -0400, Marc Branchaud wrote:

> >If we instead moved to a default fetch refspec more like:
> >
> >   [remote "origin"]
> >   fetch = +refs/*:refs/remotes/origin/refs/*
> 
> I'm all for such a change.
> 
> You no doubt recall the lengthy discussion about remote ref
> namespaces back in 2011 [1].  That arose while planning for 1.8, but
> my feeble recollection is that the change was considered too
> disruptive.  It seems 2.0 would be a better home for such work.

I do recall the discussion, though I did not review all of the
complications before writing this most recent mail.

I assume there are backwards compatibility issues lurking, and we may
even need a config switch to flip between old-style and new-style modes
(and leave it set to old-style at first, wait a while for people to have
a git that understands both, and then flip the default to new-style).

However, none of that is for Git 2.0. I do not think we have an exact
date set for Git 2.0, but we already have several switches ready to be
flipped.  I think Junio's plan was to do it sooner rather than later,
and not try to cram a bunch of last-minute compatibility breakages in.

-Peff
