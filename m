From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git/Documentation/Makefile - "install" doesn't depend on "all"
Date: 21 Sep 2005 10:12:36 -0700
Message-ID: <868xxq73az.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 21 19:16:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI89i-0005Nh-Gy
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 19:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVIURMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 13:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVIURMn
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 13:12:43 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:63166 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751261AbVIURMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 13:12:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id A3C088F70C
	for <git@vger.kernel.org>; Wed, 21 Sep 2005 10:12:36 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 00110-02-5 for <git@vger.kernel.org>;
 Wed, 21 Sep 2005 10:12:36 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 45DAB8F716; Wed, 21 Sep 2005 10:12:36 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.11.12; tzolkin = 8 Eb; haab = 10 Chen
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9065>


I traditionally simply say "make install" to a Makefile, which should
always have the installed components depend on their sources.

For the past few days, apparently I've been doing nothing but the final
"install" command, even though the sources have been changed.

On a whim, I typed "make all install", and there ya go, everything got
made.

So, apparently, the manpages don't properly depend on the sources,
or "install" doesn't properly depend on "all", or both.

Therefore, broken.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
