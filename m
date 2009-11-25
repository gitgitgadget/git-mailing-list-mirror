From: "Stephan T." <stman937-lingit@yahoo.com>
Subject: Please help with GIT install problem.
Date: Wed, 25 Nov 2009 14:07:54 -0800 (PST)
Message-ID: <377205.65475.qm@web30806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 23:08:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQ1n-00072Z-Uh
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758957AbZKYWHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758920AbZKYWHs
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:07:48 -0500
Received: from web30806.mail.mud.yahoo.com ([68.142.200.149]:22601 "HELO
	web30806.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758905AbZKYWHs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 17:07:48 -0500
Received: (qmail 65919 invoked by uid 60001); 25 Nov 2009 22:07:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1259186874; bh=d6qhH/q86qksifbUINka6Y7xaTVTIh78v+VzBBEhq9A=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=Icl+HvRj27f3liII9tZhvzUbwAAoXuHRzZ+xLPkGufZLHoNq4rMxHXKZ/zZKRq0EGVqonEM7XuXAULMaZwohDqbOXIyLtDRcoZqB1chqiE7gp/2LHiqR0WhBtCFAaS97mpv+gmPkvWG+fCWdW3m6gBsr8XpBupH0Plj7QFlmiTI=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=B+j7oezsn7gfOBpuGMaVrqEu+EUXo5tuf8Dd9bW/e3w0epAahApFUscCxM0Rd75pMMwaQhCmG7MUAWj5cZ/5FJgqDCStDigZr1CaB8aJsB8+0n7vINjVNUj9pq8AIGn9trj7yhsR3jzolB7QTn53U+6DkltgrQLy7Goi2a+N8CQ=;
X-YMail-OSG: 9QBHhngVM1mMtoSv9UQcMlr7PDkqDNeSnDsnXp3ShM256wND4r57ml4NS54lmCkcc6m8S3i8P8aK8KW1Hq2g4kAk1qs8k0Pq5szXL8fSr7kEpYZWeMFd.JGotM0dIx1c_.lnbEK09RU6zX9hcYtB3HmjGi2d9bqwADdsGaEq6PvjT0fZerJAMKpQfd2j_nWGMnCLG6hi5gqUfzilPmX9B3BScsp68InvvjHjXgVrvN73ZHAV5DjkQtxOcHC2rfW4LMpm7IpLOWjD8UAO0vxXPER4SDiOdvWpH8UXVL58wsMGOmJcxuPEzt_dWg--
Received: from [209.172.102.66] by web30806.mail.mud.yahoo.com via HTTP; Wed, 25 Nov 2009 14:07:54 PST
X-Mailer: YahooMailRC/211.6 YahooMailWebService/0.8.100.260964
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133680>

Hello there,

My system is a:
% uname -a
Linux naboo 2.4.21-50.ELsmp #1 SMP Tue May 8 17:18:29 EDT 2007 i686 i686 i386 GNU/Linux

Trying to install "git-1.6.5.3".  Configure goes happily to the end but make gives me the following error:

> make
    CC fast-import.o
In file included from /usr/include/openssl/ssl.h:179,
                 from git-compat-util.h:138,
                 from builtin.h:4,
                 from fast-import.c:143:
/usr/include/openssl/kssl.h:72:18: krb5.h: No such file or directory
In file included from /usr/include/openssl/ssl.h:179,
                 from git-compat-util.h:138,
                 from builtin.h:4,
                 from fast-import.c:143:
/usr/include/openssl/kssl.h:134: syntax error before "krb5_enctype"


What is missing on my system?

Thanks for your help,
Stephan.
