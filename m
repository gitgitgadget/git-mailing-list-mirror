From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: "HEAD -> branch" decoration doesn't work with "--decorate=full"
Date: Wed, 13 May 2015 17:26:32 +0200
Message-ID: <55536D28.6070001@drmicha.warpmail.net>
References: <55534D95.60609@alum.mit.edu> <xmqq617wbkez.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 13 17:26:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsYYT-0007kM-8e
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 17:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934447AbbEMP0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 11:26:36 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42768 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933546AbbEMP0f (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2015 11:26:35 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 612EA205BB
	for <git@vger.kernel.org>; Wed, 13 May 2015 11:26:34 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 13 May 2015 11:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=P2ckLtTh8SVIdU/YkXWj6MYqYE0=; b=mA/KeF
	tf360i7eniVMEbVUcoUB7VT41QNAkHNDRVcSq7tG+GcPZLI3qLnsRS+9cFRykK14
	VGbPlxIAWRRRqonWaP7IlOQP6Ybb/zs0TSQepLpYfrilN7lEC09giLR2dKqV397f
	PnH7o7Gk1U4Cq30Sclaaz5gZ9b9pLHQOZYBH0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=P2ckLtTh8SVIdU/
	YkXWj6MYqYE0=; b=b394SBXmRi4cp9/g7bS7DGLzNFzUyR3LiRQYORAiw7viDlb
	q2DmWm1yEToGiPaDdMdi6HUhOn4NWfWAHtGu6UcWgAAIJcXYD4yhEv702/BGH5NO
	bp2Wlk8oxl9d9zVshpuWPwh0lel2USAvsrPu6GzUJCdNwqdOnKG9U3wQE28Y=
X-Sasl-enc: VDLmcicX9NECcPSSj4+0CtUQwaW44yMKwUSr3EQ04h+s 1431530793
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8FE136800AD;
	Wed, 13 May 2015 11:26:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqq617wbkez.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268988>

Junio C Hamano venit, vidit, dixit 13.05.2015 16:51:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The new-style "HEAD -> branch" style decoration doesn't work when
>> "--decorate=full" is used:
>> ...
>> Was that an oversight or a conscious decision?
> 
> I do not recall making such a decision, and I doubt (the other)
> Michael wanted that way, either, so patches welcome, perhaps?

I was not aware of an alternate codepath for full decorations (and am
surprised about it).

I can't look into this before next week, but --decorate=full should
produce "HEAD -> refs/heads/master" and such.

I even vaguely remember testing it, but that may have been for v1 which
turned different knobs than the end version.

Michael
