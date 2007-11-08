From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 8 Nov 2007 09:59:29 +0100
Message-ID: <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <4732B899.6000908@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Ralf.Wildenhues@gmx.de, tsuna@lrde.epita.fr,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:01:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3G8-0002KE-56
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbXKHJAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbXKHJAw
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:00:52 -0500
Received: from mailer.zib.de ([130.73.108.11]:38515 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbXKHJAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:00:52 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA88wBVZ029973;
	Thu, 8 Nov 2007 09:58:11 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA88wBN7027807
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 8 Nov 2007 09:58:11 +0100 (MET)
In-Reply-To: <4732B899.6000908@viscovery.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63969>


On Nov 8, 2007, at 8:19 AM, Johannes Sixt wrote:

> Steffen Prohaska schrieb:
>> +If you linearize the history by rebasing the lower branch on
>> +top of the upper, instead of merging, the bug becomes much easier to
>> +find and understand.  Your history would instead be:
>
> At this point I'm missing the words
>
> 	The solution is ...
>
> I.e.:
>
> The solution is to linearize the history by rebasing the lower  
> branch on
> top of the upper, instead of merging. Now the bug becomes much  
> easier to
> find and understand.  Your history would instead be:

Hmm. It might be a solution if you did not publish history.

How about leaving the text as is and adding an introductory
paragraph at the beginning of the section?

I.e:

This section discusses how gitlink:git-bisect[1] plays
with differently shaped histories. If you did not yet
publish a branch you can use either gitlink:git-merge[1] or
gitlink:git-rebase[1] to integrate changes from a second
branch. The two approaches create differently shaped
histories. So it might be interesting to know about the
implications on gitlink:git-bisect[1].


	Steffen
