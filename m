From: Jeff King <peff@peff.net>
Subject: Re: FFmpeg considering GIT
Date: Tue, 8 May 2007 03:26:52 -0400
Message-ID: <20070508072651.GA1554@coredump.intra.peff.net>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org> <20070505133543.GC3379@diana.vm.bytemark.co.uk> <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org> <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org> <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org> <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue May 08 09:27:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlK68-0000i8-4s
	for gcvg-git@gmane.org; Tue, 08 May 2007 09:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934320AbXEHH0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 03:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934402AbXEHH0z
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 03:26:55 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2658 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934320AbXEHH0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 03:26:54 -0400
Received: (qmail 20689 invoked from network); 8 May 2007 07:26:47 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 8 May 2007 07:26:47 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2007 03:26:52 -0400
Content-Disposition: inline
In-Reply-To: <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46549>

On Mon, May 07, 2007 at 10:13:44PM +1000, Paul Mackerras wrote:

> I have thought about rewriting it in a different language, but I
> haven't found anything that really appeals.  I don't want to go to
> C/GTK or C/Qt since that would make it hard to port to Windows and
> MacOS AFAIK.  Python/Tk would be a possibility, but I have never
> learnt python and I'm actually not all that comfortable with having to
> do things the object-oriented way.
> 
> Any suggestions?

I just ran across this today (it was just packaged for Debian):

  http://developer.imendio.com/projects/giggle

It seems to be a C/GTK repository browser (but also with a few git-gui
type features). It doesn't seem very far along (the viewer barfs on the
git.git repo, but shows some of my simpler repos), but it might worth
starting a dialogue with those guys.

-Peff
