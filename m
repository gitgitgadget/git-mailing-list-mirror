From: Jeff King <peff@peff.net>
Subject: Re: Repo corrupted somehow?
Date: Tue, 4 Nov 2008 22:29:43 -0500
Message-ID: <20081105032943.GA24886@coredump.intra.peff.net>
References: <216e54900811032309s51c8cb1fr64054ff18c450b1d@mail.gmail.com> <216e54900811032334y35ada7daw753c0ad3073c0317@mail.gmail.com> <216e54900811040712k51db6fbfu44c59d9f90f1eabd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 04:31:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxZ6h-0006tQ-Vz
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 04:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbYKED3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 22:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754439AbYKED3q
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 22:29:46 -0500
Received: from peff.net ([208.65.91.99]:4493 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388AbYKED3p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 22:29:45 -0500
Received: (qmail 11655 invoked by uid 111); 5 Nov 2008 03:29:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Nov 2008 22:29:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2008 22:29:43 -0500
Content-Disposition: inline
In-Reply-To: <216e54900811040712k51db6fbfu44c59d9f90f1eabd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100140>

On Tue, Nov 04, 2008 at 07:12:40AM -0800, Andrew Arnott wrote:

> Nah, that wasn't a false alarm after all.  It's happening again, only
> this time for dozens of files, and
> git rebase --abort
> git reset --hard
> 
> is not helping.

This is certainly unusual. Can you provide a tarball of your repo
(including .git and working tree)? I don't know that a clone will be
sufficient if there is something funny going on in your local git index.

-Peff
