From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: maybe breakage with latest git-pull and http protocol
Date: 12 Oct 2005 17:53:03 -0700
Message-ID: <867jciz18w.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 13 02:53:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPrLV-0003Pd-BM
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 02:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVJMAxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 20:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVJMAxS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 20:53:18 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:49839 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932466AbVJMAxQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 20:53:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id E773C8F7F6
	for <git@vger.kernel.org>; Wed, 12 Oct 2005 17:53:03 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 29659-03-12 for <git@vger.kernel.org>;
 Wed, 12 Oct 2005 17:53:03 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 80B638F7FC; Wed, 12 Oct 2005 17:53:03 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.12.13; tzolkin = 3 Ben; haab = 11 Yax
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10057>


I updated git to d06b689a933f6d2130f8afdf1ac0ddb83eeb59ab,
then compiled and installed.

When I went to "git-pull" on my cogito archive (which I had edited
to use HTTP instead of RSYNC), I got into trouble.  Unfortunately,
I changed it to rsync to force cogito into a sane state before
I realized that this would be a good bug report. :)

This is perhaps just a heads-up that the recent git-pull might be
broken with respect to http updates.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
