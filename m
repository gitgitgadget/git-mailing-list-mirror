From: Jeff King <peff@peff.net>
Subject: Re: Explicitly adding ignored files in subdirectories not working
Date: Tue, 23 Feb 2010 23:59:58 -0500
Message-ID: <20100224045958.GA2385@coredump.intra.peff.net>
References: <fabb9a1e1002231307o2c3499e6k3f1026f71a544b16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 06:00:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk9M0-0002j2-HS
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 06:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab0BXFAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 00:00:00 -0500
Received: from peff.net ([208.65.91.99]:52415 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755324Ab0BXE77 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 23:59:59 -0500
Received: (qmail 28417 invoked by uid 107); 24 Feb 2010 05:00:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 24 Feb 2010 00:00:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2010 23:59:58 -0500
Content-Disposition: inline
In-Reply-To: <fabb9a1e1002231307o2c3499e6k3f1026f71a544b16@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140897>

On Tue, Feb 23, 2010 at 10:07:52PM +0100, Sverre Rabbelier wrote:

> I've been bitten by this before, is this behavior intentional? We
> don't even warn that the user's action was ignored; at the very least
> we should do that. The current behavior is just frustrating.

It is intentional to consider them ignored (but was broken prior to
v1.7.0), but it is a bug not to complain to the user. See:

  http://thread.gmane.org/gmane.comp.version-control.git/140405

-Peff
