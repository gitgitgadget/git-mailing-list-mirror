From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git blame-tree
Date: Fri, 4 Mar 2011 09:53:40 -0500
Message-ID: <20110304145340.GA8345@sigill.intra.peff.net>
References: <20110302164031.GA18233@sigill.intra.peff.net>
 <1299249614.2133.19.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 15:53:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvWO5-0004Lp-Ga
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 15:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759685Ab1CDOxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 09:53:44 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38585 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759605Ab1CDOxn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 09:53:43 -0500
Received: (qmail 4620 invoked by uid 111); 4 Mar 2011 14:53:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 04 Mar 2011 14:53:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Mar 2011 09:53:40 -0500
Content-Disposition: inline
In-Reply-To: <1299249614.2133.19.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168441>

On Fri, Mar 04, 2011 at 02:40:14PM +0000, Will Palmer wrote:

> Coincidentally, I'm doing a similar thing in a shell script at the
> moment. Unfortunately, no tree-object is involved: I'm instead using the
> output from "git diff" on two different branches to generate a list of
> files I care about. How hard would it be to accept a nul-delimited list
> of filenames via stdin, rather than from a tree? If I'm reading this
> right, it looks like a pretty trivial change.

My planned rewrite will take arbitrary pathspecs, so you can ask for a
subset of the project files, not just a specific tree, on the
command-line.  Which may be enough for your purposes (coupled with
xargs). But it would also be easy enough to take rev options on stdin
for very large cases that would exceed the usual command-line limits.

> (I couldn't get the existing patch to apply, myself.. I assume I'm
> just doing something wrong as I don't need to use "git am" very
> often.)

It's also possible I screwed something up in posting it. If you describe
the problem, I might be able to help.

-Peff
