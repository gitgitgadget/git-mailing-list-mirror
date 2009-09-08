From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Add more instructions about how to install git.
Date: Tue, 8 Sep 2009 10:52:46 -0400
Message-ID: <a4c8a6d00909080752p5b663fc8r8bf1c60023ef39b4@mail.gmail.com>
References: <1252386686-15689-1-git-send-email-tfransosi@gmail.com>
	 <81b0412b0909072244k21a4ddf6vdc38d9f713a4a084@mail.gmail.com>
	 <vpqhbvekldk.fsf@bauges.imag.fr>
	 <a4c8a6d00909080724q1c792f6bs641ea9d000d08b5a@mail.gmail.com>
	 <4AA66C54.4060101@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 16:52:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml23z-0002WW-Uj
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 16:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbZIHOwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 10:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbZIHOwq
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 10:52:46 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:37558 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbZIHOwp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 10:52:45 -0400
Received: by an-out-0708.google.com with SMTP id d40so9129991and.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wytd99XGX1YQOc2PaaOST8wownsMXymMTuQqAknH5aI=;
        b=bXC+RAMw4GW48tlsPRDbF8ZHrQxT2Ed+ARtXo3yiSJC0/oOCC8HtBTNmKKxyVKgVlL
         K1OiEurCuQc7UW4nGEPBj87mT1fHJGLjKX6luDEa53gJueKlJzYasEq8MFT5fVXvGz+A
         kEaYHL+A7v5qA2RQ4f315RnqulDTEZ0SuebwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N4iLWKC1rAPATNFI5fwVvLKDsNITBhgi1Mo3jX2iRYfn2QRHzL/45wWV1bpLHHycoZ
         WVdMy49V68BMkJr1N5W//duynC+YJZSXjuauYEh4w3aLiOfccMo2ym9juSYyb4cxUq7/
         VDaA10MugukOgZo9091MUKjz06Hp43CrwBRM0=
Received: by 10.101.75.20 with SMTP id c20mr16969470anl.42.1252421566945; Tue, 
	08 Sep 2009 07:52:46 -0700 (PDT)
In-Reply-To: <4AA66C54.4060101@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128011>

On Tue, Sep 8, 2009 at 10:38 AM, Johannes Sixt<j.sixt@viscovery.net> wr=
ote:
> Thiago Farina schrieb:
>> I tried to being more explicit about what the new users has to do. T=
he
>> first instruction that the text says is: "Normaly you can just do
>> "make"".
>> But the new user, cloning git won't have a configure file, so he can=
't
>> just do "make".
>>
>> And then, the text says: "so you can write instead". This brings me =
to
>> one alternative (not what I really should do), when in fact it shoul=
d
>> be (I guess) the first instructions that new users need to follow.
>
> Then guessed wrong. You really only have to say "make". The use of
> autoconf and ./configure is purely optional and not necessary.
I don't think so.
Running only "make".
$ make
GIT_VERSION =3D 1.6.5.rc0
    * new build flags or prefix
    CC fast-import.o
In file included from builtin.h:4,
                 from fast-import.c:143:
git-compat-util.h:129:25: error: openssl/ssl.h: No such file or directo=
ry
git-compat-util.h:130:25: error: openssl/err.h: No such file or directo=
ry
In file included from builtin.h:6,
                 from fast-import.c:143:
cache.h:8:21: error: openssl/sha.h: No such file or directory
In file included from fast-import.c:152:
csum-file.h:10: error: expected specifier-qualifier-list before =91SHA_=
CTX=92
fast-import.c: In function =91create_index=92:
fast-import.c:850: error: =91SHA_CTX=92 undeclared (first use in this f=
unction)
fast-import.c:850: error: (Each undeclared identifier is reported only =
once
fast-import.c:850: error: for each function it appears in.)
fast-import.c:850: error: expected =91;=92 before =91ctx=92
fast-import.c:886: warning: implicit declaration of function =91SHA1_In=
it=92
fast-import.c:886: error: =91ctx=92 undeclared (first use in this funct=
ion)
fast-import.c:891: warning: implicit declaration of function =91SHA1_Up=
date=92
fast-import.c:896: warning: implicit declaration of function =91SHA1_Fi=
nal=92
fast-import.c: In function =91store_object=92:
fast-import.c:1035: error: =91SHA_CTX=92 undeclared (first use in this =
function)
fast-import.c:1035: error: expected =91;=92 before =91c=92
fast-import.c:1040: error: =91c=92 undeclared (first use in this functi=
on)
fast-import.c: In function =91validate_raw_date=92:
fast-import.c:1750: warning: ignoring return value of =91strtoul=92,
declared with attribute warn_unused_result
fast-import.c:1758: warning: ignoring return value of =91strtoul=92,
declared with attribute warn_unused_result
make: *** [fast-import.o] Error 1

Running configure and then make
$ make configure
GIT_VERSION =3D 1.6.5.rc0.dirty
    GEN configure
$ make
    CC fast-import.o
In file included from builtin.h:4,
                 from fast-import.c:143:
git-compat-util.h:129:25: error: openssl/ssl.h: No such file or directo=
ry
git-compat-util.h:130:25: error: openssl/err.h: No such file or directo=
ry
In file included from builtin.h:6,
                 from fast-import.c:143:
cache.h:8:21: error: openssl/sha.h: No such file or directory
In file included from fast-import.c:152:
csum-file.h:10: error: expected specifier-qualifier-list before =91SHA_=
CTX=92
fast-import.c: In function =91create_index=92:
fast-import.c:850: error: =91SHA_CTX=92 undeclared (first use in this f=
unction)
fast-import.c:850: error: (Each undeclared identifier is reported only =
once
fast-import.c:850: error: for each function it appears in.)
fast-import.c:850: error: expected =91;=92 before =91ctx=92
fast-import.c:886: warning: implicit declaration of function =91SHA1_In=
it=92
fast-import.c:886: error: =91ctx=92 undeclared (first use in this funct=
ion)
fast-import.c:891: warning: implicit declaration of function =91SHA1_Up=
date=92
fast-import.c:896: warning: implicit declaration of function =91SHA1_Fi=
nal=92
fast-import.c: In function =91store_object=92:
fast-import.c:1035: error: =91SHA_CTX=92 undeclared (first use in this =
function)
fast-import.c:1035: error: expected =91;=92 before =91c=92
fast-import.c:1040: error: =91c=92 undeclared (first use in this functi=
on)
fast-import.c: In function =91validate_raw_date=92:
fast-import.c:1750: warning: ignoring return value of =91strtoul=92,
declared with attribute warn_unused_result
fast-import.c:1758: warning: ignoring return value of =91strtoul=92,
declared with attribute warn_unused_result
make: *** [fast-import.o] Error 1

Now autconf, ./configure, make.
$ autoconf
$ ./configure
configure: Setting lib to 'lib' (the default)
configure: Will try -pthread then -lpthread to enable POSIX Threads.
configure: CHECKS for site configuration
configure: CHECKS for programs
checking for cc... cc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether cc accepts -g... yes
checking for cc option to accept ISO C89... none needed
checking if linker supports -R... no
checking if linker supports -Wl,-rpath,... yes
checking for gar... no
checking for ar... ar
checking for gtar... no
checking for tar... tar
checking for asciidoc... asciidoc
checking for asciidoc version... asciidoc 8.2.7 > 7
configure: CHECKS for libraries
checking for SHA1_Init in -lcrypto... no
checking for SHA1_Init in -lssl... no
checking for curl_global_init in -lcurl... yes
checking for XML_ParserCreate in -lexpat... yes
checking for iconv in -lc... yes
checking for deflateBound in -lz... yes
checking for socket in -lc... yes
checking for hstrerror in -lc... yes
checking for basename in -lc... yes
configure: CHECKS for header files
checking how to run the C preprocessor... cc -E
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking sys/select.h usability... yes
checking sys/select.h presence... yes
checking for sys/select.h... yes
checking for old iconv()... no
configure: CHECKS for typedefs, structures, and compiler characteristic=
s
checking for struct dirent.d_ino... yes
checking for struct dirent.d_type... yes
checking for struct sockaddr_storage... yes
checking for struct addrinfo... yes
checking for getaddrinfo... yes
checking for library containing getaddrinfo... none required
checking whether formatted IO functions support C99 size specifiers... =
yes
checking whether system succeeds to read fopen'ed directory... no
checking whether snprintf() and/or vsnprintf() return bogus value... no
configure: CHECKS for library functions
checking libgen.h usability... yes
checking libgen.h presence... yes
checking for libgen.h... yes
checking for strcasestr... yes
checking for library containing strcasestr... none required
checking for memmem... yes
checking for library containing memmem... none required
checking for strlcpy... no
checking for uintmax_t... yes
checking for strtoumax... yes
checking for library containing strtoumax... none required
checking for setenv... yes
checking for library containing setenv... none required
checking for unsetenv... yes
checking for library containing unsetenv... none required
checking for mkdtemp... yes
checking for library containing mkdtemp... none required
checking for mkstemps... no
checking Checking for POSIX Threads with '-pthread'... yes
configure: creating ./config.status
config.status: error: cannot find input file: config.mak.in
$ make

Now it compiles everything.
