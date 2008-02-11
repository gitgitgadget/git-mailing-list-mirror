From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: C-compiler features
Date: Mon, 11 Feb 2008 09:03:26 +0100
Message-ID: <20080211090326.2d0c64cd@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 09:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOTe2-00039F-79
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 09:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbYBKIDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 03:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYBKIDd
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 03:03:33 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:2399 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbYBKIDa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 03:03:30 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1B83R2r017927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 11 Feb 2008 09:03:28 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73480>

Having to answer questions about my C-compiler isn't always that easy.
Sometimes you need to find include files, for which you don't know if
and if how they are used. Sometimes you need to compile test programs
to see the behaviour, and then there is threads, 32/64 bitness etc.

I was recently pointed to http://www.math.utah.edu/pub/features/
Which gives a nice summary of what your C/C++ compiler behaves like.
Here's the output for HP C-ANSI-C on HP-UX 11.23/64 IPF and on 11.00

========================================================================
HP-UX 11.23/64 U  rx1620/64 Itanium 2/1600(2) ia64  2037 Mb
B9007AA.C-ANSI-C  C.06.15   HP C/aC++ Compiler


Compiler                             = cc


Available standard predefined constant macros...
        __DATE__                     = "Feb 11 2008"
        __FILE__                     = "features.c"
        __LINE__                     =      180
        __STDC__                     =        1
        __STDC_VERSION__             =   199012
        __TIME__                     = "08:50:58"


Missing standard predefined constant macros...
        __bool_true_false_are_defined
        __cplusplus
        __func__
        __STDC_HOSTED__
        __STDC_IEC_559__
        __STDC_IEC_559_COMPLEX__
        __STDC_ISO_10646__
        __STDC_CONSTANT_MACROS
        __STDC_FORMAT_MACROS
        __STDC_LIMIT_MACROS


Available nonstandard but traditional header files...
        <sys/types.h>
        <varargs.h>


Missing nonstandard but traditional header files...


Available 1989 Standard C header files...
        <assert.h>
        <ctype.h>
        <errno.h>
        <float.h>
        <limits.h>
        <locale.h>
        <math.h>
        <setjmp.h>
        <signal.h>
        <stdarg.h>
        <stddef.h>
        <stdio.h>
        <stdlib.h>
        <string.h>
        <time.h>


Missing 1989 Standard C standard header files...


Available additional 1999 Standard C header files...
        <complex.h>
        <fenv.h>
        <inttypes.h>
        <iso646.h>
        <stdbool.h>
        <stdint.h>
        <tgmath.h>
        <wchar.h>
        <wctype.h>


Missing additional 1999 Standard C standard header files...


Available additional POSIX (IEEE Std 1003.1-2001) header files...
        <aio.h>
        <arpa/inet.h>
        <cpio.h>
        <dirent.h>
        <dlfcn.h>
        <fcntl.h>
        <fmtmsg.h>
        <fnmatch.h>
        <ftw.h>
        <glob.h>
        <grp.h>
        <iconv.h>
        <langinfo.h>
        <libgen.h>
        <monetary.h>
        <mqueue.h>
        <ndbm.h>
        <net/if.h>
        <netdb.h>
        <netinet/in.h>
        <netinet/tcp.h>
        <nl_types.h>
        <poll.h>
        <pthread.h>
        <pwd.h>
        <regex.h>
        <sched.h>
        <search.h>
        <semaphore.h>
        <strings.h>
        <stropts.h>
        <sys/ipc.h>
        <sys/mman.h>
        <sys/msg.h>
        <sys/resource.h>
        <sys/select.h>
        <sys/sem.h>
        <sys/shm.h>
        <sys/socket.h>
        <sys/stat.h>
        <sys/statvfs.h>
        <sys/time.h>
        <sys/timeb.h>
        <sys/times.h>
        <sys/types.h>
        <sys/uio.h>
        <sys/un.h>
        <sys/utsname.h>
        <sys/wait.h>
        <syslog.h>
        <tar.h>
        <termios.h>
        <ucontext.h>
        <ulimit.h>
        <unistd.h>
        <utime.h>
        <utmpx.h>
        <wordexp.h>


Missing additional POSIX (IEEE Std 1003.1-2001) header files...
        <spawn.h>
        <trace.h>


Pointer sizes...
        sizeof(char*)                   =    8
        sizeof(void*)                   =    8
        sizeof(void(*)(void))           =    8


Integer sizes...
        sizeof(char)                    =    1
        sizeof(short)                   =    2
        sizeof(int)                     =    4
        sizeof(long)                    =    8
        sizeof(long long)               =    8


Integer-like sizes...
        sizeof(clock_t)                 =    4
        sizeof(div_t)                   =    8
        sizeof(fpos_t)                  =    8
        sizeof(intmax_t)                =    8
        sizeof(ldiv_t)                  =   16
        sizeof(off_t)                   =    8
        sizeof(ptrdiff_t)               =    8
        sizeof(sig_atomic_t)            =    4
        sizeof(size_t)                  =    8
        sizeof(time_t)                  =    8
        sizeof(uintmax_t)               =    8
        sizeof(wchar_t)                 =    4


C++ 1998 integer-like sizes...


C99 integer-like sizes...
        sizeof(double_t)                =    8
        sizeof(fenv_t)                  =    8
        sizeof(fexcept_t)               =    4
        sizeof(float_t)                 =    4
        sizeof(int8_t)                  =    1
        sizeof(int_fast16_t)            =    4
        sizeof(int_fast32_t)            =    4
        sizeof(int_fast64_t)            =    8
        sizeof(int_fast8_t)             =    4
        sizeof(int_least16_t)           =    2
        sizeof(int_least32_t)           =    4
        sizeof(int_least64_t)           =    8
        sizeof(int_least8_t)            =    1
        sizeof(intptr_t)                =    8
        sizeof(ssize_t)                 =    8
        sizeof(uint_fast16_t)           =    4
        sizeof(uint_fast32_t)           =    4
        sizeof(uint_fast64_t)           =    8
        sizeof(uint_fast8_t)            =    4
        sizeof(uint_least16_t)          =    2
        sizeof(uint_least32_t)          =    4
        sizeof(uint_least64_t)          =    8
        sizeof(uint_least8_t)           =    1
        sizeof(uintptr_t)               =    8
        sizeof(wchar_t)                 =    4
        sizeof(wctype_t)                =    4
        sizeof(wint_t)                  =    4
        sizeof(_Bool)                   =    1


Floating-point sizes...
        sizeof(float)                   =    4
        sizeof(double)                  =    8
        sizeof(long double)             =   16


Missing data types...
        imaxdiv_t
        lldiv_t
        mbstate_t
        nothrow_t
        wctrans_t
        _Complex
        _Imaginary


fpathconf() and pathconf() tests...
        pathconf("/", _PC_NAME_MAX)              =   255
        pathconf("/bin", _PC_NAME_MAX)           =   255
        pathconf("/etc", _PC_NAME_MAX)           =   255
        pathconf("/tmp", _PC_NAME_MAX)           =   255
        pathconf("/usr", _PC_NAME_MAX)           =   255
        pathconf("/var", _PC_NAME_MAX)           =   255
        pathconf("./", _PC_NAME_MAX)             =   255
        fpathconf(fileno(stdin),  _PC_NAME_MAX)  =    -1
        fpathconf(fileno(stdout),  _PC_NAME_MAX) =    -1
        fpathconf(fileno(stderr),  _PC_NAME_MAX) =    -1

        pathconf("/", _PC_PATH_MAX)              =  1023
        pathconf("/bin", _PC_PATH_MAX)           =  1023
        pathconf("/etc", _PC_PATH_MAX)           =  1023
        pathconf("/tmp", _PC_PATH_MAX)           =  1023
        pathconf("/usr", _PC_PATH_MAX)           =  1023
        pathconf("/var", _PC_PATH_MAX)           =  1023
        pathconf("./", _PC_PATH_MAX)             =  1023
        fpathconf(fileno(stdin),  _PC_PATH_MAX)  =    -1
        fpathconf(fileno(stdout),  _PC_PATH_MAX) =    -1
        fpathconf(fileno(stderr),  _PC_PATH_MAX) =    -1

float limits:
        smallest floating-point number: 1.40129846e-45 == 2^(-149)      [IEEE 754 smallest 32-bit subnormal]
        machine epsilon:                1.19209290e-07 == 2^(-23)       [IEEE 754 32-bit conformant]

double limits:
        smallest floating-point number: 4.94065646e-324 == 2^(-1074)    [IEEE 754 smallest 64-bit subnormal]
        machine epsilon:                2.22044605e-16 == 2^(-52)       [IEEE 754 64-bit conformant]

long double limits:
        smallest floating-point number: 0.00000000e+00 == 2^(-16494)    [IEEE 754 smallest 128-bit subnormal]
        machine epsilon:                1.92592994e-34 == 2^(-112)      [IEEE 754 128-bit conformant]
        long double appears to be 128-bit value stored in 128-bit (16-byte) field


FEATURES TESTS COMPLETED

========================================================================
HP-UX 11.00/64 U  A500-7X/64 PA8700/750(2) pa-2.0  2048 Mb
B3901BA.C-ANSI-C  B.11.11.10 HP C/ANSI C Compiler

Compiler                             = cc


Available standard predefined constant macros...
        __bool_true_false_are_defined =        1
        __DATE__                     = "Feb 11 2008"
        __FILE__                     = "features.c"
        __LINE__                     =      180
        __STDC__                     =        1
        __TIME__                     = "09:01:55"


Missing standard predefined constant macros...
        __cplusplus
        __func__
        __STDC_HOSTED__
        __STDC_IEC_559__
        __STDC_IEC_559_COMPLEX__
        __STDC_ISO_10646__
        __STDC_CONSTANT_MACROS
        __STDC_FORMAT_MACROS
        __STDC_LIMIT_MACROS
        __STDC_VERSION__


Available nonstandard but traditional header files...
        <sys/types.h>
        <varargs.h>


Missing nonstandard but traditional header files...


Available 1989 Standard C header files...
        <assert.h>
        <ctype.h>
        <errno.h>
        <float.h>
        <limits.h>
        <locale.h>
        <math.h>
        <setjmp.h>
        <signal.h>
        <stdarg.h>
        <stddef.h>
        <stdio.h>
        <stdlib.h>
        <string.h>
        <time.h>


Missing 1989 Standard C standard header files...


Available additional 1999 Standard C header files...
        <fenv.h>
        <inttypes.h>
        <stdbool.h>
        <wchar.h>


Missing additional 1999 Standard C standard header files...
        <complex.h>
        <iso646.h>
        <stdint.h>
        <tgmath.h>
        <wctype.h>


Available additional POSIX (IEEE Std 1003.1-2001) header files...
        <aio.h>
        <arpa/inet.h>
        <cpio.h>
        <dirent.h>
        <dlfcn.h>
        <fcntl.h>
        <fmtmsg.h>
        <fnmatch.h>
        <ftw.h>
        <glob.h>
        <grp.h>
        <iconv.h>
        <langinfo.h>
        <libgen.h>
        <monetary.h>
        <mqueue.h>
        <ndbm.h>
        <net/if.h>
        <netdb.h>
        <netinet/in.h>
        <netinet/tcp.h>
        <nl_types.h>
        <poll.h>
        <pthread.h>
        <pwd.h>
        <regex.h>
        <sched.h>
        <search.h>
        <semaphore.h>
        <strings.h>
        <stropts.h>
        <sys/ipc.h>
        <sys/mman.h>
        <sys/msg.h>
        <sys/resource.h>
        <sys/sem.h>
        <sys/shm.h>
        <sys/socket.h>
        <sys/stat.h>
        <sys/statvfs.h>
        <sys/time.h>
        <sys/timeb.h>
        <sys/times.h>
        <sys/types.h>
        <sys/uio.h>
        <sys/un.h>
        <sys/utsname.h>
        <sys/wait.h>
        <syslog.h>
        <tar.h>
        <termios.h>
        <ucontext.h>
        <ulimit.h>
        <unistd.h>
        <utime.h>
        <utmpx.h>
        <wordexp.h>


Missing additional POSIX (IEEE Std 1003.1-2001) header files...
        <spawn.h>
        <sys/select.h>
        <trace.h>


Pointer sizes...
        sizeof(char*)                   =    4
        sizeof(void*)                   =    4
        sizeof(void(*)(void))           =    4


Integer sizes...
        sizeof(char)                    =    1
        sizeof(short)                   =    2
        sizeof(int)                     =    4
        sizeof(long)                    =    4
        sizeof(long long)               =    8


Integer-like sizes...
        sizeof(clock_t)                 =    4
        sizeof(div_t)                   =    8
        sizeof(fpos_t)                  =    4
        sizeof(intmax_t)                =    8
        sizeof(ldiv_t)                  =    8
        sizeof(off_t)                   =    4
        sizeof(ptrdiff_t)               =    4
        sizeof(sig_atomic_t)            =    4
        sizeof(size_t)                  =    4
        sizeof(time_t)                  =    4
        sizeof(uintmax_t)               =    8
        sizeof(wchar_t)                 =    4


C++ 1998 integer-like sizes...


C99 integer-like sizes...
        sizeof(double_t)                =    8
        sizeof(fenv_t)                  =    4
        sizeof(fexcept_t)               =    4
        sizeof(float_t)                 =    4
        sizeof(int8_t)                  =    1
        sizeof(int_fast16_t)            =    4
        sizeof(int_fast32_t)            =    4
        sizeof(int_fast64_t)            =    8
        sizeof(int_fast8_t)             =    4
        sizeof(int_least16_t)           =    2
        sizeof(int_least32_t)           =    4
        sizeof(int_least64_t)           =    8
        sizeof(int_least8_t)            =    1
        sizeof(intptr_t)                =    4
        sizeof(ssize_t)                 =    4
        sizeof(uint_fast16_t)           =    4
        sizeof(uint_fast32_t)           =    4
        sizeof(uint_fast64_t)           =    8
        sizeof(uint_fast8_t)            =    4
        sizeof(uint_least16_t)          =    2
        sizeof(uint_least32_t)          =    4
        sizeof(uint_least64_t)          =    8
        sizeof(uint_least8_t)           =    1
        sizeof(uintptr_t)               =    4
        sizeof(wchar_t)                 =    4
        sizeof(wctype_t)                =    4
        sizeof(wint_t)                  =    4
        sizeof(_Bool)                   =    1


Floating-point sizes...
        sizeof(float)                   =    4
        sizeof(double)                  =    8
        sizeof(long double)             =   16


Missing data types...
        imaxdiv_t
        lldiv_t
        mbstate_t
        nothrow_t
        wctrans_t
        _Complex
        _Imaginary


fpathconf() and pathconf() tests...
        pathconf("/", _PC_NAME_MAX)              =   255
        pathconf("/bin", _PC_NAME_MAX)           =   255
        pathconf("/etc", _PC_NAME_MAX)           =   255
        pathconf("/tmp", _PC_NAME_MAX)           =   255
        pathconf("/usr", _PC_NAME_MAX)           =   255
        pathconf("/var", _PC_NAME_MAX)           =   255
        pathconf("./", _PC_NAME_MAX)             =   255
        fpathconf(fileno(stdin),  _PC_NAME_MAX)  =    -1
        fpathconf(fileno(stdout),  _PC_NAME_MAX) =    -1
        fpathconf(fileno(stderr),  _PC_NAME_MAX) =    -1

        pathconf("/", _PC_PATH_MAX)              =  1023
        pathconf("/bin", _PC_PATH_MAX)           =  1023
        pathconf("/etc", _PC_PATH_MAX)           =  1023
        pathconf("/tmp", _PC_PATH_MAX)           =  1023
        pathconf("/usr", _PC_PATH_MAX)           =  1023
        pathconf("/var", _PC_PATH_MAX)           =  1023
        pathconf("./", _PC_PATH_MAX)             =  1023
        fpathconf(fileno(stdin),  _PC_PATH_MAX)  =    -1
        fpathconf(fileno(stdout),  _PC_PATH_MAX) =    -1
        fpathconf(fileno(stderr),  _PC_PATH_MAX) =    -1

float limits:
        smallest floating-point number: 1.40129846e-45 == 2^(-149)      [IEEE 754 smallest 32-bit subnormal]
        machine epsilon:                1.19209290e-07 == 2^(-23)       [IEEE 754 32-bit conformant]

double limits:
        smallest floating-point number: 4.94065646e-324 == 2^(-1074)    [IEEE 754 smallest 64-bit subnormal]
        machine epsilon:                2.22044605e-16 == 2^(-52)       [IEEE 754 64-bit conformant]

long double limits:
        smallest floating-point number: 0.00000000e+00 == 2^(-16494)    [IEEE 754 smallest 128-bit subnormal]
        machine epsilon:                1.92592994e-34 == 2^(-112)      [IEEE 754 128-bit conformant]
        long double appears to be 128-bit value stored in 128-bit (16-byte) field


FEATURES TESTS COMPLETED


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
