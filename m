From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Fri, 09 Sep 2011 21:29:32 +0200
Message-ID: <4E6A691C.2060803@drmicha.warpmail.net>
References: <20110825175301.GC519@sigill.intra.peff.net> <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net> <7vfwkodq5s.fsf@alter.siamese.dyndns.org> <4E5A5290.4050005@drmicha.warpmail.net> <20110907195611.GD13364@sigill.intra.peff.net> <4E6889DF.7030404@drmicha.warpmail.net> <7vr53qwxtz.fsf@alter.siamese.dyndns.org> <7vmxeewx7f.fsf@alter.siamese.dyndns.org> <4E69B832.9030503@drmicha.warpmail.net> <7vlitxvh45.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 21:29:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R26lj-0002Cm-IQ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759879Ab1IIT3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:29:37 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:36078 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759693Ab1IIT3g (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 15:29:36 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 90C7128885;
	Fri,  9 Sep 2011 15:29:36 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 09 Sep 2011 15:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=W78faaJtV2d5CRmsprkm/O
	v8KyY=; b=F2Lgo2D2YnDWGYatBL8vF3u9TV/RkRyIsh/6Ewd+kPQngbEBP6NF58
	v9xJjoN1mAtYcOx56kOgrKum1cYT5OtJRjSUmeWgdKtytJT3B1TZrN0N+PopuVdu
	5zUJxW2A4lsM8GM4I8iBAEd45STdFa7Za2LZiFCwqyUFhbiSPS9jM=
X-Sasl-enc: a9Dwv5R43MLqtI0g5kQEVxT91SWhNkwcPDtKtskdogDE 1315596576
Received: from localhost.localdomain (p548594B4.dip0.t-ipconnect.de [84.133.148.180])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A40B2780521;
	Fri,  9 Sep 2011 15:29:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vlitxvh45.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181111>

Junio C Hamano venit, vidit, dixit 09.09.2011 18:02:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 08.09.2011 23:17:
>>> Ah, nevermind.
>>>
>>> As the series is already in 'next', here is what I came up with.
>>
>> I thought you'll rebuild next anyways after 1.7.7, but either way it's
>> fine. Thanks for holding this series in next long enough to really cook
>> it (and Jeff for revisiting it), it's much better now, keeping the
>> (undocumented, but expected) behavior of "git branch -v foo".
> 
> Thank *you* for all the work.
> 
> I recall Peff had some comments on your new tests last night, by the way.
> 

Yes, we have tests (now) for "-v -d", "-v -m", "-v branch*" and
combinations with --list. Testing "-v foo" for creation would be good
(and belong into t3200). Is there anything to amend?

Michael
