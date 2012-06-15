From: Jeff King <peff@peff.net>
Subject: Re: Incorrect v1.7.10.4 tag on github?
Date: Fri, 15 Jun 2012 14:25:34 -0400
Message-ID: <20120615182534.GB14843@sigill.intra.peff.net>
References: <77A5E1CD-836A-4747-9E62-42C25C0D8B7D@sfu.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Graham Ballantyne <grahamb@sfu.ca>
X-From: git-owner@vger.kernel.org Fri Jun 15 20:26:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfbDs-0000sy-NE
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 20:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227Ab2FOSZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 14:25:37 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57655
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757025Ab2FOSZh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 14:25:37 -0400
Received: (qmail 2219 invoked by uid 107); 15 Jun 2012 18:25:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 14:25:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 14:25:34 -0400
Content-Disposition: inline
In-Reply-To: <77A5E1CD-836A-4747-9E62-42C25C0D8B7D@sfu.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200077>

On Fri, Jun 15, 2012 at 09:51:00AM -0700, Graham Ballantyne wrote:

> I just downloaded the 1.7.10.4 tag from github. After compiling and
> installing, git --version returns "git version 1.7.10.3". I think that
> tag might be pointing to the wrong commit?

Looks like 121f71f (Git 1.7.10.4, 2012-06-03) forgot to update DEF_VAR
in GIT-VERSION-GEN. Operator error from the maintainer?

It builds with the right version from the git repository (which runs
git-describe and sees we are on the v1.7.10.4 tag), but exporting the
tag's contents and building fails. I suspect that the git-1.7.10.4
tarball on kernel.org would also have the same problem.

-Peff
