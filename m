From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Problems with Windows, Was: What's cooking in git.git (May 2013,
 #01; Fri, 3)
Date: Tue, 07 May 2013 16:27:20 +0200
Message-ID: <51890F48.3090409@web.de>
References: <7vvc6zwta7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 16:27:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZirk-0000q2-Je
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 16:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab3EGO10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 10:27:26 -0400
Received: from mout.web.de ([212.227.15.3]:53279 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753857Ab3EGO1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 10:27:23 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MORuj-1UexWm15vx-005iqY; Tue, 07 May 2013 16:27:21
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vvc6zwta7.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:eJTvbOcU7XiGM7R5br+K+xa5hbgeFutPLMnV7MRKv4X
 z3xe8tgVmi84lZVgNhSCNNtLEwz0mFrf4C40rUVZQFK06x44pL
 cGB1TS9dr1e4sj9mv6KLvfFCFOzpcZJ0YSbFZfKjH4vzMK5CVB
 CNpb4U+J9fwhfrm/RyI61MRZDX5MqDhUDdM76JWJRQNCLerfWW
 W2jaoFok1QopQTgCNbMBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223571>

On 2013-05-04 01.14, Junio C Hamano wrote:
> 
>  Cygwin portability; both were reviewed by Jonathan, and the tip one
>  seems to want a bit further explanation.  Needs positive report
>  from Cygwin 1.7 users who have been on 1.7 to make sure it does not
>  regress for them.

I was trying to verify that cygwin 1.7 is still Ok, but got puzzled.

Running the test suite under cygwin doesn't seem to work any more (?):

Scenario 1:
The PC is running alone, and goes into the screen saver.
Pressing CTRL-ALT-DEL didn't get any effect.

Scenario 2:
The PC didn't react any more, when the test suite was run in background.
In 3 or 4 cases the PC needed to be reboot hardly.

Using the commits before and after this change makes the test suite hang 
as well at some point, then it hangs somewhere at TC 3000--4000.

Scenario 4:
The I disabled the screensaver, upgdated cygwin,
 and went back to an older commit:
The latest run from commit 52d63e70, April 28,
hangs in TC 5500, ok 26 clone shallow object count.

I can see 2 times 
git.exe pull --depth 4 ..A 

Scenario 5:
The run of today 1.8.3-rc1, hangs in t5510,
some git.exe are running fetch. (or pull)


It seems as if some process/exes are not terminated
in the way it should be.

I will try on a different machine,
comments are wellcome
/Torsten
