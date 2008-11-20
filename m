From: Roger Leigh <rleigh@codelibre.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 14:22:17 +0000
Message-ID: <20081120142217.GD6023@codelibre.net>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <20081120132107.GA27571@piper.oerlikon.madduck.net> <20081120133546.GA6023@codelibre.net> <alpine.DEB.1.00.0811201506390.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 20 15:23:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3ART-0003BG-47
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 15:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbYKTOWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 09:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYKTOWU
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 09:22:20 -0500
Received: from nagini.codelibre.net ([80.68.93.164]:47536 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbYKTOWT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 09:22:19 -0500
Received: by nagini.codelibre.net (Postfix, from userid 1000)
	id 202949467C; Thu, 20 Nov 2008 14:22:17 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811201506390.30769@pacific.mpi-cbg.de>
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 13:26:52 up 13 days,  1:44,  3 users,  load average: 0.01,
	0.11, 0.09
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101439>

On Thu, Nov 20, 2008 at 03:07:46PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 20 Nov 2008, Roger Leigh wrote:
> 
> > They are optional build depdendencies.  They are provided pre-built, and 
> > won't be rebuilt unless they get outdated.  In the release tarball, the 
> > timestamps are correct, ensuring this never happens. When checking out 
> > with git, the timestamps are incorrect, and it attempts to rebuild 
> > something that's *already built*.
> 
> I'll try just one more time.  Why don't you teach your build process to 
> check if the generated files can be generated, and if not, fall back to 
> the committed ones?

Well, it's definitely not a good idea to try rebuilding when the tools
aren't available, and I'll update the Makefiles to only attempt a
rebuild when this is the case.  So yes, making the build a bit more
intelligent is definitely something to do.  However, this is really
a separate issue, since the repo dates back eight years, and I don't
want to break older stuff.  This will only fix things for the future.


Regards,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.
