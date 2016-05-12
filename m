From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Work on t3404 in preparation for rebase--helper
Date: Thu, 12 May 2016 09:21:58 -0700
Message-ID: <xmqq8tzfgsbd.fsf@gitster.mtv.corp.google.com>
References: <cover.1462888768.git.johannes.schindelin@gmx.de>
	<cover.1463067811.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 12 18:22:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0tNJ-0006cB-EV
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 18:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbcELQWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 12:22:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751614AbcELQWD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 12:22:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 669B91A539;
	Thu, 12 May 2016 12:22:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Puq+32NM487oA3yP4eO/vkQPZfo=; b=Vhpaxp
	fysqF87xdA1JmQeZO0Tq+aCZ3YAC/6U9Z4usUrjUSdxmR8X4mxB0crPCKa09BZ8i
	5HwdDEFdViMlSF12KGhzLmbmjp6CaV+m1lym/DvNtF75YxpR0YM+uq007fgHouQo
	AxoMVbpa3r1KrQcFiSky3TbM2OYFKqVVw4lpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NH3PYvWGsZfcIJA8g9arI5p4Q0YnhUn+
	fRMKm6pE9ug7SA1J2v0OZh6hKWb9a49Gl5afBRbBXx0GK7WrqYcbDsorzlw4VVjx
	mce6wTNmxUj83q0DEXc0WWKiS+a8yHgagid9nonF7r4Dhorlziee68AjBz/9VnK9
	xneSSF/FQ9A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EE571A538;
	Thu, 12 May 2016 12:22:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F1D81A536;
	Thu, 12 May 2016 12:22:01 -0400 (EDT)
In-Reply-To: <cover.1463067811.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Thu, 12 May 2016 17:43:54 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A833BA2A-185D-11E6-9E89-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294416>

I took these separately already, and plan to fast-track them as they
are both "trivially correct"; I double checked that what I have
match these two, too.

Thanks.
