From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: sprintf security holes?
Date: 16 Sep 2005 07:56:05 -0700
Message-ID: <86zmqd5aey.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 16 16:56:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGHe2-00079f-DM
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 16:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbVIPO4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 10:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbVIPO4o
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 10:56:44 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:32554 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932663AbVIPO4o
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 10:56:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 06CF48F596
	for <git@vger.kernel.org>; Fri, 16 Sep 2005 07:56:32 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 05626-01 for <git@vger.kernel.org>;
 Fri, 16 Sep 2005 07:56:06 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 310BE8F562; Fri, 16 Sep 2005 07:56:06 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.11.7; tzolkin = 3 Manik; haab = 5 Chen
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8686>


As I was trying to (unsuccessfully) compile git for OpenBSD, I noticed
a number of occurances of sprintf(), because OpenBSD thoughtfully
yells at programmers for using that.

Since sprintf() can lead to buffer overflows from unprotected user
data, and you want to use git in server situtations, wouldn't it be
prudent to eliminate those in some near-ish timeframe?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
