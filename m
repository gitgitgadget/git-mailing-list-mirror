From: Jeff King <peff@peff.net>
Subject: Re: Migrating from StarTeam to GIT
Date: Thu, 19 Feb 2009 22:08:56 -0500
Message-ID: <20090220030856.GD22419@coredump.intra.peff.net>
References: <89b129c60902190919p2cdbe349o4a2a659617dae341@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sean Kelley <sean.v.kelley@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 04:10:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaLmV-0002bj-4O
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 04:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbZBTDI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 22:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZBTDI6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 22:08:58 -0500
Received: from peff.net ([208.65.91.99]:37580 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbZBTDI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 22:08:58 -0500
Received: (qmail 31175 invoked by uid 107); 20 Feb 2009 03:09:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Feb 2009 22:09:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2009 22:08:56 -0500
Content-Disposition: inline
In-Reply-To: <89b129c60902190919p2cdbe349o4a2a659617dae341@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110785>

On Thu, Feb 19, 2009 at 11:19:28AM -0600, Sean Kelley wrote:

> Are there ways to migrate views in StarTeam to a DVCS like GIT? Anyone
> have experience with this?

Wow, I've never even heard of StarTeam. AFAIK, there is no converter
already (as in, I have never heard of one, and searching the list
archive turns up nothing).

Getting history data into git is usually easy. If you can generate a
series of snapshots, at worst you can script around commiting each one.
Or you can write to the "git fast-import" input language, which is,
well...fast.

The tricky part will be getting your data out of StarTeam, which is
apparently not very easy:

  http://svn.haxx.se/users/archive-2005-07/0720.shtml

-Peff
