From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: multiple definitions of _warn ?
Date: 10 Jan 2007 21:47:37 -0800
Message-ID: <86ac0qdshy.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 11 06:47:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4sn4-0006OB-9Y
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 06:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbXAKFro (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 00:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbXAKFro
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 00:47:44 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:3162 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965266AbXAKFro (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 00:47:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 994648D5AE
	for <git@vger.kernel.org>; Wed, 10 Jan 2007 21:47:40 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 24199-01-6 for <git@vger.kernel.org>;
 Wed, 10 Jan 2007 21:47:38 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 1B2C08E440; Wed, 10 Jan 2007 21:47:38 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.13.17.8; tzolkin = 3 Lamat; haab = 1 Muan
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36548>


I'm getting a lot of this on the recent compile on OSX:

  /usr/bin/ld: warning multiple definitions of symbol _warn
  libgit.a(usage.o) definition of _warn in section (__TEXT,__text)
  /usr/lib/gcc/i686-apple-darwin8/4.0.1/../../../libSystem.dylib(err.So) definition of _warn

Is that just expected, or an indication that there's a portability issue,
or something else entirely?
-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
