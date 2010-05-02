From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFD: tables in documentation
Date: Sun, 02 May 2010 15:31:02 +0200
Message-ID: <4BDD7E96.2050603@drmicha.warpmail.net>
References: <4BDC74F3.2020206@drmicha.warpmail.net> <20100502050622.GF14776@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 02 15:31:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8ZGN-0004uZ-W0
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 15:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab0EBNbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 09:31:07 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50663 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755705Ab0EBNbE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 09:31:04 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4750AEFECD;
	Sun,  2 May 2010 09:31:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 02 May 2010 09:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=oLHNEC1fc3MbgwildfmW0VKy/Ds=; b=DQw6DKSEfFkLMjSjWpQ4md7KYLTim0lyi5eLHeowc5Ou/RmO/DI2LqSrt+1szZCzQk74L6H9qNAsmxR9OMPfAF4ZX7XVUQGk2DxGtifmJBCVXJd05EmoSN+7e/Sny7Xpg9JOMFG8iltB4dmAfpIiOnOJI0ugAFWPNVCQ7Obqkgs=
X-Sasl-enc: p9hMOBj+/EJLVWO3B/bcsRw5SoAa88K7IPS9h0peWrrV 1272807061
Received: from localhost.localdomain (p5DCC03EE.dip0.t-ipconnect.de [93.204.3.238])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 881A24C9D6B;
	Sun,  2 May 2010 09:31:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100502050622.GF14776@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146173>

Jeff King venit, vidit, dixit 02.05.2010 07:06:
> On Sat, May 01, 2010 at 08:37:39PM +0200, Michael J Gruber wrote:
> 
>> Currently, all tables are formatted using indentation by spaces. This
>> breaks whenever AsciiDoc's parsing changes.
>>
>> Instead, I suggest to use AsciiDoc's table syntax which also produces
>> proper tables in the HTML and man output. I formatted the first part of
>> the first table in git-read-tree(1) like that so that you can compare
>> easily.
> 
> Conceptually I am in favor of semantic markup where possible. I find the
> resulting manpage a little harder to read, though. Is it possible for us
> to style it a bit more (e.g., such a simple table looks better, IMHO,
> without ascii-art borders).

I really don't know (about styling docbook's tables). We can easily
switch off the outer borders in AsciiDoc.

The docbook part of the toolchain makes me sick whenever I have to look
at it. I really wish AsciiDoc could output roff straight away. I find it
incredibly hard to find the relevant information for this part of the
toolchain since it involves xmlto as well as the style sheets. Also, at
least my version of xmlto/style sheets/whatever does not cope well with
adjacent (or even non-adjacent multiple) rowspans, see below. Only the
vger.k.o. outage kept me from posting without noticing this before...

> 
>> I put it up at http://repo.or.cz/w/git/mjg.git/commit/table-example for
>> your viewing pleasure. I'd say it looks great even in links (but not in
>> lynx). It also shows a problem of xmlto with multiple rowspans (the xml
>> is correct, .1 apparently not), which could be circumvented easily by
>> repeating those cells.
> 
> Did you put the source up anywhere? I didn't see it, but it would be
> interesting to see how painful it is to write.

http://repo.or.cz/w/git/mjg.git/shortlog/refs/heads/doc-use-tables

Tough guess, I know ;)

Michael
