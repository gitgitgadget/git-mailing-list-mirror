From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git tonight
Date: 06 Nov 2005 02:54:59 -0800
Message-ID: <86acgiujuk.fsf@blue.stonehenge.com>
References: <7v3bmayu2r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 11:56:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYiBR-0003TH-1y
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 11:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVKFKzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 05:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVKFKzG
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 05:55:06 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:15445 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932353AbVKFKzE
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 05:55:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 435C58F8BE;
	Sun,  6 Nov 2005 02:55:00 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 31206-01-16; Sun,  6 Nov 2005 02:54:59 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C10E88F8DF; Sun,  6 Nov 2005 02:54:59 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.13.18; tzolkin = 2 Etznab; haab = 16 Zac
In-Reply-To: <7v3bmayu2r.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11204>


http-push.c no longer compiles on OSX:

gcc -o http-push.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>' http-push.c
http-push.c:10:19: error: expat.h: No such file or directory
http-push.c:1113: warning: type defaults to 'int' in declaration of 'XML_Char'
http-push.c:1113: error: parse error before '*' token
http-push.c: In function 'activelock_cdata':
http-push.c:1115: error: 'userData' undeclared (first use in this function)
http-push.c:1115: error: (Each undeclared identifier is reported only once
http-push.c:1115: error: for each function it appears in.)
http-push.c:1116: error: 'len' undeclared (first use in this function)
http-push.c:1117: error: 's' undeclared (first use in this function)
http-push.c: In function 'lock_remote':
http-push.c:1187: error: 'XML_Parser' undeclared (first use in this function)
http-push.c:1187: error: parse error before 'parser'
http-push.c:1188: error: storage size of 'result' isn't known
http-push.c:1276: warning: implicit declaration of function 'XML_SetUserData'
http-push.c:1276: error: 'parser' undeclared (first use in this function)
http-push.c:1277: warning: implicit declaration of function 'XML_SetElementHandler'
http-push.c:1279: warning: implicit declaration of function 'XML_SetCharacterDataHandler'
http-push.c:1280: warning: implicit declaration of function 'XML_Parse'
http-push.c:1282: error: 'XML_STATUS_OK' undeclared (first use in this function)
http-push.c:1283: warning: implicit declaration of function 'XML_ErrorString'
http-push.c:1284: warning: implicit declaration of function 'XML_GetErrorCode'
http-push.c:1284: warning: format '%s' expects type 'char *', but argument 3 has type 'int'
http-push.c:1188: warning: unused variable 'result'
http-push.c: In function 'check_locking':
http-push.c:1353: error: 'XML_Parser' undeclared (first use in this function)
http-push.c:1353: error: parse error before 'parser'
http-push.c:1354: error: storage size of 'result' isn't known
http-push.c:1392: error: 'parser' undeclared (first use in this function)
http-push.c:1397: error: 'XML_STATUS_OK' undeclared (first use in this function)
http-push.c:1399: warning: format '%s' expects type 'char *', but argument 2 has type 'int'
http-push.c:1354: warning: unused variable 'result'


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
