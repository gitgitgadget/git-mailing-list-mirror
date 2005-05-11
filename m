From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: GIT compile error on Sun Sparc SB2000
Date: Wed, 11 May 2005 11:41:27 +0400
Message-ID: <200505111141.27725.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 11 09:34:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVljY-0005uP-W5
	for gcvg-git@gmane.org; Wed, 11 May 2005 09:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVEKHlm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 03:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVEKHlm
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 03:41:42 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:2498 "HELO
	penza-gsm.ru") by vger.kernel.org with SMTP id S261917AbVEKHlb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 03:41:31 -0400
Received: (qmail 19110 invoked from network); 11 May 2005 07:41:29 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 11 May 2005 07:41:28 -0000
To: Git Mailing List <git@vger.kernel.org>
User-Agent: KMail/1.7.2
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello. GIT refuses to compile on Debian sarge on sparc64.
Probably some compile flag is incompartible but can't figure out which.
=============================
webmaster@www:/tmp/cogito-0.10$ make
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o read-cache.o 
read-cache.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o sha1_file.o 
sha1_file.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o usage.o usage.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o object.o object.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o commit.o commit.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o tree.o tree.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o blob.o blob.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o tag.o tag.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o date.o date.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o strbuf.o strbuf.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o diff.o diff.c
ar rcs libgit.a read-cache.o sha1_file.o usage.o object.o commit.o tree.o 
blob.o tag.o date.o strbuf.o diff.o
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-update-cache 
update-cache.c libgit.a -lz -lssl
/usr/bin/ld: skipping 
incompatible /usr/lib/gcc-lib/sparc-linux/3.3.3/../../../libz.so when 
searching for -lz
/usr/bin/ld: skipping 
incompatible /usr/lib/gcc-lib/sparc-linux/3.3.3/../../../libz.a when 
searching for -lz
/usr/bin/ld: skipping incompatible /usr/bin/../lib/libz.so when searching for 
-lz
/usr/bin/ld: skipping incompatible /usr/bin/../lib/libz.a when searching for 
-lz
/usr/bin/ld: skipping incompatible /usr/lib/libz.so when searching for -lz
/usr/bin/ld: skipping incompatible /usr/lib/libz.a when searching for -lz
/usr/bin/ld: cannot find -lz
collect2: ld returned 1 exit status
make: *** [git-update-cache] Error 1
webmaster@www:/tmp/cogito-0.10$ 
-- 
Respectfully
Alexey Nezhdanov

