From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Mon, 28 Apr 2014 14:01:50 -0400
Message-ID: <20140428180150.GA25993@sigill.intra.peff.net>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com>
 <20140425231953.GB3855@sigill.intra.peff.net>
 <xmqqa9b5s5ui.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:48:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerXZ-0001h4-SX
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929AbaD1Tse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:48:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:40632 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754374AbaD1Tsd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:48:33 -0400
Received: (qmail 6339 invoked by uid 102); 28 Apr 2014 18:01:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 13:01:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 14:01:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa9b5s5ui.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247422>

On Mon, Apr 28, 2014 at 10:48:21AM -0700, Junio C Hamano wrote:

> > diff --git a/diff.c b/diff.c
> > index 54d5308..a03744b 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -2894,7 +2894,7 @@ static void run_external_diff(const char *pgm,
> >  			      int complete_rewrite,
> >  			      struct diff_options *o)
> >  {
> > -	const char *spawn_arg[10];
> > +	const char *spawn_arg[11];
> >  	int retval;
> >  	const char **arg = &spawn_arg[0];
> >  	struct diff_queue_struct *q = &diff_queued_diff;
> >
> > as a fix for maint/2.0.0 in the interim. I can write a commit message
> > for that if you're interested.
> 
> I think we should merge the first one (and possibly the second one,
> too) as-is for 2.0 instead.  No change can possibly be more
> trivially correct than these two ;-)

I'm fine with that. The second patch is pure clean-up and doesn't fix
anything (because the "3" in the env array is actually correct), so it
can happily wait for the next cycle.

-Peff
