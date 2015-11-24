From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Nov 2015, #03; Fri, 20)
Date: Tue, 24 Nov 2015 10:53:45 +0100
Message-ID: <565433A9.5050707@drmicha.warpmail.net>
References: <20151120140937.GA17079@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 10:53:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1AIL-0001XQ-JU
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 10:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbbKXJxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 04:53:52 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53564 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752867AbbKXJxs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2015 04:53:48 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 4F62C205B6
	for <git@vger.kernel.org>; Tue, 24 Nov 2015 04:53:47 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 24 Nov 2015 04:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=ONn0nDiaWochDcG2+RS5++vJLQw=; b=fbcie0
	N6qR3aIt+cAScoXTuFfX/au4l3F35izlPhBlNWo6wLTt/TtZOsmv66ijw6jQ6U8h
	pbRR4bcLaY5ZmY8loNZI2ZGkJQv5grQDogIv/bIx9o+N/UCn9U4jSrR+S/gcieWI
	rsRIWkQ+XAcwQH6+WxtuQZFLO7Oz+IXGZ5htA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ONn0nDiaWochDcG
	2+RS5++vJLQw=; b=TQvRXJBZc3dRKfZCSL87YiT9Y9PGD5YeMhKB/muisXhbi9N
	sp7dmfI6oeBqpCL7KBaiecWznDMpnLMqWS44MbTtMXyMp55fUdlbv7XIO2reQp12
	ilVECnklGnzxVRnCZ704REI1ll8JtFRcJC8PRAw4uzIusW2N68jas4loC+7k=
X-Sasl-enc: upiDkOrdrekFxB2XcvdyPTNZDQ8FgCt45Wb320iqo78x 1448358826
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id C72366800E8;
	Tue, 24 Nov 2015 04:53:46 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151120140937.GA17079@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281614>

Jeff King venit, vidit, dixit 20.11.2015 15:09:
> What's cooking in git.git (Nov 2015, #03; Fri, 20)
> --------------------------------------------------
> 
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
> 
> Sorry for the extreme delay in pushing out my tree. I ended up busier
> than I expected during the first week of Junio's absence, and then it
> took me a while to dig myself out of the ever-filling hole of incoming
> topics. :)
> 
> Expect quite a few new topics in this edition.  A number of them have
> seen review already, and I'm planning to merge them to "next" fairly
> quickly (I may do another integration cycle late tonight or tomorrow
> with those changes).
> 
> I still have a few threads to comb through on the list. If you don't see
> the latest version of your topic here, please feel free to ping me, or
> to repost.
> 
> You can find the normal integration branches at:
> 
>     https://github.com/git/git/
> 
> and all topic branches at:
> 
>     https://github.com/peff/git/
> 
> But note that I will _not_ be pushing to kernel.org.

Does peff/git include the integration branches, too?

Also, that one should be uncontroversial (f[l]amous last words):

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation/diff: give --word-diff-regex=. example
Date: Fri, 20 Nov 2015 14:36:14 +0100

Message-ID:
<6697f80b679b2bc910aa02a0fc945453be38c532.1448026505.git.git@drmicha.warpmail.net>

http://permalink.gmane.org/gmane.comp.version-control.git/281520>

Thanks for your work!

Michael
