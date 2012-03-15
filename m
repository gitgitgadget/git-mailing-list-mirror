From: =?UTF-8?B?6rmA64Ko7ZiV?= <namhyung.kim@lge.com>
Subject: Re: [PATCH 1/3] help: Fix help message for aliases
Date: Thu, 15 Mar 2012 14:48:49 +0900
Message-ID: <4F6182C1.9080600@lge.com>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com> <7vipi6mo93.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 06:49:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S83Yb-0007kR-4Q
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 06:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab2COFsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 01:48:52 -0400
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:52196 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab2COFsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 01:48:51 -0400
X-AuditID: 9c930197-b7c59ae000000e75-48-4f6182c2ba50
Received: from [192.168.0.31] ( [10.177.201.156])
	by LGEMRELSE7Q.lge.com (Symantec Brightmail Gateway) with SMTP id 7D.C2.03701.2C2816F4; Thu, 15 Mar 2012 14:48:50 +0900 (KST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vipi6mo93.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193180>

Hi,

2012-03-15 2:23 PM, Junio C Hamano wrote:
> Namhyung Kim <namhyung.kim@lge.com> writes:
>
>> -		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
>> +		printf("`git %s' is aliased to `git %s'\n", argv[0], alias);
>
> NAK.
>
> What would the above change will do to one of my favorite alias?
>
> $ git help who
> `git who' is aliased to `!sh -c 'git log -1 --format="%an<%ae>" --author="$1"' -'
>
> Wouldn't removing "git " from the first phrase be a better solution?
>

Right. But as I replied to Jeff King, it can be improved to check whether the 
aliased output is such a complicated commands or not. Now I see that we can 
examine if the first letter is '!'.

Thanks,
Namhyung
