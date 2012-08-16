From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 22:52:39 +0200
Message-ID: <502D5D97.3020906@kdbg.org>
References: <20120816095018.GD5489@suse.cz> <7v1uj63iyx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 22:52:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T273i-0005XH-Ek
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 22:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669Ab2HPUwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 16:52:44 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:53327 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932636Ab2HPUwn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 16:52:43 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2DF402C4003;
	Thu, 16 Aug 2012 22:52:39 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A6FCC19F69C;
	Thu, 16 Aug 2012 22:52:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v1uj63iyx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.08.2012 18:22, schrieb Junio C Hamano:
> Miklos Vajna <vmiklos@suse.cz> writes:
> 
>> ---
>>  Documentation/git-pull.txt |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
>> index defb544..67fa5ee 100644
>> --- a/Documentation/git-pull.txt
>> +++ b/Documentation/git-pull.txt
>> @@ -101,6 +101,7 @@ include::merge-options.txt[]
>>  
>>  :git-pull: 1
>>  
>> +-r::
>>  --rebase::
>>  	Rebase the current branch on top of the upstream branch after
>>  	fetching.  If there is a remote-tracking branch corresponding to
> 
> I am not sure if this is worth it, as it comes from a natural
> "abbreviated options" support,

Are you sure? This adds '-r', not '--r', i.e., the single-letter option
'r', to the documentation, which is not something we want to hide, usually.

-- Hannes
