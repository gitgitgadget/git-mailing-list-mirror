From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-stash: add new 'drop' subcommand
Date: Fri, 4 Jan 2008 22:51:18 -0500
Message-ID: <20080105035118.GB26892@coredump.intra.peff.net>
References: <1199495198-26270-1-git-send-email-casey@nrlssc.navy.mil> <477EDDD4.5060509@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jan 05 04:52:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB04k-0004b5-As
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 04:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbYAEDvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 22:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYAEDvW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 22:51:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2878 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbYAEDvV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 22:51:21 -0500
Received: (qmail 22062 invoked by uid 111); 5 Jan 2008 03:51:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 22:51:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 22:51:18 -0500
Content-Disposition: inline
In-Reply-To: <477EDDD4.5060509@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69638>

On Fri, Jan 04, 2008 at 07:31:00PM -0600, Brandon Casey wrote:

> Thus far I haven't been a big user of git stash, but I plan to
> use it more and I expect to use 'drop' more often than
> 'clear'. I expect in the common case there will be a single

There was some discussion of a sensible name, but I don't recall seeing
a resolution on this: why not "clear stash@{0}" to clear one, and
"clear" to clear all? Otherwise, I foresee "git stash clear stash@{0}"
followed by "oops, I just deleted all of my stashes."

I guess you get "git stash drop" as a synonym for "git stash drop
stash@{0}" this way, but it just seems mean to users to make them
remember which of "drop" and "clear" does what they want.

-Peff
