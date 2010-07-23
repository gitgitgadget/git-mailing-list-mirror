From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 18:50:49 -0400
Message-ID: <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<4C49B31F.8000102@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 00:51:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcR5K-0006hF-1p
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 00:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002Ab0GWWvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 18:51:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55570 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757486Ab0GWWvL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 18:51:11 -0400
Received: by wyf19 with SMTP id 19so697482wyf.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 15:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fVFh9HWpnLMwh1pnBIDCQsk4W1ARtA33qPmsI7l8Rc0=;
        b=MdAkwyCosm21OJpza0aN4NF7maYxcDZAxaLoyVhFQyadFJqxchJfr3OM7GMc8y2hlo
         7zcRrl6n94KFA+2YKioSB6NTzSs2bz1fwndtZtQ/OD+4mxKUlYozklg8UPpgFHHMOW5w
         VJ/aMu9VC8Ta+I4vkf89CUecLrdfcLebOjODs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KxrP+LsrEKWKY3fidU7PTerT4z+r8J3PxQaLEXrdeiktkAKgWnTalfVsrVIeVCPJhL
         0Xr7UM5dVK/W83OPeKZfECCysb3/Uh/jVH14CZOOjhhqsN+K2EXfpQY2m0OrVVXQmLvh
         iGWfYiC5sUi60ERZ3T/Ijk1V/pYrRfWSQaHZM=
Received: by 10.216.187.143 with SMTP id y15mr4165580wem.74.1279925469422; 
	Fri, 23 Jul 2010 15:51:09 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Fri, 23 Jul 2010 15:50:49 -0700 (PDT)
In-Reply-To: <4C49B31F.8000102@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151582>

On Fri, Jul 23, 2010 at 11:19 AM, Marc Branchaud <marcnarc@xiplink.com>=
 wrote:
> On 10-07-22 03:41 PM, Avery Pennarun wrote:
>> 1) Sometimes I want to clone only some subdirs of a project
>> 2) Sometimes I don't want the entire history because it's too big.
>> 3) Super huge git repositories start to degrade in performance.
>
> The reason we turned to submodules is precisely to deal with reposito=
ry size.

I believe that's very common.

However, I wonder whether that's actually a good reason for git to
develop better submodules, or actually just a good reason for git to
get better support for handling huge repositories.

My bup project (http://github.com/apenwarr/bup) is all about huge
repositories.  It handles repositories with hundreds of gigabytes, and
trees containing millions of files (entire filesystems), quite nicely.
 Of course, it's not a version control system, so it won't solve your
problems.  It's just evidence that large repositories are actually
quite manageable without changing the fundamentals of git.

> =A0Our code base encompasses the entire FreeBSD tree plus different v=
ersions of
> the Linux kernel, along with various third-party libraries & apps. =A0=
You don't
> need everything to build a given product (a FreeBSD product doesn't u=
se any
> Linux kernels, for example) but because all the products share common=
 code we
> need to be able to branch and tag the common code along with the unco=
mmon code.

Honest question: do you care about the wasted disk space and download
time for these extra files?  Or just the fact that git gets slow when
you have them?

How people answer that question very much affects the way git should
be designed.

> So a straight "git clone" that would need to fetch all of FreeBSD plu=
s 4
> different Linux kernels and check all that out is a major problem, es=
pecially
> for our automated build system (which could definitely be implemented=
 better,
> but still).

To be absolutely pedantic, the four linux kernels likely share most of
their objects and so you're only paying the cost (at least during
fetch) of including it once :)

(If you're actually using git-submodule and each copy of the kernel is
its own module, then it might be cloning the kernel four times
separately, in which case the objects *don't* get shared, so this ends
up being much more expensive than it should be.  That could be fixed
by slightly improving git-submodule to share some objects rather than
rearchitecting it though.)

>=A0In truth it's the checkout that takes the most time by far,
> though commands like git-status also take inconveniently long.

Yeah, git could stand to be optimized a bit here.  And since Windows
stats files about 10x slower than Linux, this problem occurs about 10x
sooner on Windows, which makes using git on Windows (which sadly I
have to do sometimes) extremely painful compared to Linux.

IMHO, the correct answer here is to have an inotify-based daemon prod
at the .git/index automatically when files get updated, so that git
itself doesn't have to stat/readdir through the entire tree in order
to do any of its operations.  (Windows also has something like inotify
that would work.)  If you had this, then git
status/diff/checkout/commit would be just as fast with zillions of
files as with 10 files.  Sooner or later, if nobody implements this, I
promise I'll get around to it since inotify is actually easy to code
for :)

Also note that the only reason submodules are faster here is that
they're ignoring possibly important changes.  Notably, when you do
'git status' from the top level, it won't warn you if you have any
not-yet-committed files in any of your submodules.  Personally, I
consider that to be really important information, but to obtain it
would make 'git status' take just as long as without submodules, so
you wouldn't get any benefit.  (I think nowadays there's a way to get
this recursive status information if you want it, but it'll be slow of
course.)

> We chose git-submodule over git-subtree mainly because git-submodule =
lets us
> selectively checkout different parts of our code. =A0(AFAIK sparse ch=
eckouts
> aren't yet an option.)

=46air enough.  If you could confirm or deny my theory that this is
*entirely* a performance related concern (as opposed to disk space /
download time), that would be helpful.

>=A0We didn't really consider git-subtree because it's
> not an official part of git, and we didn't want to have to teach (and=
 nag)
> all our developers to install and maintain it in addition to keeping =
up with
> git itself.

Arguably, this is a vote for including git-subtree into the core
(which was Bryan's point when he started this thread); it obviously is
being rejected sometimes by git users simply because it's not in the
core, even though it could help them.

Have fun,

Avery
