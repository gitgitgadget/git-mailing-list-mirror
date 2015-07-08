From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Draft of Git Rev News edition 5
Date: Wed, 08 Jul 2015 09:22:38 +0200
Message-ID: <559CCFBE.9000702@drmicha.warpmail.net>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>	<20150705191101.GB9815@flurp.local>	<CAP8UFD3pD_6_SrrtCWywA8x5XY_SD3bed=QhZBBrTq0zQvqFPw@mail.gmail.com>	<CAPig+cTpy32c13Sv=m49hzqOBisZ0v07AT0X5BYNB07acrcW8w@mail.gmail.com>	<CAEcj5uXiGVvLm==s_SB7GnvBfuKi7j4yH+fgNq4JZtkvK7pZwg@mail.gmail.com> <CAPig+cRv6g_nAEdGtrESFiE+5+OxEHwjhEPX0Q0WL+eHzkCAGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Eric Raible <raible@nextest.com>,
	Emma Jane Hogbin Westby <emma@emmajane.net>,
	Max Kirillov <max@max630.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	karthik nayak <karthik.188@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 09:22:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCjgt-0006zD-Jx
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 09:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbbGHHWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 03:22:43 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48408 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932771AbbGHHWl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 03:22:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3A38D20476
	for <git@vger.kernel.org>; Wed,  8 Jul 2015 03:22:41 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 08 Jul 2015 03:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=u0GjuMMmsOErlJ0h5crSGZBGRag=; b=NrWhpY
	rk/oCQATW7sGwaaYKxHPmAKe5NE7pHRiTN19hyxpRZR7K2D2vfEYTBd71n5Uv7A1
	7YsM9drwSwgVYF3dWus3hL+qMGSU6rv3AhgWfU6IYzlSLSPjOP2QDzijBd3wDF7m
	vHWd7E8B2QjaQBBQuR49c1FbNgTuJ4YcVYvts=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=u0GjuMMmsOErlJ0
	h5crSGZBGRag=; b=NLfxv6H66pRdLzgn2YrDjLM7c2fPzarGqfjWmH5JPbotCFD
	nt/GnaZpmN9qlXjgsJCxY1YEA22BZOYYoeQUbkTM0Up81fgcNntXSp7Q9XM06I7s
	Lj6VwG+ySbuLX0myfpkG0FE15AI5MXnoMil5dbrvfG8WX/E1iNrDf4WTxPps=
X-Sasl-enc: UOecgTtJHMWuMG8zC6etPGuH7SJdhVrVSmCHOuVMWW/8 1436340160
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F2B63C00023;
	Wed,  8 Jul 2015 03:22:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cRv6g_nAEdGtrESFiE+5+OxEHwjhEPX0Q0WL+eHzkCAGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273642>

Eric Sunshine venit, vidit, dixit 06.07.2015 01:12:
> On Sun, Jul 5, 2015 at 6:35 PM, Thomas Ferris Nicolaisen
> <tfnico@gmail.com> wrote:
>> On Mon, Jul 6, 2015 at 12:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> Unfortunately, the non-ASCII characters
>>> in Duy's name got corrupted, and the botch is present in the patch I
>>> sent. Sorry. Not sure how that happened. Can you fix it locally?
>>
>> Fixed [1].
>>
>> [1] https://github.com/git/git.github.io/commit/b5f7d6523ca6a634d568fc9017135ff2a9ea6462
> 
> Thanks.
> 

Maybe a matter of taste, but I think in general we could do with a bit
less of "narrating" and more of "summarizing".

Just as an example, in the section on "visualizing merge diffs after the
fact", few people will be interested in the detail that I pointed out
the "--merges" option of rev-list to Dscho. While that recollection is
true and everything on the git-ml is public, I consider "Git Rev News"
to be "more public", targetted to a wider audience than the regulars.
They don't all know how much Git owes to Dscho. If things like this end
up in the news it makes me ponder for each on-list reply whether I'd
rather reply in private. Maybe I'm being overly sensitive (though not
affected in this case), but I just feel there are different degrees of
"public".

The pattern "...led to a discussion [between...] that resulted in..."
that we have in other places seems to be a good guideline.

Michael
