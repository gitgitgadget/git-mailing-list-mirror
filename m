From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 16:12:08 -0400
Message-ID: <45392D98.307@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> <200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca> <Pine.LNX.4.64.0610201016490.3962@g5.osdl.org> <45390BAF.5040405@utoronto.ca> <Pine.LNX.4.64.0610201100070.3962@g5.osdl.org> <Pine.LNX.4.64.0610201110320.3962@g5.osdl.org> <45391DC3.7060002@utoronto.ca> <Pine.LNX.4.64.0610201214530.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 22:12:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb0jJ-000564-Ra
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 22:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422831AbWJTUM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 16:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWJTUM3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 16:12:29 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:47516 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1422979AbWJTUM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 16:12:28 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Gb0jA-00054n-00; Fri, 20 Oct 2006 16:12:24 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201214530.3962@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29531>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Fri, 20 Oct 2006, Aaron Bentley wrote:
> 
>>>Btw, this is a pet peeve of mine, and it is not at all restricted to 
>>>the SCM world.
>>
>>I guess I don't mind a bit of high-mmv discussion, so long as it doesn't
>>get in the way of real work.  Polishing these kinds of things seems to
>>fall in the category of 10% of functionality that takes 90% of effort.
> 
> 
> Well, the thing is, that 10% of the functionality usually takes a whole 
> lot _less_ than 10% of the work.

I guess this depends on whether you consider the brainstorming and
discussion to be part of the work of polishing, and I do mean polishing.
 Getting from something that works 90% of the time to something that
works 99% of the time can be a questionable expenditure of time and effort.

> The same is actually true of SCM's too, I'm totally convinced. At least in 
> git, we really haven't spent _that_ much time on merges, for example. My 
> original stupid three-way merge was really simple, and I think the way I 
> introduced "stages" into the git index was really clever, but it was still 
> a small detail. And it worked surprisingly way.

I did rewrite our merge code once, but that was because the API was
quite hard to deal with and made it hard to maintain.  I agree that it's
important to focus effort on the areas that make a difference.

On the other hand, our "exotic" text merge algorithms have been praised
by the people who work on Launchpad.  So that's a win.

> As an example: I suspect that in git just the CVS importer has gotten 
> _way_ more attention than merging ever got. Importing from CVS is simply a 
> much harder problem in practice, and we've probably had more people 
> working on it (and that's _despite_ the fact that this is one of the areas 
> where git has successfully re-used other projects that had similar goals: 
> cvsps, cvs2svn etc). It's hard to "think" about, because a lot of the 
> problems with importing from CVS are literally all about the details and 
> the nasty crud. I really think "merging" is _way_ easier.

Yes, I don't even want to think about CVS when I don't have to.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFOS2Y0F+nu1YWqI0RAiOcAJ0TXmBdiCcvnTzmg+nnF+kayJ25cgCggMFx
w6xFlFHwPoNm9dt/T4LnmCU=
=zNuy
-----END PGP SIGNATURE-----
