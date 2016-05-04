From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 04 May 2016 15:27:45 -0700
Message-ID: <xmqq1t5he9we.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
	<xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
	<20160504192516.GD21259@sigill.intra.peff.net>
	<xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
	<20160504200635.GA22787@sigill.intra.peff.net>
	<xmqq8tzpfrt0.fsf@gitster.mtv.corp.google.com>
	<20160504213149.GA22828@sigill.intra.peff.net>
	<xmqq4madfqxs.fsf@gitster.mtv.corp.google.com>
	<20160504214412.GA25237@sigill.intra.peff.net>
	<xmqqk2j9ebj8.fsf@gitster.mtv.corp.google.com>
	<20160504220935.GA26339@sigill.intra.peff.net>
	<xmqq60uteacx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 00:27:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay5Gr-0003wK-Ba
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbcEDW1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 18:27:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754232AbcEDW1s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:27:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 480A0199DE;
	Wed,  4 May 2016 18:27:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/20L34OJSe6eswSFRirQ/8sFJ3E=; b=G/tF2A
	wGXBATqipTLIKMsab16Mfzn0XN8bv2wpSQABLan6dtI5Q647M853Tf0+1f2ryaGj
	srOK0/dVoetz3bRuqqz6sdQqVPVlbM7zA6tJzGDoR/pS5Nhc+PR6Dii2jc9FozPQ
	zFZ/OzhSA/YiZ1/cDwqPqM0dIB+g7ciD2cAgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fbK0ZGb7J3qccZl1GBjDT+XpHZHbz8y7
	s8pfdKU3wHVPHzY/IdTw5Uokj9ZfR302Z51WV4oSk0S/DMWrfeHPj9VbeCGJXEMu
	h5iIwhsuobs/orAcsUoIpLw3ejztaczBoUkv6WoZk7ZtydDtxKibKa/3W3qnI05s
	tVvf09e3pX0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F17C199DD;
	Wed,  4 May 2016 18:27:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEEA8199DC;
	Wed,  4 May 2016 18:27:46 -0400 (EDT)
In-Reply-To: <xmqq60uteacx.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 May 2016 15:17:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D5A50BA-1247-11E6-990A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293611>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> But I think the point remains,
>> which is that your perl script is an implementation detail of the
>> Makefile process. I thought the "ci" directory was supposed to be for
>> ci-specific scripts that would be driven directly by Travis, etc.
>
> True.  Documentation/ has tools like built-docdep.perl,
> howto-index.sh, etc., so it can live next to it.
>
> Thanks.

Gaah, the Makefile part of the final patch is wrong; we do not check
the included sources at all if we only passed the top-level targets'
sources.
