From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add two grep config options
Date: Mon, 28 Mar 2011 10:14:52 -0700
Message-ID: <7vr59ryxo3.fsf@alter.siamese.dyndns.org>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
 <7vlj024wal.fsf@alter.siamese.dyndns.org>
 <4D9037AA.9090601@drmicha.warpmail.net>
 <AANLkTin_qeFSqyXHddmEpu=5e4yO8cxyOkbhcXUg3efn@mail.gmail.com>
 <AANLkTin_qRH54C0wKML67gftS05X98sKE+AxHJ4xo77C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Joe Ratterman <jratt0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:15:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4G27-0002dI-Kq
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 19:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab1C1RPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 13:15:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab1C1RPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 13:15:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26E5345AC;
	Mon, 28 Mar 2011 13:16:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m1DMdYaXvTieuHDQITWCbPj1ZYM=; b=KABjHt
	luuinv462Lc+cXn13NlzK623ML8LLyzN1ccF4s4zanBPOCRrxYNSZRhfGRxpHf6u
	eRfwRBOkxIeUcgMhwcLra5dy4KqT+f0gJo5MWhHm11t5Ry4/ISx7/BXX2jMa3teA
	qiD51wCNGLJWOClKc21wsopv51pVxYCvwO5fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jc5DIDGmghdPe5oK5Hbl9cjJg6YZwUaj
	OPI122rW2KBKXOS4pffmLRcsMzNOUav7f6fl8dPfIqL0Aa8BW6ajD2c0imAVjzHZ
	6QaPC174fzN2uxnKOIxMoOh6dd5HtuWFm+yuJYORRAy7YLFZRPC8u6P+FIJMzvBh
	vJgyelCH1Ko=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C87C045A8;
	Mon, 28 Mar 2011 13:16:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B4BA145A5; Mon, 28 Mar 2011
 13:16:40 -0400 (EDT)
In-Reply-To: <AANLkTin_qRH54C0wKML67gftS05X98sKE+AxHJ4xo77C@mail.gmail.com>
 (Joe Ratterman's message of "Mon, 28 Mar 2011 09:48:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29AEF4AC-595F-11E0-BEE4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170161>

Joe Ratterman <jratt0@gmail.com> writes:

> With regard to disabling the line numbering, GNU grep supports both -n
> and --line-number.  Adding the latter option to git grep allows for
> the long form --no-line-number.

Yes, that is something we would probably want regardless of your patch we
are discussing in this thread, if only for helping people who are used to
the GNU way.
