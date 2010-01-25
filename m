From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's cooking in git.git (Jan 2010, #08; Sun, 24)
Date: Tue, 26 Jan 2010 00:12:41 +0100
Message-ID: <20100125231241.GA4159@machine.or.cz>
References: <7vfx5u6bn9.fsf@alter.siamese.dyndns.org>
 <m3eildbydx.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 00:13:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZY7K-00036O-E3
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 00:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713Ab0AYXMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 18:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088Ab0AYXMp
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 18:12:45 -0500
Received: from w241.dkm.cz ([62.24.88.241]:46205 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab0AYXMp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 18:12:45 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0BAE186208B; Tue, 26 Jan 2010 00:12:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3eildbydx.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138005>

On Mon, Jan 25, 2010 at 02:43:01PM -0800, Jakub Narebski wrote:
> You are right that actual caching support is in flux.  The discussion
> continues: it is very good that we have the voice from Pasky, too.

Unfortunately, I can't give much time to it, or actual contributions.
I think it would be great to apply at least the miscellanous-changes
part to (i) move this further (ii) give jh some positive feedback. :)
There are ugly minor things, but they can be patched up later. I think
it's healthier for new gitweb stuff to develop more in-tree, even
if that means few angry users annoyed about less-than-perfect UI stuff,
rather than polish the diamond in infinite discussions; worse is better!
The only thing we should be worried about is avoiding introducing new
bad URL interfaces since we should keep backwards compatibility there.

But Jakub's opinion is definitely much more important, he gives gitweb
much more time than me.

For the main caching patch, it seems like good idea to take Jakub's
split-up series instead, let's see what is J.H.'s opinion on the series?

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
