From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 6/6] git-reset.txt: make modes description more consistent
Date: Wed, 15 Sep 2010 22:47:27 +0200
Message-ID: <4C9130DF.70303@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net> <d4a048c1cfd39a2d7ab8a86554bb48937629620c.1284365021.git.git@drmicha.warpmail.net> <7vd3sh9n7l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 22:47:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvytD-0004Tk-Dp
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab0IOUrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 16:47:24 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40208 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753281Ab0IOUrY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 16:47:24 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3A1C95E0;
	Wed, 15 Sep 2010 16:47:23 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 15 Sep 2010 16:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mumI0Ay2eOkx3ATkKSHLHjKeqNI=; b=L1M3vvWBG2azJPvhMaITqXOqLv5QaVpVf2nlBzQ2Vz9lm3N6tLSYrQKej+8dFr454Bm6qNMWKl4nAd6tM4Kav69t0T/jZp0FUiXHAIQ51Ai2BRqjmFvhuBEff9F81MDhYvPLoL6lmwMsf3FglB9oQcVJ70MMhBuGdSXvfRnjySw=
X-Sasl-enc: 1SZ2HImwxUdoHCKaEvL4k5yxmjzf17NJcZQ/AUb3p/fS 1284583642
Received: from localhost.localdomain (p548580A7.dip0.t-ipconnect.de [84.133.128.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 53002400500;
	Wed, 15 Sep 2010 16:47:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <7vd3sh9n7l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156248>

Thanks for all your hints and thoughts. I'll be sending a v2 in a
minute. There's just one point where I chose not to follow completely
for now:

Junio C Hamano venit, vidit, dixit 14.09.2010 02:35:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
[snip]
>> @@ -57,22 +58,30 @@ linkgit:git-add[1]).
>>  	been updated. This is the default action.
>>  
>>  --hard::
>> -	Matches the working tree and index to that of the tree being
>> -	switched to. Any changes to tracked files in the working tree
>> -	since <commit> are lost.
>> +	Resets the index and working tree. Any changes to tracked files in the
>> +	working tree since <commit> are lost.
> 
> Explaining what "reset" does using the undefined word "reset" smells
> somewhat wrong.  Not that "matches" is any better, but at least the
> original says "to that of the tree", which you seem to have lost, so there
> is no indication what they are reset _to_.  I don't think the above is a
> good change for this reason.

The idea was to define "reset" once (in the paragraph right before the
list of modes) and then use it without repeating that. I tried to make
this a bit clearer now by emphasising the term "reset" more in the
leading paragraph.

[snip]
> It may be just me, but "unstaged" sounds as if you once have staged and
> then changed your mind and took it back.  "... which have changes that
> haven't been added" might be clearer.

We use "unstaged" in the meaning of "not staged/added yet" in other
places, as well - but in surprisingly few I have to admit! I went with
your version here.

Michael
