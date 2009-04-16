From: Jeff King <peff@peff.net>
Subject: Re: how to check what your pulling down?
Date: Thu, 16 Apr 2009 07:07:07 -0400
Message-ID: <20090416110707.GA31915@coredump.intra.peff.net>
References: <23075475.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: cantona <adam@dwpub.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 13:08:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuPSX-0000nh-Qd
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 13:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbZDPLHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 07:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbZDPLHP
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 07:07:15 -0400
Received: from peff.net ([208.65.91.99]:40050 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbZDPLHO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 07:07:14 -0400
Received: (qmail 2257 invoked by uid 107); 16 Apr 2009 11:07:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Apr 2009 07:07:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2009 07:07:07 -0400
Content-Disposition: inline
In-Reply-To: <23075475.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116693>

On Thu, Apr 16, 2009 at 04:00:08AM -0700, cantona wrote:

> My question: before I pull down I always get that bad feeling... "what am i
> gunna get? will there be a conflict?". Is there a git command to check what
> will come down with the next pull? If not, a command that will tell you
> which local files differ from the git repository files?

Pull is just fetch+merge, so you can do:

  $ git fetch $remote
  $ git log ..$remote/$branch

to see how they differ from you. And then "git merge $remote/$branch" if
you like it.

-Peff
