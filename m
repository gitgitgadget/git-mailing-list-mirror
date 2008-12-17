From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Wed, 17 Dec 2008 08:48:41 -0800
Message-ID: <20081217164841.GH32487@spearce.org>
References: <4946F4D9.8050803@gmx.ch> <87zlixvtu9.fsf@jidanni.org> <49470D65.40808@gmx.ch> <alpine.LFD.2.00.0812160039180.30035@xanadu.home> <20081217154407.GZ32487@spearce.org> <alpine.LFD.2.00.0812171104340.30035@xanadu.home> <20081217162127.GG32487@spearce.org> <alpine.LFD.2.00.0812171136250.30035@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Luc Herren <jlh@gmx.ch>, jidanni@jidanni.org,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 17:50:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCzay-0006es-AJ
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 17:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbYLQQsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 11:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbYLQQsm
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 11:48:42 -0500
Received: from george.spearce.org ([209.20.77.23]:52644 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbYLQQsl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 11:48:41 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3FCB638200; Wed, 17 Dec 2008 16:48:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812171136250.30035@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103361>

Nicolas Pitre <nico@cam.org> wrote:
> > Its also not easy to
> > implement, which is why we've only been talking about it for years
> > and never actually seen a patch proposing to do it.
> 
> A partial clone could possibly be turned into a shalow clone if at least 
> the top commit is complete ...

But you of all people should know well that the top commit is also
a huge part of most clones.  Getting that top commit can be 30-60%
of the repository itself.  :-|

-- 
Shawn.
