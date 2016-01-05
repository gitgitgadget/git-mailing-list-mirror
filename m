From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2016, #01; Mon, 4)
Date: Mon, 04 Jan 2016 19:36:05 -0800
Message-ID: <xmqqy4c4k89m.fsf@gitster.mtv.corp.google.com>
References: <1718717.tR0GOgDc0N@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Will Palmer <wmpalmer@gmail.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stephen & Linda Smith <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 04:36:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGIPt-00055U-61
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 04:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbcAEDgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 22:36:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751925AbcAEDgI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 22:36:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F9E938733;
	Mon,  4 Jan 2016 22:36:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l2kgF1ne51w6u1yfEsR0Hl5OAM0=; b=oYS8Pw
	OpKFyQv+7N3jgSt87feM46iQLU/HXSM8Dfe17/eE/vIjoPmfaVBZvgDLpj9KQKPl
	lCWps4JKi32af19AVygyn4hiFxycsXUZRPAD2MrSyhxvQoDkXgE9mVo2gVX+9IJ8
	5m1pNBzFIv/TCtSG0hbHUxsvPrcuDuhjE9/Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Euqdz1PHy1xngvmQVmU2H264Ohq676tN
	iy5M4Zcs7Zp1YmBNRpLiJmfy0c96vWFk9/dna13JkrWC2lE/v2rb1Zn6fB7u0Mhc
	3B3nHboeE0OYFwCHHT/fVHbOODrQUvpgsY+7bz1q/YbpR5rbDEPzR47mB8a9ACtP
	6RMePzHRKB4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6461C38731;
	Mon,  4 Jan 2016 22:36:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DAB5A3872E;
	Mon,  4 Jan 2016 22:36:06 -0500 (EST)
In-Reply-To: <1718717.tR0GOgDc0N@thunderbird> (Stephen & Linda Smith's message
	of "Mon, 04 Jan 2016 19:44:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 744B7564-B35D-11E5-A57C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283343>

Stephen & Linda Smith <ischis2@cox.net> writes:

> On Monday, January 04, 2016 03:44:33 PM Junio C Hamano wrote:
>>  Becoming tired of waiting for a reroll.
>>  ($gmane/271213).
>>  Anybody wants to help rerolling this?  Otherwise will discard.
>
> <snip>
>
>> Becoming tired of waiting for a reroll.
>>  Anybody wants to help rerolling this?  Otherwise will discard.
>  > ($gmane/272180).
>
> What do you mean by rerolling this?  If you mean that you would
> like someone to pick up the patch and try and get it though then I
> don't mind helping.

More or less.  I do not mind if these topics disappeared, either,
but we have spent review and discussion bandwidth for these
unfinished topics and we may want to take them to the completion.

> For my education, how does this affect the sign-off proceedure?

Depending on the extent of changes from the original version, either
you take the authorship (with comment in the log message saying that
it is based on Such and Such's patches) or you still keep them as
the author (with comment in the log message saying that you extended
it in such and such way).  In either case, as long as their original
remains in the resulting patch, you retain their Sign-off and then
add your Sign-off at the end.

If you take the ideas from their series and rewrite everything from
scratch, you would take the authorship, with comment in the log
message saying that you took inspiration from Such and Such's
patches, and have only your Sign-off.
