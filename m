From: Olivier Galibert <galibert@pobox.com>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Mon, 4 Jun 2007 23:21:21 +0200
Message-ID: <20070604212121.GA31852@dspnet.fr.eu.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com> <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org> <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com> <alpine.LFD.0.98.0706040857380.23741@woody.linux-foundation.org> <20070604175751.GL19935@cip.informatik.uni-erlangen.de> <alpine.LFD.0.98.0706041336440.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <thomas@glanzmann.de>,
	Bryan Childs <godeater@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 23:27:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvK5d-0005jV-NI
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 23:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbXFDV1f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 17:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757280AbXFDV1f
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 17:27:35 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:3537 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761972AbXFDV1d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 17:27:33 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2007 17:27:33 EDT
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id D3CC0A385C; Mon,  4 Jun 2007 23:21:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706041336440.23741@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49130>

On Mon, Jun 04, 2007 at 01:45:26PM -0700, Linus Torvalds wrote:
> I'd like to point out some more upsides and downsides of "git rebase".
> 
> Downsides:
> 
>  - you're rewriting history, so you MUST NOT have made your pre-rebase 
>    changes available publicly anywhere else (or you are in a world of pain 
>    with duplicate history and tons of confusion)

Wouldn't it be possible to register the rebase somewhere (weak parent?
some kind of note not influencing the sha1 ?) that pull/merge could
follow?  Rebases and cherry-picking are a special kind of merge, so
maybe it can be handled like one where it counts...

  OG.
