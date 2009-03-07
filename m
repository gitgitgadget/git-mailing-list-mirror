From: P Baker <me@retrodict.com>
Subject: Re: [GSoC] Google Summer of Code 2009 - new ideas
Date: Sat, 7 Mar 2009 14:59:20 -0500
Message-ID: <526944450903071159v3ddc92c5q9b3239f2aef97ac8@mail.gmail.com>
References: <200903070144.17457.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 21:00:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg2hX-0004DX-0g
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 21:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbZCGT7Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 14:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755192AbZCGT7X
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 14:59:23 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:17497 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbZCGT7W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 14:59:22 -0500
Received: by yx-out-2324.google.com with SMTP id 8so610303yxm.1
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 11:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=8liKKT0NHjUbThoJoFWkg1hL3g0HchUuk/wlKkZ1O/o=;
        b=mIy8Ugr0jkunNIOaHvtcoSgzofIhvvnTDtKnQwYPSh1N++tNzijpz42LAcs5EiPEsV
         aDnjuXs+FlWArfeFhgSCjWZQ4pQ++L8fzoSSUR/TCF0FEZARibecLFqcRbMbergeCnIM
         KTeeeuChRi9jjR6i3vAHDqFUAnw3IrdgugP2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=dFIqJUFsrZgCjMKIdPF/nwUZlwkR0ZXfCzdOMvWp6lea57U1YZFxPZQYXgk7CkXeyx
         VgRmc2DEwY5C67oRTdNIZOi0FudHrsQXBrK3JT4T/Zzw32rU+TVHTheK73lgN2frDutI
         1nTuM2a/XQbFeZErzomKRdhTRnjxpQcy2AolQ=
Received: by 10.220.92.194 with SMTP id s2mr1244116vcm.10.1236455960090; Sat, 
	07 Mar 2009 11:59:20 -0800 (PST)
In-Reply-To: <200903070144.17457.jnareb@gmail.com>
X-Google-Sender-Auth: 332b9a15653d6167
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112570>

I posted to this list serve a few days ago about one of the 2008 SoC
ideas. Are those ideas still plausible? Specifically, I'm interested
in pursuing the git-submodule update. Is this off the drawing board?

P Baker

On 3/6/09, Jakub Narebski <jnareb@gmail.com> wrote:
> Time to submit application as mentoring organization to
>  Google Summer of Code 2009 is close:=C2=A0=C2=A0March 9 -- March 13.
>
>  I'd like to add a few ideas to SoC2009Ideas wiki page, but before I =
do
>  this I'd like to ask for comments.=C2=A0=C2=A0(The proposals also la=
cks proposed
>  mentor).
>
>  I am wondering if it would be worth it to make a separate class betw=
een
>  "New to Git?" easy tasks, and "Larger Projects" hard tasks...
>
>  BTW. some of ideas didn't make it from SoC2008Ideas wiki page to cur=
rent
>  year page, namely:
> =C2=A0=C2=A0* Apply sparse To Fix Errors
> =C2=A0=C2=A0* Lazy clone / remote alternates
> =C2=A0=C2=A0* Implement git-submodule using .gitlink file
> =C2=A0=C2=A0* Teach git-apply the 3-way merge fallback git-am knows
> =C2=A0=C2=A0* Better Emacs integration
>  Was this ommision deliberate or accidental?
>
>
>  -- >8 --
>
>  =3D New To Git? New To Open Source Development? =3D
>
>  =3D=3D Packfile caching for git-daemon =3D=3D
>
>  Even with delta reuse, enumerating objects to be present in packfile
>  generates significant load on server for pack-generating protocols,
>  such as git:// protocol used by git-daemon.=C2=A0=C2=A0Many of reque=
sts result in
>  the same packfile to be generated and sent; examples include full
>  clone, or fetch of all branches since last update.=C2=A0=C2=A0It wou=
ld make sense
>  then to save (cache) packfiles, and if possible avoid regenerating
>  packfiles by sending them from cache.=C2=A0=C2=A0(Possible extension=
 would be to
>  send slightly larger pack than needed if one can reuse cached packfi=
le
>  instead).
>
>  The goal is for git-daemon to cache packfiles, use cached packfiles =
if
>  possible, and to manage packfile cache.=C2=A0=C2=A0Note that one wou=
ld need in
>  the final version some way to specify upper limit on packfile cache
>  size and some cache entry expire policy.
>
>  '''Goal:''' Support for packfile cache in git-daemon,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0benchmark server load
>  '''Language:''' C
>
>  =3D=3D Single credentials =3D=3D
>
>  Currently if you don't save your username and password in plain-text
>  `.netrc` file (for HTTP transport), or avoid need for interactive
>  credentials using public key / private key pair (for SSH), you need =
to
>  repeat credentials many times during single git-fetch or git-clone
>  command.=C2=A0=C2=A0The goal is to reuse existing connections if pos=
sible, so the
>  whole transaction occurs using single connection and single
>  credentials; if that is not possible cache credentials (in secure wa=
y)
>  so user need to provide username and password at most once.
>
>  '''Goal:''' git-fetch and git-clone over HTTPS and git://
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0requiring providing username and password at most once
>  '''Language:''' C (perhaps also shell script)
>
>
>  =3D Larger Projects =3D
>
>  =3D=3D Directory renames =3D=3D
>
>  Git deals quite well with renames when merging.=C2=A0=C2=A0One of th=
e corner cases
>  is when one side renamed some directory, and other side created ''ne=
w
>  files'' in the old-name directory.=C2=A0=C2=A0Git currently creates =
new files in
>  resurrected old-name directory, while it could create new files unde=
r
>  new-name directory instead.
>
>  There is a bit of controversy about this feature, as for example in
>  some programming languages (e.g. Java) or in some project build tool
>  info it is not posible to simply move a file (or create new file in
>  different directory) without changing file contents.=C2=A0=C2=A0Some=
 say that
>  is better to fail than to do wrongly clean merge.
>
>  '''Goal:''' At minimum option enabling wholesame directory rename
>  detection.=C2=A0=C2=A0Preferred to add dealing with directory rename=
s also to
>  merge.=C2=A0=C2=A0At last, one can try to implement "git log --follo=
w" for
>  directories.
>  '''Language:''' C
>  '''See:''' [http://thread.gmane.org/gmane.comp.version-control.git/9=
9529
>  |RFC PATCH v2 0/2| Detection of directory renames] thread on git
>  mailing list (via GMane)
>  '''See also:'''
> =C2=A0=C2=A0*
>  [http://thread.gmane.org/gmane.comp.version-control.git/80912/focus=3D=
81362
>  merge renamed files/directories?] subthread on git mailing list
> =C2=A0=C2=A0* [http://thread.gmane.org/gmane.comp.version-control.git=
/108106
>  Comments on "Understanding Version Control" by Eric S. Raymond] thre=
ad
>  contains some thoughts on wholesame directory rename detection
> =C2=A0=C2=A0* [http://blog.teksol.info/2008/01/16/directory-renames-u=
nder-git
>  Directory renames under Git] blog post notice the issue
> =C2=A0=C2=A0* [http://www.markshuttleworth.com/archives/123 Renaming =
is the killer
>  app of distributed version control] blog post by Mak Shuttleworth
>  (pro-Bazaar).
>
>  --
>  Jakub Narebski
>  Poland
>
> --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-i=
nfo.html
>
