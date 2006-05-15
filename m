From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: 1.3.2.gde1d fails to build on OpenBSD
Date: 15 May 2006 07:24:32 -0700
Message-ID: <86psiftlgf.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 15 17:40:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FffAv-0007r9-3K
	for gcvg-git@gmane.org; Mon, 15 May 2006 17:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWEOPj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 11:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWEOPj6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 11:39:58 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:62272 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751494AbWEOPj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 11:39:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 8B4DE8D4F6
	for <git@vger.kernel.org>; Mon, 15 May 2006 08:38:37 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 12451-01-12 for <git@vger.kernel.org>;
 Mon, 15 May 2006 08:38:37 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 212CA8D500; Mon, 15 May 2006 07:24:32 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.13.5.8; tzolkin = 10 Lamat; haab = 1 Zip
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20057>


GIT_VERSION = 1.3.2.gde1d
gcc -o sha1_file.o -c -g -O2 -Wall -I/usr/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRCASESTR sha1_file.c
sha1_file.c:16:20: stdint.h: No such file or directory
gmake: *** [sha1_file.o] Error 1

I think you want

        #include <sys/types.h>

on OpenBSD.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
