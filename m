From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: What's cooking in git.git (Jan 2009, #03; Wed, 14)
Date: Fri, 16 Jan 2009 11:08:08 +0300
Organization: St.Petersburg State University
Message-ID: <20090116080807.GA10792@landau.phys.spbu.ru>
References: <7vmydu3yy7.fsf@gitster.siamese.dyndns.org> <20090115194926.GA6899@roro3.zxlink> <7vd4eos3rp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 09:09:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNjln-0004eU-EJ
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 09:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbZAPIIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 03:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754603AbZAPIIM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 03:08:12 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1964 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbZAPIIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 03:08:11 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 3AE4A17B661; Fri, 16 Jan 2009 11:08:08 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7vd4eos3rp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105926>

On Thu, Jan 15, 2009 at 12:39:06PM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
> 
> > Sorry for the inconvenience, and please pull them all from
> >
> >     git://repo.or.cz/git/kirr.git   for-junio
> >
> > Kirill Smelkov (4):
> >       mailinfo: 'From:' header should be unfold as well
> >       mailinfo: more smarter removal of rfc822 comments from 'From'
> >       mailinfo: correctly handle multiline 'Subject:' header
> >       mailinfo: add explicit test for mails like '<a.u.thor@example.com> (A U Thor)'
> 
> Sorry, but I cannot _pull_ this one; not because these four patches are
> bad (I haven't looked at them).
> 
> They include all the other totally unrelated stuff that happend on the
> master branch since the topic ks/maint-mailinfo-folded forked.  I've been
> hoping upon completion of this topic we can merge it down to maint to
> propagate the fix back to v1.6.1.X series.
> 
> With this alias:
> 
> $ git config alias.lg log --pretty=oneline --abbrev-commit --boundary --left-right
> 
> Here are what I have queued so far (and they are in next):
> 
> $ git lg master..ks/maint-mailinfo-folded
> >ddfb369... mailinfo: 'From:' header should be unfold as well
> >353aaf2... mailinfo: correctly handle multiline 'Subject:' header
> -141201d... Merge branch 'maint-1.5.6' into maint-1.6.0
> 
> $ git lg maint..ks/maint-mailinfo-folded
> >ddfb369... mailinfo: 'From:' header should be unfold as well
> >353aaf2... mailinfo: correctly handle multiline 'Subject:' header
> -141201d... Merge branch 'maint-1.5.6' into maint-1.6.0
> 
> 141201d is only three commits ahead of v1.6.0.6 and
> 
> $ git lg v1.6.0.6..141201d
> 
> will show that we _could_ even issue v1.6.0.7 with the fixes in this topic
> if we cared about this bug deeply enough.  If I pull the above to the
> topic, we'll lose the ability to propagate these fixes to the maintenance
> serires.
> 
> So please either say "Yes, you are welcome to cherry-pick -- fetching and
> cherry-picking would be easier than e-mail for this kind of patch", or
> "Ok, I'll rebase my series on top of ddfb369".
> 
> Well, I just noticed that some of your commits already conflict with the
> two patches that I already have, so I guess we would need at least one
> rebase anyway, so this time around, I'd really prefer you not to say "you
> are welcome to cherry-pick" ;-)

Sure, I've rebased my series on top of ddfb369 :)

    git://repo.or.cz/git/kirr.git   for-junio-maint


Kirill Smelkov (3):
      mailinfo: more smarter removal of rfc822 comments from 'From'
      mailinfo: add explicit test for mails like '<a.u.thor@example.com> (A U Thor)'
      mailinfo: tests for RFC2047 examples


Thanks,
Kirill
