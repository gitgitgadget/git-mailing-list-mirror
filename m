From: Nicolas Pitre <nico@cam.org>
Subject: Re: [JGIT PATCH 1/2] index-pack: Avoid disk corruption yielding a
 valid pack footer checksum
Date: Wed, 27 Aug 2008 20:26:07 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808272024160.1624@xanadu.home>
References: <1219873724-13348-1-git-send-email-spearce@spearce.org>
 <alpine.LFD.1.10.0808272007541.1624@xanadu.home>
 <20080828001401.GT26523@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 02:27:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYVMR-0005EJ-Oo
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 02:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbYH1A0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 20:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754120AbYH1A0f
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 20:26:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26986 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbYH1A0e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 20:26:34 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6A006YMBVJ30N0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Aug 2008 20:26:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080828001401.GT26523@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94001>

On Wed, 27 Aug 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Wed, 27 Aug 2008, Shawn O. Pearce wrote:
> > > 
> > >   This was inspired by the data corruption thread started
> > >   by J. Bruce Fields.  At some point in the thread Linus
> > >   pointed out the C Git index-pack isn't as safe as it can
> > >   be, and offered a strategy to fix it.
> > 
> > I thought it was Nicolas Pitre who offered that strategy?
> > Maybe I was mistaken.  ;-)
> 
> Sorry about the bad attribution.  Going back through the
> archives does say it was you that had the brilliant idea.

Thanks.  Now my ego is fully restored.  ;-)


Nicolas
