From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: daemon.c fails to build on Darwin
Date: 28 Sep 2006 08:48:36 -0700
Message-ID: <86ejtw3sbv.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 28 17:48:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSy7t-0004Cb-Hq
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 17:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWI1Psi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 11:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWI1Psi
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 11:48:38 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:18561 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964958AbWI1Psh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 11:48:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 512EE8FAB6
	for <git@vger.kernel.org>; Thu, 28 Sep 2006 08:48:37 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 14662-03-8 for <git@vger.kernel.org>;
 Thu, 28 Sep 2006 08:48:36 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C6C708FAB7; Thu, 28 Sep 2006 08:48:36 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.13.12.4; tzolkin = 3 Kan; haab = 17 Chen
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28009>


If this is obvious, can someone fix it?  If not, I'll try to sort it out later
tonight.

    gcc -o daemon.o -c -g -O2 -Wall -I/sw/include -I/opt/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRLCPY daemon.c
    daemon.c: In function 'fill_in_extra_table_entries':
    daemon.c:460: error: 'HOST_NAME_MAX' undeclared (first use in this function)
    daemon.c:460: error: (Each undeclared identifier is reported only once
    daemon.c:460: error: for each function it appears in.)
    daemon.c:460: warning: unused variable 'addrbuf'
    make: *** [daemon.o] Error 1

This is with 2d5b459107cf07bbb307cfb196c2007c497a6dd2.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
