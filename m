From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: diff settings
Date: Sat, 31 Jan 2009 15:10:16 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901311507350.10805@kiwi.cs.ucla.edu>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu> <87ocxwv6qg.fsf@iki.fi> <alpine.GSO.2.00.0901241159050.23073@kiwi.cs.ucla.edu> <497CD352.2060402@tedpavlic.com> <alpine.GSO.2.00.0901251307030.12651@kiwi.cs.ucla.edu> <497D1AB7.7000208@tedpavlic.com>
 <alpine.GSO.2.00.0901310750470.5437@kiwi.cs.ucla.edu> <4984AACD.20600@tedpavlic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 00:11:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTP0F-0005X3-3e
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 00:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbZAaXK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 18:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbZAaXK3
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 18:10:29 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:60610 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbZAaXK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 18:10:29 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0VNAI2W014824;
	Sat, 31 Jan 2009 15:10:18 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0VNAHH7014817;
	Sat, 31 Jan 2009 15:10:18 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <4984AACD.20600@tedpavlic.com>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107953>

On Sat, 31 Jan 2009, Ted Pavlic wrote:

> As I already discussed, Mercurial has both "diff.primer" and "primer.diff" 
> precisely because "diff" settings affects so many Hg commands.

Yes I remember you did mention that.

> In particular, in my .hgrc, I have:
> [diff]
> git = 1
> which causes all Mercurial commands that need to generate a diff to use
> gitdiff rather than truediff. However, if I *wanted* to apply a set of flags
> to a particular command, I could (using the equivalent "git" commands)...
> [defaults]
> pull = --rebase
> commit = -a
> format-patch = -M
> So I see a purpose for both *.defaults and defaults.*. Of course, aliases are 
> also nice (IIRC, Mercurial doesn't have "aliases", but I could be wrong). 
> Mercurial users are very happy with having both available. I imagine git 
> people would be too.

I like it!  I'm all for it.  Perfect opportunity for future work.  In fact, I 
think I already glanced at the part of the code that's the right place to make 
that stuff happen.

                                      -- Keith
