From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/2] index-pack: Avoid disk corruption yielding a
	valid pack footer checksum
Date: Wed, 27 Aug 2008 17:14:01 -0700
Message-ID: <20080828001401.GT26523@spearce.org>
References: <1219873724-13348-1-git-send-email-spearce@spearce.org> <alpine.LFD.1.10.0808272007541.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 02:15:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYVAN-0002Hw-Eq
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 02:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbYH1AOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 20:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037AbYH1AOE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 20:14:04 -0400
Received: from george.spearce.org ([209.20.77.23]:51939 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbYH1AOC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 20:14:02 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 40D4F38375; Thu, 28 Aug 2008 00:14:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808272007541.1624@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93998>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 27 Aug 2008, Shawn O. Pearce wrote:
> > 
> >   This was inspired by the data corruption thread started
> >   by J. Bruce Fields.  At some point in the thread Linus
> >   pointed out the C Git index-pack isn't as safe as it can
> >   be, and offered a strategy to fix it.
> 
> I thought it was Nicolas Pitre who offered that strategy?
> Maybe I was mistaken.  ;-)

Sorry about the bad attribution.  Going back through the
archives does say it was you that had the brilliant idea.

Heh.  Well at least my fuzzy memory of recent history is
only on the mailing list archives and not in a commit.

;-)

-- 
Shawn.
