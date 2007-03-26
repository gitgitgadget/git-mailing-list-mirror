From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: use of warn (usage.c) conflicts with BSD
Date: Mon, 26 Mar 2007 06:03:50 -0700
Message-ID: <86bqig40nd.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 15:04:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVosB-0006Hp-5f
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 15:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbXCZNDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 09:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbXCZNDw
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 09:03:52 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:24459 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbXCZNDv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 09:03:51 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 4DC151DE4FB; Mon, 26 Mar 2007 06:03:50 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.3.3; tzolkin = 13 Akbal; haab = 16 Cumku
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43151>


I finally tracked down all the (albeit inconsequential) errors I was getting
on both OpenBSD and OSX.  It's the warn() function in usage.c.  There's
warn(3) in BSD-style distros.  It'd take a "great rename" to change it, but if
someone with better C skills than I have could do that, my linker and I would
appreciate it.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
