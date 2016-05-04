From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 04 May 2016 15:17:50 -0700
Message-ID: <xmqq60uteacx.fsf@gitster.mtv.corp.google.com>
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
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 00:18:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay57J-00070A-9a
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbcEDWRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 18:17:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754627AbcEDWRx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:17:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FF0219916;
	Wed,  4 May 2016 18:17:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/JzrdVcciuSV3VJCXqQrZrQMxgI=; b=EXadq1
	R6t4yfBlGmpDOitpJc7Vd6PCDYxEXseyoMd0smJ2AxkrevAA53lY9VruPEHO2Vqo
	+5/ZCiV+xXwn1tGCWzK833NZJzKXmQBz6YG8LhyapS5l0wRYy5C9UEu7TzY3aH5a
	VcbGje/sO7U/LJQS4H2cl7Vlcs+Iz+s+5b9Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l3cL3CY/fP0+ALimfPdLq2gshYKGAOdZ
	FJcq6BDVYy+NKu487A5St9H2AxDQ6RPf+NgA6W5otpZQgA10/fdkvu4jM9FvQD62
	jNOeZkqJyttMo/e9IzonrTUwRiYZm0GsSqIFJq8UX0c5SCK9Th3mHjtOvtwXPELm
	ZneYO7ucL7E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8678419915;
	Wed,  4 May 2016 18:17:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EEA8D19914;
	Wed,  4 May 2016 18:17:51 -0400 (EDT)
In-Reply-To: <20160504220935.GA26339@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 May 2016 18:09:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0ADC1C44-1246-11E6-8BF0-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293610>

Jeff King <peff@peff.net> writes:

> But I think the point remains,
> which is that your perl script is an implementation detail of the
> Makefile process. I thought the "ci" directory was supposed to be for
> ci-specific scripts that would be driven directly by Travis, etc.

True.  Documentation/ has tools like built-docdep.perl,
howto-index.sh, etc., so it can live next to it.

Thanks.
