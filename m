From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: 26 Oct 2005 07:11:59 -0700
Message-ID: <86y84gfjv4.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 26 16:17:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUm12-0008DA-3y
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 16:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbVJZOMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 10:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVJZOMW
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 10:12:22 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:5199 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751493AbVJZOMW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 10:12:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 7B7098F703
	for <git@vger.kernel.org>; Wed, 26 Oct 2005 07:12:17 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 25008-02-30 for <git@vger.kernel.org>;
 Wed, 26 Oct 2005 07:12:16 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id F39EC8F744; Wed, 26 Oct 2005 07:12:00 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.13.7; tzolkin = 4 Manik; haab = 5 Zac
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10665>


gcc -o sha1_file.o -c -g -O2 -Wall -I/usr/local/include -L/usr/local/lib -Dstrcasestr=gitstrcasestr -DNO_STRCASESTR=1 -DSHA1_HEADER='<openssl/sha.h>' sha1_file.c
sha1_file.c: In function `move_temp_to_file':
sha1_file.c:1247: error: `ENOTSUP' undeclared (first use in this function)
sha1_file.c:1247: error: (Each undeclared identifier is reported only once
sha1_file.c:1247: error: for each function it appears in.)
gmake: *** [sha1_file.o] Error 1


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
