From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] utf8: fix duplicate words of "the"
Date: Fri, 06 May 2016 10:28:56 -0700
Message-ID: <xmqqoa8j3xk7.fsf@gitster.mtv.corp.google.com>
References: <1462537893-18493-1-git-send-email-lip@dtdream.com>
	<20160506130922.GA5051@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Li Peng <lip@dtdream.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 06 19:29:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayjYm-00008N-Rv
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 19:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758551AbcEFR3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 13:29:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758161AbcEFR27 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 13:28:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31035191E0;
	Fri,  6 May 2016 13:28:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nLbUZBQUYQ+s475AZJnNFtQsPxw=; b=a7Sw3H
	RShMrC8olTDCtU+9mMmJL2DXj6PNbinhXDAFcgjv0P3HOHxC8ib9dQwbYNO7WxFt
	Yn5uVLW4Mx8Y80zF/SlKc48ai48KzNM5zXzLUs7m0EQpiMS+sn+HF94Z79SqyZRS
	+oudgivP3/zHn/xm6pxvZrbPXNwrcdxjFVKJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vcah5cHkeSMrtHO7xYO1G16ZPKPC2PRU
	+WSfP+Oz5RInLTmjVuYKwCjm+dN8UaJLq8hn8bf+LyLCytQ9nbqXXOdElSmk+kmh
	N2sef70+B7i5G8uy1vmzjQOwYNBfsMCqQtq/WqH6/3YGQQ7xZWv9TffgcjwDdi3P
	gNr8VlqmVHA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 28990191DF;
	Fri,  6 May 2016 13:28:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9120E191DD;
	Fri,  6 May 2016 13:28:57 -0400 (EDT)
In-Reply-To: <20160506130922.GA5051@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 6 May 2016 09:09:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 038C0006-13B0-11E6-B16E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293838>

Jeff King <peff@peff.net> writes:

> On Fri, May 06, 2016 at 08:31:33PM +0800, Li Peng wrote:
>
>> Fix duplicate words of "the" in comment.
>
> Obviously a good change, along with the other one of mine you found.
>
>> ---
>>  transport-helper.c | 2 +-
>>  utf8.h             | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> You seem to be breaking these up by file; was the change in
> transport-helper supposed to be in a different patch?
>
> IMHO it would be fine to just do all of these in a single patch. They're
> different files, yes, but it's all conceptually the same change.
>
> -Peff

I can squash them into a single one.  So far, everything except two
I saw was good.
