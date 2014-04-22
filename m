From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [NOT_A_PATCH] A naive attempt to cross-build
 Linux->mingw64 Git
Date: Tue, 22 Apr 2014 17:36:18 +0400
Message-ID: <20140422133616.GA5079@seldon>
References: <535569e92cbcc_32c48493101f@nysa.notmuch>
 <1398118479-7731-1-git-send-email-marat@slonopotamus.org>
 <5355b0ce562b8_6c39e772f0cb@nysa.notmuch>
 <5355b2807a10c_1d5ab792ecfd@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: msysgit+bncBCE7TAPITACRB5XA3GNAKGQE263VT7Y@googlegroups.com Tue Apr 22 15:36:56 2014
Return-path: <msysgit+bncBCE7TAPITACRB5XA3GNAKGQE263VT7Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f185.google.com ([209.85.220.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB5XA3GNAKGQE263VT7Y@googlegroups.com>)
	id 1WcasZ-0005LM-Oc
	for gcvm-msysgit@m.gmane.org; Tue, 22 Apr 2014 15:36:56 +0200
Received: by mail-vc0-f185.google.com with SMTP id lg15sf488241vcb.2
        for <gcvm-msysgit@m.gmane.org>; Tue, 22 Apr 2014 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=CesRYKC2hx71EcHFcsjFugculIH2x1Kjy/dE2I+sJjU=;
        b=dgI8PaxOZeqZfEpXEXEUT4ttd7cRivGEkKn1KpmSBH8J2XZJpFRyHpL+UuIxLNzOe/
         Ke/EoiheKrWuhbf9hZ5BP31QCRr9qNf8Rz+kcfo/KpQB2QtFJtFtEIRhXwigoKxV000j
         PMDi4QAm9i22uWbJ1OT8ToU3TyFB2XiZNPP1vTmzHDUssf04MREmYK6WpqBhwsHQ6wWT
         MPqdNkxzsuyhtEBdZiaQ0fK/MUS/vC+qBYAgEcHihGYmtlNKsAmHZEHBis6cMRo3jZpR
         tFnebF3iKNZd/z2m1byYYFAkqU8KONumN4vXe8GnucamMcKk7Fe8hzxIoCBVhhZ2owj9
         ketg==
X-Received: by 10.50.29.110 with SMTP id j14mr712151igh.5.1398173814966;
        Tue, 22 Apr 2014 06:36:54 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.66.148 with SMTP id f20ls2175257igt.32.canary; Tue, 22 Apr
 2014 06:36:54 -0700 (PDT)
X-Received: by 10.66.66.109 with SMTP id e13mr21734219pat.1.1398173814307;
        Tue, 22 Apr 2014 06:36:54 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id vc6si1571289pab.2.2014.04.22.06.36.52
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 06:36:52 -0700 (PDT)
Received-SPF: neutral (google.com: 94.242.204.247 is neither permitted nor denied by best guess record for domain of marat@slonopotamus.org) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wcary-0001Kw-3g; Tue, 22 Apr 2014 17:36:18 +0400
In-Reply-To: <5355b2807a10c_1d5ab792ecfd@nysa.notmuch>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 94.242.204.247 is neither permitted nor denied by best guess
 record for domain of marat@slonopotamus.org) smtp.mail=marat@slonopotamus.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246737>

On Mon, Apr 21, 2014 at 07:06:24PM -0500, Felipe Contreras wrote:
> I managed to fix all the errors, some apply to newer mingw, regardless of 32 or
> 64, others are specific to 64-bit. It's all hacky and I haven't checked if it
> runs, but at least it compiles (mostly).

Do you plan to evolve it into something mergeable?

> diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
> index f216a2a..3e4affd 100644
> --- a/compat/nedmalloc/malloc.c.h
> +++ b/compat/nedmalloc/malloc.c.h
> @@ -720,6 +720,7 @@ struct mallinfo {
>    inlining are defined as macros, so these aren't used for them.
>  */
>  
> +#undef FORCEINLINE
>  #ifndef FORCEINLINE
>    #if defined(__GNUC__)
>  #define FORCEINLINE __inline __attribute__ ((always_inline))
> @@ -1352,58 +1353,6 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
>  #ifndef __MINGW32__
>  #pragma intrinsic (_InterlockedCompareExchange)
>  #pragma intrinsic (_InterlockedExchange)
> -#else
> -  /* --[ start GCC compatibility ]----------------------------------------------
> -   * Compatibility <intrin_x86.h> header for GCC -- GCC equivalents of intrinsic
> -   * Microsoft Visual C++ functions. Originally developed for the ReactOS
> -   * (<http://www.reactos.org/>) and TinyKrnl (<http://www.tinykrnl.org/>)
> -   * projects.
> -   *
> -   * Copyright (c) 2006 KJK::Hyperion <hackbunny@reactos.com>
> -   *
> -   * Permission is hereby granted, free of charge, to any person obtaining a
> -   * copy of this software and associated documentation files (the "Software"),
> -   * to deal in the Software without restriction, including without limitation
> -   * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> -   * and/or sell copies of the Software, and to permit persons to whom the
> -   * Software is furnished to do so, subject to the following conditions:
> -   *
> -   * The above copyright notice and this permission notice shall be included in
> -   * all copies or substantial portions of the Software.
> -   *
> -   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> -   * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> -   * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> -   * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> -   * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> -   * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> -   * DEALINGS IN THE SOFTWARE.
> -   */
> -
> -  /*** Atomic operations ***/
> -  #if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) > 40100
> -    #define _ReadWriteBarrier() __sync_synchronize()
> -  #else
> -    static __inline__ __attribute__((always_inline)) long __sync_lock_test_and_set(volatile long * const Target, const long Value)
> -    {
> -      long res;
> -      __asm__ __volatile__("xchg%z0 %2, %0" : "=g" (*(Target)), "=r" (res) : "1" (Value));
> -      return res;
> -    }
> -    static void __inline__ __attribute__((always_inline)) _MemoryBarrier(void)
> -    {
> -      __asm__ __volatile__("" : : : "memory");
> -    }
> -    #define _ReadWriteBarrier() _MemoryBarrier()
> -  #endif
> -  /* BUGBUG: GCC only supports full barriers */
> -  static __inline__ __attribute__((always_inline)) long _InterlockedExchange(volatile long * const Target, const long Value)
> -  {
> -    /* NOTE: __sync_lock_test_and_set would be an acquire barrier, so we force a full barrier */
> -    _ReadWriteBarrier();
> -    return __sync_lock_test_and_set(Target, Value);
> -  }
> -  /* --[ end GCC compatibility ]---------------------------------------------- */
>  #endif
>  #define interlockedcompareexchange _InterlockedCompareExchange
>  #define interlockedexchange _InterlockedExchange

Git doesn't link without this for me, fails to find _InterlockedExchange.

> diff --git a/config.mak.uname b/config.mak.uname
> index efaed94..01acd54 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> -	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
> +	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -Icompat -Icompat/win32

builtin/fast-export.c still failed for me with:

builtin/fast-export.c: At top level:
builtin/fast-export.c:28:15: error: expected identifier before numeric constant
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ERROR;
               ^

ERROR is defined in <mingw>/usr/include/wingdi.h and you dropped -DNOGDI what lead to wingdi.h inclusion,
perhaps you shouldn't.

For the reference: mingw64-runtime-3.1.0, x86_64-w64-mingw32-gcc 4.8.2

P.S. besides CC/LD, I also had to define AR and fix `windres` executable name in `config.mak.uname`.

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
