From: Jeff King <peff@peff.net>
Subject: Re: Can I use git protocol to push change to remote repo?
Date: Tue, 16 Dec 2008 03:52:05 -0500
Message-ID: <20081216085205.GB3031@coredump.intra.peff.net>
References: <856bfe0e0812152318h1375401fx944834ad6410835d@mail.gmail.com> <856bfe0e0812152322i3a7fa376h8a35466b7abf82a5@mail.gmail.com> <20081216073835.GA2468@coredump.intra.peff.net> <856bfe0e0812160048l7d901658tca96f5055c69743c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 09:53:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCVgK-0001pf-3a
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 09:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbYLPIwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 03:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbYLPIwI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 03:52:08 -0500
Received: from peff.net ([208.65.91.99]:3513 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbYLPIwH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 03:52:07 -0500
Received: (qmail 11936 invoked by uid 111); 16 Dec 2008 08:52:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 16 Dec 2008 03:52:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Dec 2008 03:52:05 -0500
Content-Disposition: inline
In-Reply-To: <856bfe0e0812160048l7d901658tca96f5055c69743c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103260>

On Tue, Dec 16, 2008 at 04:48:34PM +0800, Emily Ren wrote:

> It failed with another error, is there anything I missed to config daemon ?
> $ git push git://host.xz/testgit test_push2
> updating 'refs/heads/test_push2'
>   from 0000000000000000000000000000000000000000
>   to   eebb60caae38a38361d002cdace043124a2fc871
> Generating pack...
> Done counting 3 objects.
> Deltifying 3 objects...
>  100% (3/3) done
> Writing 3 objects...
>  100% (3/3) done
> Total 3 (delta 0), reused 0 (delta 0)
> unpack unpacker exited with error code
> ng refs/heads/test_push2 n/a (unpacker error)
> error: failed to push to 'git://host.xz/testgit'

Does the user running git-daemon have permissions to write to the repo?

-Peff
