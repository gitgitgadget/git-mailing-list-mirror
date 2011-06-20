From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC] branch: add optional parameter to -r to specify remote
Date: Mon, 20 Jun 2011 13:08:13 +0200
Message-ID: <4DFF2A1D.3060206@drmicha.warpmail.net>
References: <1308511149-10933-1-git-send-email-billiob@gmail.com> <1308511149-10933-2-git-send-email-billiob@gmail.com> <7vtyble9k8.fsf@alter.siamese.dyndns.org> <4DFEEB60.5000005@viscovery.net> <20110620070316.GA15246@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Boris Faure <billiob@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 13:08:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYcL7-0003Zk-Vj
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 13:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab1FTLIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 07:08:17 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:39295 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751155Ab1FTLIQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2011 07:08:16 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C329E2031E;
	Mon, 20 Jun 2011 07:08:15 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 20 Jun 2011 07:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=d+bFmI8wRkggtMcxMk1Hb68ZLCY=; b=luGOUvzxe87snwPYMCg9UQyg5Q7l2I6W2OPRBOvu5fG74hmPUxxdOQGz3VO79T2k0ut7LK2DBnkbTfIPfTJaBBD2idXCbKTmv2RpJnqas7xyb4FEDhvLv0LKILB7Of9KWn3RRkyeV10/2ROk0CsDB7I7Cfld/4CIA8+vkM7Ygvk=
X-Sasl-enc: cSn3Zm5BgJ459QRCmNvnVQBZ0e4Ur1bxNkkIveAaWjk4 1308568095
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C900B446031;
	Mon, 20 Jun 2011 07:08:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110620070316.GA15246@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176063>

Jeff King venit, vidit, dixit 20.06.2011 09:03:
> On Mon, Jun 20, 2011 at 08:40:32AM +0200, Johannes Sixt wrote:
> 
>>> 	$ git branch --match "jk/*"
>>>
>>> to show only local topic branches whose names match the given blob.
>>
>> I would hate having to learn a new syntax '--match "jk/*"' when we can
>> already say
>>
>>     $ git log --remotes
>>     $ git log --remotes=alice --remotes=bob
>>     $ git log --remotes="jk/*"
>>
>> IMO, it is the right approach to have a long option --remotes with an
>> optional argument.
> 
> For that matter, --match should be spelled "--glob", as we already have:
> 
>   $ git log --glob='jk/*'
> 
> I think having the ref-selection for "git branch" match that of the
> revision walker makes sense.
> 
> -Peff

Well, "branch" is about refs, and "log" about revs. I'd rather have
"branch" similar to "tag" in that respect (i.e. '-l'). I'm still meaning
to revive that series:

http://permalink.gmane.org/gmane.comp.version-control.git/172228

I've reworked a few more things compared to the RFC from back then but
was caught by lack of time and the rc phase. I'll send what I have asap.

Michael
