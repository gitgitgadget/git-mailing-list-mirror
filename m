From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Fix the exit code of MSVC build scripts on cygwin
Date: Fri, 09 Oct 2009 23:04:43 +0100
Message-ID: <4ACFB37B.8010602@ramsay1.demon.co.uk>
References: <4ACE064B.5020909@ramsay1.demon.co.uk> <81b0412b0910081313x31f72916p6fddd1a23df154df@mail.gmail.com> <7vy6nl5ag0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, mstormo@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 20:09:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwgNR-0003LY-Fr
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 20:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762063AbZJJSGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 14:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762061AbZJJSGl
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 14:06:41 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:35444 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762045AbZJJSGk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Oct 2009 14:06:40 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1MwgKM-0004aT-k8; Sat, 10 Oct 2009 18:05:58 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vy6nl5ag0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129895>

Junio C Hamano wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>>> -exit system(@args);
>>> +system(@args) == 0
>>> +       or exit 1;
>>> +exit 0;
>> exit(system(@args) != 0);
>>
>> Yours looks a little verbose...
> 
> Thanks, will queue with a fixup.
> 

Thanks! (Alex and Junio)

I had this as my penultimate version, so I'm happy.

[I changed it to be more explicit about the actual exit values
returned by the script. (and thus more verbose :) ]

ATB,
Ramsay Jones
