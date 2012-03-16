From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Fri, 16 Mar 2012 23:01:19 +0100
Message-ID: <20120316220117.GA25624@ecki>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr>
 <7vty1rqek5.fsf@alter.siamese.dyndns.org>
 <7vlin1gl9l.fsf@alter.siamese.dyndns.org>
 <20120316091019.GB22273@ecki>
 <7v3998kb0x.fsf@alter.siamese.dyndns.org>
 <20120316214151.GA25092@ecki>
 <7v1uosfc0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Tiwald <christiwald@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 23:02:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8fDs-0004Mv-7i
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 23:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031730Ab2CPWCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 18:02:03 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:15034 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031333Ab2CPWCC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 18:02:02 -0400
Received: from localhost (p5B22F52F.dip.t-dialin.net [91.34.245.47])
	by bsmtp.bon.at (Postfix) with ESMTP id A93CC2C4004;
	Fri, 16 Mar 2012 23:02:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v1uosfc0p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193287>

On Fri, Mar 16, 2012 at 02:53:42PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > On Fri, Mar 16, 2012 at 05:03:58AM -0700, Junio C Hamano wrote:
> >> Clemens Buchacher <drizzd@aon.at> writes:
> >> ...
> >> >> +static const char message_advice_use_upstream[] =
> >> >> +	N_("Some of your local branches were stale with respect to their\n"
> >> >> +	   "remote counterparts. If you did not intend to push these branches,\n"
> >> >> +	   "you may want to set the 'push.default' configuration variable to\n"
> >> >> +	   "'current' or 'upstream' to push only the current branch.");
> >> >> +
> >> >> +static const char message_advice_checkout_pull_push[] =
> >> >> +	N_("Updates were rejected because the tip of some of your branches are\n"
> >> >> +	   "behind the remote. Check out the branch and merge the remote\n"
> >> >> +	   "changes (e.g. 'git pull') before pushing again. See the\n"
> >> >> +	   "'Note about fast-forwards' section of 'git push --help'\n"
> >> >> +	   "for details.");
> >> >
> > ...
> > Sorry if I did not express myself well. I should have deleted the first
> > message. I was not talking about the case where the current branch is
> > rejected. I mean the two cases where other branches are rejected.
> 
> Oh, I see.  My reply ended up being very similar, though ;-)

I am afraid we are still not talking about the same thing...
