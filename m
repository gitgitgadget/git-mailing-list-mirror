From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add MYMETA.yml to perl/.gitignore
Date: Thu, 1 Dec 2011 17:35:20 -0500
Message-ID: <20111201223520.GB4869@sigill.intra.peff.net>
References: <20111201203114.GA12796@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Morr <sebastian@morr.cc>
X-From: git-owner@vger.kernel.org Thu Dec 01 23:35:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWFDz-0001LR-Sv
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 23:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978Ab1LAWfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 17:35:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59340
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754710Ab1LAWfW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 17:35:22 -0500
Received: (qmail 20418 invoked by uid 107); 1 Dec 2011 22:41:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Dec 2011 17:41:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2011 17:35:20 -0500
Content-Disposition: inline
In-Reply-To: <20111201203114.GA12796@thinkpad>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186196>

On Thu, Dec 01, 2011 at 09:31:15PM +0100, Sebastian Morr wrote:

> This file is auto-generated in the process of building the Perl
> extension.
>
> [...]
> 
> I just built Git for the first time, issued "git status", and there
> was this untracked file. I guess you could call that an itch. This patch
> fixes that, however, I'm not sure whether this is a relevant issue.

Thanks, I wrote the same patch myself last week. I could swear I sent it
to the list, but it appears that I forgot.

The only thing I would add is the reason this is suddenly coming up now:
generating MYMETA.yml is done only by new-ish versions of
ExtUtils::MakeMaker (it started for me with perl 5.14, which just hit
debian unstable recently). The file just contains extra information
about the environment and arguments to the Makefile-building process,
and can be safely deleted.

-Peff
