From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Don't use GIT_CONFIG in t5505-remote
Date: Tue, 26 Feb 2008 17:19:59 -0500
Message-ID: <20080226221959.GB6098@sigill.intra.peff.net>
References: <alpine.LNX.1.00.0802261713520.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 23:20:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU8AD-0007mk-80
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 23:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYBZWUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 17:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbYBZWUE
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 17:20:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1752 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbYBZWUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 17:20:03 -0500
Received: (qmail 10457 invoked by uid 111); 26 Feb 2008 22:20:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 26 Feb 2008 17:20:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2008 17:19:59 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0802261713520.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75183>

On Tue, Feb 26, 2008 at 05:15:31PM -0500, Daniel Barkalow wrote:

> For some reason, t5505-remote was setting GIT_CONFIG to .git/config
> and exporting it. The sole effect of this was to cause the tests to
> fail if "git clone" obeyed it (which it presumably should).
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> Maybe test-lib used to set GIT_CONFIG to something that would interfere? 
> Or the default behavior was wrong?

test-lib used to set it to ".git/config" until recently, so this would
have been a no-op. As to why it was ever in here, I have no idea.

-Peff
