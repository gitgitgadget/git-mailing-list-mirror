From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/8] Add a function to set a non-default work tree
Date: Mon, 21 Apr 2008 23:47:36 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804212340590.19665@iabervon.org>
References: <alpine.LNX.1.00.0804171931550.19665@iabervon.org> <7vprslcdxf.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0804201546340.19665@iabervon.org> <7v3apeagxj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 05:48:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo9UY-0002PG-Qv
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 05:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbYDVDri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 23:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbYDVDri
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 23:47:38 -0400
Received: from iabervon.org ([66.92.72.58]:39243 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546AbYDVDrh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 23:47:37 -0400
Received: (qmail 9003 invoked by uid 1000); 22 Apr 2008 03:47:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Apr 2008 03:47:36 -0000
In-Reply-To: <7v3apeagxj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80055>

On Mon, 21 Apr 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Sat, 19 Apr 2008, Junio C Hamano wrote:
> > ...
> >> How should the setting of new work tree from sideways using this interface
> >> interact with bareness of the repository?
> >
> > I'm only using it before any initialization and when I'm going to force 
> > the repository (which doesn't even exist yet; I haven't set git_dir let 
> > alone created it, let alone looked at its configuration) to be bare, so I 
> > hadn't considered that.
> 
> That is not quite an explanation that builds confidence in a patch that
> adds a generic-sounding helper function that could be called by later
> callers.  Doesn't it have a very tempting name for people to call?

My latest version has it die() if you've gotten meaningfully far in 
initializing the repository state. I'm also not sure there's a tempting 
use case for it aside for in setup code where it clearly works, at least 
until we've got support for dealing with multiple working trees in the 
same process or something of that sort. But, in any case, it'll now fail 
fast and obviously outside of what I've planned for.

	-Daniel
*This .sig left intentionally blank*
