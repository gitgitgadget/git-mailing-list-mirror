From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add submitGit patch-submission information
Date: Thu, 14 Apr 2016 22:05:03 -0400
Message-ID: <20160415020503.GB22112@sigill.intra.peff.net>
References: <0102015416d52ae9-da060607-a742-4efc-8b40-98301c2bb261-000000@eu-west-1.amazonses.com>
 <0102015416d52b62-ce575cc4-6dc2-4097-8883-79baac701105-000000@eu-west-1.amazonses.com>
 <xmqq37qng721.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Roberto Tyley <roberto.tyley@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:05:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqt8E-0000Fj-8F
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 04:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbcDOCFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 22:05:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:49874 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751623AbcDOCFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 22:05:06 -0400
Received: (qmail 7210 invoked by uid 102); 15 Apr 2016 02:05:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 22:05:06 -0400
Received: (qmail 5729 invoked by uid 107); 15 Apr 2016 02:05:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 22:05:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 22:05:03 -0400
Content-Disposition: inline
In-Reply-To: <xmqq37qng721.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291590>

On Thu, Apr 14, 2016 at 03:27:18PM -0700, Junio C Hamano wrote:

> > +  - Create a pull request on https://github.com/git/git and
> > +    use https://submitgit.herokuapp.com/ to send it as a patch series
> > +    to the mailing list.  Note that the PR is just the place where your
> > +    patch is born - discussion of the patch should still take place on
> > +    the Git mailing list.
> 
> This is a tangent but I am wondering if you can do this _without_
> creating a pull request to that repository.  I have a watch on that
> repository and my notification gets unnecessarily large because of
> these pull requests that were made _only_ for submitGit.  Can't
> submitGit be taught to take a branch in a repository of the
> submitter as input, (instead of a pull request to that public
> repository)?

Yeah, I have noticed that, too. It creates a lot of noise in my
notification feed (which I process by email), to the point that I'll
probably un-watch git/git.

-Peff
