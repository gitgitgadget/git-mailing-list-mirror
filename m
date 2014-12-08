From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 0/5] git-glossary
Date: Mon, 08 Dec 2014 17:41:35 +0100
Message-ID: <5485D4BF.7010700@drmicha.warpmail.net>
References: <cover.1418052470.git.git@drmicha.warpmail.net> <CAP8UFD0yRKRPj3x6jZoL72jkzs0T2vZ0HZVi46zX0gzXqGv_Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:41:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy1NV-0003R5-DT
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbaLHQlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:41:37 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40624 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751520AbaLHQlh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 11:41:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 7F80520B15
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 11:41:36 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 08 Dec 2014 11:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ue8stIj1rTxpWIbzwVSAnB
	TZdbE=; b=YSnet0bYr3IbwxxVTHcyboTlftZE3DRm0XKJdhY8srLtMxd5M4+EJf
	Y8dhJTjaXBD00y+EsGvKH95j80aEBN541+X0bhd+TaNuctffVucXGXUlT5fcqcaP
	VjIUaDD1/wbdNn1IM0zPWyhwqiGY+4xn9n/6e92AYBnzUWSyzla68=
X-Sasl-enc: S4gJ8KkyC+4xf9Yxwbz9Iw8E/FGF6IO5oSJBIWqy14ex 1418056896
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0BE27C00282;
	Mon,  8 Dec 2014 11:41:35 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CAP8UFD0yRKRPj3x6jZoL72jkzs0T2vZ0HZVi46zX0gzXqGv_Sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261078>

Christian Couder schrieb am 08.12.2014 um 17:16:
> On Mon, Dec 8, 2014 at 4:38 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> More and more people use Git in localised setups, which usually means
>> mixed localisation setups - not only, but also because of our English
>> man pages.
>>
>> Here's an attempt at leveraging our current infrastructure for helping
>> those poor mixed localisation folks. The idea is to keep the most
>> important iterms in the glossary and translate at least these.
> 
> If the problem is related to all the man pages, shouldn't the solution
> apply to all the man pages?

Huh? I'm not going to translate the man pages.

This is about providing a localised glossary. It just so happens that we
have a glossary as a man page already, so I'm leveraging it.

>> 1/5: generate glossary term list automatically from gitglossary.txt
>> 2/5: introduce git-glossary command which helps with lookups
> 
> Couldn't you improve git-help ?

I think git help is good as is.

Or do you suggest integrating the glossary lookup command in "git help"?
For my taste, "git help" does a lot of magic already (in terms of
revolving "foo" in "git help foo"). What it does not do is translating.
Integrating "glossary" in "help" would require the use of mode changing
options to get the same functionality as "git glossary" and "git
glossary foo". So, git help is really for help about commands, and git
younameit for localised help about terms.

Michael
