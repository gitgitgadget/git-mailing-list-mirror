From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 01:11:08 +0200
Message-ID: <200610180111.09068.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45355CBB.80108@utoronto.ca>
	<BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 18 01:10:55 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZy5B-0003dy-U2
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 18 Oct 2006 01:10:50 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZy5A-0003Th-Th; Wed, 18 Oct 2006 00:10:49 +0100
Received: from ug-out-1314.google.com ([66.249.92.169])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1GZy51-0003Sa-1r
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 00:10:43 +0100
Received: by ug-out-1314.google.com with SMTP id 36so60880ugg
	for <bazaar-ng@lists.canonical.com>;
	Tue, 17 Oct 2006 16:10:38 -0700 (PDT)
Received: by 10.66.216.6 with SMTP id o6mr2839253ugg;
	Tue, 17 Oct 2006 16:10:38 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
	by mx.google.com with ESMTP id e1sm257760ugf.2006.10.17.16.10.37;
	Tue, 17 Oct 2006 16:10:38 -0700 (PDT)
To: Sean <seanlkml@sympatico.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29133>

/me too post ;-)

Sean wrote:
> On Tue, 17 Oct 2006 18:44:11 -0400
> Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> 
> > That can lead to feature bloat.  Some plugins are not useful to
> > everyone, e.g. Mercurial repository support.  Some plugins introduce
> > additional dependencies that we don't want to have in the core (e.g. the
> > rsync, baz-import and graph-ancestry commands).
> 
> Shrug, it's really not that tough to do in regular ole source code.
> On Fedora for instance you have your choice of which rpms you want
> to install to get the features of Git you want.

git-core, git-email, git-arch, git-cvs, git-svn, gitk
(and git-debuginfo).

gitk and gitweb were developed in its own repositories, but some time
ago got incorporated into git repository. We have contrib/ area.
QGit, Cogito, StGit are developed separately.

> > Plugins also don't have a Bazaar's rigid release cycle, testing
> > requirements and coding conventions, so they are a convenient way to try
> > out an idea, before committing to the effort of getting it merged into
> > the core.
> 
> Hmm.. It's pretty easy to test out Git ideas too.  People do it all
> the time, and without plugins.  Junio maintains several such trees
> for instance.  Dunno.. I just think plugs _sounds_ good to developers
> without much real benefit to users over regular ole source code.

Thanks to many low lewel (plumbing in git-speak) commands it is very
easy to prototype (write actually) new command in language suitable
for fast prototyping, i.e. shell or Perl (or Python, too). Then if it is
performance critical, or if it get troublesome to manage shell script
version, it gets rewritten in C as builtin command.
