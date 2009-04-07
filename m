From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Makefile: allow building without perl
Date: Tue, 7 Apr 2009 03:27:53 -0400
Message-ID: <20090407072738.GB5239@coredump.intra.peff.net>
References: <20090403192700.GA14965@coredump.intra.peff.net> <20090403193220.GC5547@coredump.intra.peff.net> <20090404T224109Z@curie.orbis-terrarum.net> <20090404233936.GB26906@coredump.intra.peff.net> <20090404T234556Z@curie.orbis-terrarum.net> <20090404235636.GA27354@coredump.intra.peff.net> <20090405T000318Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:29:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5kR-000849-1I
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbZDGH16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbZDGH16
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:27:58 -0400
Received: from peff.net ([208.65.91.99]:43093 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbZDGH15 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:27:57 -0400
Received: (qmail 603 invoked by uid 107); 7 Apr 2009 07:27:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 03:27:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 03:27:53 -0400
Content-Disposition: inline
In-Reply-To: <20090405T000318Z@curie.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115916>

On Sat, Apr 04, 2009 at 05:06:09PM -0700, Robin H. Johnson wrote:

> At a glance, PERL_PATH in configure.ac isn't actually used at the
> moment, the definition in the Makefile overrides it.

It is. The configure variables go into config.mak.autogen which is
included after PERL_PATH is set to a default value.

> Ok, drop the export then, but do keep at least the if(is empty
> PERL_PATH) then { set NO_PERL }, even if you won't keep the existence
> check.

Will do.

-Peff
