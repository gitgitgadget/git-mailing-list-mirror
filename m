From: dhruva <dhruvakm@gmail.com>
Subject: Re: git build on msys fails (and fix)
Date: Mon, 1 Dec 2008 16:22:41 +0530
Message-ID: <e3f230850812010252i67d9846cg439b5951485ee7fe@mail.gmail.com>
References: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com> <4933A922.7080300@viscovery.net> <e3f230850812010132g48fcdf2fm46310b601990e51d@mail.gmail.com>
Reply-To: dhruvakm@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Dec 01 11:54:03 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-1516.google.com ([209.85.146.160])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L76Pi-0002iO-Ud
	for gcvm-msysgit@m.gmane.org; Mon, 01 Dec 2008 11:54:03 +0100
Received: by wa-out-1516.google.com with SMTP id k6so388006wah.53
        for <gcvm-msysgit@m.gmane.org>; Mon, 01 Dec 2008 02:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=UQJwUKATN4qqK/ptF6rWixx4uRjdqSzrrkDbiSj2gIw=;
        b=tcroQhASFRvEpFxrDeaVen6YyM599ElcDTo88a+PUDcAYihkgKE8JruO+SgrcAKtit
         Dym/uNBkC4e+2N5ZVIpzdjUcWdVt4Vjd4RxjNaG9rC2HvqTn3BAe4XYPPq0QBtfKLb+Q
         YZByBXVw3H2Cd/xiMrxYJqLavrfj9jTjzeR6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:to:subject
         :cc:in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:references:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=ZX3A+ailIwZLhL3YJ0Y4rAppwUsbWPzHkb+tTpZYs4fLN26n+5Zh9VJd9Wbr8LYWpJ
         CUfbGw7HvdxHL8FUGM2IMEtc+hdIXqLcIJaiUA5xdMuTtyR4RxqoMnkd8/l10WbmPMmR
         Rlz+mf25BRkTlHtfBjSj56hzVaZUdjsZj7o48=
Received: by 10.141.175.5 with SMTP id c5mr493315rvp.22.1228128763829;
        Mon, 01 Dec 2008 02:52:43 -0800 (PST)
Received: by 10.106.212.23 with SMTP id k23gr3190prg.0;
	Mon, 01 Dec 2008 02:52:43 -0800 (PST)
X-Sender: dhruvakm@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.142.108.3 with SMTP id g3mr5699224wfc.29.1228128763412; Mon, 01 Dec 2008 02:52:43 -0800 (PST)
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243]) by mx.google.com with ESMTP id m37si3380737waf.0.2008.12.01.02.52.42; Mon, 01 Dec 2008 02:52:42 -0800 (PST)
Received-SPF: pass (google.com: domain of dhruvakm@gmail.com designates 209.85.198.243 as permitted sender) client-ip=209.85.198.243;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of dhruvakm@gmail.com designates 209.85.198.243 as permitted sender) smtp.mail=dhruvakm@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by rv-out-0708.google.com with SMTP id c5so2479771rvf.28 for <msysgit@googlegroups.com>; Mon, 01 Dec 2008 02:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to :subject:cc:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:references; bh=N49dyFLP4o/zDKsFYJek6fOIoYWKum5Iq+oCHhzO6Q0=; b=t6jJ+tB5aexIJRGBcD74UuaGTppTIj/UN4dFvCNlIH4wHvXwTA67ujyd8FKdLBVc+u KZurxXsO7tvhtcUe4vAaDf4FSPBDW9crkdGruTR6SYuVu/5NnEl8SB+q7whhFhotmmdO 6G++7OIDEsgrI5HdwQTuH2HfvttEIIj1sm7EI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version :content-type:content-transfer-encoding:content-disposition :references; b=OBaRmfXOMdEEYfK9xPGwI1FRjFZ3BM+kyK/YxcbSEOjcSQIE5+jbjSmNE7Dvy42P/F m8m6Hvkjcfh3D1CYc6FIrb50YLXvy3KbU3djAC3NqsXNGPuQwfe0/gVoJYWDPbO66Vd1 UQaC4kuy9Qa5bZAhY0MvWCAPkfmhubPNYh9FA=
Received: by 10.142.90.16 with SMTP id n16mr4467339wfb.133.1228128761596; Mon, 01 Dec 2008 02:52:41 -0800 (PST)
Received: by 10.142.110.21 with HTTP; Mon, 1 Dec 2008 02:52:41 -0800 (PST)
In-Reply-To: <e3f230850812010132g48fcdf2fm46310b601990e51d@mail.gmail.com>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102017>


Hi,

On Mon, Dec 1, 2008 at 3:02 PM, dhruva <dhruvakm@gmail.com> wrote:
> On Mon, Dec 1, 2008 at 2:36 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> dhruva schrieb:
>>> Hello,
>>>  I build git on msys environment regularly. With the recent changes to
>>> add cache preload facility (commit ID:
>>> 671c9b7e315db89081cc69f83a8f405e4aca37bc) brings in dependency on
>>> pthreads. This is not available in the msys distribution which was
>>> part of the git build distro. I installed libpthread for mingw to get
>>> the related headers and libraries. I had to make some minor changes to
>>> libpthread installation. I copied the 'setjmp.h' from my other mingw
>>> installation and had to had edit it to remove some mingw specific
>>> macros.
>>>
>>> @:/e/users/dhruva/stub/repo/git/git
>>> [520]$ diff -u /e/tools/gnu/include/setjmp.h /mingw/include/setjmp.h
>>> --- /e/tools/gnu/include/setjmp.h       Sun Oct  5 04:01:15 2008
>>> +++ /mingw/include/setjmp.h     Sun Nov 30 16:18:00 2008
>>> @@ -36,7 +36,7 @@
>>>   * The function provided by CRTDLL which appears to do the actual work
>>>   * of setjmp.
>>>   */
>>> -_CRTIMP int __cdecl __MINGW_NOTHROW _setjmp (jmp_buf);
>>> +int __cdecl _setjmp (jmp_buf);
>>>
>>>  #define        setjmp(x)       _setjmp(x)
>>>
>>> @@ -44,7 +44,7 @@
>>>   * Return to the last setjmp call and act as if setjmp had returned
>>>   * nVal (which had better be non-zero!).
>>>   */
>>> -_CRTIMP void __cdecl __MINGW_NOTHROW longjmp (jmp_buf, int)
>>> __MINGW_ATTRIB_NORETURN;
>>> +void __cdecl longjmp (jmp_buf, int);
>>>
>>>  #ifdef __cplusplus
>>>  }
>>>
>>> Also,
>>>  had to copy a pthread library with a dfferent name to the standard name:
>>> $cp libpthreadGC2.a libpthread.a
>>>
>>> The build went fine and am using the new binaries.
>>
>> Would you please push your addition to the mob branch of
>> git://repo.or.cz/msysgit.git? The push URL is repo.or.cz:/srv/git/msysgit.git
>>
>> (But notice that some commits are on the mob branch currently that are not
>> in any other branch; hence, you better build on top of them so that they
>> are not lost when you push to mob.)
>>
>> -- Hannes
>>
>
> I am not using git from the above repo. I am using it from:
> git://git2.kernel.org/pub/scm/git/git.git
>
> I will clone from the repo you have mentioned and push my changes,
> that will take some time. I have started the clone now...

I added a new remote to pull changes from the msys repo and it is
taking a long time (bad network). In the meantime for some wanting to
play:

1. I downloaded pthreads for windows from:
ftp://sourceware.org/pub/pthreads-win32/pthreads-w32-2-8-0-release.exe
2. Extracted and copied the headers, libraries to
msysgit/mingw/include and msysgit/mingw/lib folders. I made a copy of
DLL in bin folder too so that runtime can pick it.
3. I copied msysgit/mingw/lib/libpthreadGC2.a as
msysgit/mingw/lib/libpthread.a as -lpthread needs a lib with that name
4. Copied the setjmp.h header referred by pthread.h from my native
mingw installation and modified it (refer my earlier mail). The
modified contents of the new file that needs to go under
msysgit/mingw/include/setjmp.h:

/*
 * setjmp.h
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is a part of the mingw-runtime package.
 * No warranty is given; refer to the file DISCLAIMER within the package.
 *
 * Declarations supporting setjmp and longjump, a method for avoiding
 * the normal function call return sequence. (Bleah!)
 *
 */

#ifndef _SETJMP_H_
#define _SETJMP_H_

/* All the headers include this file. */
#include <_mingw.h>

#ifndef RC_INVOKED

#ifdef __cplusplus
extern "C" {
#endif

/*
 * The buffer used by setjmp to store the information used by longjmp
 * to perform it's evil goto-like work. The size of this buffer was
 * determined through experimentation; it's contents are a mystery.
 * NOTE: This was determined on an i386 (actually a Pentium). The
 *       contents could be different on an Alpha or something else.
 */
#define _JBLEN 16
#define _JBTYPE int
typedef _JBTYPE jmp_buf[_JBLEN];

/*
 * The function provided by CRTDLL which appears to do the actual work
 * of setjmp.
 */
int __cdecl _setjmp (jmp_buf);

#define setjmp(x)       _setjmp(x)

/*
 * Return to the last setjmp call and act as if setjmp had returned
 * nVal (which had better be non-zero!).
 */
void __cdecl longjmp (jmp_buf, int);

#ifdef __cplusplus
}
#endif

#endif  /* Not RC_INVOKED */

#endif  /* Not _SETJMP_H_ */

5. I modified git Makefile as:
diff --git a/Makefile b/Makefile
index 649cfb8..71f995d 100644
--- a/Makefile
+++ b/Makefile
@@ -776,6 +776,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
        NO_PERL_MAKEMAKER = YesPlease
        NO_POSIX_ONLY_PROGRAMS = YesPlease
        NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+       THREADED_DELTA_SEARCH = YesPlease
        COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
-Icompat/regex -Icompat/fnmatch
        COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
        COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"

-dhruva

-- 
Contents reflect my personal views only!
