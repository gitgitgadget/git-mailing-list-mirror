From: Petr Baudis <pasky@suse.cz>
Subject: git-svn on MSysGit and why is it (going to be?) unsupported
Date: Wed, 6 Aug 2008 15:51:00 +0200
Message-ID: <20080806135100.GB10151@machine.or.cz>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness> <200807231852.10206.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231356540.8986@racer> <20080806111545.GD32184@machine.or.cz> <alpine.DEB.1.00.0808061436310.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 06 16:03:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQjby-0003Eh-MP
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 16:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbYHFOCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 10:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbYHFOCb
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 10:02:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56827 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbYHFOCa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 10:02:30 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B2919393B603; Wed,  6 Aug 2008 15:51:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808061436310.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

On Wed, Aug 06, 2008 at 02:43:51PM +0200, Johannes Schindelin wrote:
> On Wed, 6 Aug 2008, Petr Baudis wrote:
> 
> > On Wed, Jul 23, 2008 at 01:57:54PM +0100, Johannes Schindelin wrote:
> > > Note that you will have to do your digging using msysGit (i.e. the 
> > > developer's pack, not the installer for plain Git), since git-svn will 
> > > be removed from the next official "Windows Git" release, due to lack 
> > > of fixers.
> > 
> >   is there any other problem with git-svn on Windows than the CRLF
> > issue? I couldn't find anything significant in the issue tracker.
> 
> http://code.google.com/p/msysgit/issues/detail?id=120&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary

Yes, that's why added the word "significant". ;-) This seems to be
simple module-out-of-sync issue.

> It is also frustrating that 
> 
> http://code.google.com/p/msysgit/issues/detail?id=83&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary
> http://code.google.com/p/msysgit/issues/detail?id=103&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary
> http://code.google.com/p/msysgit/issues/detail?id=129&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary
> 
> are probably the same issue.  I cannot only blame the users for not really 
> looking if their issue has been reported yet; there are 32 open issues in 
> msysGit right now, number increasing, so it gets quite confusing.
> 
> I once switched off the issue tracker, because I was the only one who took 
> at least a little bit of care of it.  Due to list consensus, it was turned 
> back on -- against my will.
> 
> Guess who takes care of it right now?
> 
> Exactly.  So I will soon be switching it off again, I think, because there 
> are few more useless things than an unmonitored issue tracker.

Well, when looking through the tracker earlier today, I actually wanted
to mark few dupes, but I did not find out how on the earth I'm supposed
to do that. Either the operation is well-hidden in the web interface or
I have to have some special rights to do that - in which case, it's no
wonder the tracker is deteriorating.

> >   If not, why do you want to drop git-svn from Windows Git? It seems 
> > that the CRLF issue has trivial workaround to set autocrlf=false; this 
> > will make git-svn-tracked repositories useful only on Windows, but I'd 
> > bet this is fine for large majority of Windows git-svn users?
> 
> If it was so trivial, why does nobody use it?

Because it is not documented? Or is it? *Searches crlf in git-svn.html
bundled with his msysgit* *Looks at Git FAQ* *Looks for release notes in
the start menu ... unsuccessfully* *Tries to Google out MSysGit release
notes ... unsuccessfully* *Founds MSysGit release notes sitting in
Program Files* "git svn is slow or seems to be broken (see discussions
on the mailing list)" What is "the" mailing list in MSysGit context?

*Googles out MSysGit Google Group* *Searches git-svn and pages... and
pages.*

	http://groups.google.com/group/msysgit/browse_thread/thread/8240da55a76f8c92/30656b448e9f5e74?lnk=gst&q=git-svn#30656b448e9f5e74

Okay. That was really easy to find, wasn't it... Somewhere deep inside,
even few mentions of autocrlf can be found.

> Oh, and git-svn is slow, too.
> 
> And _noone_ of those competent Windows git-svn users seemed fit or willing 
> to do anything about git-svn, not even the simplest of issues.

I can of course understand that argument, even though it's a bit sad to
see when the issues are apparently either trivial or there is simple
workaround available. My trouble was that the _concrete_ reasons for
this are buried deep inside long mail threads (or threads on other
mailing lists).

> If you want to do something about it, go ahead.  But I have no inclination 
> of hearing from any Windows user about git-svn again, ever.

Not currently, I'm just afraid I *might* have to sometime in the future.
;-)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
