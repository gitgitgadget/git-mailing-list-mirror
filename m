From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Test failures on cygwin (v1.6.0)
Date: Thu, 28 Aug 2008 16:46:02 +0100
Message-ID: <48B6C83A.3080506@ramsay1.demon.co.uk>
References: <48B4405E.2020507@ramsay1.demon.co.uk> <20080827061239.GA7805@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlCh-0006T8-K1
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbYH1RVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYH1RVa
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:21:30 -0400
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:39102 "EHLO
	anchor-post-37.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751769AbYH1RV3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2008 13:21:29 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.69)
	id 1KYlBY-0005B8-NX; Thu, 28 Aug 2008 17:21:28 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20080827061239.GA7805@blimp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94087>

Alex Riesen wrote:
> Ramsay Jones, Tue, Aug 26, 2008 19:41:50 +0200:
>> Also, the new test summary shows (on Linux and cygwin):
>>
>>           Linux    Cygwin
>> fixed     1        3
>> success   3748     3511
>> failed    0        0
> 
> You have no failed tests.
> 

True. But I guess I didn't make clear that the cygwin numbers relate
to the test summary, *after* skipping the tests that fail ;-)

>> Note the number of fixed on cygwin. It took some time to find, but it
>> appears that the additional FIXED where t0050-filsystem.sh tests
>> 5 "merge (case change)" and 6 "add (with different case)".  Again, I
>> haven't investigated yet.
> 
> That's normal for cygwin: the microsoft filesystems are
> case-insensitive and the tests were skipped because of that.
> 
> 

OK, Thanks.

ATB,

Ramsay Jones
