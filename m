From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: "make test" works again (sort-of) on cygwin.
Date: Tue, 08 Jul 2008 23:27:08 +0100
Message-ID: <4873E9BC.5040708@ramsay1.demon.co.uk>
References: <486D0FFC.5090308@ramsay1.demon.co.uk> <20080703202637.GC3546@steel.home> <486FD4FB.6070803@ramsay1.demon.co.uk> <20080706231146.GE17659@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 19:41:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGdfj-0004PB-S4
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 19:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686AbYGIRki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 13:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754673AbYGIRkh
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 13:40:37 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:1558 "EHLO
	anchor-post-33.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754659AbYGIRkg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2008 13:40:36 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.67)
	id 1KGded-000Fxd-AX; Wed, 09 Jul 2008 17:40:35 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20080706231146.GE17659@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87898>

Alex Riesen wrote:
> Ramsay Jones, Sat, Jul 05, 2008 22:09:31 +0200:
>> Alex Riesen wrote:
>>> Ramsay Jones, Thu, Jul 03, 2008 19:44:28 +0200:
>>>
>>>> Anyhow, the "sort-of" in the subject line, relates to the fact that
>>>> I am seeing some test failures.  In particular, all tests in
>>>> t0004-unwritable.sh and tests 21->24 in t3700-add.sh. All of these
>>>> tests involve chmod/permissions ...
>>> Don't run "make test" as root (or "backup operator" on windows).
>>> OTOH, a windows machine is almost useless, unless you're a member of
>>> local administrators group (which includes "backup" permission).
>>>
>> Ah, yes... I am a "Computer administator" aren't I ;-) I totally forgot!
>>
>> Hmm, but is that really the reason for these failures? After all, (referring
>> to the example you snipped) the permissions are respected for creating
>> files in the directory, just not directories.  Is the "root" user on
>> windows only selectively omnipotent?
> 
> It is (it is the backup operators who can read open, even locked,
> files), but it is boringly hard to find when and where. You can try
> reading MSDN (or better don't, you'll live longer if you don't).
> 
> 

Yeah, I'm afraid I've had to serve that sentence (several times) in
the past; I'm still trying to figure out what my crime was... ;P

ATB,

Ramsay Jones
