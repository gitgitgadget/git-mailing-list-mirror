From: Jeff King <peff@peff.net>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 07:59:46 -0500
Message-ID: <20090212125946.GC5397@sigill.intra.peff.net>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com> <20090212084811.GA14261@piper.oerlikon.madduck.net> <20090212092558.GB21074@skywalker> <20090212125621.GB5397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aneesh Kumar <aneesh.kumar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, madduck@debian.org,
	git@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 14:01:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXbBu-0007sr-AQ
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 14:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749AbZBLM7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 07:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbZBLM7u
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 07:59:50 -0500
Received: from peff.net ([208.65.91.99]:43006 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbZBLM7u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 07:59:50 -0500
Received: (qmail 8351 invoked by uid 107); 12 Feb 2009 13:00:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 12 Feb 2009 08:00:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Feb 2009 07:59:46 -0500
Content-Disposition: inline
In-Reply-To: <20090212125621.GB5397@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109613>

On Thu, Feb 12, 2009 at 07:56:21AM -0500, Jeff King wrote:

> So what I suspect is happening is that topgit is trying to set HEAD to
> "refs/top-bases/whatever". Aneesh, can you confirm by running your test
> with GIT_TRACE=1?  I suspect you will see a call like "git symbolic-ref
> HEAD refs/top-bases/foo".

Actually, I was able to reproduce with the recipe from Martin and Bert
elsewhere in the thread. And that is indeed what is happening:

  trace: built-in: git 'symbolic-ref' 'HEAD' 'refs/top-bases/test'

-Peff
