From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/21] check-attr: there are only two possible line terminations
Date: Fri, 15 Jan 2016 13:20:31 -0800
Message-ID: <xmqq60yuh74w.fsf@gitster.mtv.corp.google.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-6-git-send-email-gitster@pobox.com>
	<20160115191611.GB11301@sigill.intra.peff.net>
	<20160115193640.GA19291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 22:20:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKBnS-0006ZB-Tu
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 22:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbcAOVUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 16:20:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751314AbcAOVUe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 16:20:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 10DC63BAF0;
	Fri, 15 Jan 2016 16:20:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5BUkq1dhqTzlWQPhpJInKZ43Yug=; b=w6Gy3Q
	SVDsPEhpwAcSgnlz4Uyo7kP2NA+eT0N5obgq7Jtnr/ZnRJtOF7IcasldXFacCxHE
	BWm7QiCc7uboM2yqeFe8LJCIXKafJvnMAcCftJ+LU2VYuGgUg4IGAocHeJTVI6Qy
	Ot2hBPlxfrMB3dBuzux8X3Gt6OrJxoe84nAUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XxoX7kY9H57mIM4jX0e/KphbXl3n9A1y
	X2vBGO8c/5U3n+Gxd3O/sjO/QddwozYKQikx+DN6vs4Yf6KcYMNQhx4VdbfsuzY0
	gEx8LI8D8g4uE/YR0w1ewIT2WSOyedN+kZ9m2WgaGjC9ZBcTD9CnpmVe3dbNXZ1U
	6847QlDKMMw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 074373BAEF;
	Fri, 15 Jan 2016 16:20:33 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F6243BAEE;
	Fri, 15 Jan 2016 16:20:32 -0500 (EST)
In-Reply-To: <20160115193640.GA19291@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 15 Jan 2016 14:36:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF4DD61E-BBCD-11E5-91F5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284217>

Jeff King <peff@peff.net> writes:

> Apparently we use this pattern in quite a few places (or they all copied
> from each other). Here's a possible fixup that could go after your
> series (it could go before, too, but it creates a lot of textual
> conflicts with your stuff).

Sounds good, but I'm in favor of leaving this as an unrelated
clean-up that happens to touch the same area.
