From: =?UTF-8?B?6rmA64Ko7ZiV?= <namhyung.kim@lge.com>
Subject: Re: [PATCH 2/3] help: Add '--follow-alias' option
Date: Thu, 15 Mar 2012 15:15:23 +0900
Message-ID: <4F6188FB.7020406@lge.com>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com> <1331779969-8641-2-git-send-email-namhyung.kim@lge.com> <7vehsummit.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 07:15:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S83yS-00020t-RT
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 07:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089Ab2COGPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 02:15:34 -0400
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:44874 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862Ab2COGP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 02:15:26 -0400
X-AuditID: 9c930197-b7c59ae000000e75-58-4f6188fb4b50
Received: from [192.168.0.31] ( [10.177.201.156])
	by LGEMRELSE7Q.lge.com (Symantec Brightmail Gateway) with SMTP id D7.7B.03701.BF8816F4; Thu, 15 Mar 2012 15:15:23 +0900 (KST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vehsummit.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193183>

2012-03-15 3:00 PM, Junio C Hamano wrote:
> Namhyung Kim<namhyung.kim@lge.com>  writes:
>
>> The --follow-alias option will look up the alias definitions and
>> use the first word as a command. For example, if I set my aliases
>> as follows:
>>
>>   $ git help br
>>   `git br' is aliased to `git branch'
>>   $ git help ru
>>   `git ru' is aliased to `git remote update'
>>
>> adding --follow-alias (or -f) option will show man pages of
>> git-branch and git-remote, respectively.
>
> What would happen when somebody has this?
>
> 	[alias]
>          	br = branch --list
>
> 	$ git help --follow-alias br
> 	... man page for git-branch is shown ...
>
> NAK.
>

I'm sorry I don't understand what you meant by this. What should be happened 
for this?


>> +-f::
>> +--follow-alias::
>> +	Read alias definitions and use its first word as a command name
>> +	(if any).
>
> Also, please do not let a potentially ill-conceived option to squat on a
> short and sweet single letter option name, until it proves to be useful.
>

OK, will be careful next time.

Thanks,
Namhyung
