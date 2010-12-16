From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 06/14] t9501-*.sh: Fix a test failure on Cygwin
Date: Thu, 16 Dec 2010 19:25:43 +0000
Message-ID: <4D0A67B7.5010202@ramsay1.demon.co.uk>
References: <4D07B6DE.8080400@ramsay1.demon.co.uk> <201012142004.30322.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, marada@uwaterloo.ca
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:41:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMVZ-0000BJ-FI
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277Ab0LPWlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:41:04 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:65139 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855Ab0LPWlC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 17:41:02 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PTMVQ-00041D-pW; Thu, 16 Dec 2010 22:41:01 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201012142004.30322.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163828>

Jakub Narebski wrote:
> Ramsay Jones wrote:
>> The first (setup) test attempts to create a file, using the
>> test_commit function, called 'i can has snapshot?'. On cygwin
>> (and MinGW) this fails with a "No such file or directory" error.
>> In order to fix the tests, we simply remove the '?' wildcard
>> from the name, since the purpose of these tests is not about
>> creating funny filenames.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> 
> All right.
> 
> Acked-by: Jakub Narebski <jnareb@gmail.com>

Thanks.

> BTW. if the test was about handling funny filenames (containing
> leading, embedded and trailing space, +&@=<>"' characters), what
> should we do instead?

Hmm... dunno; take a look at t3600-rm.sh and t4135-apply-weird-filenames.sh
for inspiration? ;-)

Just FYI the "illegal" pathname characters in windows include:
    < > : " / \ | ? *
along with control chars from 0 - 31.
Also, you can't have any trailing spaces or periods.

ATB,
Ramsay Jones
