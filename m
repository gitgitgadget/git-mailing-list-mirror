From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: First round of UGFWIINI results
Date: Tue, 17 Feb 2009 17:47:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 17:49:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZT7s-0004ui-RB
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 17:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbZBQQrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 11:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbZBQQrW
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 11:47:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:58455 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752085AbZBQQrV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 11:47:21 -0500
Received: (qmail invoked by alias); 17 Feb 2009 16:47:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp057) with SMTP; 17 Feb 2009 17:47:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/T20qL2U/vwIHP+n3w4uJmfuB3UFY1YG+5jqX9I
	CLPsi8o4qt2mKR
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110411>

Dear fans of Git,

a while ago I announced the UGFWIINI contest, a glorious battle of ideas
how to

	Use Git For What It Is Not Indended

As most of you probably did not find my blog yet, this may come as a
surprise to you, but it will not be the only surprise in this email.

I managed to collect 10 candidates already, and since I did all the hard
work of collating them, I took the liberty of ordering them into a very
subjective order of ugfwiininess (pronounced "You-gah-wee-knee-ness").

Please assist me while reading this mail by hitting your desk alternating
between your two index fingers, increasing the frequency from 2 to 4 hertz
throughout the mail.

Ready? Okay.

Number 10:

Sergio Callegari describes how to manage opendocument (openoffice.org) files
in git in

	http://kerneltrap.org/mailarchive/git/2008/9/15/3305014

While this might strike some of you as pretty lame, in my opinion it is still
something Git was not intended for: Never mind the title "stupid content
tracker", Git was clearly intended to track source code stored as small ASCII
files; otherwise, 'git diff' would not be such an integral part of Git.

Number 9:

Tim Ansell talked about managing large media with Git at the GitTogether:

	http://www.thousandparsec.net/~tim/media+git.pdf

This falls into the same category as number 10, but in addition it strains
the assumption of Git that you can easily fit the contents of a file into
memory, as well as the assumption that it is pretty easy (and meaningful)
to make a diff from two versions of a file.

Number 8:

Avery Pennarun explains his endeavor of tracking windows with git...
"If I get a virus, I can 'git revert' it."
http://alumnit.ca/~apenwarr/log/?m=200901#21
 
Sverre remarks: "It even beats the way we use Git to track the MSys
installation in msysgit.git..."

This is also related to Martin Krafft's idea to sort of replace the Debian
packaging management by using Git, but...

Number 7:

... actually does something like that: James Tucker implemented a port manager
based on Git:

	http://github.com/raggi/source_ports

Number 6:

Dieter Plaetinck synchronizes Firefox profiles using Git:

	http://dieter.plaetinck.be/rethinking_the_backup_paradigm_a_higher-level_approach

Now, this even strains the definition of "content"...

Number 5:

David Abrahams archiving a large number of files (and detecting duplicates)
uses Git partly for something it _can_ do, but certainly was not intended to
do: identify duplicates.

	http://kerneltrap.org/mailarchive/git/2009/1/27/4827304

While the content-addressable filesystem has to deal with duplicates in the
_time_ dimension very well (not many files are supposed to change from one
revision to the next one, so most of the files _are_ duplicated), dealing
with it in the _space_ dimension is not the purpose of Git, as can be seen
by the lack of tool support for it (also keep in mind the absence of git-cp).

Number 4:

Josef Wolf asks in <20090131123336.GA1702@raven.wolf.lan> (with a fully
valid Mail-Followup-To header) "How to move subdirectories from one svn
repos to another."

"I would like to move a complete subdirectory with all its history from
one svn repository to another."

Now, the ugfwiininess of this entry is definitely increased dramatically
by Josef being inclined to go to Git _and back to Subversion_ again :-)

(Imagine a cheeky smirk on the face of your host.)

Number 3:

Jan Krueger's Git cookbook uses a Git repository as a backend of a content
management system:

	http://repo.zoidberg.org/w/git-articledb.git
	http://gitrecipes.de/

This is related to the way my own blog works, but he was first.  Credit
where credit is due.

Number 2:

At the GitTogether, Sam Vilain presented his idea to use Git as a DB backend:

	http://utsl.gen.nz/talks/git-db

Just think about it: committing by "INSERT INTO"!

And now, ladies and gentlemen, please brace yourself for...

Number 1:

Scott Chacon's iGitHub: Running a git-daemon on an iPhone

	http://github.com/schacon/igithub/

This is so awesome as to defeat any attempt to describe it.


I hope you enjoyed the show, and see you again next time, on

	Using Git For What It Is Not Intended

(Now play your favorite jingle.)
