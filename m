From: Jeff King <peff@peff.net>
Subject: Re: File Systems and a Theory of Edits
Date: Sun, 31 Jul 2011 19:22:38 -0600
Message-ID: <20110801012237.GA32509@sigill.intra.peff.net>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
 <23101-1312054868-691056@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 03:22:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnhDS-0005Po-Ev
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 03:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094Ab1HABWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 21:22:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36877
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897Ab1HABWl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 21:22:41 -0400
Received: (qmail 13274 invoked by uid 107); 1 Aug 2011 01:23:13 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 31 Jul 2011 21:23:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jul 2011 19:22:38 -0600
Content-Disposition: inline
In-Reply-To: <23101-1312054868-691056@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178293>

On Sat, Jul 30, 2011 at 02:40:57PM -0500, John M. Dlugosz wrote:

> On 7/30/2011 9:29 AM, Michael Nahas wrote:
> >For these commands to work, the git command will have to include an
> >argument that specifies which commit it operates on.  So some basic
> >ones might be:
> >     "git ls<commit>  -- <path>"
> >     "git cat<commit>  -- <path>"
> >(There exists "git ls-files", "git ls-tree", and "git cat-file" but
> 
> If you could "mount" a repository, then you would not need these
> commands at all.  It would be in fact a read-only file system.  Once
> mounted, the individual commits could be directories, and under that
> you explore in the usual way.

There are several (mostly fuse-based) tools listed on the wiki:

  https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Filesystem_interfaces

I've never used any of them, though. No idea how mature or usable they
are.

Googling around also came up with this newer attempt:

  https://github.com/mfontani/git-fuse-perl

Again, no idea on the quality.

-Peff
