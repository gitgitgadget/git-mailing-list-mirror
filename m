From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Mon, 14 Jan 2008 13:14:20 +0100
Message-ID: <200801141314.21686.jnareb@gmail.com>
References: <200712101357.49325.jnareb@gmail.com> <200801140131.23027.jnareb@gmail.com> <20080114065810.GY2963@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shlomi Fish <shlomif@iglu.org.il>, git@vger.kernel.org,
	Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	David Kastrup <dak@gnu.org>, Florian Weimer <fw@deneb.enyo.de>,
	Chris Shoemaker <c.shoemaker@cox.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 13:15:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEODs-0001tJ-Vj
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 13:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbYANMO2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2008 07:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbYANMO2
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 07:14:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:17989 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374AbYANMO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 07:14:26 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2249247fga.17
        for <git@vger.kernel.org>; Mon, 14 Jan 2008 04:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=p0w+RGvUd3diTmSPXHTiAuMXzcVmOfOciHy9wQ5rgVs=;
        b=oN/kc/Vht6MM+dZAUwhvx3Sc+P7FPsHi0sFjq0Dk8ba24zmC6wknpmV1u5RHNK3QrWjDh8gP7Cc7lXJw0tEvKe+jZqljWwZO2jywfTqqrcdH6ejERI833gI1Dd7m1vsEbwIf7Ccofudo2pYgsvCXcq9tV6isk0JfSK+C8bJG+Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=wta+gpQbJD9F016c68njsgBAphg05ALT1XpgKKweL/ivaU/5Lv8b/6oychvPONU+uJY4D0jdVw4IqEgN0eq8DC6yEEsAc1hszJtNlOLgV7GxO7Gw4obAsGKmi3s296B3Gi0DJNmdPYgkWStrazp4cIlionk+lbcQvgZG2A/aqls=
Received: by 10.82.150.20 with SMTP id x20mr10811184bud.5.1200312862535;
        Mon, 14 Jan 2008 04:14:22 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.211.248])
        by mx.google.com with ESMTPS id q9sm5059449gve.10.2008.01.14.04.14.19
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Jan 2008 04:14:21 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080114065810.GY2963@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70456>

Dnia poniedzia=B3ek 14. stycznia 2008 07:58, Dmitry Potapov napisa=B3:
> On Mon, Jan 14, 2008 at 01:31:19AM +0100, Jakub Narebski wrote:
> > On Mon, 14 January 2008, Dmitry Potapov wrote:
> >=20
> > > Yes. Git can automatically detects renames and show history toget=
her,
> > > however being content oriented rather than file oriented, the not=
ion of
> > > "retaining the history of the file" can not exactly applied to it=
=2E
> >=20
> > "History of a file" can be defined as "<scm> log 'file'", and this =
is
> > well defined also for git.=20
>=20
> You missed the key word here -- *retaining*. In fact, if you define t=
he
> history of a file just as something what "<scm> log" produce then wha=
t
> is the problem with CVS here? Why do most people say that CVS does no=
t
> retain file history over rename? Certainly, you can type "cvs old-nam=
e"
> and see history of one file, and if you type "cvs new-name" then hist=
ory
> of another... But somehow most people think about these two pieces as
> being the history of *one* file... So, your definition is incorrect o=
r,
> at least, very different from what most people mean by that.

I assume that 0th part of rename support is true, i.e. that we can
recover previous full-tree state of repository.

> BTW, when you type "git log 'file'", it shows you not history of a fi=
le,
> but history of changes that affect the specified paths...

The fact that in "git log <path>" the <path> part is path _limiter_
(and can be directory, or set of directories) rather than being limited
to simply single filename is what makes git different, both in good
("git log subsystem/path") and in bad (different from what other SCM
used to) way.

When you type "git log --follow=3D'file'", it shows you history of
a _contents_ which currently is in 'file'; even if there were rename
in the history of 'file' somewhere in the past.

When you type "git log 'directory'", it shows you (simplified) history
of changes affesting specified directory (usually some subsystem).


IMHO "rename support" should be defined as
1.) showing renames when examining given revision (status, log, show;
    whatever it is called).
2.) it should be able to follow history of a file when it looks like
    this: add, change, rename, change.

> > And 'rename support' for file means just
> > that this history of a file (of a current file contents) follows fi=
le
> > renames.
[...]
> >=20
> > IIRC this des not work for directories...=20
>=20
> Git works for directories, it is just that the --follow option cannot
> applied to it, because this option means to follow the file contents,
> which does not make much sense for directories.

But it would be nice to have somehow "git log --follow=3Ddirectory" wor=
k,
even if directory in which susystem resides was renamed. It is harder
work also because (I think) directories are more often split and joined
than file[s contents].

> > > Git is different in that it tracks the content as the whole rathe=
r than
> > > tracking a set of files. When you look at some source code, what =
you
> > > really want to know who and why wrote *this*, and usually it does=
 not
> > > matter to you whether it was written in this file or another one.=
 CVS
> > > is really bad at that, because if you renamed a file, it would be=
 very
> > > difficult to go back to history and find that. Many file-ids base=
d SCMs
> > > have solved this problem, however, they do not do any better than=
 CVS
> > > in another very common case -- when your code is moved around as =
result
> > > of refactoring, but Git addresses both problems, not just one!
> >=20
> > AFAIK Mercurial (hg) is not file-id based, but does explicitely tra=
ck
> > renames. There was even an idea presented on git mailing list to ma=
rk
> > renames in commit object in some "note" header.
>=20
> I suspect the main reason why Mercurial support that is that a lot of
> programmers whose mind was mangled by many years of CVS experience as=
ked
> for that feature. In practice, what you really want to track is conte=
nts.
> And it is not difficult to add some "note" to the commit and teach Gi=
t to
> follow it, but I don't see any practical value in that...

Mercurial can be IMHO from architecture point of view be viewed a bit
as "CVS done right", much more than Subversion, with its path-hashed
changeset storage, manifest file, and changelog / changerev file.

And I guess that Mercurial supports this because of the most important
part of "renames support" (which is present only as TODO for Better-SCM
comparison), namely merging correct files in presence of renames.
=20
> >=20
> > It would be much better if for each feature there was some test
> > described which would allow to check if the feature is supported.
>=20
> Wanna test your LCD monitor with some old CRT tests? -:)

If those tests were done correctly, not from technical side ("renames
support" and other similar thingies for SCMs, refresh rate for LCD/CRT)=
,
but from user side (does command which shows history of a file follows
renames, eyestrain / image sharpness for monitors).... :-)

--=20
Jakub Narebski
Poland
