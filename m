From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/5] pretty: make %H/%h/etc respect --abbrev[-commit]
Date: Sun, 02 May 2010 02:11:18 -0700
Message-ID: <7vaasiwtvt.fsf@alter.siamese.dyndns.org>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
 <1272656128-2002-3-git-send-email-wmpalmer@gmail.com>
 <7vocgzyp1f.fsf@alter.siamese.dyndns.org> <1272790255.4258.11.camel@walleee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, raa.lkml@gmail.com,
	jrnieder@gmail.com
To: wmpalmer@gmail.com
X-From: git-owner@vger.kernel.org Sun May 02 11:12:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8VDw-0005II-D3
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 11:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab0EBJLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 05:11:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890Ab0EBJLc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 05:11:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B8B9AF8AA;
	Sun,  2 May 2010 05:11:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Muw7kPJpWRZFNTb6fW0NJ/eQgAo=; b=ZBMJVQ
	/CRbAyFr5ddkmZcK8ou40VglyqxLDv2E/sJB1zTTu/RBp/zw5jobvdcmMAjbzsB7
	RQs1UPVOwhZ8kXmvLAOumPBhWpAZjjRpfNEC+6YTiOcBAUB14tHFfCJ6Bkt2Mqom
	W9VGMD5YTtrh5jtsEXTf0H5Tj7yutks4z2ti0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n87YSXsWZx7x8czXLfYuL3O5zupPvOYZ
	cwKpCmGxC9X1hYlV1kMXOsinS40wTN/6FGi7woGjORQye/C0HP/LMDgA3E+KLeH9
	CZ35rL/g6Lm8STixKvziDYLZL5/QzWDOwpQu7YX+7SFGlgHfdG6eYNIk5qruBPkQ
	Qg7+Xe/NjA0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7ECCAF89C;
	Sun,  2 May 2010 05:11:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D26CDAF89A; Sun,  2 May
 2010 05:11:19 -0400 (EDT)
In-Reply-To: <1272790255.4258.11.camel@walleee> (Will Palmer's message of
 "Sun\, 02 May 2010 09\:50\:55 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AF4D6C18-55CA-11DF-AFE9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146149>

Will Palmer <wmpalmer@gmail.com> writes:

> If the current behaviour is actually intentional, we should at least
> update the documentation to say that %H is the "full commit hash",
> rather than just the "commit hash".

I think it was obvious from the context that lists %H and %h next to each
other, with description without "abbreviated" and with "abbreviated" to
them.  The description for %H should be rewritten as "commit object name"
and %h "abbreviated commit object name".
