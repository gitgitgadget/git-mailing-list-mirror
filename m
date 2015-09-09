From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Standardization of messages - dot after the sentence
Date: Wed, 9 Sep 2015 09:41:02 +0200
Message-ID: <55EFE28E.1060601@drmicha.warpmail.net>
References: <CALx9kCVwpOvBfTxBi8gn7MBajEbuMLGP_HAJ0TW3XGzmUE0=QA@mail.gmail.com>
 <55ED3973.2020304@drmicha.warpmail.net>
 <xmqqh9n493q3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: sigo <spam@sigo.pl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 09:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZa0F-0007UA-Qj
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 09:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbbIIHlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 03:41:09 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55318 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751342AbbIIHlH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 03:41:07 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 17E00215F3
	for <git@vger.kernel.org>; Wed,  9 Sep 2015 03:41:06 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 09 Sep 2015 03:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=rhcSJP6x/vC2bJrsIFluB4fWqXo=; b=kDf83X
	EIRqf984yDoW8KEpjFTlbhf6W/iVCmHLkKS4oNDY15EJYuU+ktr3bK60WHLrPWG2
	VFgU5SJhvIkNAA8fkGNqFSyxcGOwN/IJ2qcFvePH9KFpvvezK1yncN4J74ksGI8L
	Vj3SCRVeeOEHD6vyDG5/dfo+a8F9hV+CfycWE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=rhcSJP6x/vC2bJr
	sIFluB4fWqXo=; b=JS6tcMnFslsFsKEoDL2QEuWaYKWyxuc0dqLJrzLdSMVtbUY
	xYQ9f6Tk0QwCEm4QRJi8KKNX9NEqYyi8TjGh5pFky0pXiWZSq1IWB8+mG1y5yAfL
	l6LeYscssHa1bEpohC5H4pJT+wpTFqYQyq9f3qcEmo3l0RjAA4CTKqefSZP4=
X-Sasl-enc: Xayh43jtJhzxsfkovnbXd0AOY+yZpwI9wGeVe/njQctY 1441784465
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6DC32C00285;
	Wed,  9 Sep 2015 03:41:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqqh9n493q3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277532>

Junio C Hamano venit, vidit, dixit 08.09.2015 20:16:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> sigo venit, vidit, dixit 05.09.2015 14:22:
>>> I've found really "little bug" with dots in the git output.
>>>
>>> $ git push
>>> Everything up-to-date
>>>
>>> git pull
>>> Already up-to-date.
>>>
>>> Could all phrases contain dots? :)
>>>
>>
>> In this case, also both messages mean the same but are phrased
>> differently, which is suboptimal in more than one way.
> 
> I do not particularly care between these two commands, but I think
> "git pull" says the same "Already up-to-date" in two situations that
> are two quite different ones.  That ambiguity bothers me a lot more.

I think both are bad in the same way:

If a user sees two different messages she rightfully assumes there is a
difference. If she sees two same messages she righfully assumes there is
no difference.

Besides: l10n...

Michael
