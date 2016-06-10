From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adds *~ to the .gitignore
Date: Fri, 10 Jun 2016 08:52:10 -0700
Message-ID: <xmqq4m91ghxx.fsf@gitster.mtv.corp.google.com>
References: <1465506629-16577-1-git-send-email-Lars.Vogel@vogella.com>
	<xmqqh9d2girw.fsf@gitster.mtv.corp.google.com>
	<20160609213809.GA23059@sigill.intra.peff.net>
	<xmqqd1nqges3.fsf@gitster.mtv.corp.google.com>
	<20160609233118.GA25709@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Vogel <lars.vogel@gmail.com>, git@vger.kernel.org,
	Lars Vogel <Lars.Vogel@vogella.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 17:52:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBOjK-0001aE-Ko
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 17:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbcFJPwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 11:52:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752779AbcFJPwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 11:52:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C3D2121FCA;
	Fri, 10 Jun 2016 11:52:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QII8hGgvUeSJjumVXisrf9qH1qU=; b=pIL+bw
	JFermKCFuF84Xk2v54YI+f47RiRHOX7+1zQFjiyHzE5lPlUFywvHG+f1dL0QrwHE
	uNmRuOQqojtuhzyjjPfRcm7FIutGptnJwwxmg62AzjoTzUcp0/oxoS16SDytOyUb
	K8dY2cP58JsFkEmsUQ1MmZuEumFozvdCG6kMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EOYLVpEw5rRiwC2BK9NjYWLySJoU2wCd
	jMpeq+p48pyI3Wf+W2hfwqDmPx+Gp5SFO5paQ+SOnNaaadJml1BVLM20Ozy19qV0
	iIlso3P2BfS6eDhoXxrbwPFWuQOc99n1WSZRDGynJdOzLnzlvj2YwvaA1956FxrH
	LBWwJUNP97U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BC84A21FC9;
	Fri, 10 Jun 2016 11:52:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 412F621FC8;
	Fri, 10 Jun 2016 11:52:12 -0400 (EDT)
In-Reply-To: <20160609233118.GA25709@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jun 2016 19:31:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4BC2808C-2F23-11E6-A9B1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297007>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 09, 2016 at 03:48:12PM -0700, Junio C Hamano wrote:
>
>> As I said, however, I could support a move to add some selected
>> small number of common file extensions, as long as we have some
>> (social) mechanism to avoid churning this file every time somebody
>> new comes and complains their favourite editor or other tools are
>> not supported.
>
> Yeah, I don't mind it either, myself, provided we avoid the churn.
>
> OTOH, wouldn't somebody who cared about this want it for all of their
> projects? I guess I just don't see the point in making this a
> git-specific thing.

My version was "it is your personal preference, why should we cater
to it while we know we cannot do the same for everybody else who has
different preference?"

Your version is a lot more positive, while leading to the same
conclusion.  "It is your personal preference.  Even if we added it
ourselves, it would not help you with other projects".

As usual, you are more brilliant than I am here.
