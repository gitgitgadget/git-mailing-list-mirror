From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 1 Feb 2011 14:51:15 +0100
Message-ID: <201102011451.17456.jnareb@gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com> <20110129231310.GA11088@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 14:52:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkGeQ-000152-0Y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 14:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757056Ab1BANvd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 08:51:33 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55818 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757047Ab1BANvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 08:51:31 -0500
Received: by wyb28 with SMTP id 28so6699198wyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 05:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=dPY7lk5Bd5HgXfsSlNSAS6iwIlF+1dmsGjNhEkWJfmM=;
        b=dzZmT1O32zQufjAKRaF2GoZv7S2G1/pwYSPHIvfCrEuhRRHfJGRGeTkjcl8JG0VylY
         vIk+v3vEfCPD+L5b9IkqwMc47JwWej4KKpj77uxsWJlGcbA/98Lp7KDIM/hDRydhQaKf
         OO3pyR6+F6QkU9iOnad6r72nLZOb4nTZngM3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=hH6CpFlorj19evFQDPv0FXeh41PnNuJ0S0IewtDS2trjWnFvQgR1KzW5KygDAvOY17
         JQ7cJvtOlT50JO2I0Ol+UPaTBms/5sluNQ/XaFqYA92ojHZfZPqA5tGc8xOqOA965np6
         KlldQCYgkUnetOiK5jke1sPyf867EP/LKnjqg=
Received: by 10.227.146.13 with SMTP id f13mr1830330wbv.171.1296568289415;
        Tue, 01 Feb 2011 05:51:29 -0800 (PST)
Received: from [192.168.1.13] (abuz232.neoplus.adsl.tpnet.pl [83.8.197.232])
        by mx.google.com with ESMTPS id y29sm10944515wbd.22.2011.02.01.05.51.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 05:51:26 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110129231310.GA11088@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165804>

On Sun, 30 Jan 2011, Jonathan Nieder wrote:
> Hi Dmitry,
>=20
> Dmitry S. Kravtsov wrote:
>=20
> > I want to dedicate my coursework at University to implementation of
> > some useful git feature. So I'm interesting in some kind of list of
> > development status of these features
> [...]
> > Or I'll be glad to know what features are now 'free' and what are
> > currently in active development.
>=20
> Interesting question.  The short answer is that they are all "free".
> Generally people seem to be happy to learn of an alternative approach
> to what they have been working on.
>=20
> [For the following pointers, the easiest way to follow up is probably
> to search the mailing list archives.]
>=20
> > better support for big files (large media)
>=20
> For a conservative approach, you might want to get in touch with Sam
> Hocevar, Nicolas Pitre, and Miklos Vajna.  The idea is to stream big
> files directly to pack and not waste time trying to compress them.

There is also, supposedly stalled, git-bigfiles project.

>=20
> For an alternative approach, Joey Hess's git-annex might be
> interesting.

Note that this feature would not be easy to implement; you would need
both quite good knowledge of git internals, and some realistic use case
that you can test performance of your improvements with.

> > resumable clone/fetch (and other remote operations)
>=20
> Jakub Narebski seems to be interested in this and Nicolas Pitre has
> given some good advice about it.  You can get something usable today
> by putting up a git bundle for download over HTTP or rsync, so it is
> possible that this just involves some UI (porcelain) and documentatio=
n
> work to become standard practice.

I wouldn't say that: it is Nicolas Pitre (IIRC) who was doing the work;
I was only interested party posting comments, but no code.

Again, this feature is not very easy to implement, and would require=20
knowledge of git internals including "smart" git transport ("Pro Git"
book can help there).

> > GitTorrent Protocol, or git-mirror
>=20
> Sam Vilain and Jonas Fonseca did some good work on this, but it's
> stalled.

There was some recent discussion on this on git mailing llist, but
without any code.

One would need to know similar areas as for "resumable clone" feature.
Plus some knowledge on P2P transport in GitTorrent case.

> > lazy clone / on-demand fetching of object
>=20
> There's a patch.  As is, it is not likely to be useful outside
> specialized circumstances imho.
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/73117

One would need to know about how git checks for consistency, e.g. via
git-fsck for that.

> > subtree clone
>=20
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy and Elijah Newren have done=
 some design and
> prototyping work.

Git mailing list archives should contain proof of concept / RFC patches
for this feature.  Quite interesting.

> > support for tracking empty directories
>=20
> Tricky to get the UI right.  I am interested in and would be glad to
> help with this one.

Also one needs to remember that this would require adding extension
to git index, because currently it tracks only files, and not=20
directories.  Explicitly tracking directories in the index could be=20
useful for other purposes...

The major difficulty of this is IMHO not the UI, but tracking all those
tricky corner cases (like directory/file conflict, etc.).

[...]=20
> > side-by-side diffs and/or color-words diff in gitweb
> > admin and/or write features in gitweb
> > graphical history view in gitweb
> =20
> There may or may not have been design work on some of these for Pavan
> Kumar Sunkara's last summer of code project.  John 'Warthog9' Hawley,
> Jakub Narebski, and Petr Baudis might have advice.

Pavan was to work on admin and/or write features in gitweb, while he
didn't even finish splitting gitweb (perhaps he tried to be too=20
ambitious in trying to split whole of gitweb at once, instead of=20
splitting-off well definied pieces?).

There are existing Perl modules on CPAN and/or Perl web apps that use
side-by-side diffs and/or color-words diff, so there is code to take an
example, to use in gitweb, or to borrow.

The graphical history view would be more difficult, but not very=20
difficult, I think.  You would have to decide how to draw a graph:=20
should gitweb generate image on the fly, use some smart combination
of CSS and pre-made images (perhaps with transparency), use Unicode
graph characters, or use ASCII-art graph.  You would also have to decid=
e=20
whether to use or base on some existing algorithm to generate graph,
borrowing from tig, git-browser, gitk or git-forest (the last is in=20
Perl, like gitweb), or whether to make use of "git log --graph" output.

> > GUI for rebase in git-gui
> > GUI for creating repository in git-gui
> > graphical diff/merge tool integrated with git-gui
> > syntax highlighting in git-gui
> =20
> Pat Thoyts is probably the one to talk to.

Note that for graphical diff/merge tool you should be able to borrow=20
from xxdiff graphical diff/merge tool, which is also written in Tcl/Tk.

> > filename encoding (in repository vs in filesystem)
> =20
> This is important for the Windows port and likely to be a nuisance
> on Unix.  I think there has been some work on it on the msysgit list?

That would need a good design (note also different forms of Unicode),
and overcoming inertia.

> > localization of command-line messages (i18n)
>=20
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason did some work which is in pu. =
 It needs
> some polishing.  I am also interested.

I don't know how much is left to do (beside actually translating=20
messages).  But this series could use a little help.
 =20
> > union checkouts (some files from one branch, some from other)
>=20
> Not sure I understand the use case?

I don't know if it would be really useful, but the concept is similar t=
o=20
union mounts.  In union mount (unionfs, aufs,...) you can e.g. mount=20
CD-ROM read-only, and over it overlay on some read-write filesystem.

The idea is to have some files (some directories) in working area come=20
from one branch, some from other branch, persistently in some way.  Not=
=20
sure if it would be actually useful.
 =20
> > advisory locking / "this file is being edited"
>=20
> Probably better to implement out of band (using hooks?).  I don't
> know of any work or documentation in that direction.

Yes, t would probably be best as external project, only with git=20
integration.

> > built-in gitjour/bananajour support
> =20
> A good start might be to submit one or both of these to contrib?

If I remember correctly there are some third-party extensions to be=20
found, and perhaps even some patches in git mailing list.


Best choose something you are both interested in, and proficient with.

HTH
--=20
Jakub Narebski
Poland
