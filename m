From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: [PATCH 3/3] help: Add 'help.follow-alias' config item
Date: Thu, 15 Mar 2012 15:29:04 +0900
Message-ID: <4F618C30.2030407@lge.com>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com> <1331779969-8641-3-git-send-email-namhyung.kim@lge.com> <7v7gymmm9a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 07:29:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S84BX-0003Am-Ef
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 07:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab2COG3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 02:29:09 -0400
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:54261 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab2COG3H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 02:29:07 -0400
X-AuditID: 9c93016f-b7cedae00000438b-ad-4f618c30cf2e
Received: from [192.168.0.31] ( [10.177.201.156])
	by LGEMRELSE1Q.lge.com (Symantec Brightmail Gateway) with SMTP id A1.A5.17291.03C816F4; Thu, 15 Mar 2012 15:29:04 +0900 (KST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7v7gymmm9a.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193186>

2012-03-15 3:06 PM, Junio C Hamano wrote:
> Namhyung Kim<namhyung.kim@lge.com>  writes:
>
>> The 'help.follow-alias' config option is used to determine the
>> default value of '--follow-alias' option. To do this, move some
>> codes to honor the priority of command line options.
>
> How badly would this change break what 7c3baa9 (help -a: do not
> unnecessarily look for a repository, 2009-09-04) tried to fix?
>

Oops, I was completely unaware of the problem, sorry :(.


>> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
>> index debf293..9725e9f 100644
>> --- a/Documentation/git-help.txt
>> +++ b/Documentation/git-help.txt
>> @@ -80,6 +80,14 @@ line option:
>>   * "info" corresponds to '-i|--info',
>>   * "web" or "html" correspond to '-w|--web'.
>>
>> +help.follow-alias
>
> Please be consistent with existing ones.  I think we spell multi-word
> variable names without hyphens.
>

Will fix if you're OK with this series.

Thanks,
Namhyung
