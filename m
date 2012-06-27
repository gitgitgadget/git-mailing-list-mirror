From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Wed, 27 Jun 2012 23:19:39 +0100
Message-ID: <20120627221938.GA1742@arachsys.com>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
 <233b27a14d16a2a1cb38b9f3e07a3a79b09a3256.1340830514.git.chris@arachsys.com>
 <20120627210502.GB2292@sigill.intra.peff.net>
 <7vbok4785a.fsf@alter.siamese.dyndns.org>
 <20120627221106.GE2292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 28 00:19:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk0aU-0001Xm-3Y
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 00:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258Ab2F0WTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 18:19:46 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:47726 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab2F0WTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 18:19:46 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1Sk0aM-0005CU-49; Wed, 27 Jun 2012 23:19:42 +0100
Content-Disposition: inline
In-Reply-To: <20120627221106.GE2292@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200767>

Jeff King <peff@peff.net> writes:

> I don't know that configured vs compiled-in is the right distinction
> there, though. If I'm building a minimal git for a stripped-down machine
> and I don't want to include the HTML pages locally, I might want to set
> the html path to a URL at build-time. That saves each user from having
> to configure it.

How about only testing for a git documentation directory if both
help.htmlpath isn't set (so we're using the compiled-in version) and the
compiled-in version doesn't contain ://?

Best wishes,

Chris.
