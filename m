From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: [BUG] cg-mkpatch uses non-portable "tac" command
Date: 21 Nov 2005 08:10:08 -0800
Message-ID: <86r79ayobj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 21 17:15:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeEFI-0002os-9m
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 17:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVKUQKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 11:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVKUQKP
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 11:10:15 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:60995 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932347AbVKUQKN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 11:10:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 147BE8F31D
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 08:10:09 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 09195-02-61 for <git@vger.kernel.org>;
 Mon, 21 Nov 2005 08:10:08 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 9BFC28F31F; Mon, 21 Nov 2005 08:10:08 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.14.13; tzolkin = 4 Ben; haab = 11 Ceh
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12452>


cg-mkpatch uses "tac" to reverse some lines.  This is not a POSIX command.

Since you already presume Perl, you can replace the use of tac with:

        | perl -e 'print reverse <>' |

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
