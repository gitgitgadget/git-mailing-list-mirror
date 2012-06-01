From: Ted Ts'o <tytso@mit.edu>
Subject: Re: GIT PULL] ext4 updates for 3.5
Date: Fri, 1 Jun 2012 16:52:09 -0400
Message-ID: <20120601205209.GC19987@thunk.org>
References: <E1SaTSI-0005UV-4B@tytso-glaptop.cam.corp.google.com>
 <CA+55aFwk8oYx8EKWdT=5cMTLK7RDz8GQdGmHk2KXwcCq+Bb8PA@mail.gmail.com>
 <CA+55aFwwfMTN=WGQGmFO7DYeBUOGA7V4_6XueQS4JAzeykwn3Q@mail.gmail.com>
 <20120601174336.GA15778@thunk.org>
 <CA+55aFxgZupkAotfjUuWcfwTzHDYg0Afezme62P17=EX2KN+UQ@mail.gmail.com>
 <7v8vg63lri.fsf@alter.siamese.dyndns.org>
 <7v4nqu3lhy.fsf@alter.siamese.dyndns.org>
 <20120601203836.GB19987@thunk.org>
 <CA+55aFyqN2OJkSKVLERtMr-P6OKWEfjrS6eP8OtDyoZB0mmR3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 22:52:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaYpx-0005Zu-Mn
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 22:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758130Ab2FAUwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 16:52:13 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:47105 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab2FAUwN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 16:52:13 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1SaYpO-0007zT-21; Fri, 01 Jun 2012 20:52:10 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1SaYpN-0005Ji-7b; Fri, 01 Jun 2012 16:52:09 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyqN2OJkSKVLERtMr-P6OKWEfjrS6eP8OtDyoZB0mmR3w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199022>

On Fri, Jun 01, 2012 at 01:43:35PM -0700, Linus Torvalds wrote:
> On Fri, Jun 1, 2012 at 1:38 PM, Ted Ts'o <tytso@mit.edu> wrote:
> > One other thought. =A0One of the reasons why I used "dev" and not
> > "ext4_for_linus" in my git request-pull command line was because th=
at
> > several months ago I had created a branch called ext4_for_linus, an=
d I
> > hadn't gotten around to deleting it, so I figured I'd just use "dev=
"
> > instead, since it was non-ambiguous.
>=20
> You can always just use "tags/xyzzy" to disambiguate..

Ah, I thought you always had to type the full "refs/tags/.."
specification.  I didn't realize it did substring matching.  Besides,
"dev" was much shorter and easier to type.  :-)

One of the things which is easy for a novice to miss is the "warning:
ext4_for_linus is ambiguous" message, though.  And I suspect many
novices don't know about the "git show-refs -a | grep ambiguous_tag"
trick to figure out where the ambiguity is coming from.  So if we are
going to give a warning, it might be good if we actually told the user
what were the other choices, and which choice git was going to choose.
Most of the time it seems to choose the right thing, but trusting
computer programs to choose the right answer from something ambiguous
via some hueristic always scares the bejesus out of me....

    	 	   	  	     	     - Ted
