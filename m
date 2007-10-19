From: Theodore Tso <tytso@thunk.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 17:58:11 -0400
Message-ID: <20071019215811.GE751@thunk.org>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com> <20071019113822.GB16726@thunk.org> <20071019143844.GB23765@diana.vm.bytemark.co.uk> <alpine.LFD.0.9999.0710191058570.19446@xanadu.home> <20071019211755.GC751@thunk.org> <alpine.LFD.0.9999.0710191739270.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 23:58:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iizra-0003JA-RM
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 23:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967610AbXJSV61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 17:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966798AbXJSV60
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 17:58:26 -0400
Received: from THUNK.ORG ([69.25.196.29]:42771 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967604AbXJSV60 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 17:58:26 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Ij016-000377-65; Fri, 19 Oct 2007 18:08:28 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Iizr9-0003Di-EA; Fri, 19 Oct 2007 17:58:11 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710191739270.19446@xanadu.home>
1;1609;0cFrom: Theodore Tso <tytso@mit.edu>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61770>

On Fri, Oct 19, 2007 at 05:40:48PM -0400, Nicolas Pitre wrote:
> No.  "next" is the name of the _remote_ branch that is stored locally in 
> spearce/next.  So the arrow is correct.

Ah; yes, you're right.  I can see this being very confusing to the
newbie, though.  Enough so that in beginner mode we might want it to
say:

   895be02..2fe5433   (remote) next -> (local) spearce/next

... especially since the git pull might follow up the pull with a
merge from the local remotes/spearce/next to the local next branch.
So it would be a good idea that it is clear when we are referring to a
local or a remote branch.

   		      	       	       	       - Ted
