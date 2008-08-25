From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 19:08:16 +0200
Message-ID: <20080825170816.GQ10544@machine.or.cz>
References: <20080824202325.GA14930@eagain.net> <7vfxoukv56.fsf@gitster.siamese.dyndns.org> <20080824203825.GB14930@eagain.net> <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tommi Virtanen <tv@eagain.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXfZH-0002Na-Mt
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 19:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbYHYRIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 13:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbYHYRIV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 13:08:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49199 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947AbYHYRIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 13:08:21 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id EEDE73939B47; Mon, 25 Aug 2008 19:08:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93643>

On Sun, Aug 24, 2008 at 02:20:20PM -0700, Junio C Hamano wrote:
> Tommi Virtanen <tv@eagain.net> writes:
> 
> > On Sun, Aug 24, 2008 at 01:36:37PM -0700, Junio C Hamano wrote:
> >> Of course it would.  Does using /usr/libexec/git-core/git-shell work?
> >
> > It would, but do you really want people using that?
> 
> I do not have particular preference either way.  What people wanted was to
> have smaller number of git-foo on $PATH, and especially as "git-shell" is
> not something people would be typing from their command line, so I dunno.

Can we agree that direct calls of libexec stuff should never be part of
the "official" interface (i.e. not workarounds for deprecated usage)?
Considering that calling the git-shell executable directly is the _only_
sensible way of using this interface, it should follow that it has to be
in /usr/bin, no matter if users type this command or not.

(I'm actually a little confused that you bring up the "typing from their
command line" aspect at all, since that never seemed to be relevant
criterium. People type the commit command all the time, yet we do not
install git-commit. Typing the three git-* commands we do install -
git-receive-pack, git-upload-pack and git-upload-archive - should be on
the other hand pretty rare occasion. About gitk, well, 'git k' would
just look silly, I guess. ;-)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
