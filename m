From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Am I doing something wrong?
Date: 21 Dec 2005 10:17:54 -0800
Message-ID: <86zmmuwbzh.fsf@blue.stonehenge.com>
References: <86k6dyxuke.fsf@blue.stonehenge.com>
	<7v3bkmcp83.fsf@assigned-by-dhcp.cox.net>
	<864q52xrm6.fsf@blue.stonehenge.com>
	<7vmziub9yw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 19:21:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep8Xq-0001mb-A6
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 19:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVLUSR5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 13:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVLUSR4
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 13:17:56 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:33657 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964776AbVLUSRz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 13:17:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 5B2578D511;
	Wed, 21 Dec 2005 10:17:55 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 19689-02-98; Wed, 21 Dec 2005 10:17:54 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id BD27E8D4E7; Wed, 21 Dec 2005 10:17:54 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.16.3; tzolkin = 8 Akbal; haab = 1 Kankin
In-Reply-To: <7vmziub9yw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13887>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> I said I tried cloning from scratch and fetching into an old one
Junio> over HTTP and succeeded, did I not?  So it does not seem to be
Junio> the case either.

Cloning from scratch probably worked differently than starting
from wherever I was.

Sorry, I didn't preserve the exact state from where I started... I
think my last update was yesterday afternoon.  Would have been a good
test case.  However, I'm very clear on the symptoms... trying to start
from wherever I had last updated, to update to the current release,
failed when sucking from HTTP, but worked when sucking from GIT.

In fact, I got the same exact behavior both on my Darwin laptop and my
OpenBSD box, so I had to edit them both to get away from HTTP
protocol.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
