From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Mon, 06 Jun 2016 13:55:49 -0700
Message-ID: <xmqqporuuje2.fsf@gitster.mtv.corp.google.com>
References: <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
	<57511B2D.7040501@kdbg.org> <20160603094544.GA3865@Messiaen>
	<xmqq8tymqnj9.fsf@gitster.mtv.corp.google.com>
	<20160606072800.GA3803@Messiaen>
	<xmqqinxmxkmx.fsf@gitster.mtv.corp.google.com>
	<20160606204542.GA9280@Messiaen>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	simon.rabourg@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 22:56:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA1Yz-0007MA-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 22:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbcFFUzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 16:55:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751872AbcFFUzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 16:55:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 55C87224C4;
	Mon,  6 Jun 2016 16:55:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5s/uD7GIu11EEBBlLQ0S7iZs/eI=; b=sthK8l
	ZEsfarbD+sedUvzM4F7kRzz/rcXOsjnK+2BeRcwlOAQbhb5iOxq4SLPj92T0MrQ4
	2mr1TPHopqqd14xbvlB+GYk631nFaNSNbHJxsbAjcpFNPxRj/hxLtVxrwAoHivsU
	e37Nuo8B3ngJde47aAHGg7H3qU04sCK9Won14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iTvceVKUgg1XaTa/eEaNEOUIoVRIX3un
	bSsNMPSF1m3YDIm6Zsyxs0pwopsS+/hUZWmXZvS7VqETkbpTrlMESpvpT4uZ+mEa
	xAo3J+pb0SWNFW9mdH0i4XPxZoTIiAISZbFITyMY7PF1vRODX0UyWUbD6BN43D07
	sqvg3Y6yqBo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D488224C3;
	Mon,  6 Jun 2016 16:55:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAC17224C2;
	Mon,  6 Jun 2016 16:55:50 -0400 (EDT)
In-Reply-To: <20160606204542.GA9280@Messiaen> (William Duclot's message of
	"Mon, 6 Jun 2016 22:45:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D370646-2C29-11E6-93C7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296567>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

>> Yup, thanks.  Isn't that what I queued as 0719f3ee (userdiff: add
>> built-in pattern for CSS, 2016-06-03)?
>
> It is, my bad

Not your bad at all.  I am leaky and was asking you to double check;
it was entirely possible that I missed your even newer patch and
what was queued was the second from the last one.

Thanks.
