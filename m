From: Jeff King <peff@peff.net>
Subject: Re: How to find where a branch was taken from.
Date: Sat, 22 Mar 2008 12:41:37 -0400
Message-ID: <20080322164136.GA7611@coredump.intra.peff.net>
References: <47E37A63.9070209@glidos.net> <7v4pb0qw28.fsf@gitster.siamese.dyndns.org> <32541b130803211039h1f5b8da5k8fb353d46e57b05e@mail.gmail.com> <47E4F7A0.6060702@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Sat Mar 22 17:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd6nV-0005z5-IR
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 17:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbYCVQlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 12:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbYCVQlk
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 12:41:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3718 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121AbYCVQlj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 12:41:39 -0400
Received: (qmail 31886 invoked by uid 111); 22 Mar 2008 16:41:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 22 Mar 2008 12:41:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Mar 2008 12:41:37 -0400
Content-Disposition: inline
In-Reply-To: <47E4F7A0.6060702@glidos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77823>

On Sat, Mar 22, 2008 at 12:12:16PM +0000, Paul Gardiner wrote:

> Yes, that's exactly what I need too. I need to produce it
> programatically. I notice gitk displays, for each commit,
> the branches that include it. If I knew a command for
> deriving that, I could iterate through HEAD, HEAD~1, HEAD~2...
> until I see a remote branch.

How about:

  git name-rev --refs='refs/remotes/*' $COMMIT

?

-Peff
