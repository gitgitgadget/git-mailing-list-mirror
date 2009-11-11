From: Petr Baudis <pasky@suse.cz>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Wed, 11 Nov 2009 22:42:16 +0100
Message-ID: <20091111214216.GO12890@machine.or.cz>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <20091111184215.GG27518@vidovic>
 <alpine.LFD.2.00.0911111408380.16711@xanadu.home>
 <20091111210727.GN12890@machine.or.cz>
 <alpine.LFD.2.00.0911111617440.16711@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 22:42:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Kxg-0005W1-Jn
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 22:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759370AbZKKVmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 16:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759368AbZKKVmO
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 16:42:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49958 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759321AbZKKVmM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 16:42:12 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 67F3586201F; Wed, 11 Nov 2009 22:42:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911111617440.16711@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132707>

On Wed, Nov 11, 2009 at 04:19:44PM -0500, Nicolas Pitre wrote:
> On Wed, 11 Nov 2009, Petr Baudis wrote:
> 
> > On Wed, Nov 11, 2009 at 02:50:22PM -0500, Nicolas Pitre wrote:
> > > According to strace, data from sideband channel #2 (prefixed with 
> > > "remote: ") pertaining to object compression is printed way after pack 
> > > data has already started to arrive locally.  This is really weird.
> > > 
> > > And this occurs only when fetching from repo.or.cz and not from 
> > > git.kernel.org for example.  So there is something to investigate on the 
> > > server side.  Pasky: anything you changed in your git installation 
> > > lately?
> > 
> > Yes, but nothing should have changed in git-daemon, that's the only part
> > of the infrastructure that uses system-wide git (which it perhaps
> > shouldn't). I cannot reproduce this problem, though. I have changed
> > git-daemon to use my local git version (about one week old master), does
> > this still happen for you?
> 
> No, it doesn't happen anymore.
> 
> What was the git-daemon version before?

1.5.6.5, the default version in debian lenny

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
