From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Perl version support
Date: 23 Nov 2005 11:59:30 -0800
Message-ID: <86br0bm8yl.fsf@blue.stonehenge.com>
References: <200511231141.57683.lan@ac-sw.com>
	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
	<7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>
	<867jazre78.fsf@blue.stonehenge.com>
	<7vu0e369p4.fsf@assigned-by-dhcp.cox.net>
	<20051123135604.GB16995@mythryan2.michonline.com>
	<86mzjvphhj.fsf_-_@blue.stonehenge.com>
	<7vwtiz4053.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 21:00:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef0mQ-0008PR-Ss
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 20:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVKWT7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 14:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVKWT7l
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 14:59:41 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:38175 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932270AbVKWT7k
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 14:59:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 568408F7AC;
	Wed, 23 Nov 2005 11:59:31 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 05866-02-60; Wed, 23 Nov 2005 11:59:30 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B383E8F7AE; Wed, 23 Nov 2005 11:59:30 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.14.15; tzolkin = 6 Men; haab = 13 Ceh
In-Reply-To: <7vwtiz4053.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12649>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> I think the target market is people who use whatever POSIXy
Junio> systems for their own work.  To them, git and its dependencies
Junio> are merely tools to get their job done, and while they might be
Junio> capable and even willing to match the version requirements if it
Junio> is absolutely necessary, they'd rather spend their time on what
Junio> they do best (i.e. write software or documentation or whatever,
Junio> whose changes are to be managed by git), than installing or
Junio> upgrading base software just to satisfy git.  And I'd like to
Junio> see their time spent on what they do best, instead of caring and
Junio> feeding of git, too.

Yes, this is why I keep pointing out GNU tools being used instead of
POSIXy versions. :)  Mostly because they break on either my Darwin
laptop or my OpenBSD host server.

Junio> So in that sense, excluding 75% of people with "5.8 only" is not
Junio> acceptable at all, and covering 75% with "5.6 or better" might
Junio> be good enough, at least as a starter.

I think we're in agreement.

>> If you'd like, I can review all the Perl code with a tool that
>> determines the minimum Perl version, and provide patches to bring the
>> code to 5.5 level.

Junio> If it is not too much trouble, I'd appreciate it, at least the
Junio> first half that can be done without taking too much of your time.
Junio> Is it a mechanical "lint" like thing, that says "line 47 you
Junio> have list form of pipe open -- that's 5.8 and better"?

The "perlver" tool installed with the "Perl::MinimumVersion" module
from the CPAN will do about 80% of it.  The other 20% are things
that I can use my brain for.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
