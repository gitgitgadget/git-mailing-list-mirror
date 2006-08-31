From: Jorma Karvonen <karvjorm@users.sourceforge.net>
Subject: Re: Compiling git-snapshot-20069831
Date: Thu, 31 Aug 2006 17:38:48 +0300
Message-ID: <44F6F478.1070708@users.sourceforge.net>
References: <44F6D016.4050007@users.sourceforge.net> <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: karvjorm@users.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090203010100080008010307"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 16:38:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIngi-0007dm-0e
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 16:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWHaOid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 10:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWHaOid
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 10:38:33 -0400
Received: from smtp1.song.fi ([194.100.2.124]:8547 "EHLO smtp1.song.fi")
	by vger.kernel.org with ESMTP id S932338AbWHaOic (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 10:38:32 -0400
Received: from [192.168.1.34] (dsl-60-2-216-83.maxinetti.fi [83.216.2.60])
	by smtp1.song.fi (Postfix) with ESMTP id 32EE317AFF0;
	Thu, 31 Aug 2006 17:38:29 +0300 (EEST)
User-Agent: Thunderbird 2.0a1 (X11/20060724)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26262>

This is a multi-part message in MIME format.
--------------090203010100080008010307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Johannes Schindelin wrote:
> Hi,
>
> since you do have a recent snapshot, why not try ./configure, as Pasky 
> suggested?
>
> BTW I cannot read Finnish, but it probably says that you do not have curl 
> installed. configure would detect that, and automatically set NO_CURL=1.
>
> Ciao,
> Dscho
>
>
>   
Sorry,

but I have not any git installed and there is no configure file in 
installing directory. It was the first thing I checked after extracting 
the git-snapshot-20060831.bz2 file. The INSTALL file does not mention 
the ./configure command, either.

When I tested 

make NEEDS_LIBICONV=1 NO_CURL=1

the make succeeded but when trying make install I got error messages 
shown in the enclosed file.

Best regards,

Jorma Karvonen
karvjorm (at) users (dot) sourceforge (dot) net



--------------090203010100080008010307
Content-Type: text/plain;
 name="error2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="error2.txt"

make install;

/bin/sh: curl-config: command not found
gcc -o http.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  -DDEFAULT_GIT_TEMPLATE_DIR='"/root/share/git-core/templates/"' -DGIT_USER_AGENT='"git/1.3.GIT"' http.c
In file included from http.c:1:
http.h:6:23: error: curl/curl.h: Tiedostoa tai hakemistoa ei ole (no file or directory)
http.h:7:23: error: curl/easy.h: Tiedostoa tai hakemistoa ei ole (no file or directory)
In file included from http.c:1:
http.h:27: error: syntax error before 'CURLcode'
http.h:27: warning: no semicolon at end of struct or union
http.h:29: error: syntax error before '}' token
http.h:33: error: syntax error before 'CURL'
http.h:33: warning: no semicolon at end of struct or union
http.h:36: error: syntax error before 'curl_result'
http.h:36: warning: type defaults to 'int' in declaration of 'curl_result'
http.h:36: warning: data definition has no type or storage class
http.h:43: error: syntax error before '}' token
http.h:85: error: 'CURL_ERROR_SIZE' undeclared here (not in a function)
http.c:163: error: syntax error before '*' token
http.c:164: warning: return type defaults to 'int'
http.c: In function 'get_curl_handle':
http.c:165: error: 'CURL' undeclared (first use in this function)
http.c:165: error: (Each undeclared identifier is reported only once
http.c:165: error: for each function it appears in.)
http.c:165: error: 'result' undeclared (first use in this function)
http.c:165: warning: implicit declaration of function 'curl_easy_init'
http.c:167: warning: implicit declaration of function 'curl_easy_setopt'
http.c:167: error: 'CURLOPT_SSL_VERIFYPEER' undeclared (first use in this function)
http.c:173: error: 'CURLOPT_SSLCERT' undeclared (first use in this function)
http.c:183: error: 'CURLOPT_CAINFO' undeclared (first use in this function)
http.c:184: error: 'CURLOPT_FAILONERROR' undeclared (first use in this function)
http.c:187: error: 'CURLOPT_LOW_SPEED_LIMIT' undeclared (first use in this function)
http.c:189: error: 'CURLOPT_LOW_SPEED_TIME' undeclared (first use in this function)
http.c:193: error: 'CURLOPT_FOLLOWLOCATION' undeclared (first use in this function)
http.c:196: error: 'CURLOPT_VERBOSE' undeclared (first use in this function)
http.c:198: error: 'CURLOPT_USERAGENT' undeclared (first use in this function)
http.c: In function 'http_init':
http.c:210: warning: implicit declaration of function 'curl_slist_append'
http.c:210: warning: assignment makes pointer from integer without a cast
http.c:211: warning: assignment makes pointer from integer without a cast
http.c: In function 'http_cleanup':
http.c:278: error: dereferencing pointer to incomplete type
http.c:279: warning: implicit declaration of function 'curl_easy_cleanup'
http.c:279: error: dereferencing pointer to incomplete type
http.c:280: error: dereferencing pointer to incomplete type
http.c: In function 'get_active_slot':
http.c:311: error: dereferencing pointer to incomplete type
http.c:312: error: dereferencing pointer to incomplete type
http.c:315: error: dereferencing pointer to incomplete type
http.c:316: error: dereferencing pointer to incomplete type
http.c:317: error: dereferencing pointer to incomplete type
http.c:318: error: dereferencing pointer to incomplete type
http.c:324: error: dereferencing pointer to incomplete type
http.c:325: error: dereferencing pointer to incomplete type
http.c:327: error: dereferencing pointer to incomplete type
http.c:332: error: dereferencing pointer to incomplete type
http.c:334: error: dereferencing pointer to incomplete type
http.c:341: error: dereferencing pointer to incomplete type
http.c:342: error: dereferencing pointer to incomplete type
http.c:343: error: dereferencing pointer to incomplete type
http.c:344: error: dereferencing pointer to incomplete type
http.c:345: error: dereferencing pointer to incomplete type
http.c:346: error: dereferencing pointer to incomplete type
http.c:347: error: dereferencing pointer to incomplete type
http.c:347: error: 'CURLOPT_HTTPHEADER' undeclared (first use in this function)
http.c:348: error: dereferencing pointer to incomplete type
http.c:349: error: dereferencing pointer to incomplete type
http.c:349: error: 'CURLOPT_ERRORBUFFER' undeclared (first use in this function)
http.c: In function 'run_active_slot':
http.c:421: error: dereferencing pointer to incomplete type
http.c:422: error: dereferencing pointer to incomplete type
http.c:422: warning: implicit declaration of function 'curl_easy_perform'
http.c:422: error: dereferencing pointer to incomplete type
http.c: In function 'closedown_active_slot':
http.c:431: error: dereferencing pointer to incomplete type
http.c: In function 'release_active_slot':
http.c:437: error: dereferencing pointer to incomplete type
http.c:438: warning: implicit declaration of function 'curl_multi_remove_handle'
http.c:438: error: 'curlm' undeclared (first use in this function)
http.c:438: error: dereferencing pointer to incomplete type
http.c:439: error: dereferencing pointer to incomplete type
http.c:440: error: dereferencing pointer to incomplete type
http.c:442: warning: implicit declaration of function 'fill_active_slots'
http.c: In function 'finish_active_slot':
http.c:448: warning: implicit declaration of function 'curl_easy_getinfo'
http.c:448: error: dereferencing pointer to incomplete type
http.c:448: error: 'CURLINFO_HTTP_CODE' undeclared (first use in this function)
http.c:448: error: dereferencing pointer to incomplete type
http.c:450: error: dereferencing pointer to incomplete type
http.c:451: error: dereferencing pointer to incomplete type
http.c:454: error: dereferencing pointer to incomplete type
http.c:455: error: dereferencing pointer to incomplete type
http.c:455: error: dereferencing pointer to incomplete type
http.c:456: error: dereferencing pointer to incomplete type
http.c:456: error: dereferencing pointer to incomplete type
http.c:460: error: dereferencing pointer to incomplete type
http.c:461: error: dereferencing pointer to incomplete type
http.c:461: error: dereferencing pointer to incomplete type
http.c: In function 'finish_all_active_slots':
http.c:470: error: dereferencing pointer to incomplete type
http.c:474: error: dereferencing pointer to incomplete type
make: *** [http.o] Error 1

--------------090203010100080008010307--
