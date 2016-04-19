From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/7] i18n: index-pack: use plural string instead of normal one
Date: Tue, 19 Apr 2016 12:46:51 -0700
Message-ID: <xmqq37qh1ivo.fsf@gitster.mtv.corp.google.com>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
	<xmqqbn551kqb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Tue Apr 19 21:47:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asbbw-0008Sg-A9
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbcDSTqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:46:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750859AbcDSTqz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 15:46:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 858CF1285E;
	Tue, 19 Apr 2016 15:46:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GL2IATvMDvgIEAgk5zZH85lhOpQ=; b=FcEBii
	BKS+IWm8eSkEsgQUqyuHa9dZvSHt5wBBgXEWdBoWZCNwBXD4W7/QQZlAultCWUUq
	6ZU+qNadE4sLt7K3rNR64cKYa86CrdTKKfweWFbarc/Gfbq+fLIVBMsALBmaZ65G
	sA11cfHPyQyWK8xMIz9qsqj3N89dHF5EzVUdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VJlXu3nA9u6UI6pcSe/Lxrc2Bbw9inEZ
	MZmiNH2beiPUobo4cn+d4aQNQGJitQ/Ty4pqLJgX7h/TuO4/fRVj18a5MjAUT/Ty
	Eg5KXUH8eclGkv5CHUBt0uWk69kbsMF6qeVr2vU73vH7gkQ+KSja3eOPqqqoB/Er
	v9Yyf1YYf2c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E0AC1285D;
	Tue, 19 Apr 2016 15:46:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D88301285C;
	Tue, 19 Apr 2016 15:46:52 -0400 (EDT)
In-Reply-To: <xmqqbn551kqb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 Apr 2016 12:06:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76FC0884-0667-11E6-A23B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291914>

Junio C Hamano <gitster@pobox.com> writes:

> Hmph, two patches in the previous series seem to be missing.  On
> purpose, or by mistake?  Their net-effect is shown at the end of
> this message, and I thought they made sense.
>
> Puzzled...

Ah, I see.  These two were sent outside the series, but because they
are on the same theme, I chose to queue them together.

Will keep them.  Thanks.
