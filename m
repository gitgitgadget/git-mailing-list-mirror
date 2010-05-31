From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Mac OS 9 (Lamp) port
Date: Sun, 30 May 2010 21:35:58 -0700
Message-ID: <2776E3E5-234F-4A94-B06A-F4D83D87A414@gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org> <1274948384-167-2-git-send-email-abcd@gentoo.org> <20100527101043.GA4390@progeny.tock> <AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com> <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com> <20100530003718.GA27024@progeny.tock> <67A778DE-DB7E-40A3-9BE8-4D17F09B847F@gmail.com> <20100531031906.GA465@progeny.tock>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=WINDOWS-1252;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 06:36:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIwjU-0004Zx-Tz
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 06:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab0EaEgF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 00:36:05 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:44187 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab0EaEgD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 00:36:03 -0400
Received: by pzk42 with SMTP id 42so1466178pzk.4
        for <git@vger.kernel.org>; Sun, 30 May 2010 21:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references
         :mime-version:content-type:message-id:cc:content-transfer-encoding
         :from:subject:date:to:x-mailer;
        bh=1lqJdg+1PhJ6hFsBXwjEdirVh2J+vHIR8ZghO5jaWjo=;
        b=JSi3UN4dogHqPYxda/jgPK8+FVCB4He+3o9Zob4csf+btSWcgX7+3zkSDaVIVEx2Zy
         92T5zAKXFlupP7tKecjWqdeGk+gyKdLFeBUI7phCqe+sT/gia77gkQgFwTgXuKMRkO1N
         O2PbTmxw6gh1h0agpqVcap/duNJ57d3pHH5xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc
         :content-transfer-encoding:from:subject:date:to:x-mailer;
        b=tjLjMZoNGHzolyG76Lc3IEPUkIqNzS3rCna7kIVieuzIEoZSrO8sP9zhOM0RzlTjLX
         0nyI2dwxMLPDaDPS3R6dP+uz8BxWGPXHEmAHNbpphngckI0rSed3e0y8SpQgxuPoTYoz
         2rq3s90HFDRVy4FgUi2OnDbMyFYIFQOnX9kj4=
Received: by 10.142.119.6 with SMTP id r6mr2509842wfc.34.1275280561626;
        Sun, 30 May 2010 21:36:01 -0700 (PDT)
Received: from [192.168.1.24] (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id 23sm3736944pzk.6.2010.05.30.21.36.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 21:36:00 -0700 (PDT)
In-Reply-To: <20100531031906.GA465@progeny.tock>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148032>

On May 30, 2010, at 8:19 PM, Jonathan Nieder wrote:

> Joshua Juran wrote:
>
>> http://github.com/jjuran/git.git

Apparently <http://github.com/jjuran/git> works better.

> I assume the lamp-git branch is the interesting one.  Some of

The lamp-git branch is the one you'd checkout to build git.  It =20
merges the interesting ones.

> these patches (e.g., a3b378781) look like they might be of general

$ git show a3b378781
commit a3b378781228d59a13ee055d06c8f5465b543178
Author: Joshua Juran <jjuran@metamage.com>
Date:   Sun Nov 29 03:57:54 2009 -0800

     Avoid pointless use of one-celled array (which also confounds =20
Metrowerks C).

     Pass the address of fetch_refspec_str directly to =20
parse_refspec_internal()
     instead of copying fetch_refspec_str to an array and passing that.

     Metrowerks C won't initialize aggregates with values determined =20
at runtime, and
     we can't use the C++ translator for parse_refspec_internal() =20
because it uses the
     same identifier (refspec) for a variable as an existing struct =20
type.

     That, and there's no purpose to the array in the first place.

diff --git a/remote.c b/remote.c
index c70181c..ade0424 100644
--- a/remote.c
+++ b/remote.c
@@ -657,10 +657,9 @@ static struct refspec *parse_refspec_internal=20
(int nr_refspec, const char **refsp

  int valid_fetch_refspec(const char *fetch_refspec_str)
  {
-       const char *fetch_refspec[] =3D { fetch_refspec_str };
         struct refspec *refspec;

-       refspec =3D parse_refspec_internal(1, fetch_refspec, 1, 1);
+       refspec =3D parse_refspec_internal(1, &fetch_refspec_str, 1, 1)=
;
         free_refspecs(refspec, 1);
         return !!refspec;
  }

Yes, this is the patch I suggested to Gary V. Vaughan.

> interest, while others (e.g., 6e6b106d) reveal Metrowerks to be
> a bit braindead.

$ git show 6e6b106d
commit 6e6b106dd6c561db726f90e2db07beeef1f716f9
Author: Joshua Juran <jjuran@metamage.com>
Date:   Wed Apr 8 01:51:04 2009 -0700

     Cast compare_info() arguments to (const struct pack_info *const *)=
=2E

     Otherwise, Metrowerks C reports "illegal implicit conversion =20
from 'const void *'
     to 'struct pack_info *const *'".

diff --git a/server-info.c b/server-info.c
index 4098ca2..a9a0188 100644
--- a/server-info.c
+++ b/server-info.c
@@ -132,8 +132,8 @@ static int read_pack_info_file(const char *infofile=
)

  static int compare_info(const void *a_, const void *b_)
  {
-       struct pack_info *const *a =3D a_;
-       struct pack_info *const *b =3D b_;
+       const struct pack_info *const *a =3D a_;
+       const struct pack_info *const *b =3D b_;

         if (0 <=3D (*a)->old_num && 0 <=3D (*b)->old_num)
                 /* Keep the order in the original */

I certainly won't defend Metrowerks C 2.4.1, but the patch is =20
harmless enough.

> Have you thought about getting git to compile in C++ mode, where

If the Git maintainers are interested in this, I'm glad to do it.  I =20
expect it to require generally less maintenance than my c++-=20
initializer-fix branch, which is rather ugly to boot.

> Metrowerks might be a little more sane[1]?  Sure, this runs into

Well, I wasn't going to suggest general C++ compatibility just for my =20
port, but if there's interest, then yes, that would obviate my (by =20
far) largest and nastiest patch.

> basically all the major incompatibilities between C and C++[2], but
> that might not be insurmountable:

Writing code which is both valid C and valid C++ is not difficult.

>  . No implicit conversion from void* to other: don=92t use void *,
>    then.  With type-safe interfaces like
>
> #define typed_malloc(size, type) (type *)xmalloc(size)
> #define malloc_many(nmemb, type) typed_malloc((nmemb) * sizeof=20
> (type), type)
>
>    one can take advantage of type checking without the annoyance of
>    casts at the call site.

Replacing xmalloc(size) with typed_malloc(size, struct foo) instead =20
of (struct foo *)xmalloc(size) still feels like a cast to me.  IMHO =20
it adds no safety and reduces readability.

Maybe you could have:

	#define alloc_n(type, n)  ((type*)xmalloc(sizeof (type) * n))

to factor the multiplication out of the calling code.  But for a =20
plain data buffer, nothing is shorter or clearer than a simple =20
(char*) cast.

>    Another place git uses void * is for low-level access to the
>    object database, because it is not obvious whether objects data
>    should use char * or unsigned char *.  unsigned char * should
>    be fine.

If there were a configurable typedef defining this, I'd use char* =20
since the Metrowerks debugger by default displays it as a C string =20
(as opposed to a Pascal string for unsigned char* -- it's a Mac OS =20
convention).  But that's a minor point and not one I'd spend time =20
advocating.

>  . Use of C++ keywords:
>
> #ifdef __cplusplus
> #define template git_template
> #define typename git_typename
> #endif
>
>    It is not like this is an actual C++ program.

My c++initializer-fix patch does this locally in a few places.  I =20
suppose it makes sense to nail them all at once in git-compat-util.h.

>  . Assignment of ints to enums is forbidden: okay, this one is
>    not worth working around.  Does Metrowerks have an option to turn
>    off this piece of C++ insanity?

It's a feature.  :-)  I use enums for type-safety in my C++ POSIX =20
wrapper library.  p7::wait() returns p7::wait_t, and if you try to =20
pass that to p7::exit() (which takes p7::exit_t) you get a compile =20
error (instead of a program that 'works' when the wait status is zero).

(No, I'm not aware of an option to disable this restriction.)

If you want the type-safety, you have to pay for it.  Otherwise, =20
declare variables and parameters as integral types instead.  I don't =20
care one way or the other -- I just want git to work on Lamp, and if =20
there's community interest in C++ compatibility then I can assist =20
with that.

Josh

P.S.  Every patch in my git repository is Signed-off-by: Joshua Juran =20
<jjuran@gmail.com> (or s/gmail/metamage/).
