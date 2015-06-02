From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] l10n: de.po: translate "index" as "Index"
Date: Tue, 02 Jun 2015 10:34:19 +0200
Message-ID: <556D6A8B.2020202@drmicha.warpmail.net>
References: <1432925644-26231-1-git-send-email-ralf.thielow@gmail.com> <556C0BFD.3060806@drmicha.warpmail.net> <9A423AE7-27D6-402F-80C2-C9DA7AF08033@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: sbeller@google.com, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: phillip <phillip.szelat@gmail.com>, git@drmicha.warpmail.net,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 10:34:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzheW-0001c1-T2
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 10:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082AbbFBIeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 04:34:25 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59759 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754248AbbFBIeW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 04:34:22 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 5B713208B6
	for <git@vger.kernel.org>; Tue,  2 Jun 2015 04:34:22 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 02 Jun 2015 04:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=c7XU8R//vwNi3N+WE+4TR07zwjA=; b=pqTwYP
	wNagaCHPMW3a5XN8/NLQ3CDVJoPy+FdDa9K2V4NMc6J5gOSmOAeeTxAvm06Xuj0X
	lGvGqK3Yo8LoIj+vuo797EA7LritfcS5OChxRR6ZNrj3opTCB9jdY3iq16Ya/Nw+
	p2gBTHFzDDsgVP7hGUpaMWpgFZDb0FhcakwA0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=c7XU8R//vwNi3N+
	WE+4TR07zwjA=; b=GQ7bBWkFp/daCQnTT6rvHoF8tmHIO4/IP/Byw9La+Cuk6/I
	g46ZnBkYIIgo9ktFXNdaOiffGKNajysDqkFiPjF6wANA+7dV9cC2ls++5qwhn6Nk
	zf2DOO+wZShCCA5UpeC7wXW3qejyiNwX2D/xlTKiZrv9VSbWMiBDJe4OISN8=
X-Sasl-enc: kmqaLXj2hYvIIxxzx1WEIll1Ntgd0KBcH0pYNYTxzWHp 1433234061
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 813B86800C5;
	Tue,  2 Jun 2015 04:34:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <9A423AE7-27D6-402F-80C2-C9DA7AF08033@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270509>

phillip venit, vidit, dixit 01.06.2015 17:10:
>  
> 
> Hi, 
> 
>>>  #: sequencer.c:661
>>>  #, c-format
>>>  msgid "git %s: failed to read the index"
>>> -msgstr "git %s: Fehler beim Lesen der Staging-Area"
>>> +msgstr "git %s: Fehler beim Lesen des Indexes"
>>
>> Now we have to decide whether we flex "Index" like a foreign word in
>> German or like a German word:
>>
>> der Index, des Index, ...; die Indizes (pl.)
>>
>> or
>>
>> der Index, des Indexes, ...; die Indexe (pl.)
>>
>> I'd vote the former.
>>
> 
> You can use Indizes and Indexe both as german word.

Yes, that's what I wrote. I suggested to make this choice
systematically: Either des Index, die Indizes or des Indexes, die Indexe.

> I would prefer Indexe as its easier to understand.

I'm wondering what's easier to understand about that. Deriving the
singular from the plural maybe? Granted, but:

In fact, "die Indexe" used to be plainly wrong until a few years ago,
and "die Indizes" is still favored by quite a few sources. It's just
that the common knowledge about flexing latin and greek words in German
is deteriorating...

So I guess we have German (traditional) and German (simplified) just
like for Chinese and English ;)

I don't think the plural appears often in Git messages, though, and the
simplified genitive doesn't sound as wrong . So if the simplified form
is considered more helpful for the majority of German users...

Michael
