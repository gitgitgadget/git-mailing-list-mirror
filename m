From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git-pull (or cg-fetch?) with exit status
Date: 30 Oct 2005 05:24:54 -0800
Message-ID: <86fyqjt9w9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 30 14:26:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWDBC-0000t9-Hp
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 14:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVJ3NYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 08:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVJ3NYz
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 08:24:55 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:63578 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750710AbVJ3NYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 08:24:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id A7D598FAF2
	for <git@vger.kernel.org>; Sun, 30 Oct 2005 05:24:54 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 31983-01-7 for <git@vger.kernel.org>;
 Sun, 30 Oct 2005 05:24:54 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 4C2378FAF7; Sun, 30 Oct 2005 05:24:54 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.13.11; tzolkin = 8 Chuen; haab = 9 Zac
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10820>


Other than grep the output of the "pull" commands, I'd like to have a
flag added that will also set an exit status to "successful" if new
things were pulled.  That way, I can automate a "make install"
resulting from a successful new pull, ala:

        git-pull --silent && make install

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
