From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/6] builtin/verify-tag: change variable name for readability
Date: Wed, 06 Apr 2016 09:46:58 -0700
Message-ID: <xmqqfuuyy9a5.fsf@gitster.mtv.corp.google.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<1459872449-7537-4-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Wed Apr 06 18:47:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anqbl-0007aw-Qf
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 18:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbcDFQrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 12:47:03 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750748AbcDFQrB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 12:47:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 428D052883;
	Wed,  6 Apr 2016 12:47:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KD1lD3zBphvb/5ec4QmlTOpPEHc=; b=Z5EPiz
	Sxb3719n7TVWiN/i3ttsSk1lSAJJHf1jMttW6nu8OCPBt3GvEMAJXJP7U+P9QoIi
	7O/3xwbAmVNc0fv5qHnZztE5cQ9UbA8vE1zu0OIKatqNjBbyaA+zJnn0OK6TNpNJ
	dOY1lRJjS5p6jD93oDg7wz2GKsRozkXwV0kyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b5PO5QWGku2hzf1MK20ekOYB2isnGiEh
	3fLGuk8DytDId6Pix+YUhJrWECjtuBYDDEjUkhUTC76thAc8b+XlceoOvFGx3RtC
	3rcnUPJa3lmPpNkuYewvdxEYoZNfDmCjoG7btK/DQtzgHaBHbC4DhD9K6x62QuH2
	4IPLT4QLMO4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2754052882;
	Wed,  6 Apr 2016 12:47:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8A24652881;
	Wed,  6 Apr 2016 12:46:59 -0400 (EDT)
In-Reply-To: <1459872449-7537-4-git-send-email-santiago@nyu.edu>
	(santiago@nyu.edu's message of "Tue, 5 Apr 2016 12:07:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E4B6D32-FC17-11E5-BE77-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290852>

santiago@nyu.edu writes:

> From: Santiago Torres <santiago@nyu.edu>
>
> The run_gpg_verify function has two variables size, and len. 

I somehow found this harder to parse than necessary.

> This may come off as confusing when reading the code. We clarify which one
> pertains to the length of the tag headers by renaming len to
> payload_length.

I'd rephrase it like so:

    verify-tag: change variable name for readability

    The run_gpg_verify() function has two variables, size and len.
    This may come off as confusing when reading the code.

    Clarify which one pertains to the length of the tag headers by
    renaming len to payload_length.

The patch text looked good.
