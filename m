From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/3] revisions.txt: structure with a labelled list
Date: Fri, 01 Apr 2011 09:01:46 +0200
Message-ID: <4D95785A.7010701@drmicha.warpmail.net>
References: <cover.1301569271.git.git@drmicha.warpmail.net>	<9e7095318e6dc40657db0cfef3400a66f6de20a4.1301569271.git.git@drmicha.warpmail.net> <m3mxkb3qwt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 09:05:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5YQ9-00071J-F3
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 09:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab1DAHFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 03:05:18 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49176 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754658Ab1DAHFR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 03:05:17 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BF7D92083E;
	Fri,  1 Apr 2011 03:05:16 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 01 Apr 2011 03:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=QsLwQl0msWwcm8Ywli7C+1TZr1o=; b=J09PPqpLYBz4HmBElFQhEcHy5A0utpFn1ILGvnsQap6PFA/r7865qoBScAQ0YszCbMJlE4QdUxU1nUQS+GkqNLCnr+x3+G/ENfL+rop9KpOu9I/tDjJEBelps714bFo5gSALsorl2exGP3iGasyE9NJ2S9HjVpGhGKXyKkobiX8=
X-Sasl-enc: rnfrQRAoi6s5QsADYLwcMA9bfjIPfUuqZveXw/v+J6hm 1301641516
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 48CD6407E28;
	Fri,  1 Apr 2011 03:05:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <m3mxkb3qwt.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170555>

Jakub Narebski venit, vidit, dixit 31.03.2011 23:46:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> -* The special construct '@\{-<n>\}' means the <n>th branch checked out
>> +'@\{<n>\}', e.g. '@\{-1\}'::
>> +  The special construct '@\{-<n>\}' means the <n>th branch checked out
>>    before the current one.
> 
> I think you meant
> 
>   +'@\{-<n>\}', e.g. '@\{-1\}'::
> 
> here.

Thanks, good spotting!

I'll recheck the processed form and send out a v2 today.

Michael
