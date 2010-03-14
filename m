From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] don't use default revision if a rev was specified
Date: Sat, 13 Mar 2010 22:57:03 -0800
Message-ID: <7vzl2bqtkw.fsf@alter.siamese.dyndns.org>
References: <4B9C086D.10004@lsrfire.ath.cx>
 <1268520425-31889-1-git-send-email-cxreg@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rene.scharfe@lsrfire.ath.cx,
	Vladimir Panteleev <vladimir@thecybershadow.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 07:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqhlI-0006Db-Vx
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 07:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab0CNG5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 01:57:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab0CNG5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 01:57:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB70BA162F;
	Sun, 14 Mar 2010 01:57:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5xJA5mm9vlgJsFD2+XOSCfI5XMk=; b=x4Ljn/
	NGxVEEjKVmHAgl8Uq3i828v5H6H7LqJ0Ub38xTl5l5UZuLRFgt6+tU2Do6UsT7HG
	/C8HtKeblCfEY5r+nfnUzVDgjXPBL97t89pnP+4OXqEUynz0G6Kau+CEWzpKlVw8
	TLjlOl/6lorU1JQMewqaSB5n0IqIhQGtYT2a0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=an/gu7y4gaApY+vt8k6rc3Bq9V+No7e8
	Nyiog5MkgCqiZwRCVydjGq/0uSmlUhiNEJAOcqYvFgFkGdnF3WjAee+wZF2DEKhv
	da6vEM1UTsIKuHw++shj/Eu1bcQNeA122L/T0c3RIB2MJz9u3VOfmuzyqucTL7O0
	jFbOf2DUU3c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC0AEA1622;
	Sun, 14 Mar 2010 01:57:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB3BEA161D; Sun, 14 Mar
 2010 01:57:04 -0500 (EST)
In-Reply-To: <1268520425-31889-1-git-send-email-cxreg@pobox.com> (Dave
 Olszewski's message of "Sat\, 13 Mar 2010 14\:47\:05 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CFE0D4E8-2F36-11DF-B629-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142129>

Dave Olszewski <cxreg@pobox.com> writes:

> If a revision is specified, it happens not to have any commits, don't
> use the default revision.  By doing so, surprising and undesired
> behavior can happen, such as showing the reflog for HEAD when a branch
> was specified.
>
> Signed-off-by: Dave Olszewski <cxreg@pobox.com>

Thanks, will queue.
