From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] notes: mention --notes in more places
Date: Thu, 18 Oct 2012 14:11:57 +0200
Message-ID: <507FF20D.6030106@drmicha.warpmail.net>
References: <1350443975-19935-1-git-send-email-eblake@redhat.com> <20121017055136.GA12301@sigill.intra.peff.net> <507EB310.8020904@redhat.com> <20121017190507.GA17648@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <eblake@redhat.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 14:12:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOoxQ-0006BD-5C
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 14:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359Ab2JRMMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 08:12:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34630 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753957Ab2JRML7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2012 08:11:59 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CF4C820701;
	Thu, 18 Oct 2012 08:11:58 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 18 Oct 2012 08:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=kaqjFe+vDcG2iyPKpwIHrY
	SI3js=; b=rfS+9dwWWbzFQjNnFc23HB8F4NKylAJTv1aHD6A0+KDmnqGdM99GSg
	gJbc7A9pd6oCQtqZjyOnd2Vd1EAM4wSHRloxtrIspNAupWXmz108PE7JXeSbPTl0
	YOgbNXapVZs5c1959ZC/+CA1rBxp9C/mokADTj/2sAmeOyJXuoiDM=
X-Sasl-enc: YIvYO2cF0ehR1poxaTIjj37PoMsJrEdOui9ToVQp/Hba 1350562318
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 205A64827F6;
	Thu, 18 Oct 2012 08:11:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <20121017190507.GA17648@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208002>

Jeff King venit, vidit, dixit 17.10.2012 21:05:
> On Wed, Oct 17, 2012 at 07:30:56AM -0600, Eric Blake wrote:
> 
>>> We've talked about it several times, but it's never happened (probably
>>> because most people don't actually use notes).
>>
>> And people (like me) don't use notes because they aren't documented.
>> Catch-22, so we have to start somewhere.
> 
> Oh, I definitely agree your patch is the right direction. I was just
> explaining why it hasn't happened, even though people think it's a good
> idea.
> 
>> I'll submit a v2 with the non-controversial edits, and spend some time
>> trying to figure out how to isolate the portion of pretty-options.txt
>> that is relevant to format-patch.  If it's easy enough, I can also
>> consider using --- instead of Notes: as the separator when using
>> format-patch.
> 
> Hmm. After digging in the archive, it seems we (including both you and
> me!) have discussed this several times, and there are even some patches
> floating around. Maybe one of them would be a good starting point for
> your submission (I did not read carefully over all of the arguments for
> each):
> 
>   Patch from Thomas, Feb 2010:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/139919/focus=140818
> 
>   Discussion between us, Dec 2010:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/163141
> 
>   Patch from Michael, Apr 2011:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/172079

That one used to work for about one more year or so (it went through a
few rebases) but stopped working during some rework involving the
signature (signed-off-by), i.e. it puts the notes before the signed-off
now. I didn't update it because nobody seemed interested anyway (and
because branch-notes got implemented in a different, non-note way, so I
dumped that part of my workflow also).

Michael
