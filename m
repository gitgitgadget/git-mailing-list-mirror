From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 04 May 2016 14:52:27 -0700
Message-ID: <xmqqk2j9ebj8.fsf@gitster.mtv.corp.google.com>
References: <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
	<5729DF25.7030503@ramsayjones.plus.com>
	<xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
	<xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
	<20160504192516.GD21259@sigill.intra.peff.net>
	<xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
	<20160504200635.GA22787@sigill.intra.peff.net>
	<xmqq8tzpfrt0.fsf@gitster.mtv.corp.google.com>
	<20160504213149.GA22828@sigill.intra.peff.net>
	<xmqq4madfqxs.fsf@gitster.mtv.corp.google.com>
	<20160504214412.GA25237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 23:52:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4j2-0000SY-A4
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbcEDVwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:52:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754388AbcEDVwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:52:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB60C18771;
	Wed,  4 May 2016 17:52:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fn85nizCglneM3id59YY3/XmHTo=; b=BU7Dgx
	Le/HKR/hA90g9sQIxEURB3yQyfIGSpZNY1K2stLtnL0EYJK9lZIRaC3+zbF+9MtQ
	KoUEooI8oZs5pn/1ipt9RQ5wIs9p7W17EsbiyR2+Y7FX+KMezTb2hj3tHM51vMA/
	ExSxUUpq2bcSf1kfpcXhUGRiZDLKTnMm5Zhkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iOtdjL6EkvX3agx+nkzNEVUrKMwaB0J4
	yao2eTYGI06SXQlTSqCvrNLvfCpSrPO9YrEwY5JP5EWIJGiMXHLfE3u7TKegRIHf
	r0QxGyIRfps69g3rDBiIg4gHJJz7WOBMOArDHgZ8ul+BkvAUJE6HyoJ0Uozxkp4U
	HIK86o9USN4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2B2618770;
	Wed,  4 May 2016 17:52:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 373BE18764;
	Wed,  4 May 2016 17:52:29 -0400 (EDT)
In-Reply-To: <20160504214412.GA25237@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 May 2016 17:44:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7F3A58F2-1242-11E6-A7B4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293603>

Jeff King <peff@peff.net> writes:

> This dependency feels funny. Wouldn't CI want to invoke this as:
>
>   make -C Documentation lint-docs

I expected CI to do this instead

	make check-docs
