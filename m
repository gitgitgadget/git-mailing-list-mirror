From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git log --author=me
Date: Tue, 3 Nov 2015 11:26:52 +0100
Message-ID: <56388BEC.7050207@drmicha.warpmail.net>
References: <563764B8.4010101@exec64.co.uk>
 <CACsJy8D83-Mg8UHA-=CPJ3z37CQTn7USjEbfO8QcU1T+=tS0Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 03 11:27:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtYoF-0000xr-BL
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 11:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbbKCK1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 05:27:16 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35141 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751336AbbKCK1P (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 05:27:15 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 1FAF621CCB
	for <git@vger.kernel.org>; Tue,  3 Nov 2015 05:26:54 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 03 Nov 2015 05:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=oHoQq824fqrXmemTvYsij+tgG3A=; b=ctqRdw
	pO2B2OvUHFQUPy9IFTCxbbiRwziIDlztNBQ6YujAo8TIXwBsKZj5kCJkUbdkTVHM
	5X3hmsyetQPk3QXftib3HDiA+RjHY9Vcv7xKlx+s2bqwr1AOV2PKVShSjFwPEcej
	c6AxpK/mGfRp+p7IpHzQu8AVKJJnMDoNe8LyA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=oHoQq824fqrXmem
	TvYsij+tgG3A=; b=H2OmGKHmZFNWZ9UNImimZtuAkYPVxLnxK9kmcdzFd3DJJTu
	AmowlYRTPwZNTk7SoZPDeKpYA9aXeGO5UR67purWyuxtQORJ/xQqPRECDLJ1lFKI
	ussbxVcJOpc7pHkzLJAIw4x7b+l4g2jNWIwDiOTqiWPoKAfwe/Bkfpl9D8Bs=
X-Sasl-enc: QJrAaeNHwp2f9LUzbVY7NeWuEL0T5maKN7BSplo7WXIG 1446546413
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7744568021F;
	Tue,  3 Nov 2015 05:26:53 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CACsJy8D83-Mg8UHA-=CPJ3z37CQTn7USjEbfO8QcU1T+=tS0Bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280790>

Duy Nguyen venit, vidit, dixit 02.11.2015 19:37:
> On Mon, Nov 2, 2015 at 2:27 PM, Harry Jeffery <harry@exec64.co.uk> wrote:
>> Hi,
>>
>> I've written a patch that allows `me` to be used as shorthand for
>> $(user.name) or $(user.email) in the `--author` and `--commiter` fields.
>>
>> The purpose being to make finding your own commits quicker and easier:
>>     git log --author=me
>>
> 
> It would be even cooler if it accepts mail aliases, then you can
> define "me" to your address and also have shortcuts to a few of your
> best friends. Though as Andreas pointed out --author is not a good fit
> because it accepts regex, and you can't use --mine either, so more
> work..
> 

Alternatively: How about teaching git-completion to complete the
argument to --author? Expensive, I know, but faster than typing it out
or realising "Michael J" is not as unique as you think ;)

Michael
