From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: don't output non-errors on stderr
Date: Fri, 25 Jun 2010 10:25:56 -0700
Message-ID: <7v1vbvkorf.fsf@alter.siamese.dyndns.org>
References: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
 <1277418881-11286-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 19:26:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSCfM-0004vw-B9
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 19:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575Ab0FYR0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 13:26:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab0FYR0F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 13:26:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A3F3ABDE31;
	Fri, 25 Jun 2010 13:26:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KbwRFxgPT8Ij
	Nmjrznr1s7yJ0jE=; b=KEHNCMT7FZsf0H9cm48sW9Qqy62vo0WSk5nlyoPkeH8f
	4tXqEiasZJS+bjtI5js5FUdgRtOp2alj8bhaOoZT0I+Ab5LysfgJn7u1Ml2JYoIm
	0qxtXPZfdRJDwr6wnsYxC6jT02iAoiMTvjqB33JVEYl6lg1angHaFTw4uTmNKug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dZK0lE
	J540ZC8PXHNYEE6ijH4JFcbNWxp69XrXGoQfkUOC/LSqFjEBiQ7khBqXqmRexBZt
	OPNfYzKeHIQv1gTVdO5mvAz7lDZshXeOh9kw3lfhIvhHH8BxDKwpPlF6aqjic1a2
	HTFyXOiU7i2LfuppnaanqMIa3aVbJB83dxwew=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73CF5BDE2F;
	Fri, 25 Jun 2010 13:26:01 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BABBBBDE27; Fri, 25 Jun
 2010 13:25:57 -0400 (EDT)
In-Reply-To: <1277418881-11286-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 24 Jun
 2010 22\:34\:41 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9B7FAB8-807E-11DF-84D5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149699>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Before the change error messages were drowned out by git-fetch's
> non-error update notices, which didn't need my attention.

I don't understand this part; care to elaborate?
