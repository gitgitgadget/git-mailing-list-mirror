From: Jeff King <peff@peff.net>
Subject: Re: git status options feature suggestion
Date: Thu, 9 Oct 2008 02:11:37 -0400
Message-ID: <20081009061136.GA24288@coredump.intra.peff.net>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 08:13:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knolc-000419-3L
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 08:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893AbYJIGLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 02:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbYJIGLm
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 02:11:42 -0400
Received: from peff.net ([208.65.91.99]:4254 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412AbYJIGLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 02:11:41 -0400
Received: (qmail 25855 invoked by uid 111); 9 Oct 2008 06:11:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 09 Oct 2008 02:11:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Oct 2008 02:11:37 -0400
Content-Disposition: inline
In-Reply-To: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97828>

On Thu, Oct 09, 2008 at 01:34:41AM -0400, Caleb Cushing wrote:

> I was just doing a git status for a large add and all I really wanted
> to see was the untracked files maybe git status could have options
> like --new --untracked --modified to only show those.

How about "git ls-files -o"?

-Peff
