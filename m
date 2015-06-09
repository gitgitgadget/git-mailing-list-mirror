From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitscm vs. git-scm
Date: Tue, 09 Jun 2015 15:47:52 +0200
Message-ID: <5576EE88.6050607@drmicha.warpmail.net>
References: <5576E2FE.4090105@drmicha.warpmail.net> <vpq382181wh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 15:48:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Jsn-0003LG-0x
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 15:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbbFINr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 09:47:57 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57614 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750946AbbFINrz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 09:47:55 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id D20ED20B1A
	for <git@vger.kernel.org>; Tue,  9 Jun 2015 09:47:54 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 09 Jun 2015 09:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=BHcv9bKnnkbljcUZ7Rj7HlmF/1c=; b=OsDqVN
	BIAiLz4a+PXusVJPwNp1za84HF0KR8nf2Ily6WxFOhcoprR76H43lgdOr7Din6+q
	so8p0mj1ZmsjEGoZEddeHsMi2BbzSypyXc2koHGc/DQt/+wLhxwv4XsKRIYoe+KN
	A8SPrWueWuzUzFuLpUrQh41DdbFDD8+XwKOYE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=BHcv9bKnnkbljcU
	Z7Rj7HlmF/1c=; b=sY5we1gxV0lxWhOvR54zqXUOWrVoreVfORl1Jk+fIpfxFqZ
	49wP2padfxPTpTgI5cEWZfbSQ5JrY94O4Jpt8aKHJAdhBtdE8MiKb+e7D2CenQgt
	AJ/lgpAqQNJg9V0/zR++2uqu8cXg08cBNoc/Sej5qv4C3xkUobLhasA1d9dM=
X-Sasl-enc: LCCrL40TwrczAlhDb9b2S2VWJ3VCx5UWscMdLs4JIN8w 1433857674
Received: from localhost.localdomain (unknown [130.75.173.50])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1BDA06800FC;
	Tue,  9 Jun 2015 09:47:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpq382181wh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271178>

Matthieu Moy venit, vidit, dixit 09.06.2015 15:08:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Hi there,
>>
>> I (mis-) remembered the git site address and noticed that gitscm.com
>> returns empty while git-scm.com is our beloved home. I thought, though,
>> that we have a couple domains with redirects but I may be misremembering
>> that also. Or DNS is "hicking up".
> 
> Not the DNS. gitscm.com is returning a whole window frame containing
> git-scm.com, but then the frame doesn't load (at least in Firefox). The
> inspector tells me:
> 
> Load denied by X-Frame-Options: http://git-scm.com/ does not permit cross-origin framing.
> 
> I guess gitscm.com should just redirect to git-scm.com (sending the
> Location: field, and/or with stg like
> <meta http-equiv="Refresh" content="0; URL=http://git-scm.com" />
> )
> 
> Frames are so 2000 ;-).
> 

Ooo, frames. That's my second encounter with zombies today.

[Should have hit CTRL+U myself, sorry.]

Michael
