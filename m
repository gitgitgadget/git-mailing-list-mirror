From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] pull: allow interactive rebase with --rebase=interactive
Date: Wed, 13 Jan 2016 12:58:11 -0800
Message-ID: <xmqqio2xmc2k.fsf@gitster.mtv.corp.google.com>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
	<cover.1452668201.git.johannes.schindelin@gmx.de>
	<2ebf99214ba600b63a39c58bcb9abb7941a7619d.1452668201.git.johannes.schindelin@gmx.de>
	<xmqqd1t5pej1.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601131949060.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:58:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJSUk-0006B9-4U
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 21:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758795AbcAMU6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 15:58:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755077AbcAMU6N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 15:58:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 39C153A1A8;
	Wed, 13 Jan 2016 15:58:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XxGcG8WvmXsMbFidWVq4H3RwUso=; b=vhIPwz
	LMAfxjsJMtUIglIye2v/t7eWE5NqcLq3n9sXeCorlHPF6T53U+q0S7HTRJVfjHBN
	nkDsmA6v2jkM9uWkLcUeRCnXXpTihy5j3KuKtyXhdQVB9tGc6dbK3gn9Ul6o+UWS
	pDvXAhEYnThJpVymxJG4OeF0RRJ+BRm8caBNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oithOeaOuZXQXFoILd0Sh1IQGZpnDJZE
	vkVH8+5ajEXwZnK5pLE2mptfrhP1cYNhKkVQP8Jm4wuZ5LM0As/PXa3wje6iAUq8
	eNy0Ql5Z2mxgR2JUm3nhg8w2oQj1Ay0z7HffSHdYJYq9jQGRQumG1vlDuLd38W5f
	KsxiDZMavkA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3200D3A1A7;
	Wed, 13 Jan 2016 15:58:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 879BF3A1A2;
	Wed, 13 Jan 2016 15:58:12 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601131949060.2964@virtualbox> (Johannes
	Schindelin's message of "Wed, 13 Jan 2016 19:50:00 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5BCB9B9A-BA38-11E5-914D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283987>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 13 Jan 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>>     A couple of years ago, I found the need to collaborate on topic
>>     branches that were rebased all the time, and I really needed to see
>>     what I was rebasing when pulling, so I introduced an
>>     interactively-rebasing pull.
>> 
>> [...] I may just insert these four lines at the beginning of the log
>> message while queuing, or something.
>
> Oh, that's what you meant! Sorry for misunderstanding, and thanks for not
> requiring a reroll.

Heh, that is too early, as I haven't even read v3 yet.  There we may
find other reasons that we would want to improve it before queuing.
