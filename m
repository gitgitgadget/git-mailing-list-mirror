From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff-tree does not use alternate objects for submodules
Date: Tue, 08 May 2012 08:37:28 -0700
Message-ID: <7vwr4my98n.fsf@alter.siamese.dyndns.org>
References: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com>
 <7v1umuznuj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad and Raizel Shaneh <orgads@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 17:37:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRmTo-00085v-9F
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 17:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab2EHPhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 11:37:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756106Ab2EHPhb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 11:37:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C525777AA;
	Tue,  8 May 2012 11:37:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Zy8ZirBpwAVpicimd4b2xLDuFQ=; b=rqrVt6
	F/qkkeFVCZm/Vdsl4lABz9/l598S/7Fn1TL9tYlpe2CD7U1vnE/VztQYDAbB4x07
	0LNWpXZiGF/lNgX+dBQKzh6vqvUE11CLWCZc9q0bikyA5XLFHeZF+fVC/ZRo448W
	tacxExkSa20A6IPncSd2YA2z5AXmHu/8VmCZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HVswjJcp4vsrq/ZbwNdQTC8WyBLQ0Zci
	n5QbAktEy9r0oVrUBjQ0iOKCVrYdBmeqtsAtVpGZfoBE25KH52Envhm8wkvR8AAt
	haVSnjUrVVLeFw2m1Kg+jGz7neXJp1AQRFScC2deUqlUaZN7OtbxmE0YXG9nRHrk
	6lnKRI4/2gc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAFC977A9;
	Tue,  8 May 2012 11:37:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53F4E77A8; Tue,  8 May 2012
 11:37:30 -0400 (EDT)
In-Reply-To: <7v1umuznuj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 08 May 2012 08:36:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8F133C8-9923-11E1-8A7A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197376>

Junio C Hamano <gitster@pobox.com> writes:

> For now, an easiest workaround would be to rephrase the error message to
> "commits not present" to "commit not present or missing", or something.

I meant s/or missing/or borrowed/;  "not present" and "missing" are the
same thing ;-)
