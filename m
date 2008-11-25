From: Jeff King <peff@peff.net>
Subject: Re: Extra pair of double quotes in "git commit" output?
Date: Tue, 25 Nov 2008 18:25:21 -0500
Message-ID: <20081125232521.GC30942@coredump.intra.peff.net>
References: <20081126064906.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 00:27:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L57It-0005R5-TZ
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 00:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbYKYXZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 18:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbYKYXZY
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 18:25:24 -0500
Received: from peff.net ([208.65.91.99]:1028 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbYKYXZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 18:25:24 -0500
Received: (qmail 2794 invoked by uid 111); 25 Nov 2008 23:25:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Nov 2008 18:25:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Nov 2008 18:25:21 -0500
Content-Disposition: inline
In-Reply-To: <20081126064906.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101692>

On Wed, Nov 26, 2008 at 06:49:06AM +0900, Nanako Shiraishi wrote:

> While I think the way recent "git commit" displays the commit you just
> created is very helpful, I often find the double quotes around the
> message unnecessary and sometimes even confusing.  I just made a
> commit and saw this message:
> 
>     [master]: created d9a5491: "Show "standard deviation" column in table 3"

While I do think that typographically the embedded quotes look awful, I
find that the quotes do help separate the commit subject from the other
text when there are colons in the subject. IOW, I think that

  [master]: created d9a5491: foo: bar

is harder to read than

  [master]: created d9a5491: "foo: bar"

And 47% of commits in git.git have a colon (only 7% have a double
quote).

So I sympathize with the desire to remove the quotes, as they look bad
and are obviously not too rare. But I'd like to find a solution which
maintains a better visual separation between the subject and the other
text than simply removing them.

-Peff
