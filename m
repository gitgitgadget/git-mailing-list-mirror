From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvsps, parsecvs, svn2git and the CVS exporter mess
Date: Sun, 06 Jan 2013 12:15:24 +0100
Message-ID: <50E95CCC.30002@alum.mit.edu>
References: <20121222173649.04C5B44119@snark.thyrsus.com> <50E5A5CF.2070009@alum.mit.edu> <20130103205301.GD26201@thyrsus.com> <1E7F9F86-F040-42E4-98C4-152B8CCE47CE@quendi.de> <20130105151106.GA1938@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Max Horn <postbox@quendi.de>, Yann Dirson <ydirson@free.fr>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Bart Massey <bart@cs.pdx.edu>,
	Keith Packard <keithp@keithp.com>,
	David Mansfield <david@cobite.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sun Jan 06 12:15:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TroCo-0004oB-3d
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 12:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab3AFLPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 06:15:34 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:47411 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753189Ab3AFLPc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2013 06:15:32 -0500
X-AuditID: 1207440e-b7f116d0000008ae-3e-50e95cd37a22
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id D5.B2.02222.3DC59E05; Sun,  6 Jan 2013 06:15:31 -0500 (EST)
Received: from [192.168.69.140] (p57A246C2.dip.t-dialin.net [87.162.70.194])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r06BFPfx010386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 6 Jan 2013 06:15:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130105151106.GA1938@thyrsus.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsUixO6iqHs55mWAwe1Xsha/zu5isWj8e4/J
	Ymf7DVaLq1t8LLqudDNZrHx8l9liybfZ7BbNlzewWuyYu4rNgdPj2NnHzB6vV09j9ehf95nV
	Y+esu+we7e/fMXvc+viVzWPC9r3MHsu+drJ4fN4kF8AZxW2TlFhSFpyZnqdvl8CdsXHCZraC
	Y5oVXx7NZ2xgPKDYxcjJISFgItGx5RILhC0mceHeejYQW0jgMqPEj7YYCPs0k8SRPdYgNq+A
	psTGlcuYQGwWAVWJ7h0XwHrZBHQlFvU0g8VFBQIkFi85xw5RLyhxcuYToBoODhEBYYljfWpd
	jFwczAJzmCS2XLsMtktYwF6io/E/O0gCbO+/PXOYQRKcAgYS7/9cYAWxmQV0JN71PWCGsOUl
	tr+dwzyBUWAWkh2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGusV5uZoleakrp
	JkZIzPDtYGxfL3OIUYCDUYmH9+LOFwFCrIllxZW5hxglOZiURHm5ol8GCPEl5adUZiQWZ8QX
	leakFh9ilOBgVhLh7bEEyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiU
	JHiPggwVLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VqfDEwVkFSPEB75WNA9hYX
	JOYCRSFaTzEaczS8vPGUkeNWw82njEIsefl5qVLivGtBNgmAlGaU5sEtgiXLV4ziQH8L874E
	qeIBJlq4ea+AVjEBrUp9/BxkVUkiQkqqgbFkwe6Kv4eqp1tFbw7fk6xwPsNo98/j 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212793>

On 01/05/2013 04:11 PM, Eric S. Raymond wrote:
> Perhaps I was unclear.  I consider the interface design error to
> be not in the fact that all the blobs are written first or detached,
> but rather that the implementation detail of the two separate journal
> files is ever exposed.
> 
> I understand why the storage of intermediate results was done this
> way, in order to decrease the tool's working set during the run, but
> finishing by automatically concatenating the results and streaming
> them to stdout would surely have been the right thing here.

cvs2svn/cvs2git is built to be able to handle very large CVS
repositories, not only those that can fit in RAM.  This goal influences
a lot of its design, including the pass-by-pass structure with
intermediate databases and the resumability of passes.

The blobfile necessarily contains every version of every file, with no
delta-encoding and no compression.  Its size can be a large multiple of
the on-disk size of the original CVS repository.  If the "save to
tempfiles then cat tempfiles at end of run" behavior were hard-coded
into cvs2git, then there would be no way to avoid requiring enough
temporary space to hold the whole blobfile.

Writing the blobfile into a separate file, on the other hand, means that
for example the blobfile could be written into a named pipe connected to
the standard input of "git fast-import" [1].  "git fast-import" could
even be run on a remote server.

I consider these bigger advantages than the ability to pipe the output
of cvs2git directly into another command.

> The downstream cost of letting the journalling implementation be
> exposed, instead, can be seen in this snippet from the new git-cvsimport
> I've been working on:
> 
>     def command(self):
>         "Emit the command implied by all previous options."
>         return "(cvs2git --username=git-cvsimport --quiet --quiet --blobfile={0} --dumpfile={1} {2} {3} && cat {0} {1} && rm {0} {1})".format(tempfile.mkstemp()[1], tempfile.mkstemp()[1], self.opts, self.modulepath)
> 
> According to the documentation, every caller of csv2git must go
> through analogous contortions!  This is not the Unix way; if Unix
> design principles had been minimally applied, that second line would
> just read like this:
> 
>      return "cvs2git --username=git-cvsimport --quiet --quiet"

Never in my worst nightmares did I imagine that my terrible design taste
would force you to type an extra two lines of code.  Oh the humanity!

By the way, patches are welcome.  And you don't need to trumpet their
imminent arrival [2] or malign the existing code beforehand.  Moreover,
it would be adequate if you just demonstrate working code and *then* ask
for "sign-in", rather than the other way around.

> If Unix design principles had been thoroughly applied, the "--quiet
> --quiet" part would be unnecessary too - well-behaved Unix commands
> *default* to being completely quiet unless either (a) they have an
> exceptional condition to report, or (b) their expected running time is
> so long that tasteful silence would leave users in doubt that they're
> working.

cvs2git is not a command that one uses 100 times a day.  It is a tool
for one-shot conversions of CVS repositories to git.  These conversions
can take hours or even days of processing time (not to mention the time
for configuring the conversion and changing the rest of a project's
infrastructure from CVS to git).  So yes, I think we would like to
appeal to (b) and humbly ask for your permission to give the user some
feedback during the conversion.

> (And yes, I do think violating these principles is a lapse of taste when
> git tools do it, too.)
> 
> Michael Haggerty wants me to trust that cvs2git's analysis stage has
> been fixed, but I must say that is a more difficult leap of faith when
> two of the most visible things about it are still (a) a conspicuous
> instance of interface misdesign, and (b) documentation that is careless and
> incomplete.

The cvs2git documentation is lacking; I admit it (as opposed to the
cvs2svn documentation, which I think is quite complete).  And the
program itself also has a lot of rough edges, for example its inability
to convert .cvsignore files into .gitignore files.  Patches are welcome.
 I haven't used cvs2svn for my own purposes in many years and I've
*never* once had a need to use cvs2git; I maintain these programs purely
as a service to the community.  Most of the community seems satisfied
with the programs as they are, and if not they usually submit courteous
and concrete bug reports or submit patches.

I request that you follow their example.  I especially ask that you
restrain from spreading public FUD about imagined problems based on
speculation.  Please do your tests and *then* report any problems that
you find.

Yours,
Michael

[1] In fact, the current implementation of generate_blobs.py sometimes
seeks back to earlier parts of the blob file when it needs the fulltext
of a revision that has already been output, but this would be easy to
change as soon as somebody needs it.

[2] http://comments.gmane.org/gmane.comp.version-control.git/212340

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
