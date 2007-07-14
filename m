From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 19:09:30 +0200
Message-ID: <4699034A.9090603@alum.mit.edu>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>	 <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
        dev <dev@cvs2svn.tigris.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: dev-return-2037-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Sat Jul 14 19:09:47 2007
Return-path: <dev-return-2037-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1I9l7r-000473-5D
	for gcvscd-dev@gmane.org; Sat, 14 Jul 2007 19:09:47 +0200
Received: (qmail 9258 invoked by uid 5000); 14 Jul 2007 17:09:42 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 9248 invoked from network); 14 Jul 2007 17:09:42 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAMOgmEbAbSoIk2dsb2JhbACPNwEBAgcIBgcIHQ
X-IronPort-AV: i="4.16,539,1175497200"; 
   d="scan'208"; a="62145734:sNHT149664473"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52488>

Martin Langhoff wrote:
> On 7/14/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Incidentally, now that cvs2svn 2.0.0 is nearly out, I am thinking about
>> what it would take to write some other back ends for cvs2svn--turning
>> it, essentially, into cvs2xxx.  Most of the work that cvs2svn does is
>> inferring the most plausible history of the repository from CVS's
>> sketchy, incomplete, idiomatic, and often corrupt data.  This work
>> should also be useful for a cvs2git or cvs2hg or cvs2baz or ...
> 
> Great to hear that. I'm game if we can do something in this direction
> - surely we can make it talk to fastimport ;-)

We added some hooks to cvs2svn 2.0 to start working in this direction.
But I don't really know what information is needed for a git import.
One quick-and-dirty idea that I had was to have cvs2svn output
information compatible with cvsps's output, as I believe that several
tools rely on cvsps to do the dirty work and so could perhaps be
persuaded to use cvs2svn out of the box.

> Does cvs2svn handle incremental imports, remembering any "guesses"
> taken earlier? Last time I looked at it, it had far better logic than
> cvsps, but it didn't do incremental imports, and repeated imports done
> at different times would "guess" different branching points for new
> branches, so it _really_ didn't support incrementals

That's correct; cvs2svn does not support incremental conversion at all
(at least not yet).

Michael
