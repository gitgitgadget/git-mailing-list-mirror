From: Jeff King <peff@peff.net>
Subject: Re: Fwd: [PATCH 4/5] Replace {pre,suf}fixcmp() with
 {starts,ends}_with()
Date: Wed, 4 Dec 2013 14:45:15 -0500
Message-ID: <20131204194515.GA16603@sigill.intra.peff.net>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
 <20131201074919.3042.92026.chriscool@tuxfamily.org>
 <CAP8UFD0jg_Vr7Zf+DiMX9RG6vmmQvmk2NvmL7j=MC-x3fLOOBA@mail.gmail.com>
 <20131203124645.GB26667@sigill.intra.peff.net>
 <CAP8UFD0By77QVH1amsh85dX6h1S3iFZcmPzs3JjPZmiD_AmOPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 20:45:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoINv-0002DL-53
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 20:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933157Ab3LDTpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 14:45:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:50441 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933096Ab3LDTpR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 14:45:17 -0500
Received: (qmail 23577 invoked by uid 102); 4 Dec 2013 19:45:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Dec 2013 13:45:16 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Dec 2013 14:45:15 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD0By77QVH1amsh85dX6h1S3iFZcmPzs3JjPZmiD_AmOPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238805>

On Tue, Dec 03, 2013 at 09:24:40PM +0100, Christian Couder wrote:

> > I skimmed the patch and didn't notice any problems. It's
> > whitespace-damaged by gmail, of course. The simplest thing is probably
> > to just point us at a public repo with the commit, if you have one.
> 
> Ok, the commit is in the use_starts_ends_with branch on this github repo:
> 
> https://github.com/chriscool/git.git

Thanks. I looked more carefully this time, using a few greps to classify
the surrounding context (since the script you used for the update could
conceivably miss some really odd misuse). The whole thing looks good to
me.

-Peff
