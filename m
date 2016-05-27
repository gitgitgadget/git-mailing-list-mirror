From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format_commit_message: honor `color=auto` for `%C(auto)`
Date: Thu, 26 May 2016 23:22:36 -0700
Message-ID: <xmqqwpmgrpeb.fsf@gitster.mtv.corp.google.com>
References: <20160527034610.GA31629@zoidberg>
	<20160527035553.GA24972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 27 08:22:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6BAb-0007GU-F4
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 08:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbcE0GWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 02:22:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753859AbcE0GWt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 02:22:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECE2914596;
	Fri, 27 May 2016 02:22:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Tgg5QIPeM29R3SB7xAbp8XCkqY=; b=DegeQS
	jaKi6xNuIeH0aszZG4nXGtR9jV3FGabJxRajlgJqbBf3mTVHe+dTsLItnElNoI18
	B/0Yb+ftYYJZNsy8P7qWwT3yhka9owqPahageyRiy8WOM2eMfUY1FEJNEtPrdPy2
	+7NwNzdQ4pG7X5TcLKGB3DYuk6F6gM+2cEBlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ai/RlF3YH+YhhsVKHT4mkd1v2zdvqVP9
	IciIKAzw3DDVgZM/KZbsAzKF9lgvAZvoG2b11yz0wLoFQi1Y47/6tqS7M95svhN5
	y3beLCdOTRUaNhKTdXEcbbzTzaBDcoz8uHn9xY2SWxP8rBEuIPe+VBCXqMA9oqeo
	B6FHhh9nWwM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E4CC614595;
	Fri, 27 May 2016 02:22:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FC4914594;
	Fri, 27 May 2016 02:22:38 -0400 (EDT)
In-Reply-To: <20160527035553.GA24972@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2016 23:55:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 68C2A302-23D3-11E6-B1F9-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295736>

Jeff King <peff@peff.net> writes:

> I suspect Junio can just tweak that while applying, unless there's
> another reason to re-roll.
>
> (Also for anybody watching, Ed did not just make up my signoff; I gave
> it to him off-list).

Understood.  Thanks.
