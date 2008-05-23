From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Fri, 23 May 2008 08:45:41 +0200
Message-ID: <20080523064541.GA31315@diana.vm.bytemark.co.uk>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Fri May 23 08:46:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzR3I-0005ba-JC
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 08:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424AbYEWGqF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2008 02:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755611AbYEWGqE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 02:46:04 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4866 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbYEWGqD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 02:46:03 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JzR26-0008IL-00; Fri, 23 May 2008 07:45:42 +0100
Content-Disposition: inline
In-Reply-To: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82686>

On 2008-05-23 01:18:42 -0500, Govind Salinas wrote:

> Some functionality isn't for everyone. I have just put into my next
> branch an addon that gives git revision numbers. Why, because other
> SCMs that are supposed to be more user friendly have them. Because
> people have been asking for them. Because they are easier to
> remember. The concept is this. A given commit encapsulates its
> parantage, so if I have commit XYZ, I can always say that XYZ is
> so-many commits away from the first commit. The question is how you
> determine that number and that you always do it the same. If we just
> define the revision number to be the place of the commit in the list
> of "git rev-list --topo-order --reverse SHA1" then we can get a
> consistant number semi-meaningful number, which is all people really
> want.

You do realize that no matter how you define your sequential numbers,
they can't be both globally consistent and unique? (That is, either
different repositories will assign different numbers to the same
commit, or the same number could be assigned to more than one commit.)

=46or a simple reason: A numbering that's both globally consistent and
unique can only look at a commit's ancestry (and the commit itself)
when assigning a number to a commit. But in order to get _sequential_
numbers, you need to look at the commit's siblings as well, and the
set of siblings can be different from repository to repository.

This has already been discussed to death elsewhere in this list at
least once (see the list archives), but your next paragraph suggests
you think it's only a performance issue, which is why I brought it up:

> So why isn't this for everyone? Because its a little slow and some
> people on the list HATE anything that takes more than half a second.
> I won't name names but he has an OS named after him. So for a git
> repo on decent hardware, this adds .5-1 seconds to look something up
> and find out its revision. Painful to some, but others would rather
> wait than have to try and remember a SHA1 or even just the first 8
> chars of a SHA1.

> Well, this mail is long enough, hopefully I will get some feedback
> on this, some more ideas for things that can be simplified or
> enhanced or whatever. Please feel free to drop me a line and/or
> check out my public repo at http://gitorious.org/projects/pyrite.

Good luck with your work!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
