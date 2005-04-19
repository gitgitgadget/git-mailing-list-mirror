From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Tue, 19 Apr 2005 12:50:08 +0200
Message-ID: <20050419105008.GB12757@pasky.ji.cz>
References: <20050416233305.GO19099@pasky.ji.cz> <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org> <20050419011206.GT5554@pasky.ji.cz> <42646967.9030903@dwheeler.com> <4264CCFF.30400@dgreaves.com> <20050419092812.GE2393@pasky.ji.cz> <1113905110.1262.1.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greaves <david@dgreaves.com>, dwheeler@dwheeler.com,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 12:47:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNqFG-0000cm-Op
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 12:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVDSKuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 06:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVDSKuT
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 06:50:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3516 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261376AbVDSKuJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 06:50:09 -0400
Received: (qmail 14550 invoked by uid 2001); 19 Apr 2005 10:50:08 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1113905110.1262.1.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 12:05:10PM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> On Tue, 2005-04-19 at 11:28 +0200, Petr Baudis wrote:
> > Dear diary, on Tue, Apr 19, 2005 at 11:18:55AM CEST, I got a letter
> > where David Greaves <david@dgreaves.com> told me that...
> >
> > Dunno. I do it personally all the time, with git at least.
> > 
> > What do others think? :-)
> > 
> 
> I think pull is pull.  If you are doing lots of local stuff and do not
> want it overwritten, it should have been in a forked branch.

I disagree. This already forces you to have two branches (one to pull
from to get the data, mirroring the remote branch, one for your real
work) uselessly and needlessly.

I think there is just no good name for what pull is doing now, and
update seems like a great name for what pull-and-merge really is. Pull
really is pull - it _pulls_ the data, while update also updates the
given tree. No surprises.

(We should obviously have also update-without-pull but that is probably
not going to be so common so a parameter for update (like -n) should be
fine for that.)

These naming issues may appear silly but I think they matter big time
for usability, intuitiveness, and learning curve (I don't want git-pasky
become another GNU arch).

Kind regards,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
