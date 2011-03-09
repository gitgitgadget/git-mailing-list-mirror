From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/3] git-log.txt,rev-list-options.txt: -n/--max-count
 is commit limiting
Date: Wed, 09 Mar 2011 08:11:26 +0100
Message-ID: <4D77281E.5020803@drmicha.warpmail.net>
References: <4D75E92C.1090506@drmicha.warpmail.net> <4c0ad5a9af1d18e59a7e820349a531f220cbf776.1299572814.git.git@drmicha.warpmail.net> <7vaah5e63p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 08:15:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxDbp-00079K-Q3
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 08:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab1CIHOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 02:14:54 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:53411 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753199Ab1CIHOx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2011 02:14:53 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CDD4C202AC;
	Wed,  9 Mar 2011 02:14:52 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 09 Mar 2011 02:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=9PMQvR+loMArCJDPgCnPIcnXWi8=; b=L1SQbFBUz40rX34xEcPj3Zr0GhYQs8zezGR1G3II1fblWlPEb6407hqQvhKwmN4nd7vRiRogbO+QTcd6ffJDOvkcrOzJ1VvsP3uLN12SQDt7FcFV55+/j/eH8G6CW5WUdIlu2JqWCH3ejFwEx8rfQo4W6y2lNyOWFWIMn0qcteQ=
X-Sasl-enc: RNtF+tKHe9SFP/xOz3ahG8CvzfeMU34VF9/jf4Iawxhj 1299654892
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 36292400F90;
	Wed,  9 Mar 2011 02:14:52 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <7vaah5e63p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168722>

Junio C Hamano venit, vidit, dixit 08.03.2011 20:59:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>> index ff41784..48c1715 100644
>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -25,6 +25,7 @@ OPTIONS
>>  
>>  -<n>::
>>  	Limits the number of commits to show.
>> +	Note that this is a commit limiting option, see below.
> 
> I wonder if we should be dropping this instead, as it appears later in the
> document anyway.

It is an intended redundancy but can be dropped, of course. I just
thought that people confused by "-<n>" would not be looking further down
for yet another description of the same option unless they are pointed
to it (or the right section) explicitly.

Michael
