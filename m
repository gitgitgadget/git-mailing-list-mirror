From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: openbsd version?
Date: 10 Oct 2005 09:12:34 -0700
Message-ID: <8664s5gxl9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 10 18:16:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP0Gl-0004hI-6K
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 18:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVJJQMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 12:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVJJQMs
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 12:12:48 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:3181 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750847AbVJJQMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 12:12:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 5BB758F69C
	for <git@vger.kernel.org>; Mon, 10 Oct 2005 09:12:35 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 00779-01-2 for <git@vger.kernel.org>;
 Mon, 10 Oct 2005 09:12:34 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id DE0958F6A0; Mon, 10 Oct 2005 09:12:34 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.12.11; tzolkin = 1 Chuen; haab = 9 Yax
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9894>


I noticed "openbsd" in the operating systems detected in Makefile,
but when I tried this on my openbsd system, I get an abort here:

    gcc -g -O2 -Wall -I/usr/local/include -L/usr/local/lib '-DSHA1_HEADER=<openssl/sha.h>' -o git-mailinfo mailinfo.o libgit.a  -liconv
    mailinfo.o(.text+0x22d): In function `slurp_attr':
    /opt/git/src/git-snapshot-20051010/mailinfo.c:130: undefined reference to `strcasestr'
    mailinfo.o(.text+0x2a9): In function `handle_subcontent_type':
    /opt/git/src/git-snapshot-20051010/mailinfo.c:155: undefined reference to `strcasestr'
    mailinfo.o(.text+0x39d): In function `handle_content_transfer_encoding':
    /opt/git/src/git-snapshot-20051010/mailinfo.c:181: undefined reference to `strcasestr'
    mailinfo.o(.text+0x3c6):/opt/git/src/git-snapshot-20051010/mailinfo.c:183: undefined reference to `strcasestr'
    collect2: ld returned 1 exit status
    gmake: *** [git-mailinfo] Error 1

What am I doing wrong?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
