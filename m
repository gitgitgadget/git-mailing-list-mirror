From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: [ANNOUNCE] GIT 1.6.5
Date: Sun, 11 Oct 2009 09:30:47 -0700
Message-ID: <f488382f0910110930k67b34da7p4a744d47073a948b@mail.gmail.com>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
	 <f488382f0910110930u1af92299ld5d72dbb31ed1914@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 18:38:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx1RT-00024E-N4
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 18:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbZJKQiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 12:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755326AbZJKQiX
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 12:38:23 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:41793 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbZJKQiW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Oct 2009 12:38:22 -0400
Received: by pxi9 with SMTP id 9so8020334pxi.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 09:37:46 -0700 (PDT)
Received: by 10.142.195.4 with SMTP id s4mr412013wff.264.1255278648051; Sun, 
	11 Oct 2009 09:30:48 -0700 (PDT)
In-Reply-To: <f488382f0910110930u1af92299ld5d72dbb31ed1914@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129935>

On Sun, Oct 11, 2009 at 9:30 AM, Steven Noonan <steven@uplinklabs.net> =
wrote:
> Uh-oh.
>
> Alcarin:crisscross steven$ git remote update
> Updating origin
> fatal: 'git@github.com/tycho/crisscross.git' does not appear to be a
> git repository
> fatal: The remote end hung up unexpectedly
> error: Could not fetch origin
>
> Alcarin:crisscross steven$ nano -w .git/config
> Alcarin:crisscross steven$ git remote update
> Updating origin

Er, meant to say before this that I edited the URI to include the
'ssh://' and then it worked fine.

>
> The 'ssh://' part is omitted in numerous places on github.com. I
> realize github.com isn't the final authority on the syntax of the URI=
,
> but was this an intentional change or a regression?
>
> - Steven
>
> On Sun, Oct 11, 2009 at 1:40 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> The latest feature release GIT 1.6.5 is available at the usual
>> places:
>>
>> =A0http://www.kernel.org/pub/software/scm/git/
>>
>> =A0git-1.6.5.tar.{gz,bz2} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(source tarball)
>> =A0git-htmldocs-1.6.5.tar.{gz,bz2} =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pref=
ormatted docs)
>> =A0git-manpages-1.6.5.tar.{gz,bz2} =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pref=
ormatted docs)
>>
>> The RPM binary packages for a few architectures are found in:
>>
>> =A0RPMS/$arch/git-*-1.6.5-1.fc9.$arch.rpm =A0 =A0 =A0 =A0(RPM)
>>
>> This cycle took a bit longer than I hoped, but here it is. =A0We alr=
eady
>> have some new features cooking in 'next', and I expect we may be abl=
e to
>> have 1.6.6 by the end of the year.
>>
>> Enjoy.
>>
>> ----------------------------------------------------------------
>>
>> GIT v1.6.5 Release Notes
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>
>> In git 1.7.0, which was planned to be the release after 1.6.5, "git
>> push" into a branch that is currently checked out will be refused by
>> default.
>>
>> You can choose what should happen upon such a push by setting the
>> configuration variable receive.denyCurrentBranch in the receiving
>> repository.
>>
>> Also, "git push $there :$killed" to delete the branch $killed in a r=
emote
>> repository $there, when $killed branch is the current branch pointed=
 at by
>> its HEAD, will be refused by default.
>>
>> You can choose what should happen upon such a push by setting the
>> configuration variable receive.denyDeleteCurrent in the receiving
>> repository.
>>
>> To ease the transition plan, the receiving repository of such a
>> push running this release will issue a big warning when the
>> configuration variable is missing. =A0Please refer to:
>>
>> =A0http://git.or.cz/gitwiki/GitFaq#non-bare
>> =A0http://thread.gmane.org/gmane.comp.version-control.git/107758/foc=
us=3D108007
>>
>> for more details on the reason why this change is needed and the
>> transition plan.
>>
>> Updates since v1.6.4
>> --------------------
>>
>> (subsystems)
>>
>> =A0* various updates to gitk, git-svn and gitweb.
>>
>> (portability)
>>
>> =A0* more improvements on mingw port.
>>
>> =A0* mingw will also give FRSX as the default value for the LESS
>> =A0 environment variable when the user does not have one.
>>
>> =A0* initial support to compile git on Windows with MSVC.
>>
>> (performance)
>>
>> =A0* On major platforms, the system can be compiled to use with Linu=
s's
>> =A0 block-sha1 implementation of the SHA-1 hash algorithm, which
>> =A0 outperforms the default fallback implementation we borrowed from
>> =A0 Mozilla.
>>
>> =A0* Unnecessary inefficiency in deepening of a shallow repository h=
as
>> =A0 been removed.
>>
>> =A0* "git clone" does not grab objects that it does not need (i.e.
>> =A0 referenced only from refs outside refs/heads and refs/tags
>> =A0 hierarchy) anymore.
>>
>> =A0* The "git" main binary used to link with libcurl, which then dra=
gged
>> =A0 in a large number of external libraries. =A0When using basic plu=
mbing
>> =A0 commands in scripts, this unnecessarily slowed things down. =A0W=
e now
>> =A0 implement http/https/ftp transfer as a separate executable as we
>> =A0 used to.
>>
>> =A0* "git clone" run locally hardlinks or copies the files in .git/ =
to
>> =A0 newly created repository. =A0It used to give new mtime to copied=
 files,
>> =A0 but this delayed garbage collection to trigger unnecessarily in =
the
>> =A0 cloned repository. =A0We now preserve mtime for these files to a=
void
>> =A0 this issue.
>>
>> (usability, bells and whistles)
>>
>> =A0* Human writable date format to various options, e.g. --since=3Dy=
esterday,
>> =A0 master@{2000.09.17}, are taught to infer some omitted input prop=
erly.
>>
>> =A0* A few programs gave verbose "advice" messages to help uninitiat=
ed
>> =A0 people when issuing error messages. =A0An infrastructure to allo=
w
>> =A0 users to squelch them has been introduced, and a few such messag=
es
>> =A0 can be silenced now.
>>
>> =A0* refs/replace/ hierarchy is designed to be usable as a replaceme=
nt
>> =A0 of the "grafts" mechanism, with the added advantage that it can =
be
>> =A0 transferred across repositories.
>>
>> =A0* "git am" learned to optionally ignore whitespace differences.
>>
>> =A0* "git am" handles input e-mail files that has CRLF line endings =
sensibly.
>>
>> =A0* "git am" learned "--scissors" option to allow you to discard ea=
rly part
>> =A0 of an incoming e-mail.
>>
>> =A0* "git archive -o output.zip" works without being told what forma=
t to
>> =A0 use with an explicit "--format=3Dzip".option.
>>
>> =A0* "git checkout", "git reset" and "git stash" learned to pick and
>> =A0 choose to use selected changes you made, similar to "git add -p"=
=2E
>>
>> =A0* "git clone" learned a "-b" option to pick a HEAD to check out
>> =A0 different from the remote's default branch.
>>
>> =A0* "git clone" learned --recursive option.
>>
>> =A0* "git clone" from a local repository on a different filesystem u=
sed to
>> =A0 copy individual object files without preserving the old timestam=
p, giving
>> =A0 them extra lifetime in the new repository until they gc'ed.
>>
>> =A0* "git commit --dry-run $args" is a new recommended way to ask "w=
hat would
>> =A0 happen if I try to commit with these arguments."
>>
>> =A0* "git commit --dry-run" and "git status" shows conflicted paths =
in a
>> =A0 separate section to make them easier to spot during a merge.
>>
>> =A0* "git cvsimport" now supports password-protected pserver access =
even
>> =A0 when the password is not taken from ~/.cvspass file.
>>
>> =A0* "git fast-export" learned --no-data option that can be useful w=
hen
>> =A0 reordering commits and trees without touching the contents of
>> =A0 blobs.
>>
>> =A0* "git fast-import" has a pair of new front-end in contrib/ area.
>>
>> =A0* "git init" learned to mkdir/chdir into a directory when given a=
n
>> =A0 extra argument (i.e. "git init this").
>>
>> =A0* "git instaweb" optionally can use mongoose as the web server.
>>
>> =A0* "git log --decorate" can optionally be told with --decorate=3Df=
ull to
>> =A0 give the reference name in full.
>>
>> =A0* "git merge" issued an unnecessarily scary message when it detec=
ted
>> =A0 that the merge may have to touch the path that the user has loca=
l
>> =A0 uncommitted changes to. The message has been reworded to make it
>> =A0 clear that the command aborted, without doing any harm.
>>
>> =A0* "git push" can be told to be --quiet.
>>
>> =A0* "git push" pays attention to url.$base.pushInsteadOf and uses a=
 URL
>> =A0 that is derived from the URL used for fetching.
>>
>> =A0* informational output from "git reset" that lists the locally mo=
dified
>> =A0 paths is made consistent with that of "git checkout $another_bra=
nch".
>>
>> =A0* "git submodule" learned to give submodule name to scripts run w=
ith
>> =A0 "foreach" subcommand.
>>
>> =A0* various subcommands to "git submodule" learned --recursive opti=
on.
>>
>> =A0* "git submodule summary" learned --files option to compare the w=
ork
>> =A0 tree vs the commit bound at submodule path, instead of comparing
>> =A0 the index.
>>
>> =A0* "git upload-pack", which is the server side support for "git cl=
one" and
>> =A0 "git fetch", can call a new post-upload-pack hook for statistics=
 purposes.
>>
>> (developers)
>>
>> =A0* With GIT_TEST_OPTS=3D"--root=3D/p/a/t/h", tests can be run outs=
ide the
>> =A0 source directory; using tmpfs may give faster turnaround.
>>
>> =A0* With NO_PERL_MAKEMAKER set, DESTDIR=3D is now honoured, so you =
can
>> =A0 build for one location, and install into another location to tar=
 it
>> =A0 up.
>>
>> Fixes since v1.6.4
>> ------------------
>>
>> All of the fixes in v1.6.4.X maintenance series are included in this
>> release, unless otherwise noted.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
