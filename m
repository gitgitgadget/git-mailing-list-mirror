From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Automatically remote prune
Date: Wed, 4 Nov 2009 18:00:19 -0800
Message-ID: <20091105020019.GL10505@spearce.org>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com> <7v639qi2un.fsf@alter.siamese.dyndns.org> <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 03:00:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5reE-0007Ee-St
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 03:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbZKECAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 21:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159AbZKECAP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 21:00:15 -0500
Received: from george.spearce.org ([209.20.77.23]:38048 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbZKECAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 21:00:14 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B89DC381FE; Thu,  5 Nov 2009 02:00:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132190>

John Tapsell <johnflux@gmail.com> wrote:
> 2009/11/5 Junio C Hamano <gitster@pobox.com>:
> > John Tapsell <johnflux@gmail.com> writes:
> 
> > You could store necessary information somewhere else when you contacted
> > the remote the last time, but we need to consider what the benefits are to
> > give this information in the first place.
> 
> We already get all this information on a "git fetch", no?  And then
> promptly discard it.  Surely when we do "git fetch" .  So I'm talking
> about just not ignoring the information we get from git fetch, but
> present that information to the user.

Good point.  We currently don't have a provision to store this
information, but we could store a list of dead remote tracking
branches for reference later during `git branch -r`.

Its not a lot of data, it just has little perceived value to most
Git hackers because a remote branch disappears very infrequently
(if ever) for most of us.

-- 
Shawn.
