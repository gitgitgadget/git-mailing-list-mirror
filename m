From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 18:43:36 -0700
Message-ID: <20081101014336.GI14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <7viqr873x7.fsf@gitster.siamese.dyndns.org> <20081031234115.GD14786@spearce.org> <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm> <20081101010011.GG14786@spearce.org> <alpine.DEB.1.10.0810311802360.5851@asgard.lang.hm> <20081101010824.GE29036@artemis.corp> <alpine.LFD.2.00.0810312121000.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, david@lang.hm,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 02:47:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw5aU-0000d1-8m
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbYKABnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYKABnh
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:43:37 -0400
Received: from george.spearce.org ([209.20.77.23]:58166 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYKABnh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:43:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B01AB3835F; Sat,  1 Nov 2008 01:43:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810312121000.13034@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99704>

Nicolas Pitre <nico@cam.org> wrote:
> On Sat, 1 Nov 2008, Pierre Habouzit wrote:
> 
> > See junio's example. It's rather easy to add hooks into the library to
> > implement a feature outside of it. It's even possible to do it while
> > preserving the ABI fully IMHO (by being a strict superset of it).
> > 
> > The patch would be so trivial, that I see no reason why they wouldn't
> > provide it. Though the real implementation of the feature that would be
> > delegated through it would be in their closed source stuff.
> 
> But at that point it's a matter of public perception.  It would clearly 
> be against the spirit of the license even though the license itself 
> couldn't prevent such tortuous practices.  Those people doing such 
> things would clearly be identified as bad guys and get bad press, and 
> libgit contributors could even attempt law suits based on the derived 
> work angle.  That might be just enough to prevent such things to happen.

Yes.
 
> OTOH they would certainly come out clean if the license was BSD since 
> the spirit of that license explicitly allows closing up the whole 
> library and adding extra features.

My take on the consensus for the license part of the discussion is
that libgit2 should be under the "GPL gcc library" license.

BTW, I can't actually find a copy of that license; the only thing
I can locate in the GCC SVN tree is a copy of the LGPL.

-- 
Shawn.
