From: Jeff King <peff@peff.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 19:26:10 -0400
Message-ID: <20080911232610.GA4279@coredump.intra.peff.net>
References: <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu> <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu> <20080911190335.GB1451@cuci.nl> <20080911200452.GM5082@mit.edu> <20080911214650.GB3187@coredump.intra.peff.net> <alpine.LFD.1.10.0809111533110.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@MIT.EDU>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:27:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdvZJ-0006v4-H4
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 01:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbYIKX0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 19:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754213AbYIKX0N
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 19:26:13 -0400
Received: from peff.net ([208.65.91.99]:1496 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbYIKX0M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 19:26:12 -0400
Received: (qmail 6707 invoked by uid 111); 11 Sep 2008 23:26:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 11 Sep 2008 19:26:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Sep 2008 19:26:10 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809111533110.3384@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95666>

On Thu, Sep 11, 2008 at 04:10:26PM -0700, Linus Torvalds wrote:

> > And obviously in Linus's workflow such references are basically useless,
> > and they should just not be generated.
> 
> This has _nothing_ to do with workflows or anything else.
> 
> Why are people claiming these total red herrings?
> 
> I have asked several times what it is that makes it so important that the 
> "origin" information be in the headers. Nobody has been able to explain 
> why it's so different from just doing it in the free-form part. NOBODY.

The message you are responding to has nothing to do with an origin
header versus putting it in the free-form part. It is equally a problem
with both approaches.

I was purely commenting on the "if I mention an arbitrary sha-1, what is
the person reading it supposed to _do_ with it, if they may never have
seen that sha-1" issue.

So yes, it has _everything_ to do with workflows. In Stephen's case, he
claims that all references will be to commits on long-lived branches. In
which case, it is a non-issue because they will have the referenced
commits.

But in the general case, people will not have them, and there is
potential head-scratching. My point is that even if a feature works for
Stephen's workflow, it may not be a good feature for everyone, since
other solutions handle the general case (as well as his case) much
better.

> [ranting about how the origin header is bad]
> The only thing I have ever argued against is adding commit headers that 
> have no sane semantics and don't make sense as internal git data 
> structures.

Yes, and I totally agree with everything you said. If you read the mail
you are responding to carefully, you will see that I never mention an
origin header versus the free-form commit.

-Peff
