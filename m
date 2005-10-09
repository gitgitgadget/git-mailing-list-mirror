From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: no "uname -o" on Mac OSX
Date: 09 Oct 2005 03:39:40 -0700
Message-ID: <86k6gnm0sz.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 09 12:41:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOYbY-0005PA-Dg
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 12:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVJIKjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Oct 2005 06:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVJIKjz
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Oct 2005 06:39:55 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:5219 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932253AbVJIKjy
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Oct 2005 06:39:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id DB7BB8F78B
	for <git@vger.kernel.org>; Sun,  9 Oct 2005 03:39:41 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 10058-01 for <git@vger.kernel.org>;
 Sun,  9 Oct 2005 03:39:41 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 046648F792; Sun,  9 Oct 2005 03:39:40 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.12.10; tzolkin = 13 Oc; haab = 8 Yax
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9861>


Recently, a change was made to git/Makefile to invoke "uname -o".
This isn't portable to OSX/Darwin.  Is there a chance this information
can be obtained some other way, or not invoked on darwni?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
