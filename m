From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] grep.c: mark private file-scope symbols as static
Date: Wed, 19 Sep 2012 13:46:41 -0700
Message-ID: <7vfw6dg2q6.fsf@alter.siamese.dyndns.org>
References: <5054AA62.2040603@ramsay1.demon.co.uk>
 <1347743452-2487-1-git-send-email-gitster@pobox.com>
 <1347743452-2487-5-git-send-email-gitster@pobox.com>
 <505A08A1.1080303@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:46:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TERAa-00038G-Sa
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 22:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab2ISUqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 16:46:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647Ab2ISUqn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 16:46:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26E76904A;
	Wed, 19 Sep 2012 16:46:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SqczS8MO3Zap5ARG9Zq4fxZRBkI=; b=DILK/F
	Cz2iQg2ZBXe3Wg1qv5qB6o7SZujzxU6Mmq6D3c8vGm7EpqZy1dHgoNvnnXA9Ew37
	rUWjabvwfZ05ljgrB5/DOO7nGGRGO4KxoHXOMwoTSn0vnPpJGlnuikTfkJwkV8f4
	AgOjjdpFsm7D9aihZl9rIz1ByNCC3FvEd2738=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aNWj6z16ooUOST7NbucfiA4Vhlqsjh73
	RDqsC/8Bts9l+N8GnxtRRf+yb9Od8zG8WGYNF50Y460aoPcMnclpDvIzFDoDoaJa
	T+QMpinJsV+Kf/T1XLudennuT/4Nh2Pvbb/m/PVWFv+2ATZWKGxLOwCSKIgSa1g5
	jVI7PEIiRHY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 147389049;
	Wed, 19 Sep 2012 16:46:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89CEE9047; Wed, 19 Sep 2012
 16:46:42 -0400 (EDT)
In-Reply-To: <505A08A1.1080303@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Wed, 19 Sep 2012 19:02:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E478066-029B-11E2-8C79-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205999>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Heh, so I obviously didn't see this before sending the patch yesterday! :-D
>
> Yes, this solves the problem addressed by yesterday's patch, so please
> ignore that. However, this tickles sparse to complain as well ... ;-)
>
> New patch on it's way.

Are you sure the patch you are responding to really "tickles
sparse"?

You have another grep.c patch timestamped two minutes after the
message I am responding to, and as far as I can see, it is a subset
of the patch you are responding to with the message I am responding
to.
