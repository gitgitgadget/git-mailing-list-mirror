From: John Kacur <jkacur@rogers.com>
Subject: Make errors
Date: Sun, 08 May 2005 15:35:04 -0400
Message-ID: <1115580904.5536.28.camel@linux.site>
Reply-To: jkacur@rogers.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-IPlIOZI0A0CZ752idQL4"
X-From: git-owner@vger.kernel.org Sun May 08 21:30:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrTw-0002rx-15
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbVEHTgx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVEHTev
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:34:51 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:44476 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262966AbVEHTdq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 15:33:46 -0400
Received: from unknown (HELO ?192.168.1.6?) (jkacur@65.48.213.144 with plain)
  by smtp100.rog.mail.re2.yahoo.com with SMTP; 8 May 2005 19:33:42 -0000
To: git@vger.kernel.org
X-Mailer: Ximian Evolution 1.4.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-IPlIOZI0A0CZ752idQL4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ok, I'm coming late to the git game, and having some build problems.
My machine is amd64 (athlon64), and I fetched both

git-0.7.tar.bz2
cogito-0.9.tar.bz2

They both fail to build in a similar fashion
For example, I did
bunzip2 -c git-0.7.tar.bz2 | tar xvf -
cd git-0.7
export PATH=$PWD:$PATH
make

and it fails here:
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-convert-cache
convert-c
ache.c libgit.a -lz -lssl
convert-cache.c: In function `write_subdirectory':
convert-cache.c:102: warning: field precision is not type int (arg 4)
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-http-pull
http-pull.c l
ibgit.a -lz -lssl -lcurl
http-pull.c:10:23: curl/curl.h: No such file or directory
http-pull.c:11:23: curl/easy.h: No such file or directory
http-pull.c:13: error: parse error before '*' token

Any hints?

Thanks in advance

The entire build output is attached:



--=-IPlIOZI0A0CZ752idQL4
Content-Disposition: attachment; filename=out.txt
Content-Type: text/plain; name=out.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'   -c -o read-cache.o read-cache.c
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'   -c -o sha1_file.o sha1_file.c
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'   -c -o usage.o usage.c
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'   -c -o object.o object.c
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'   -c -o commit.o commit.c
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'   -c -o tree.o tree.c
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'   -c -o blob.o blob.c
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'   -c -o tag.o tag.c
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'   -c -o strbuf.o strbuf.c
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'   -c -o diff.o diff.c
ar rcs libgit.a read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o tag.o strbuf.o diff.o
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-update-cache update-cache.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-diff-files diff-files.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-init-db init-db.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-write-tree write-tree.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-read-tree read-tree.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-commit-tree commit-tree.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-cat-file cat-file.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-fsck-cache fsck-cache.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-checkout-cache checkout-cache.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-diff-tree diff-tree.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-rev-tree rev-tree.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-show-files show-files.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-check-files check-files.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-ls-tree ls-tree.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-merge-base merge-base.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-merge-cache merge-cache.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-unpack-file unpack-file.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-export export.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-diff-cache diff-cache.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-convert-cache convert-cache.c libgit.a -lz -lssl
convert-cache.c: In function `write_subdirectory':
convert-cache.c:102: warning: field precision is not type int (arg 4)
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-http-pull http-pull.c libgit.a -lz -lssl -lcurl
http-pull.c:10:23: curl/curl.h: No such file or directory
http-pull.c:11:23: curl/easy.h: No such file or directory
http-pull.c:13: error: parse error before '*' token
http-pull.c:13: warning: type defaults to `int' in declaration of `curl'
http-pull.c:13: warning: data definition has no type or storage class
http-pull.c: In function `fetch':
http-pull.c:73: warning: implicit declaration of function `curl_easy_setopt'
http-pull.c:73: error: `CURLOPT_FILE' undeclared (first use in this function)
http-pull.c:73: error: (Each undeclared identifier is reported only once
http-pull.c:73: error: for each function it appears in.)
http-pull.c:74: error: `CURLOPT_WRITEFUNCTION' undeclared (first use in this function)
http-pull.c:86: error: `CURLOPT_URL' undeclared (first use in this function)
http-pull.c:90: warning: implicit declaration of function `curl_easy_perform'
http-pull.c: In function `main':
http-pull.c:191: warning: implicit declaration of function `curl_global_init'
http-pull.c:191: error: `CURL_GLOBAL_ALL' undeclared (first use in this function)
http-pull.c:193: warning: implicit declaration of function `curl_easy_init'
http-pull.c:193: warning: assignment makes pointer from integer without a cast
http-pull.c:202: warning: implicit declaration of function `curl_global_cleanup'
make: *** [git-http-pull] Error 1

--=-IPlIOZI0A0CZ752idQL4--

