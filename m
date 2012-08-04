From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Sat, 04 Aug 2012 16:05:15 -0700
Message-ID: <7vpq768dhw.fsf@alter.siamese.dyndns.org>
References: <20120803160229.GA13094@sigill.intra.peff.net>
 <1344023835-8947-1-git-send-email-michal.kiedrowicz@gmail.com>
 <20120803200201.GA10344@sigill.intra.peff.net>
 <7v3943bsuc.fsf@alter.siamese.dyndns.org> <20120804000904.13c4162b@gmail.com>
 <501D4FF0.4060109@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 01:05:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxnPx-00048j-Ul
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 01:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085Ab2HDXFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 19:05:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071Ab2HDXFS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 19:05:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A21C99591;
	Sat,  4 Aug 2012 19:05:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VVLyZDS4JyYtaEL16BhS02RRRsA=; b=iusjgH
	cZI1BsjTemL6VEXuLx6Gs41TH8AhwQwRzCcye2RHuOS0lwgJwPUVlGwQV3ztb1MB
	zbvLqS4+uy9e7Ww1xRC08vrYcEppkABLFN4rjwdvADj81XVRJ+FILgFhf/XROgJ9
	FQxr86EghRfgvTaZxGuUht0JPMeqLjsaEFxdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OnkZLdwDlNwMYibqayClnQhGx3tRQfEl
	NcIuRYmxCCEA2cJuf4SQV9CawLMqPaH/pDpuG0e60srSi/z2n2YjUVj5G98+Io6y
	C3OE6hof3qG89x+8KUraJr4rt58jrotDh/pH6Ec+uKmNfwxunghEKc+IwzhTkOz4
	qX4Cq3MlVSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88E099590;
	Sat,  4 Aug 2012 19:05:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFD4C958D; Sat,  4 Aug 2012
 19:05:16 -0400 (EDT)
In-Reply-To: <501D4FF0.4060109@kdbg.org> (Johannes Sixt's message of "Sat, 04
 Aug 2012 18:38:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB048118-DE88-11E1-AE0F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202897>

Johannes Sixt <j6t@kdbg.org> writes:

> And the reason for this is that we always told people "don't use seq"
> and they submitted an updated patch. What would we have to do now? We
> have to tell them "don't use seq, use test_seq". Therefore, the patch
> does not accomplish anything useful, IMO.
>
> The function should really just be named 'seq'.
>
> Or how about this strategy:
> ...
> but it is not my favorite.

Why not?  That implementation looks like a logical and natural
consequence of "should relly just be named 'seq'" suggestion.

Having said that, we already say "don't use cmp, use test_cmp", so
it might not be such a big deal, even though I find the reasoning in
the first paragraph I quoted above from your message quite sane and
convincing to me.
