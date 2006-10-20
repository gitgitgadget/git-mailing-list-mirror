From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 15:04:35 -0400
Message-ID: <45391DC3.7060002@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> <200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca> <Pine.LNX.4.64.0610201016490.3962@g5.osdl.org> <45390BAF.5040405@utoronto.ca> <Pine.LNX.4.64.0610201100070.3962@g5.osdl.org> <Pine.LNX.4.64.0610201110320.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 21:05:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gazfg-0006Hz-T4
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 21:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992855AbWJTTEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 15:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992860AbWJTTEl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 15:04:41 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:21915 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S2992855AbWJTTEk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 15:04:40 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GazfY-000496-00; Fri, 20 Oct 2006 15:04:37 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201110320.3962@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29524>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Fri, 20 Oct 2006, Linus Torvalds wrote:
> 
>>So yes, merges are the situation where renames are normally considered a 
>>"problem", but it's actually not nearly the most every-day situation at 
>>all.
> 
> 
> Btw, this is a pet peeve of mine, and it is not at all restricted to 
> the SCM world.

I guess I don't mind a bit of high-mmv discussion, so long as it doesn't
get in the way of real work.  Polishing these kinds of things seems to
fall in the category of 10% of functionality that takes 90% of effort.

> Of the rest, most by far need some trivial 3-way merging. And the ones 
> that have trouble? In practice, that trivial and maligned 3-way does 
> _better_ than anything more complicated.

I think the great motivator for exploring other merge algorithms has
been criss-cross merge.  There are some workflows (e.g. the Launchpad
workflow) in which heavy mesh-merging takes place, leading to frequent
criss-crosses.

Bog-standard three-way doesn't handle that criss-cross very well.  I
understand git uses recursive three-way in that situation.

The other motivator has been cherry-picking.

So I'm happy that people are trying to devise merge algorithms that are
better than three-way.  When someone gets it right, we'll implement it.

And then there are other more incremental tweaks, like
merge-across-indent and merge-across-line-ending-change that I'd like to
see.

> Go to revctrl.org for prime example of this. I think half the stuff is 
> about merge algorithms, some of it is about glossary, and almost none of 
> it is about something as pedestrian and simple as performance and 
> scalability.

Partly this is because of Bram's interests.  AIUI, he started with a
merge algorithm and built a VCS around it.

> (Actually, to be honest, I think some of the #revctrl noise has become 
> better lately.

I used to spend time on #revctrl, but I think that was before you
started visiting.  Too bad I missed ya.

 So maybe at least this area is getting more about
> real every-day problems, and less about the theoretical-but-not-very- 
> important issues).

It wouldn't surprise me if the early phases of VCS development tended
toward more theoretical discussion, just because so many questions are open.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFOR3D0F+nu1YWqI0RAo5lAJ99+5ShvLXaVIRG1A8XN7HRicoPngCeLO+y
meMZVcjdX7AX9JCfhSN5uK4=
=AI8p
-----END PGP SIGNATURE-----
