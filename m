From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: proper way to make cg-fetch work from originally git-clone'd tree
Date: 10 Nov 2005 16:13:43 -0800
Message-ID: <867jbgujm0.fsf@blue.stonehenge.com>
References: <86mzkc4nlu.fsf@blue.stonehenge.com>
	<20051111001148.GG30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 01:14:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaMYQ-0005Su-ER
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 01:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVKKANr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 19:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVKKANr
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 19:13:47 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:47141 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932278AbVKKANp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 19:13:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 2DE5C8F5CD;
	Thu, 10 Nov 2005 16:13:44 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 31609-01-80; Thu, 10 Nov 2005 16:13:43 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C5A398F5CF; Thu, 10 Nov 2005 16:13:43 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
x-mayan-date: Long count = 12.19.12.14.2; tzolkin = 6 Ik; haab = 0 Ceh
In-Reply-To: <20051111001148.GG30496@pasky.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11541>

>>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:

>> cg-merge 2>&1 | grep -v 'already fully merged' && make prefix=/opt/git all install && (cd Documentation && make prefix=/opt/git all install)

Petr> Any reason why you were unable to tell the main make 'doc install-doc'?

Because I didn't see it? :-)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
