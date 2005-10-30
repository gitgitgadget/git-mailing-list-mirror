From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-pull (or cg-fetch?) with exit status
Date: 30 Oct 2005 12:05:45 -0800
Message-ID: <86ll0asrc6.fsf@blue.stonehenge.com>
References: <86fyqjt9w9.fsf@blue.stonehenge.com>
	<7v3bmiudl1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 21:06:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWJRF-0007i4-Ga
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 21:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVJ3UFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 15:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVJ3UFy
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 15:05:54 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:39348 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750740AbVJ3UFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 15:05:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 6A5EF8F957;
	Sun, 30 Oct 2005 12:05:48 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 20387-01-12; Sun, 30 Oct 2005 12:05:46 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 054CC8F961; Sun, 30 Oct 2005 12:05:46 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.13.11; tzolkin = 8 Chuen; haab = 9 Zac
In-Reply-To: <7v3bmiudl1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10826>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> 	old_head=$(git-rev-parse --verify HEAD) &&
Junio>         git-pull -n >/dev/null 2>&1 || exit
Junio>         new_head=$(git-rev-parse --verify HEAD)
Junio> 	test "$old_head" = "$new_head" || make test install

This looks like it might work.  I'll try it out next time.  Thanks.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
