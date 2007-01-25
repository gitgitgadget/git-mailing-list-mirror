From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: .git/info/refs
Date: Thu, 25 Jan 2007 14:01:17 -0800
Message-ID: <45B928AD.50508@zytor.com>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>	<45B7818F.6020805@zytor.com> <7vireuaj9d.fsf@assigned-by-dhcp.cox.net>	<45B92332.5060206@zytor.com> <7v3b5yai6c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 23:02:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HACfS-00086g-Jy
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 23:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbXAYWB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 17:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030622AbXAYWB2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 17:01:28 -0500
Received: from terminus.zytor.com ([192.83.249.54]:56407 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030621AbXAYWB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 17:01:28 -0500
Received: from [10.0.6.0] (yardgnome.c2micro.com [69.104.58.50])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0PM1KhI023572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Jan 2007 14:01:20 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <7v3b5yai6c.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV 0.88.7/2492/Thu Jan 25 11:04:35 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37767>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>>>>> With new gitweb and new git it is not that expensive. It is now one call
>>>>> to git-for-each-ref per repository.
>>>> That IS hugely expensive.  On kernel.org, that is 24175 calls to git.
>>> Do you mean you have 24k _REPOSITORIES_ served by gitweb on
>>> kernel.org?
>> No, we currently have 250 repositories with a total of 24175 refs.
> 
> Then that would mean 250 calls to git-for-each-ref, wouldn't it?
> 

Well, I think it was Johannes that said once for each ref.  But either 
which way, it's a totally unacceptable load with resulting unacceptable 
latency.

	-hpa
