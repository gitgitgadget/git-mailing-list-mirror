From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] push: allow --follow-tags to be set by config push.followTags
Date: Sat, 14 Mar 2015 15:08:22 -0700
Message-ID: <xmqqk2yjw7u1.fsf@gitster.dls.corp.google.com>
References: <20150216061051.GA29895@peff.net>
	<20150216061619.GC32381@peff.net>
	<xmqqh9toxgdd.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.2.11.1503141049080.16979@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 23:08:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWuEP-0004Gw-C6
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 23:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbbCNWIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 18:08:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbbCNWIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 18:08:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0760B3E65E;
	Sat, 14 Mar 2015 18:08:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qrPJICj2nzA9E36oNglE2+KiLYc=; b=Syp/Ut
	Es2+1GdF2b0TOgQ25r6NTGAQQisBEmFeZ8SDuHq7u0/FR8TJRi0BV/uV42BWFu0h
	uPl+VP4AgplXdZZOtRIkFBjVFFxVNN2HyQS8FbPJmjJ7PW3Yx85M2SNkvPfmtZUJ
	gCNX3ThRxgnI5I8wu/rLrz53Be1AQr4wvyKa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NtwhpBkAM/sVPhOnaOfiKtlrsWiHfZ0T
	Dniv0xXTwSJsbIBOyMmil2uGn1VNK/S0+qWofXRrA63qSdTW+pUVE9YT5hXKPNed
	FmEGcrdS50T62ukCPkSjcsQov28ZafAHciPe8l9F6jAbkHskdGGC/HxmUqyKBxEZ
	0ut0+cPNvHI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00E0D3E65D;
	Sat, 14 Mar 2015 18:08:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7196C3E65C;
	Sat, 14 Mar 2015 18:08:23 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.11.1503141049080.16979@narbuckle.genericorp.net>
	(Dave Olszewski's message of "Sat, 14 Mar 2015 10:50:20 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1B3B116-CA96-11E4-86EF-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265462>

Dave Olszewski <cxreg@pobox.com> writes:

> On Fri, 13 Mar 2015, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > From: Dave Olszewski <cxreg@pobox.com>
>> >
>> > Signed-off-by: Dave Olszewski <cxreg@pobox.com>
>> > ---
>> > Again, this is just a preview. Dave should send the final when he thinks
>> > it is good.
>> 
>> Dave?
>> 
>> I do not see anything wrong with this version that builds on top of
>> the previous 2 clean-up.  Personally I find that these clean-up
>> changes more valuable than I care about this particular feature, and
>> it is unfortunate that waiting an Ack or reroll of this one kept
>> them stalled.
>> 
>> I am tempted to throw "Helped-by: Peff" into the log message and
>> merge the result to 'next', unless I hear otherwise in a few days.
>
> Sorry, work has kept me very busy lately, I haven't had time to re-visit
> this.  Jeff's version looks great to me, please go ahead with it.
> Thanks everyone.
>
>     Dave

Thanks.
