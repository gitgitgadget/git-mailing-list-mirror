From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Mon, 28 Sep 2009 16:11:46 -0700 (PDT)
Message-ID: <m33a66br69.fsf@localhost.localdomain>
References: <h9nlhj$heq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anteru <newsgroups@catchall.shelter13.net>
X-From: git-owner@vger.kernel.org Tue Sep 29 01:11:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsPNt-0006Q5-D5
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 01:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbZI1XLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 19:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbZI1XLr
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 19:11:47 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:34910 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbZI1XLq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 19:11:46 -0400
Received: by bwz6 with SMTP id 6so1641740bwz.37
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 16:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Gs28A7YXq3WwYebJVl5EV8JMpthVnv2VIJP+iVBheWQ=;
        b=DOpV/o1X8jbR+SwCuJArd1YUmhFL4FsQULIAHRF8NSQ30NkrkjqesnwdaCeV5p1kJO
         lhcQSUxi3PiEuEMqTxOxqSea3QScywkAa15si1Zm3avS85MqaWE7QpWGYgi39cYvFoWp
         LPPMugCQPuBoiub3uqPqZcjfEY2XmQ4WuYGBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=AxIna5NOOb2NMuCjfHPZAuVenYaUGIouY2tO0pAaxdErsJ2rmS/3guYu80q75sO81L
         MMEpxhHFWmPQiK/9qMdWuOLeOCzNHc5JVJcX1sTHJC/2KpvSbx/iwI29db1gEcggCZqs
         T3PGXz/cBOeRV/GRldXB2c30ePKDekAqi5VZ4=
Received: by 10.204.18.145 with SMTP id w17mr3535680bka.42.1254179508774;
        Mon, 28 Sep 2009 16:11:48 -0700 (PDT)
Received: from localhost.localdomain (abvk246.neoplus.adsl.tpnet.pl [83.8.208.246])
        by mx.google.com with ESMTPS id p9sm231400fkb.7.2009.09.28.16.11.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 16:11:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8SNBh2P019507;
	Tue, 29 Sep 2009 01:11:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n8SNBggR019504;
	Tue, 29 Sep 2009 01:11:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <h9nlhj$heq$1@ger.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129276>

Anteru <newsgroups@catchall.shelter13.net> writes:

> I'm currently evaluating DVCS for a project, and we're at a point where
> it comes down to either Mercurial or Git. Right now, I'm advocating for
> Git, while my co-workers like Mercurial, so I'd like to provide some
> good arguments in favor of git. Unfortunately, I'm not a git expert, so
> I hope I can get some help here ...
> 
> First of all, what's the matter with git and Windows, is there some
> long-term commitment to make git work on Windows as well as on Linux?
> I'm using msysgit on Windows, and personally I'm happy with it, but my
> co-workers constantly nag that Mercurial has superior portability ...

On one hand side Git relies quite a bit on POSIX features; also some
of git commands are implemented as shell scripts, or are written in
Perl.  Nevertheless even if people stopped working on msysGit
("native" Windows port), which I don't see happening, there is always
and will be git from Cygwin.  But the msysGit team is active, and I
predict that it soon would be full equivalent of Git on Linux (there
are some corner cases yet).  Lately there was even some work on
support infrastructore for having Git be developed in MSVC.

On the other hand side Mercurial does have some parts of its code
rewritten in C for efficiency.  I do wonder how portable it is, and
what is more important how portable is the interface between C and
Python.

But I do not use MS Windows for development, and I do not use
Mercurial...

> Mercurial's revision number system: With git, I get an SHA1 hash for
> every commit, but it's not possible to see whether Hash1 is newer than
> Hash2, while Mecurial also adds a running number to each commit. What's
> the rationale behind this decision for git, and is it possible to
> emulate Mercurial's behavior somehow?

First, you have to remember that this 'number of commit' thingy is
*local* to your repository, so you cannot use commit numbers to
communicate with other developers.  This is inherent and unavoidable
property of 'revision numbering': commit identifiers must be derivable
from commit contents (e.g. SHA-1 used by Git), or must be local to
clone of repository (e.g. Mercurial), or there must be some central
numbering authority (like in centralized SCMs like Subversion).

Second, I think advantages of revision numbering (running number) are
overemphasized.  I don't see how numbers such as 12678 and 12687 are
easier to use than even abbreviated SHA-1 IDs like f06e7eb, never mind
the "<branch>~<n>" syntax Git uses to refer to n-th ancestor of
current tip of given branch.  Besides with nonlinear history with
revision numbers such as 12678 and 12687 you know that 12678 is older
than 12687 if and only if 12678 and 12687 are on the same line of
development.

Third, I think it would be possible to emulate mercurial behaviour
with using lightweight 'number' tags for numbering, created from a
hook.

> Integration into tools: We're using Trac currently, which also has a
> nice binding to Mercurial (well, obviously easy to do as Mercurial is
> written in Python, just as Trac itself), while the git support is in
> development and looks quite alpha'ish. Do you plan to make it easier to
> integrate git with other tools by providing bindings to other languages,
> or is this a low-priority issue?

Well, I think that the problem with implementing bindings to other
programming languages is that there is currently no such thing like
the Git library (well, there are beginnings of one).  This is caused
by the fact that originally git commands were written in run-once
philosophy, and e.g. rely on operating system to do the cleanups.

So far bindings to other languages either call Git commands (like
Git.pm Perl interface from Git, or JavaGit), or are native Git
(re)implementations relying not on stable API, but on stable
repository format (JGit for Java, Dulwich for Python, partially Grit
for Ruby).  

The emphasisis in Git was (and is) for it to be *scriptable*, rather
than extensible through plugins.


BTW. the fact that JGit is reimplementation allows it to be use
different license than Git itself; license which makes JGit and EGit
to be license-compatibile with Eclipse, and allow to distribute EGit
as full Eclipse project.

> 
> So far, my key arguments are that git is more robust (more projects
> using it, larger developer base), of course git's excellent performance
> and the much better support for SVN, which is important for us as we can
> slowly migrate from SVN->Git, while hgmercurial is still in the making
> (and Python's SVN->Hg switch is for instance waiting for it).

hgmercurial? or hgsubversion?

There is also fact that git has superior support for multi-branch
development, which I think is the workflow most suited for distributed
development.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
