From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Wed, 17 Dec 2008 11:56:45 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812171152490.30035@xanadu.home>
References: <4946F4D9.8050803@gmx.ch> <87zlixvtu9.fsf@jidanni.org>
 <49470D65.40808@gmx.ch> <alpine.LFD.2.00.0812160039180.30035@xanadu.home>
 <20081217154407.GZ32487@spearce.org>
 <alpine.LFD.2.00.0812171104340.30035@xanadu.home>
 <20081217162127.GG32487@spearce.org>
 <alpine.LFD.2.00.0812171136250.30035@xanadu.home>
 <20081217164841.GH32487@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jean-Luc Herren <jlh@gmx.ch>, jidanni@jidanni.org,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 17:58:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCzj8-0001vT-5o
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 17:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbYLQQ4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 11:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbYLQQ4w
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 11:56:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19044 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbYLQQ4v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 11:56:51 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KC1003EL5QL3R70@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Dec 2008 11:56:45 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081217164841.GH32487@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103362>

On Wed, 17 Dec 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > > Its also not easy to
> > > implement, which is why we've only been talking about it for years
> > > and never actually seen a patch proposing to do it.
> > 
> > A partial clone could possibly be turned into a shalow clone if at least 
> > the top commit is complete ...
> 
> But you of all people should know well that the top commit is also
> a huge part of most clones.  Getting that top commit can be 30-60%
> of the repository itself.  :-|

Sure I know.  This is why I'm not pushing this solution really much.  ;)

I have ideas about how to solve this in a really nice way, but that 
implies pack V4.


Nicolas
