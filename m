From: Jeff King <peff@peff.net>
Subject: Re: Retrospectively add alternates to a repository?
Date: Sat, 27 Feb 2010 07:30:57 -0500
Message-ID: <20100227123056.GA22382@coredump.intra.peff.net>
References: <loom.20100227T004822-959@post.gmane.org>
 <be6fef0d1002261837g794e8df2yc92261d46f3235bd@mail.gmail.com>
 <20100227083418.GC27191@coredump.intra.peff.net>
 <loom.20100227T123539-643@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steve Folly <steve@spfweb.co.uk>
X-From: git-owner@vger.kernel.org Sat Feb 27 13:31:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlLp9-0002EL-2O
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 13:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968123Ab0B0MbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 07:31:05 -0500
Received: from peff.net ([208.65.91.99]:59413 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967007Ab0B0MbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 07:31:03 -0500
Received: (qmail 14086 invoked by uid 107); 27 Feb 2010 12:31:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 27 Feb 2010 07:31:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Feb 2010 07:30:57 -0500
Content-Disposition: inline
In-Reply-To: <loom.20100227T123539-643@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141199>

On Sat, Feb 27, 2010 at 11:43:55AM +0000, Steve Folly wrote:

> I now have a plan to write a script to attach and
> detach repositories to and from local mirrors on demand:

I think they should work, but:

> attach = 
>     echo "/path/to/mirror" > .git/objects/info/alternates && 
>     git repack -adl && 
>     git repack -ad && 
>     git repack -adl

I don't think the first repack is doing anything (I showed it in my
example only to show that it was not actually working).

-Peff
