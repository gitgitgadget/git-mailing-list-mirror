From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: vcs for hefty video and graphics files
Date: Thu, 25 Nov 2010 12:34:41 -0500
Message-ID: <jwvr5e91fj2.fsf-monnier+gmane.comp.version-control.bazaar-ng.general@gnu.org>
References: <877hg55iyd.fsf@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: bazaar@lists.canonical.com, mercurial@selenic.com, git@vger.kernel.org,
	info-cvs@gnu.org
To: info-cvs@gnu.org
X-From: info-cvs-bounces+gnu-info-cvs=m.gmane.org@nongnu.org Thu Nov 25 21:40:38 2010
Return-path: <info-cvs-bounces+gnu-info-cvs=m.gmane.org@nongnu.org>
Envelope-to: gnu-info-cvs@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <info-cvs-bounces+gnu-info-cvs=m.gmane.org@nongnu.org>)
	id 1PLicM-0004lc-6y
	for gnu-info-cvs@m.gmane.org; Thu, 25 Nov 2010 21:40:34 +0100
Received: from localhost ([127.0.0.1]:51722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1PLicL-0000Iy-QE
	for gnu-info-cvs@m.gmane.org; Thu, 25 Nov 2010 15:40:33 -0500
Received: from [140.186.70.92] (port=40871 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1PLibz-0000Ir-Lv
	for info-cvs@gnu.org; Thu, 25 Nov 2010 15:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gnu-info-cvs@m.gmane.org>) id 1PLiby-0000ZR-SX
	for info-cvs@gnu.org; Thu, 25 Nov 2010 15:40:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:44989)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gnu-info-cvs@m.gmane.org>) id 1PLiby-0000Yg-Kw
	for info-cvs@gnu.org; Thu, 25 Nov 2010 15:40:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gnu-info-cvs@m.gmane.org>) id 1PLibr-0004OS-Sh
	for info-cvs@gnu.org; Thu, 25 Nov 2010 21:40:03 +0100
Received: from 69-196-160-116.dsl.teksavvy.com ([69.196.160.116])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <info-cvs@gnu.org>; Thu, 25 Nov 2010 21:40:03 +0100
Received: from monnier by 69-196-160-116.dsl.teksavvy.com with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <info-cvs@gnu.org>; Thu, 25 Nov 2010 21:40:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 69-196-160-116.dsl.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:6/RbMlwWFrZHJivQ2YBcQjonKNI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6 (newer, 3)
X-BeenThere: info-cvs@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Announcements and discussions for the CVS version control system
	<info-cvs.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/info-cvs>,
	<mailto:info-cvs-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/info-cvs>
List-Post: <mailto:info-cvs@nongnu.org>
List-Help: <mailto:info-cvs-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/info-cvs>,
	<mailto:info-cvs-request@nongnu.org?subject=subscribe>
Sender: info-cvs-bounces+gnu-info-cvs=m.gmane.org@nongnu.org
Errors-To: info-cvs-bounces+gnu-info-cvs=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162155>

> It would involve on any one projects something like 15 to 60 GB of
> stuff to keep up with.  Large numbers of images and a dozen or 2 dozen
> video files.  All in some stake of compression depending on the codex.

FWIW, for a VCS to do a good job on this kind of problem, you'd need
to use a representation that lends itself to it.

I.e. regardless of what you end up doing, I would recommend you contact
the mailing-list of Free Software that can do the kind of video
manipulation you want to do, and tell them that you'd need their tool to
represent a project in such a way that it has a bunch of big-files that
are almost never modified (containing "binary data" such as the source
images and audio recordings, say) along with a few other smaller files
that mostly contain instructions about how to use the big-files to
generate the desired output.

Such a representation should lead to very good support from most VCSs.
E.g. If these small files use a clean text representation, then a VCS
might even be able to do useful merges between different branches of
a project (as long as the branches share the same big-files).


        Stefan
