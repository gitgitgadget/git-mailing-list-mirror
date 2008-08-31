From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 22:34:27 +0200
Message-ID: <20080831203427.GF10360@machine.or.cz>
References: <20080830173947.GF7185@schiele.dyndns.org> <7v63ph40at.fsf@gitster.siamese.dyndns.org> <32541b130808311129u79f4179enfabab8f5845ed522@mail.gmail.com> <200808312223.38222.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jeff King <peff@peff.net>, Robert Schiele <rschiele@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 22:36:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZtej-0000dC-Mn
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 22:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728AbYHaUeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 16:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYHaUeb
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 16:34:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53058 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbYHaUeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 16:34:31 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B4E3F3939B3A; Sun, 31 Aug 2008 22:34:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200808312223.38222.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94507>

On Sun, Aug 31, 2008 at 10:23:36PM +0200, Jakub Narebski wrote:
> On Sub, 31 August 2008, Avery Pennarun wrote:
> > I have a proper implementation in the 'runlock' script in gitbuilder:
> > 
> >     http://github.com/apenwarr/gitbuilder/tree/master/runlock
> > 
> > In that particular case, I wanted to handle signals carefully, so I
> > needed the manual fork thing even in perl 5.8.  You can safely remove
> > the signal handling stuff (and of course the lockfile stuff) if you
> > just want a minimal safe fork-exec-wait implementation in perl.
> 
> But if we go this way, i.e. fork+exec (perhaps implicit fork), why do
> not simply use appropriate commands from Git.pm (Git::Repo doesn't
> have it yet, IIRC).  As far as I remember Git.pm was created initially
> to unify all different "safe_pipe" and "safe_cmd" implementations among
> different Perl scripts in Git (Petr "Pasky" Baudis CC-ed).

Can anyone give a concrete justification for Perl 5.6 support? Who is
needing it and why do they have to use Perl 5.6? Does it offset the time
spent discussing and reviewing this and the maintenance burden of extra
complicated code?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
