From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] install-webdoc: quell diff output on stdout
Date: Mon, 06 Sep 2010 15:24:03 +0200
Message-ID: <4C84EB73.4040901@drmicha.warpmail.net>
References: <7vhbi842gx.fsf@alter.siamese.dyndns.org> <52f347f82734e5d75d0b93a67edca9941efaa5a9.1283612149.git.git@drmicha.warpmail.net> <7v7hizuz7h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 15:24:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsbgV-0008SL-PQ
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 15:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab0IFNYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 09:24:01 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37641 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754463Ab0IFNYA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 09:24:00 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4E89F1AE;
	Mon,  6 Sep 2010 09:24:00 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 06 Sep 2010 09:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=+Da1c4eGG9CLGg0gY4vZgZXUlqk=; b=T2B5UJd+jOK9A8RwvPmtcfR7Oy026DSBQ5Kuc6HDqOueRagaRWcwa5MPQ08Qjlh1rNsOQiycQJwfcyq6b47m2PKHgHejmm3rGki/44/Ab/G/eKvnSzssGSzZcBIWm1eVco18+viHWAGxa6swtWxcHlTgbRfg4Bjp7k/sb9pZGdg=
X-Sasl-enc: tH462fHsRjlATwF1qvpIwDDY2SJYR1484QX3jZZF0tiT 1283779440
Received: from localhost.localdomain (unknown [195.113.246.47])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D21625EA0BF;
	Mon,  6 Sep 2010 09:23:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <7v7hizuz7h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155569>

Junio C Hamano venit, vidit, dixit 06.09.2010 09:07:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> When installing html-doc, install-webdoc.sh compares the installed html
>> with the version to be installed using diff. Currently, the diff output
>> fills up stdout.
>>
>> install-webdoc.sh actually uses $DIFF, and is the only user.
> 
> I think you broke "tNNNN-X.sh -v"; isn't $DIFF used in t/ scripts
> everywhere?

Um, OK, sorry. I grepped for it but not everywhere it seems. I'll be
partially online only this week but I'll try to come up with something
agreeable.

Michael
