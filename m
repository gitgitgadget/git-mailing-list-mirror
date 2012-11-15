From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/4] Introduce diff.submodule
Date: Thu, 15 Nov 2012 08:25:26 -0800
Message-ID: <20121115162524.GE6157@sigill.intra.peff.net>
References: <http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352821367-3611-1-git-send-email-artagnon@gmail.com>
 <20121115162331.GD6157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:25:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ2G9-0003Or-At
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 17:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768388Ab2KOQZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 11:25:30 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49528 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992633Ab2KOQZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 11:25:29 -0500
Received: (qmail 17647 invoked by uid 107); 15 Nov 2012 16:26:18 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 11:26:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 08:25:26 -0800
Content-Disposition: inline
In-Reply-To: <20121115162331.GD6157@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209826>

On Thu, Nov 15, 2012 at 08:23:34AM -0800, Jeff King wrote:

> On Tue, Nov 13, 2012 at 09:12:43PM +0530, Ramkumar Ramachandra wrote:
> 
> > v1 is here: http://mid.gmane.org/1349196670-2844-1-git-send-email-artagnon@gmail.com
> > v2 is here: http://mid.gmane.org/1351766630-4837-1-git-send-email-artagnon@gmail.com
> > v3 is here: http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com
> > 
> > This version was prepared in response to Peff's review of v3.
> > What changed:
> > * Functional code simplified and moved to git_diff_ui_config.
> > * Peff contributed one additional patch to the series.
> 
> Thanks, this version looks good to me.

Oh wait. I did not look closely enough. The point was to move the option
parser _out_ of git_diff_ui_config into git_diff_basic_config, so that
it only triggers for porcelain, not plumbing.

-Peff
