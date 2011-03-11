From: Chad Joan <chadjoan@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Fri, 11 Mar 2011 01:09:58 -0500
Message-ID: <AANLkTin1sePpEbzPq5PFnk21BSRSmJf6wi0UhzSsZe7+@mail.gmail.com>
References: <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
 <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
 <20110301194428.GD10082@sigill.intra.peff.net> <AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
 <20110301200805.GA18587@sigill.intra.peff.net> <AANLkTint3PARNNN4cpic8XG6HsM3AAGuX5a+oeXfFNx=@mail.gmail.com>
 <vpqmxlea7w1.fsf@bauges.imag.fr> <AANLkTi=UX7VNH+biFgn0FQawP-ttCjW2D7SMf2n6XB6w@mail.gmail.com>
 <20110301210852.GB21429@sigill.intra.peff.net> <AANLkTi=nFMDHR5WL=TiFmshFkxLMF9N4dNEjqw+r7wyh@mail.gmail.com>
 <20110303151608.GD1074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Computer Druid <computerdruid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 07:10:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxvYP-0001ph-Rg
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 07:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab1CKGKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Mar 2011 01:10:20 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52427 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab1CKGKT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Mar 2011 01:10:19 -0500
Received: by vxi39 with SMTP id 39so2291771vxi.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 22:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=syx/fmDkrjUK0nPpCiwt5j/EXVLa0AGUDor1UfR/Ib8=;
        b=KqUNZd7IuK5/Lf4RAJnprfL89bEC+jIvymSkXlR/uLQBOfSxu52RkA7PO+30dp0VaR
         2Fex6u1u2bYV7tg0o7XSXEXDfKHt9k9Azpoa3DxRlQrAlLQyThsFVgci+4LW5MlCnsRV
         hsShAO5QFMusDFuSJ05nGf5qsikruvjBHvZBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mOPdDc1VacBbYBlesBr91WbUK+abHTY5G77E3sXjN3b7c164Ps/HriXnLWhsPKAhsP
         BuOFhpKUwUhb8fLv4rZSRnKYoU8zjfZJT+lCww/0KZlv+AlPzTNurtuc0B7mFzGsinFM
         ZAo9Hg9p8eQFizkiUj7q/tw8O4xPfmFpQBz68=
Received: by 10.220.122.149 with SMTP id l21mr2284424vcr.270.1299823818180;
 Thu, 10 Mar 2011 22:10:18 -0800 (PST)
Received: by 10.220.98.71 with HTTP; Thu, 10 Mar 2011 22:09:58 -0800 (PST)
In-Reply-To: <20110303151608.GD1074@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168884>

On Thu, Mar 3, 2011 at 10:16 AM, Jeff King <peff@peff.net> wrote:
>
> ...
>
> > diff -crB git-1.7.3.4/dir.c git-1.7.3.4-new/dir.c
>
> Context diff? Eww. There is this awesome tool called "git" that can h=
elp
> you with managing versions of software. :)
>
> -Peff

Yes... though I'm just letting Gentoo compile it for me and I'm not
doing anything serious enough to justify downloading/installing GIT by
hand and next to the one that's already there.  So I just worked from
the tarball that Gentoo uses and added stuff.  Any other day and I'd
be all over that git usage ;)


=A0I did run into more permissions being messed up, so I grepped for
rmdir and replaced /all/ instances of it in git's C code.  I haven't
had anymore trouble so far.  Here's the newer patch:

diff -crB git-1.7.3.4/dir.c git-1.7.3.4-new/dir.c
*** git-1.7.3.4/dir.c	Wed Mar  2 13:00:54 2011
--- git-1.7.3.4-new/dir.c	Thu Mar 10 11:09:32 2011
***************
*** 994,999 ****
--- 994,1022 ----
  	return ret;
  }

+ int rmdir_on_broken_cifs(const char *path)
+ {
+        struct stat sb;
+        if (stat(path, &sb) < 0) {
+                /* Oh well, hopefully if we can't stat it
+                 * it is already gone or we don't have
+                 * permissions to screw it up anyway. */
+                return rmdir(path);
+        }
+        if (rmdir(path) =3D=3D 0) {
+                /* it worked, nothing to restore */
+                return 0;
+        }
+        /* maybe remove this conditional if you can trigger
+         * the problem with other types of errors */
+        if (errno !=3D ENOTEMPTY)
+                return -1;
+        if (chmod(path, sb.st_mode) < 0)
+                warning("we probably just screwed up the permissions o=
f %s",
+                        path);
+        return -1;
+ }
+
  int remove_dir_recursively(struct strbuf *path, int flag)
  {
  	DIR *dir;
***************
*** 1037,1043 ****

  	strbuf_setlen(path, original_len);
  	if (!ret)
! 		ret =3D rmdir(path->buf);
  	return ret;
  }

--- 1060,1066 ----

  	strbuf_setlen(path, original_len);
  	if (!ret)
! 		ret =3D rmdir_on_broken_cifs(path->buf);
  	return ret;
  }

***************
*** 1066,1072 ****
  		slash =3D dirs + (slash - name);
  		do {
  			*slash =3D '\0';
! 		} while (rmdir(dirs) =3D=3D 0 && (slash =3D strrchr(dirs, '/')));
  		free(dirs);
  	}
  	return 0;
--- 1090,1096 ----
  		slash =3D dirs + (slash - name);
  		do {
  			*slash =3D '\0';
! 		} while (rmdir_on_broken_cifs(dirs) =3D=3D 0 && (slash =3D strrchr(=
dirs, '/')));
  		free(dirs);
  	}
  	return 0;
Only in git-1.7.3.4: dir.c~
diff -crB git-1.7.3.4/dir.h git-1.7.3.4-new/dir.h
*** git-1.7.3.4/dir.h	Wed Dec 15 21:52:11 2010
--- git-1.7.3.4-new/dir.h	Thu Mar 10 11:09:13 2011
***************
*** 101,104 ****
--- 101,106 ----
  /* tries to remove the path with empty directories along it, ignores =
ENOENT */
  extern int remove_path(const char *path);

+ extern int rmdir_on_broken_cifs(const char *path);
+
  #endif
diff -crB git-1.7.3.4/entry.c git-1.7.3.4-new/entry.c
*** git-1.7.3.4/entry.c	Wed Dec 15 21:52:11 2010
--- git-1.7.3.4-new/entry.c	Thu Mar 10 11:12:25 2011
***************
*** 68,74 ****
  			die_errno("cannot unlink '%s'", pathbuf);
  	}
  	closedir(dir);
! 	if (rmdir(path))
  		die_errno("cannot rmdir '%s'", path);
  }

--- 68,74 ----
  			die_errno("cannot unlink '%s'", pathbuf);
  	}
  	closedir(dir);
! 	if (rmdir_on_broken_cifs(path))
  		die_errno("cannot rmdir '%s'", path);
  }

diff -crB git-1.7.3.4/pack-refs.c git-1.7.3.4-new/pack-refs.c
*** git-1.7.3.4/pack-refs.c	Wed Dec 15 21:52:11 2010
--- git-1.7.3.4-new/pack-refs.c	Thu Mar 10 12:34:53 2011
***************
*** 2,7 ****
--- 2,8 ----
  #include "refs.h"
  #include "tag.h"
  #include "pack-refs.h"
+ #include "dir.h"

  struct ref_to_prune {
  	struct ref_to_prune *next;
***************
*** 86,92 ****
  		if (q =3D=3D p)
  			break;
  		*q =3D '\0';
! 		if (rmdir(git_path("%s", name)))
  			break;
  	}
  }
--- 87,93 ----
  		if (q =3D=3D p)
  			break;
  		*q =3D '\0';
! 		if (rmdir_on_broken_cifs(git_path("%s", name)))
  			break;
  	}
  }
diff -crB git-1.7.3.4/symlinks.c git-1.7.3.4-new/symlinks.c
*** git-1.7.3.4/symlinks.c	Wed Dec 15 21:52:11 2010
--- git-1.7.3.4-new/symlinks.c	Thu Mar 10 11:24:08 2011
***************
*** 1,4 ****
--- 1,5 ----
  #include "cache.h"
+ #include "dir.h"

  /*
   * Returns the length (on a path component basis) of the longest
***************
*** 255,261 ****
  {
  	while (removal.len > new_len) {
  		removal.path[removal.len] =3D '\0';
! 		if (rmdir(removal.path))
  			break;
  		do {
  			removal.len--;
--- 256,262 ----
  {
  	while (removal.len > new_len) {
  		removal.path[removal.len] =3D '\0';
! 		if (rmdir_on_broken_cifs(removal.path))
  			break;
  		do {
  			removal.len--;
diff -crB git-1.7.3.4/wrapper.c git-1.7.3.4-new/wrapper.c
*** git-1.7.3.4/wrapper.c	Wed Dec 15 21:52:11 2010
--- git-1.7.3.4-new/wrapper.c	Thu Mar 10 11:12:36 2011
***************
*** 2,7 ****
--- 2,8 ----
   * Various trivial helper wrappers around standard functions
   */
  #include "cache.h"
+ #include "dir.h"

  static void try_to_free_builtin(size_t size)
  {
***************
*** 346,352 ****

  int rmdir_or_warn(const char *file)
  {
! 	return warn_if_unremovable("rmdir", file, rmdir(file));
  }

  int remove_or_warn(unsigned int mode, const char *file)
--- 347,353 ----

  int rmdir_or_warn(const char *file)
  {
! 	return warn_if_unremovable("rmdir", file, rmdir_on_broken_cifs(file)=
);
  }

  int remove_or_warn(unsigned int mode, const char *file)
