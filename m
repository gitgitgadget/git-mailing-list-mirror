From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: remove undocumented '--verify' flag
Date: Tue, 23 Nov 2010 12:08:37 -0800
Message-ID: <7vk4k3vm4a.fsf@alter.siamese.dyndns.org>
References: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <vpqoc9hsemy.fsf@bauges.imag.fr> <201011221414.15982.trast@student.ethz.ch>
 <vpq8w0lqyf7.fsf@bauges.imag.fr> <alpine.DEB.1.10.1011222103290.17721@debian>
 <CA8E4FB8-70F7-415C-85DE-746B1113AE4C@sb.org>
 <20101123144133.GA3145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 23 21:09:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKzAi-0004x0-Ht
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 21:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab0KWUIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 15:08:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab0KWUIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 15:08:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26A9B22A8;
	Tue, 23 Nov 2010 15:09:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=en9X+ruYBhBstN13P00LVDcxxc4=; b=WhNl/+
	gEvYHAo1bsuGSfK5G+FRFg4M1fbRgRXcQLsGAVvSOMPqlm7K6IaqtdKF/l81PS+O
	UWeUN4TOb3+44Scj6k7JvajUNYxTRBHon7NrsFY196bKtYcFAju+bH/VaNWiYGiX
	L0m5xVGMxBzCJXhBksME8C9XQpvGbs3wZqgWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C8mW6RK/TZyVvEzdvzs7PL79j3zxOnc6
	6SOomiOSNEnOTEOXOjejODFLzQ3fnzV3HwIoinkafUj5Aq//S5eaAsmnPtLmeRCK
	sordPdlfIBfyVyTrv/ma8wwxI2Z6lEFYJGpn6r0YHHSgF3ZDdSYyA5Hwm0Tw68Wb
	v8syGB06CtE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B66A822A7;
	Tue, 23 Nov 2010 15:09:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC59922A6; Tue, 23 Nov 2010
 15:08:53 -0500 (EST)
In-Reply-To: <20101123144133.GA3145@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 23 Nov 2010 09\:41\:33 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8393F168-F73D-11DF-ADF6-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162019>

Jeff King <peff@peff.net> writes:

> That being said, people other than Junio may apply your patch, so if you
> are going to use such a marker, making it look scissor-like is probably
> the best thing to do.

FWIW, I do run "am -sc3" from inside Emacs.  It is a good idea to use what
is already accepted by the tool than coming up with a random convention of
your own anyway, so if somebody really wants to do "introductory comments
in discussion and then a patch", "-- >8 --" without quotes alone on a line
would be an appropriate thing to use.
