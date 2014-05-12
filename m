From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Mon, 12 May 2014 17:05:05 -0400
Message-ID: <20140512210505.GD2329@sigill.intra.peff.net>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com>
 <20140425231953.GB3855@sigill.intra.peff.net>
 <536D080C.7030402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 12 23:05:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjxPS-0000Jq-3u
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 23:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbaELVFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 17:05:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:50191 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755840AbaELVFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 17:05:07 -0400
Received: (qmail 24873 invoked by uid 102); 12 May 2014 21:05:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 May 2014 16:05:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 May 2014 17:05:05 -0400
Content-Disposition: inline
In-Reply-To: <536D080C.7030402@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248733>

On Fri, May 09, 2014 at 06:53:32PM +0200, Michael Haggerty wrote:

> On 04/26/2014 01:19 AM, Jeff King wrote:
> > On Fri, Apr 25, 2014 at 03:50:26PM -0700, Junio C Hamano wrote:
> > [...]
> >> * fc/publish-vs-upstream (2014-04-21) 8 commits
> >>  - sha1_name: add support for @{publish} marks
> >>  - sha1_name: simplify track finding
> >>  - sha1_name: cleanup interpret_branch_name()
> >>  - branch: display publish branch
> >>  - push: add --set-publish option
> >>  - branch: add --set-publish-to option
> >>  - Add concept of 'publish' branch
> >>  - t5516 (fetch-push): fix test restoration
> >>
> >>  Add branch@{publish}; it seems that this is somewhat different from
> >>  Ram and Peff started working on.  There were many discussion
> >>  messages going back and forth but it does not appear that the
> >>  design issues have been worked out among participants yet.
> > 
> > [...]
> > As for the patches themselves, I have not reviewed them carefully, and
> > would prefer not to. As I mentioned before, though, I would prefer the
> > short "@{p}" not be taken for @{publish} until it has proven itself.
> 
> Is it too late and/or impossible to think of a different name for either
> "push" or "publish" so that their single-letter abbreviations don't
> coincide?

I don't think it is too late, as nothing has even made it to "master"
(and even once shipped, we can add an alias with a different name,
advertise that, and use its shorthand).

However, I am not sure if that is a good approach. New terms might not
collide in single-letters, but their full names might also not be as
descriptive. We'd have to judge actual proposals to see.

In addition, there was a discussion about having "pull" as an opposite
of "push" (which would make it an alias for "upstream"), that would also
collide. So there is a potential third name to deal with.

-Peff
