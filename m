From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: Re: What's cooking in git.git (Aug 2008, #05; Tue, 19)
Date: Tue, 19 Aug 2008 14:35:31 +0200
Message-ID: <6E32922B-EBBD-4317-8E98-DF3CE6EE0E39@web.de>
References: <7vpro5cr2x.fsf@gitster.siamese.dyndns.org> <48AAA82F.9060500@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 14:37:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVQSK-00066c-QB
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 14:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbYHSMfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 08:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbYHSMfz
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 08:35:55 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:42662 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbYHSMfy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 08:35:54 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3433FE92A8B4;
	Tue, 19 Aug 2008 14:35:53 +0200 (CEST)
Received: from [91.18.110.246] (helo=[10.0.1.1])
	by smtp07.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KVQRE-0007ln-00; Tue, 19 Aug 2008 14:35:53 +0200
In-Reply-To: <48AAA82F.9060500@viscovery.net>
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX1+c89BDSGwnBcCaaEz8/Tzc+bG4c+r+qs15RRo8
	/8866Xz6cpOBijXmEFiok23x1Uc/QB2WkoFj+7aO7me/Fa9vcw
	wT3N5jSnj4tQUFfbj5nQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92852>


Am 19.08.2008 um 13:02 schrieb Johannes Sixt:

> Junio C Hamano schrieb:
>> * js/mingw-stat (Mon Aug 18 22:01:06 2008 +0200) 2 commits
>> - Revert "Windows: Use a customized struct stat that also has the
>>   st_blocks member."
>> - compat: introduce on_disk_bytes()
>>
>> This gets rid of use of st_blocks member (which is XSI but not POSIX
>> proper), which was originally prompted by recent Haiku port but it  
>> turns
>> out MinGW has the same issue as well.  Queued on 'pu' just to have a
>> chance to make sure I munged the version j6t sent me correctly before
>> merging it upwards.
>
> I tested this again, and it works as expected.

So did I for the latter, on Haiku. Together with the hardlink patch  
not yet queued, this allows to build and install (*) via `make` with  
suitable arguments.

Andreas


(*) Haiku's `read` (bash) seems to be broken - using `ls -1` in  
templates/Makefile works around that, but it should be fixed at the  
source. http://dev.haiku-os.org/ticket/2646
