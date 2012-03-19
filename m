From: Jeff King <peff@peff.net>
Subject: Re: link user-name with ssh-login
Date: Mon, 19 Mar 2012 16:57:47 -0400
Message-ID: <20120319205747.GB3039@sigill.intra.peff.net>
References: <4F6765D0.5060706@gmail.com>
 <7v7gygbdxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Roberto <mrgreiner@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:57:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9jeO-00058x-OX
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 21:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab2CSU5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 16:57:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53768
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022Ab2CSU5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 16:57:51 -0400
Received: (qmail 2021 invoked by uid 107); 19 Mar 2012 20:58:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Mar 2012 16:58:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Mar 2012 16:57:47 -0400
Content-Disposition: inline
In-Reply-To: <7v7gygbdxg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193458>

On Mon, Mar 19, 2012 at 12:15:07PM -0700, Junio C Hamano wrote:

> A pre-receive hook that lists the author names of the commits, along the
> lines of "git log --format='%an <%ae>' $OLD_HEAD..$NEW_HEAD" and compares
> against the name of the user authenticated against your SSH server would
> be a way to do this.
> 
> But that would mean you are forbidding people to accept patches from
> others, inspect the patches for validity and vouch for them, while giving
> the credit to them by recoding the author names of the patch authors.
> 
> Perhaps checking the committer name would suit your situation better.  I
> dunno.

Then you would be forbidding merges of other people's work, no? Even if
the other person's commits are available in the upstream repo, they
might be hitting this ref for the first time, and would be generally be
checked by such a hook.

-Peff
