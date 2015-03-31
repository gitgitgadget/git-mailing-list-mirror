From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] enter_repo(): fix docs to match code
Date: Tue, 31 Mar 2015 10:57:17 -0700
Message-ID: <xmqqzj6tqcci.fsf@gitster.dls.corp.google.com>
References: <vpqk2xykaiu.fsf@anie.imag.fr>
	<1427809167-21711-1-git-send-email-pyokagan@gmail.com>
	<xmqq4mp1rrwj.fsf@gitster.dls.corp.google.com>
	<20150331174141.GG18912@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:57:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd0Pr-0004jd-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbbCaR51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:57:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752779AbbCaR50 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:57:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 43A9A44024;
	Tue, 31 Mar 2015 13:57:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4DrUBbnG8iFJ2W92IUDNiScnDy0=; b=cYOuV0
	NFiddxmRWhqz7NFBp02qQYxrjBcI2kP1isiBrFCOk+5rX7K+KFw/hvjkgGOkc0nW
	TXYdUQNPDroeifB8VFkH+pnsYsRwLf75ajdb3eIsZLftjl446y7nlQKRaJaM8/8D
	PbYn4VM9ang2hmeesI3MpxtlFwYJ5WE4GT+lI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nqk+HYwUljSANSXCDqgnd+DBdS2ULBT9
	LyWw11rPqzvFOYr9be6E91MAuvi1woXxUbCxPiXL5OdGhG0qLF72bZcGLFJKnS2H
	+W9d5CReMRKNgqpyl4pWM/3iL3eTcOfQty8dE/vFdtyv2fA+6zoy/WGFGRwSi3m6
	QgdlLqrHSgM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CD7144022;
	Tue, 31 Mar 2015 13:57:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D4EB4401D;
	Tue, 31 Mar 2015 13:57:19 -0400 (EDT)
In-Reply-To: <20150331174141.GG18912@peff.net> (Jeff King's message of "Tue,
	31 Mar 2015 13:41:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FFD28B0-D7CF-11E4-82F9-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266541>

Jeff King <peff@peff.net> writes:

> I'm not sure that's true. The precedence changed, and the "is it valid"
> check changed.

Yeah, I must have misread the review thread.

I only noticed that the postimage does not have any lines that v1
changed from the original, but at the word level there indeed are
these changes you listed above.

Thanks.
