From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] branch: list branches by single remote
Date: Wed, 24 Aug 2011 17:37:52 +0200
Message-ID: <4E551AD0.7050702@drmicha.warpmail.net>
References: <4E383132.3040907@elegosoft.com> <20110804040646.GA5104@sigill.intra.peff.net> <4E4A729D.9030906@drmicha.warpmail.net> <20110816151448.GA5152@sigill.intra.peff.net> <4E551548.9090807@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 17:38:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwFWi-0007he-Ed
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 17:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab1HXPh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 11:37:56 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52113 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750917Ab1HXPhz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 11:37:55 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5B110206EC;
	Wed, 24 Aug 2011 11:37:54 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 24 Aug 2011 11:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=V+2pL00eRdHMFgRBy/TWvL
	yKRlw=; b=Ig7EqaoKpEuE02jwozF5YphrtWHm2lZqXBQVAP5THZ+PQbSwUy72GZ
	jDo5zRXdXC+8RQXErWnBTwiQUvRCWh7BR/errDO/ITv9XLmherS/h/OcUjNClZya
	nlxcBA+vN7vrtSH7vZkPf5HqboCsGuncTpksO/95X8WsjOzFPz/RU=
X-Sasl-enc: ShiAf7dPbl8N71h/Gy36lTgNegGxw+QcCt73YHJWmnKB 1314200274
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B83E8920037;
	Wed, 24 Aug 2011 11:37:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <4E551548.9090807@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180010>

Michael Schubert venit, vidit, dixit 24.08.2011 17:14:
> On 08/16/2011 05:14 PM, Jeff King wrote:
>> On Tue, Aug 16, 2011 at 03:37:33PM +0200, Michael J Gruber wrote:
>>
>>>> This isn't right. You are assuming that a remote called "foo" will have
>>>> all of its branches in refs/remotes/foo. That's true under the default
>>>> configuration, but technically speaking, the remote tracking branches of
>>>> "foo" are defined by the right-hand side of foo's fetch refspecs.
>>>
>>> You are 100% right here, but...
>>>
>>>> So I think you want something more like this:
>>>
>>> ...the op still might want to filter simply by the remote name.
>>
>> That is a perfectly reasonable approach. It just should be called
>> "--glob" or something, and not "remote".  git-tag allows patterns to an
>> explicit "tag -l", but "-l" is already taken for git-branch.
> 
> As suggested, I've just called it "--glob" for now.

Well, again, what's the point in replicating

http://permalink.gmane.org/gmane.comp.version-control.git/172228

and how is it different?

As I've mentioned, I've been in the middle of polishing that up. You can
follow it if you like:

http://repo.or.cz/w/git/mjg.git/shortlog/refs/heads/branch-list-pattern

Also, again: git branch is much more like git tag than it is like git
log, so I think the pattern matching options should be, too.

Michael
