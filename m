From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] Documentation: git-init: template directory: reword
Date: Wed, 06 Aug 2014 10:21:33 -0700
Message-ID: <xmqqwqalmt42.fsf@gitster.dls.corp.google.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
	<1407002817-29221-4-git-send-email-linusarver@gmail.com>
	<xmqqmwbioaeh.fsf@gitster.dls.corp.google.com>
	<20140806051517.GB12559@k0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Arver <linusarver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 19:21:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF4uL-0002rn-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 19:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600AbaHFRVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 13:21:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59347 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757589AbaHFRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 13:21:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 883862E4F5;
	Wed,  6 Aug 2014 13:21:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2EEPtIYZNNzk/UehWDLz5htb3JA=; b=n4nQA9
	kd3HnrabRNcHki6KnqyPa9D/HJFIJt6ih0mw9nNGs0S/Ku5EFFQclGTKiKiP9jkT
	HbWCod4EGP/8QmRzcmGsBnkBXrniLyZ+oi+TnD2p2qiJHKLad/vJH2tfRj2x3bIa
	+F6zwzqxBQrKnqQJXZB7tSrXCqlpFToPZsHVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z4eESgADl1R3TphwyXqxaIuOMxWmv3ho
	jtAavIZMn31o5u8ea69ldhFxa4LlbHOA2Ga2EkHfDLleUIANtZl1598ykw5F2WDh
	K3agBHZ7tED52AR5YeakMGkjJp1u0rZgNK6uBIE4/hiw5n8ebVAUUqPq4snVYlJ6
	GC2lxZpIPAY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D6CA2E4F4;
	Wed,  6 Aug 2014 13:21:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7A0762E4E6;
	Wed,  6 Aug 2014 13:21:36 -0400 (EDT)
In-Reply-To: <20140806051517.GB12559@k0> (Linus Arver's message of "Tue, 5 Aug
	2014 22:15:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1EABB846-1D8E-11E4-929C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254879>

Linus Arver <linusarver@gmail.com> writes:

> No, the unindenting/removal of blank lines is a non-grammar change and
> is not necessary, as it doesn't have any effect on the actual output
> (html/txt/manpage).
>
> I can either keep the same coding style with the rewording, or chop this
> into two commits, one for the rewording and another for reformatting.
> Which one do you suggest?

If I were doing this change, I wouldn't touch the formatting,
because I did not find that the reformatted version would be any
easier to read or maintain compared to the original.

But I suspect that you must have thought the reformatting was a good
thing to do for a reason, and I suspected I might have been missing
something obvious to you, and that was why I asked.  If there is a
good reason to reformat, then lets hear it in the commit log message
of one of the two patches.  Otherwise we can drop the reformatting
part.

So my suggestion would be a patch #1 to reword, and optionally
another patch #2 to reformat on top, if (and only if) there is a
good reason to reformat.
