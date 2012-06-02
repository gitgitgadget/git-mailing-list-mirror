From: Jeff King <peff@peff.net>
Subject: Re: git version statistics
Date: Sat, 2 Jun 2012 14:49:48 -0400
Message-ID: <20120602184948.GA14269@sigill.intra.peff.net>
References: <20120531114801.GA21367@sigill.intra.peff.net>
 <20120531120018.GA24986@sigill.intra.peff.net>
 <7v396g6t53.fsf@alter.siamese.dyndns.org>
 <20120601090337.GC32340@sigill.intra.peff.net>
 <7vzk8n3x5e.fsf@alter.siamese.dyndns.org>
 <20120602163248.GD15017@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 20:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SatPM-0004Cw-Kp
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 20:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038Ab2FBStw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 14:49:52 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41272
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965013Ab2FBStv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 14:49:51 -0400
Received: (qmail 16313 invoked by uid 107); 2 Jun 2012 18:49:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jun 2012 14:49:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2012 14:49:48 -0400
Content-Disposition: inline
In-Reply-To: <20120602163248.GD15017@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199055>

On Sat, Jun 02, 2012 at 12:32:48PM -0400, Jeff King wrote:

> I'll cook up a new version of the patch.

The refactoring ended up expanding this into a few patches:

  [1/4]: move git_version_string into version.c
  [2/4]: version: add git_user_agent function
  [3/4]: http: get default user-agent from git_user_agent
  [4/4]: include agent identifier in capability string

-Peff
