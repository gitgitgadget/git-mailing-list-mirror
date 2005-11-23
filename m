From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Perl version support (was Re: [PATCH] git-mv is not able to handle big directories)
Date: 23 Nov 2005 06:27:04 -0800
Message-ID: <86mzjvphhj.fsf_-_@blue.stonehenge.com>
References: <200511231141.57683.lan@ac-sw.com>
	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
	<7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>
	<867jazre78.fsf@blue.stonehenge.com>
	<7vu0e369p4.fsf@assigned-by-dhcp.cox.net>
	<20051123135604.GB16995@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 15:28:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eevam-0003KO-Rw
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 15:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVKWO1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 09:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVKWO1V
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 09:27:21 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:55677 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750829AbVKWO1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 09:27:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 5F3248F724;
	Wed, 23 Nov 2005 06:27:20 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 30893-01-52; Wed, 23 Nov 2005 06:27:05 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 5FF398F745; Wed, 23 Nov 2005 06:27:05 -0800 (PST)
To: Ryan Anderson <ryan@michonline.com>
x-mayan-date: Long count = 12.19.12.14.15; tzolkin = 6 Men; haab = 13 Ceh
In-Reply-To: <20051123135604.GB16995@mythryan2.michonline.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12625>

>>>>> "Ryan" == Ryan Anderson <ryan@michonline.com> writes:

Ryan> For the kernel, requiring 5.8 shouldn't be a big issue. I suspect it's
Ryan> really only the commercial Unixes where requiring 5.8 would be annoying.

Ryan> Randal, is my guess even remotely accurate?

I'd say that 50% of the Perl-using population is at 5.6, with 25% each
at 5.5 and 5.8.  Those on 5.5 are generally unable to upgrade Perl
for corporate reasons.

Targetting Perl 5.6 would assist broad acceptance of git for the
typical commercial end user.  Targetting 5.5 where possible would
ensure practical success for everyone.

However, I have not seen the "target market" of git discussed yet
(I came late to the party), so if support for 5.6 (or 5.5) is not chosen,
it merely limits the market.

If you'd like, I can review all the Perl code with a tool that
determines the minimum Perl version, and provide patches to bring the
code to 5.5 level.  But if it's likely that someone will say "this
is not important to us", I'd rather not waste my time. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
