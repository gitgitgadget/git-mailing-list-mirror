From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Mon, 26 Jul 2010 10:51:38 +0200
Message-ID: <201007261051.41663.jnareb@gmail.com>
References: <4C472B48.8050101@gmail.com> <4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 10:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdJQ0-00074I-FK
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 10:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab0GZIv4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 04:51:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36163 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0GZIvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 04:51:55 -0400
Received: by fxm14 with SMTP id 14so5952577fxm.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Es3NIW9coycYBNjRB/6ofRkaUBSquKIb69dct5jHh4M=;
        b=ZS62kF7qyItym8JZAm/nfy9f5OJFRLEST/UJsxshFjEmVlIFlWtJ9NPm+eXTR7NItK
         Cm6uvpyHrN9W8tb0vGiCjNvrXsDp+kWYWE1fMlG2es+c/HGdvfRTQfiXVlgr3qkUwTBD
         MarYhzb0Qu6NE5kD4qOjh8IZVKjMwDB0ciLUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hbY81L8ABY8VXjH/Cgf4UtAwtnutPiup+0vXM/rq1V5hPCS8AOuecJ4slYeUAp/6yy
         5D5SBg5DyTWdGGfRgjZrZGOIUTs0EeLPoR4vpXo7hEiqTOV5lZ9QskqDeokvDcvUC1fJ
         uRFXcY40In6J9LH8opu23mPXQSAbjS9j9BcqY=
Received: by 10.86.84.6 with SMTP id h6mr1744044fgb.43.1280134313861;
        Mon, 26 Jul 2010 01:51:53 -0700 (PDT)
Received: from [192.168.1.13] (abvc184.neoplus.adsl.tpnet.pl [83.8.200.184])
        by mx.google.com with ESMTPS id r27sm1292833faa.0.2010.07.26.01.51.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 01:51:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151819>

On Sat, 24 Jul 2010 00:50, Avery Pennarun wrote:
> On Fri, Jul 23, 2010 at 11:19 AM, Marc Branchaud <marcnarc@xiplink.co=
m> wrote:
>> On 10-07-22 03:41 PM, Avery Pennarun wrote:
>>> 1) Sometimes I want to clone only some subdirs of a project
>>> 2) Sometimes I don't want the entire history because it's too big.
>>> 3) Super huge git repositories start to degrade in performance.
>>
>> The reason we turned to submodules is precisely to deal with reposit=
ory size.
>=20
> I believe that's very common.
>=20
> However, I wonder whether that's actually a good reason for git to
> develop better submodules, or actually just a good reason for git to
> get better support for handling huge repositories.
>=20
> My bup project (http://github.com/apenwarr/bup) is all about huge
> repositories.  It handles repositories with hundreds of gigabytes, an=
d
> trees containing millions of files (entire filesystems), quite nicely=
=2E
>  Of course, it's not a version control system, so it won't solve your
> problems.  It's just evidence that large repositories are actually
> quite manageable without changing the fundamentals of git.

There is also git-bigfiles project, although it is more about large
[binary] files than large repositories per se (many files, long history=
).

Note that with 'bup' you might not see problems with large repositories
because it does not examine code paths that are slow in large repositor=
ies
(gc, log, path-delimited log).

>> =A0Our code base encompasses the entire FreeBSD tree plus different =
versions of
>> the Linux kernel, along with various third-party libraries & apps. =A0=
You don't
>> need everything to build a given product (a FreeBSD product doesn't =
use any
>> Linux kernels, for example) but because all the products share commo=
n code we
>> need to be able to branch and tag the common code along with the unc=
ommon code.

Sidenote: I have noticed there very important ability of submodules, wh=
ich
git-subtree lacks, or at least doesn't have it directly, namely ability
to tag in submodule separately of tagging superproject as whole (so e.g=
=2E
superproject v1.6.2 includes subproject 'foo' v0.99 which is foo/v0.99
tag in superproject).
=20
>> So a straight "git clone" that would need to fetch all of FreeBSD pl=
us 4
>> different Linux kernels and check all that out is a major problem, e=
specially
>> for our automated build system (which could definitely be implemente=
d better,
>> but still).
>=20
> To be absolutely pedantic, the four linux kernels likely share most o=
f
> their objects and so you're only paying the cost (at least during
> fetch) of including it once :)
>=20
> (If you're actually using git-submodule and each copy of the kernel i=
s
> its own module, then it might be cloning the kernel four times
> separately, in which case the objects *don't* get shared, so this end=
s
> up being much more expensive than it should be.  That could be fixed
> by slightly improving git-submodule to share some objects rather than
> rearchitecting it though.)

This issue is orthogonal to the fact of using submodules, it is a matte=
r
of setting up alternates to share object storage.
=20
>>=A0In truth it's the checkout that takes the most time by far,
>> though commands like git-status also take inconveniently long.
>=20
> Yeah, git could stand to be optimized a bit here.  And since Windows
> stats files about 10x slower than Linux, this problem occurs about 10=
x
> sooner on Windows, which makes using git on Windows (which sadly I
> have to do sometimes) extremely painful compared to Linux.
>=20
> IMHO, the correct answer here is to have an inotify-based daemon prod
> at the .git/index automatically when files get updated, so that git
> itself doesn't have to stat/readdir through the entire tree in order
> to do any of its operations.  (Windows also has something like inotif=
y
> that would work.)  If you had this, then git
> status/diff/checkout/commit would be just as fast with zillions of
> files as with 10 files.  Sooner or later, if nobody implements this, =
I
> promise I'll get around to it since inotify is actually easy to code
> for :)

IIUC the problem is that inotify is not automatically recursive, so
daemon would have to take care of adding inotify trigger to each newly
created subdirectory.

> Also note that the only reason submodules are faster here is that
> they're ignoring possibly important changes.  Notably, when you do
> 'git status' from the top level, it won't warn you if you have any
> not-yet-committed files in any of your submodules.  Personally, I
> consider that to be really important information, but to obtain it
> would make 'git status' take just as long as without submodules, so
> you wouldn't get any benefit.  (I think nowadays there's a way to get
> this recursive status information if you want it, but it'll be slow o=
f
> course.)

Errr... didn't it got improved in recent git?  I think git-status now
includes information about submodules if configured so / unless configu=
red
otherwise.  Isn't it?

>> We chose git-submodule over git-subtree mainly because git-submodule=
 lets us
>> selectively checkout different parts of our code. =A0(AFAIK sparse c=
heckouts
>> aren't yet an option.)

Sparse checkouts are here, IIRC, but they do not solve problem of disk
space (they are still in repository, even if not checked out), and spee=
d
(they still need to be fetched, even if not checked out).

> Fair enough.  If you could confirm or deny my theory that this is
> *entirely* a performance related concern (as opposed to disk space /
> download time), that would be helpful.
>=20
>>=A0We didn't really consider git-subtree because it's
>> not an official part of git, and we didn't want to have to teach (an=
d nag)
>> all our developers to install and maintain it in addition to keeping=
 up with
>> git itself.
>=20
> Arguably, this is a vote for including git-subtree into the core
> (which was Bryan's point when he started this thread); it obviously i=
s
> being rejected sometimes by git users simply because it's not in the
> core, even though it could help them.

Well, patch management interfaces such as StGIT, Guilt and TopGit are
also outside git code (and should be), same with GUI tools such as qgit=
=2E
That shouldn't prevent people from using them ;-)

But I am all for having git-subtree in core: we have git-remote, haven'=
t
we?  Besides git-subtree fits some workflows better than git-submodule
(and vice versa).

--=20
Jakub Narebski
Poland
