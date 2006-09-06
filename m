From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: file rename causes history to disappear
Date: 06 Sep 2006 14:45:28 -0700
Message-ID: <86bqpsvfd3.fsf@blue.stonehenge.com>
References: <44FEE0BB.2060601@garzik.org>
	<Pine.LNX.4.64.0609060834520.27779@g5.osdl.org>
	<44FEED4B.30909@garzik.org>
	<Pine.LNX.4.64.0609060858050.27779@g5.osdl.org>
	<Pine.LNX.4.64.0609060922110.27779@g5.osdl.org>
	<7vmz9c7pzm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 23:45:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL5DB-0004aV-Kq
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 23:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWIFVpb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 17:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWIFVpb
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 17:45:31 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:25160 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932142AbWIFVp3
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 17:45:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 3A0DC8F3D9;
	Wed,  6 Sep 2006 14:45:29 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 11105-01-46; Wed,  6 Sep 2006 14:45:28 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id BF29F8F3D8; Wed,  6 Sep 2006 14:45:28 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.11.2; tzolkin = 7 Ik; haab = 15 Mol
In-Reply-To: <7vmz9c7pzm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26563>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> The only people who will get burnt by this change are the ones
Junio> with metacharacters in their pathnames, so it is relative safe
Junio> change.

But does that mean you'll provide the equivalent to "fgrep" for "grep",
as in a switch that turns this off, or a seperate command?

I can think of times when I might be trying to track a file with a square
bracket in the name.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
