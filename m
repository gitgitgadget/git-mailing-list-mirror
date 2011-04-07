From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v4 0/4] Document diff and filter drivers in config
Date: Thu, 07 Apr 2011 14:48:59 +0200
Message-ID: <4D9DB2BB.8080606@drmicha.warpmail.net>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com> <1302083854-2448-1-git-send-email-artagnon@gmail.com> <4D9DB247.8040708@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 12:49:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7mlx-0003em-3n
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 12:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab1DGKtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 06:49:03 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53773 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753225Ab1DGKtD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 06:49:03 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F3F3220369;
	Thu,  7 Apr 2011 06:49:01 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 07 Apr 2011 06:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=GNc+fKl+HixgsTP/2+AkZO1pBD8=; b=sNdNAJNp6fFdnoXMTiknQyuIELx1F5Obvftt21DfJZYze7m0+VQuuFGDQY3ZAxLs4NZkWJGcX7AypSPo5qdFynWwy3jZ4ljphqnuEsd+CmD+/boB9gwvJ+kQbhW+H0OSWy1qbhhsFHxd2ICGFZ7X+/58+uSSPjVUjDwbkUXpTT4=
X-Sasl-enc: 4RkOpZZM1TMjIqfoVV2OH5eH7PCCHjXNeUZvOe8uj1Q6 1302173341
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 43392409077;
	Thu,  7 Apr 2011 06:49:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D9DB247.8040708@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171054>

Michael J Gruber venit, vidit, dixit 07.04.2011 14:47:
> Ramkumar Ramachandra venit, vidit, dixit 06.04.2011 11:57:
>> Also, describe What changed since v3:
>> - More language improvements, thanks to Michael.
>> - Junio's elaborate note clarifies several options.
>> - One more patch in the series to make similar corrections to
>>   merge-config.
>>
>> Thanks for reading.
>>
>> -- Ram
>>
>> Ramkumar Ramachandra (4):
>>   Documentation: Add filter.<driver>.* to config
>>   Documentation: Add diff.<driver>.* to config
>>   Documentation: Allow custom diff tools to be specified in 'diff.tool'
>>   Documentation: Minor language improvements to merge-config
>>
>>  Documentation/config.txt       |   72 ++++---------------------------
>>  Documentation/diff-config.txt  |   91 ++++++++++++++++++++++++++++++++++++++++
>>  Documentation/merge-config.txt |   38 ++++++++--------
>>  3 files changed, 120 insertions(+), 81 deletions(-)
>>  create mode 100644 Documentation/diff-config.txt
>>
> 
> Thanks for hanging in, looks good (minus the customs which Junio mentioned).
> 
> Michael

...oh well, that was meant to be a reply to the v5 cover letter... I
guess I got "lost in thread" ;)

M.
