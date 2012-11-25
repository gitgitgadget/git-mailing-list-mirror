From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 05:25:36 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125102536.GC22279@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <50B1DD78.5040907@kdbg.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Nov 25 11:27:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcZQX-0001Ig-AW
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 11:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab2KYK0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 05:26:30 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:42206
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab2KYK02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 05:26:28 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 188674065F; Sun, 25 Nov 2012 05:25:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <50B1DD78.5040907@kdbg.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210347>

Johannes Sixt <j6t@kdbg.org>:
> Am 25.11.2012 03:44, schrieb Eric S. Raymond:
> > That, among other things, means up-to-date versions of Python are
> > ubiquitous unless we're looking at Windows - in which case Perl and
> > shell actually become much bigger portability problems.
> 
> You seem to ignore that more than a quater of users are on Windows[1].
> This is not negligible.

I'm not ignoring that at all.  There are questions of fact here:

Are Perl and a POSIX shell part of the stock installation of Windows?
I believe the answer is "no".  You are free to correct me, but if that's
true they don't have any obvious portability advantage over Python.
That means the 25% percent of Windows users are not actually a reason
to prefer them.

> Absolutely not. To achieve best portability, all code should move to C
> instead.

I wrote the (first) book on C portability.  I mean that literally -
"Portable C and Unix Systems Programming", Prentice-Hall 1987.  Please
don't feel insulted when I point out that over the last 25 years I
have probably forgotten more about this topic than you know.  Just
listen when I tell you that it is not at all obvious that raw C is the
maximally portable language.

It may very well be the case that some random scripting language (not
necessarily Python) achieves greater portability simply because its
maintainers get to pay more concentrated attention to the portability
of the environment bindings at the bottom of their C implementation than
we can.

In any case, I don't believe the difference in portability between raw
C and Python is large enough in either direction to be a reason to
favor either, and I speak as a domain expert on this issue.  This is
not Python advocacy talking; the same could be said of Perl or Ruby.

The real advantages of a scripting language are in maintainability and
expected defect rates, not portability.  The three relevant things we kbnow
from large-scale studies of software defect patterns are these:

1) Expected defect counts are predictable from LOC.

2) Moving to any given scripting language from C dramatically reduces LOC,
and thus expected defects over time.

3) Moving to any scripting language from C eliminates a class of
memory-management problems that dominate C defect statistics.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
