From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Everday contents
Date: Mon, 04 Aug 2014 10:00:15 -0700
Message-ID: <xmqqy4v4ry00.fsf@gitster.dls.corp.google.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com>
	<B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley>
	<xmqqegxcdjzl.fsf@gitster.dls.corp.google.com>
	<7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley>
	<xmqqvbqm74v7.fsf@gitster.dls.corp.google.com>
	<xmqqegx95bxc.fsf@gitster.dls.corp.google.com>
	<35435A61F3C04DC8924B2E2329F9461E@PhilipOakley>
	<xmqqfvhdtrbj.fsf@gitster.dls.corp.google.com>
	<E675F06626AA430EB89D68FF67734824@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 19:00:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XELcn-0008Tv-OS
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 19:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbaHDRAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 13:00:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54474 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbaHDRA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 13:00:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0C7C2E2EB;
	Mon,  4 Aug 2014 13:00:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qXjvodHtNLgnGnUo3zzKo2jnKZo=; b=X6l1CS
	hZpiFtrd3UYRAERMnsA/OGxNDyHPBoa2xGhuDDQUoniDQSyr5idDWZmm3rAtNq7f
	BzabOw4oezV2NoDgVRrc9BNRHkp4NH0NGIecVEGTfVIk4bgOQUGQNjtmIzBEK2XJ
	j2FI4kZ/4ty9VtPxSENrJNJLtUFBLTni7efaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RZ3138n3Q4ruLsTnGGbMchA34W5WoINR
	Pf1XQviwMjRb+hx3yQjZWfuwmYU1ocxRkSN/2p6OEdt2BKUZOMhxMv5emjEM2sxu
	7PStLHWCIVjIpAGeY4NImCkgK6brO1/W/OvUMcKY05i//n5dQ0Qs/Cqq23iDIWmi
	BAFsgQT1SdY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6FF32E2E9;
	Mon,  4 Aug 2014 13:00:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D2E132E2C8;
	Mon,  4 Aug 2014 13:00:16 -0400 (EDT)
In-Reply-To: <E675F06626AA430EB89D68FF67734824@PhilipOakley> (Philip Oakley's
	message of "Sun, 3 Aug 2014 19:41:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF1F9EC8-1BF8-11E4-8337-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254746>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> From: "Junio C Hamano" <gitster@pobox.com>
>>> Sent: Friday, July 25, 2014 11:08 PM
>>> ...
>>>>
>>>> | Individual Developer (Participant)[[Individual Developer
>>>> (Participant)]]
>>>> | ------------------------------------------------------------------------
>>>
>>> ...
>>>> | $ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL
>>>> <5>
>>>
>>> Would I be right that "ALL" can simply be dropped as something from
>>> back then' (13 Dec 2005 v0.99.9-516-g44db136) that I'm ignorant of?
>>
>> The answer depends on the reason why you want to drop it from the
>> example.
>>
>> That "ALL" is merely a branch name, like "master", etc.
>
> That was the bit I was missing. I had it in my head that it was
> possibly some historic option as it was in caps.

Yeah, I suspected as much ;-)  Thanks for a careful reading.
