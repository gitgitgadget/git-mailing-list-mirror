From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Mon, 23 Mar 2015 16:46:45 +0100
Message-ID: <55103565.9040000@drmicha.warpmail.net>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com>	<CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>	<xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com>	<CAGZ79kaDnRiUQ6=3gVvsPrkSzkNbACRvgQBSo8gmpRZ8bka84g@mail.gmail.com> <xmqqmw37cn18.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Schneider <thosch97@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 16:46:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya4Z4-0002ew-16
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 16:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbbCWPqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 11:46:49 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48191 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752135AbbCWPqs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2015 11:46:48 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 038F720480
	for <git@vger.kernel.org>; Mon, 23 Mar 2015 11:46:44 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 23 Mar 2015 11:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	x-sasl-enc:message-id:date:from:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	 s=mesmtp; bh=EOQ9aHX4H+Ld/SGQnel1OKM/RSY=; b=TuZXrrSS5Zdf8Xnpyn
	2R5JnGj23EIhdh5ZFDTANkNnO/ctfoP1MGfr9/fzpMYqtkyWJheMRm/ch+trnkaD
	LmNcb8cby7UsA2KhJ5oyGA6GMCrq1a2g15n7J5pfTDJPwm0tXR1pIZ42Is9JrlBS
	P9G3uPYXDI8M+wv6JxOGqV+ac=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=EOQ9aHX4H+Ld/SGQnel1OK
	M/RSY=; b=aPMWIaCIerPXMIZRsZ21Lr1obZ8txVJtVLInjc68ouP0iCkVkIaJ0m
	X/Frv6+l+2MX6w2b377OYvAl6usJlnbpMXw7wkqvhlLK1IakiYKSIY/jboq+7rk3
	CaT2P7uNzSHkP7vRbhUV3CUdzhIzEI8paInOn73o1ZLeOLfew8V6w=
X-Sasl-enc: JgNSkw4lstnR/5LEkNa1laRBw3YRxk2SE3TjqwJoukb9 1427125607
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C899BC00011;
	Mon, 23 Mar 2015 11:46:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqmw37cn18.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266144>

Junio C Hamano venit, vidit, dixit 20.03.2015 23:38:
> Stefan Beller <sbeller@google.com> writes:
> 
>> Thomas referencing reading the man page offline, made me wonder
>> why you wouldn't read the man pages itself as they can also be
>> carried around offline. But the striking point is "on an iPad", which
>> doesn't offer you the convenience of a shell etc, but pdf is fine to read
>> there. Also you can add comments to pdfs more easily that html pages
>> I'd guess.
>>
>> So the patch makes sense to me now. It's just a use case I'm personally
>> not interested in for now, but I don't oppose it as is.
> 
> Well, my comment was not about opposing to it, but was about
> questioning the usefulness of it, iow, who would
> benefit from having this patch in my tree?
> 
> I didn't see (and I still do not quite see) why people would want to
> have separate pdf files for all the subcommands (instead of say an
> .epub or .pdf that binds all the man pages and perhaps user-manual,
> just like we do for .texi/.info).

Exactly. For PDF, a combined document is more natural and will hopefully
make crosslinks work as crossrefs within one document, rather than links
to external documents. I'd say that would make a valuable target.

Michael
