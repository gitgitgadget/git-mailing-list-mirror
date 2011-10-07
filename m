From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] fmt-merge-msg: use branch.$name.description
Date: Fri, 07 Oct 2011 11:45:09 +0200
Message-ID: <4E8ECA25.205@drmicha.warpmail.net>
References: <7vobxtwaog.fsf@alter.siamese.dyndns.org> <4E8EBDA7.2040007@drmicha.warpmail.net> <20111007091636.GA22822@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 11:45:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC6zW-00049a-8y
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 11:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab1JGJpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 05:45:12 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39157 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752069Ab1JGJpL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 05:45:11 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B9F48204BD;
	Fri,  7 Oct 2011 05:45:10 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 07 Oct 2011 05:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=2QwqBugIB44Opca4y20RrW
	G5lVw=; b=SCh+abQ8WeRNhP+tgQjLBRLPzCOwQ6hZcUb84o06YfmP/zBQJj9L4J
	nZwktWWp3vnyFuCfUO6JRoLVRl9i+UGapPHVF9jR0Oh2KJqIffQWmymyZlxDfpvt
	JN5aHYNqnvqoECpcw31a5KKi0ydi9OjxvDnyJeczpnkGrvv5N07ng=
X-Sasl-enc: ugecKbGxy+mIEU1aJu3q3vBpht1ejXo7CofI483SDhgC 1317980710
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 253DFCA04EF;
	Fri,  7 Oct 2011 05:45:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <20111007091636.GA22822@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183072>

Jonathan Nieder venit, vidit, dixit 07.10.2011 11:16:
> Michael J Gruber wrote:
> 
>> config based is so non-distributed, local in nature.
> 
> I don't follow.  Wouldn't a protocol change be enough to fix that, by
> sharing branch descriptions analagously to how refs themselves are
> shared?

I'd be surprised if we changed the protocol just to be able to share
some descriptions, when we have everything we need for sharing refs.
Also note that config is non-versioned etc.

But my main point here is that we should discuss the pros and cons of
each approach in context (the context of the original thread), and I
haven't heard many pros and cons for either.

Michael
