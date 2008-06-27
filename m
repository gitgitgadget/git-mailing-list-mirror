From: Mircea Bardac <dev@mircea.bardac.net>
Subject: BUG (v1.5.6.1): ./configure missing check for zlib.h
Date: Fri, 27 Jun 2008 13:30:29 +0100
Message-ID: <4864DD65.1080402@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 14:37:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDCM-0003SY-90
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 14:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbYF0MgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 08:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756976AbYF0MgG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 08:36:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:7374 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725AbYF0MgF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 08:36:05 -0400
Received: by nf-out-0910.google.com with SMTP id d3so128423nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 05:36:02 -0700 (PDT)
Received: by 10.210.19.4 with SMTP id 4mr1077460ebs.58.1214570161659;
        Fri, 27 Jun 2008 05:36:01 -0700 (PDT)
Received: from ?192.168.126.97? ( [212.13.49.167])
        by mx.google.com with ESMTPS id u14sm3349143gvf.6.2008.06.27.05.35.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 05:36:00 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86544>

$ ./configure
configure: CHECKS for programs
checking for cc... cc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether cc accepts -g... yes
checking for cc option to accept ANSI C... none needed
checking for gar... no
checking for ar... ar
checking for gtar... no
checking for tar... tar
checking for asciidoc... no
configure: CHECKS for libraries
checking for SHA1_Init in -lcrypto... no
checking for SHA1_Init in -lssl... no
checking for curl_global_init in -lcurl... no
checking for XML_ParserCreate in -lexpat... no
checking for iconv in -lc... yes
checking for deflateBound in -lz... no
checking for socket in -lc... yes
configure: CHECKS for header files
checking how to run the C preprocessor... cc -E
checking for egrep... grep -E
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
configure: CHECKS for typedefs, structures, and compiler characteristics
checking for struct dirent.d_ino... yes
checking for struct dirent.d_type... yes
checking for struct sockaddr_storage... yes
checking for struct addrinfo... yes
checking for getaddrinfo... yes
checking whether formatted IO functions support C99 size specifiers... yes
checking whether system succeeds to read fopen'ed directory... no
checking whether snprintf() and/or vsnprintf() return bogus value... no
configure: CHECKS for library functions
checking for strcasestr... yes
checking for memmem... yes
checking for strlcpy... no
checking for strtoumax... yes
checking for setenv... yes
checking for unsetenv... yes
checking for mkdtemp... yes
configure: CHECKS for site configuration
configure: creating ./config.status
config.status: creating config.mak.autogen

$ make
GIT_VERSION = 1.5.6.1
     * new build flags or prefix
     CC daemon.o
In file included from daemon.c:1:
cache.h:9:18: error: zlib.h: No such file or directory
make: *** [daemon.o] Error 1

(installing zlib1g-dev on Ubuntu 7.10 fixed the problem)

--
Mircea
http://mircea.bardac.net
