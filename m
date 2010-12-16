From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 14/14] t{3032,6038}-*.sh: Allow SED_BIN_OPT to override
 the -b sed option
Date: Thu, 16 Dec 2010 20:15:42 +0000
Message-ID: <4D0A736E.605@ramsay1.demon.co.uk>
References: <4D07BAE8.6070904@ramsay1.demon.co.uk> <7vlj3stamh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:41:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMVo-0000Ml-Mq
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab0LPWlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:41:16 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:54250 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608Ab0LPWlP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 17:41:15 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PTMVd-0003Y8-j2; Thu, 16 Dec 2010 22:41:14 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vlj3stamh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163830>

Junio C Hamano wrote:
>>  
>> -test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
>> +test_have_prereq SED_STRIPS_CR && SED_OPTIONS=${SED_BIN_OPT--b}
> 
> It is unclear who is supposed to feed you SED_BIN_OPT.
> 
> Perhaps a patch to add an insn like "If you have an ancient sed, export
> SED_BIN_OPT=-c before running tests" to t/README is also necessary to go
> together with this change.

Yes, you are right. I had such a change to t/README but it was mixed in with
another patch to document other such variables which was incomplete. (see my
previous mail in response to your comments on patch 4/14).

Also, I was half expecting you to drop the patch, because I thought I was in
the minority with an old sed; however, it seems I'm not that unusual after
all ... ;-)

ATB,
Ramsay Jones
