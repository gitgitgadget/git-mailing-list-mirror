From: Jeff King <peff@peff.net>
Subject: Re: how to make a commit only contain existing files
Date: Tue, 7 Dec 2010 16:11:26 -0500
Message-ID: <20101207211126.GA29453@sigill.intra.peff.net>
References: <alpine.DEB.2.00.1012071203190.662@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Tue Dec 07 22:11:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4ow-0000iz-6K
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 22:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252Ab0LGVL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 16:11:29 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45939 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706Ab0LGVL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 16:11:29 -0500
Received: (qmail 28433 invoked by uid 111); 7 Dec 2010 21:11:28 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Dec 2010 21:11:28 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Dec 2010 16:11:26 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012071203190.662@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163136>

On Tue, Dec 07, 2010 at 01:00:18PM -0800, david@lang.hm wrote:

> I know that I can do a git rm to explictly remove files, but is there
> an easy way to just say that this commit should contain all the files
> that exist at this point in time, without carrying over any files
> that were in a prior commit but that don't exist now?

Won't "git add -A; git commit" do what you want?

-Peff
