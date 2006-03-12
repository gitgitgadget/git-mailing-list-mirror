From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] imap-send.c fails to build on OSX
Date: 12 Mar 2006 11:08:16 -0800
Message-ID: <86k6azjxb3.fsf@blue.stonehenge.com>
References: <863bhnlo3r.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 12 20:17:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIVve-00036H-7n
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 20:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWCLTIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 14:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWCLTIW
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 14:08:22 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:53912 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750932AbWCLTIW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 14:08:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 6758D8F72A
	for <git@vger.kernel.org>; Sun, 12 Mar 2006 11:08:17 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 22799-01 for <git@vger.kernel.org>;
 Sun, 12 Mar 2006 11:08:16 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id A7A5A8F72E; Sun, 12 Mar 2006 11:08:16 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.13.2.4; tzolkin = 11 Kan; haab = 2 Cumku
In-Reply-To: <863bhnlo3r.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17523>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal>     gcc -o imap-send.o -c -g -O2 -Wall -I/sw/include -I/opt/local/include -DSHA1_HEADER='<openssl/sha.h>'  imap-send.c
Randal>     imap-send.c:376: error: static declaration of 'vasprintf' follows non-static declaration
Randal>     /usr/include/stdio.h:297: error: previous declaration of 'vasprintf' was here
Randal>     make: *** [imap-send.o] Error 1

By the way, /usr/include/stdio.h near the line in question looks like:

int      vasprintf(char **, const char *, va_list) __DARWIN_LDBL_COMPAT(vasprintf);

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
