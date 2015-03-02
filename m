From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-remote.txt: describe behavior without --tags and
 --no-tags
Date: Mon, 02 Mar 2015 15:48:33 +0100
Message-ID: <54F47841.6060009@drmicha.warpmail.net>
References: <54F431E8.3050009@gmail.com> <932c9cd452718ad5e88677fc90985ef7fafd5078.1425301543.git.git@drmicha.warpmail.net> <54F46758.4070207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 15:48:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSReJ-0002dI-EK
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 15:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbbCBOsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 09:48:36 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34831 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751687AbbCBOsf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 09:48:35 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 165902097A
	for <git@vger.kernel.org>; Mon,  2 Mar 2015 09:48:34 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 02 Mar 2015 09:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=EBFgi2dvK32DtYIumxaJsr
	Rx0Hc=; b=uidVJ0bV+AXjce2m2SyXHmAmj0C7/aQBjKH8anjijEfDvpK2DgTtA7
	S5zQI4p7JMXSlHvYKrfFzFU/Ns81e34C103GM9mOwd7dZSv+yPpr+EWFle78Bcha
	Wkk/dICLJJdoYDNuIHdTkGrvRR8NMjG37KCwKQiT4FLnRNRp2dKA4=
X-Sasl-enc: bFwaVn1y1HNdVO9P9aLjCh8D0NQcExvmfRrWrmSzsmON 1425307714
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AA3C2C00297;
	Mon,  2 Mar 2015 09:48:34 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <54F46758.4070207@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264598>

Francis Moreau venit, vidit, dixit 02.03.2015 14:36:
> Hi,
> 
> On 03/02/2015 02:08 PM, Michael J Gruber wrote:
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  Documentation/git-remote.txt | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
>> index a77607b..f3f6f0d 100644
>> --- a/Documentation/git-remote.txt
>> +++ b/Documentation/git-remote.txt
>> @@ -56,7 +56,10 @@ With `--tags` option, `git fetch <name>` imports every tag from the
>>  remote repository.
>>  +
>>  With `--no-tags` option, `git fetch <name>` does not import tags from
>>  the remote repository.
>> ++
>> +By default, only tags on fetched branches are imported
>> +(see linkgit:git-fetch[1]).
>>  +
> 
> So the default is neither --no-tags nor --tags ?
> 
> Thanks.
> 

By default, only tags on fetched branches are imported. That is: When
the fetch is done, all tags are imported that point to commits that are
reachable from refs that you are fetching, in short: "tags on fetched
branches". That is in between "none" (--no-tags) and "all" (--tags).

Michael
