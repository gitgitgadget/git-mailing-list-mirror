From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 02/32] api-lockfile: expand the documentation
Date: Tue, 09 Sep 2014 15:40:25 -0700
Message-ID: <xmqqmwa8ifja.fsf@gitster.dls.corp.google.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<1409989846-22401-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:40:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRU5g-0000Ge-RS
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbaIIWkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:40:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55414 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbaIIWk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:40:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FC703971F;
	Tue,  9 Sep 2014 18:40:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MrRyYy9UodOTpc3of+i+x3nNWZ0=; b=MPnm40
	33FgJHhj2g0kJv56Nv0t8cGm6/jJbsBKPvYKnbAbUoMdAAI/RxV62rCxLLd2J3qT
	FFIlIGm4NtOoMPeLUO/IQxkr9xmGJcWw9Wf3FOIvumxAh/K+5VzPJHNfhdewzy/u
	+vX7pZhzHyNpHxoHz488c2vGD1InNkdMSqBVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8ZLP3NHDRid+QZeuGf/XzkCNJ3q1Mx7
	uu1vbn6S2EkTpCgx1oC3M4k4XmzeP//lhiK5Gdlh7x5tFWKNDIlETkIuKPSwOias
	gzuA5/15k3cGt6sAlsr2BICX3faPvgS1LwZ1CivcbmpaEhv0oek+ADbtHtiDxvIH
	8LMmYjk3anA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06B4E3971E;
	Tue,  9 Sep 2014 18:40:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F18C83971C;
	Tue,  9 Sep 2014 18:40:26 -0400 (EDT)
In-Reply-To: <1409989846-22401-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sat, 6 Sep 2014 09:50:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4B607A6C-3872-11E4-B9E1-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256721>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +LOCK_NODEREF::

I think I've seen this mentioned already but LOCK_NO_DEREF to avoid
"lock the node ref?" misreading?
