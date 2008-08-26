From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Tue, 26 Aug 2008 10:03:15 -0700
Message-ID: <20080826170315.GH26523@spearce.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826034544.GA32334@spearce.org> <alpine.DEB.1.10.0808252052350.29665@asgard.lang.hm> <alpine.LFD.1.10.0808261255570.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: david@lang.hm, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY1xq-00047C-Cj
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbYHZRDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754289AbYHZRDQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:03:16 -0400
Received: from george.spearce.org ([209.20.77.23]:35438 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250AbYHZRDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:03:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B763238375; Tue, 26 Aug 2008 17:03:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808261255570.1624@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93763>

Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 25 Aug 2008, david@lang.hm wrote:
> 
> > and for cloneing (and especially thing like linux-next where you essentially
> > re-clone daily) letting the pack get cached is probably a very good thing.
> 
> I hope that people recloning linux-next daily are very few.  This is an 
> incredible waste of bandwidth, regardless of the protocol used, dumb or 
> not.  A standard fetch with a remote tracking branch (with -f or with a 
> plus sign on the "fetch" line in your config file) should be all that's 
> needed to significantly reduce the amount of data needed to transfer.

Or at least clone with --reference.  You get about the same benefit if
your local reference repository is fairly current, say with a stable
upstream like Linus' own tree.

-- 
Shawn.
