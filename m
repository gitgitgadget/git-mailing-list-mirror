From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/16] config: add --literal-match option
Date: Thu, 13 Mar 2008 08:42:50 -0400
Message-ID: <20080313124250.GD19485@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312214019.GL26286@coredump.intra.peff.net> <7vejaf4lmc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 13:43:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZmmS-0004Jt-6h
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 13:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbYCMMmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 08:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYCMMmx
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 08:42:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3543 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbYCMMmw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 08:42:52 -0400
Received: (qmail 28905 invoked by uid 111); 13 Mar 2008 12:42:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 08:42:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 08:42:50 -0400
Content-Disposition: inline
In-Reply-To: <7vejaf4lmc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77069>

On Wed, Mar 12, 2008 at 03:34:51PM -0700, Junio C Hamano wrote:

> > The patch is about twice as long as it needs to be since getting and
> > setting in builtin-config follow two almost-the-same parallel codepaths.
> > I suspect this could be cleaned up, but I didn't look too closely.
> 
> I think that is a good new feature to propose.
> 
> Historically, the config_set_multivar() function has been one of the most
> buggy part of the then-current codebase.  It might be a good idea to
> clean-up first and then enhance.
> 
> But in either case I am quite reluctant to touch this part of the code
> right now before 1.5.5, especially without extra sets of eyeballs.

That sounds sensible. I will throw this on the backburner until
post-1.5.5, then, and try to respin it with some config cleanups.

-Peff
