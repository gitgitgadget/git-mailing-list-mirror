From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-add.txt: Explain --patch option in
 layman terms
Date: Mon, 31 Aug 2009 00:32:27 -0700
Message-ID: <7v8wh04ewk.fsf@alter.siamese.dyndns.org>
References: <87ocpxb46g.fsf@jondo.cante.net>
 <7vab1hdppb.fsf@alter.siamese.dyndns.org> <87tyzp9da4.fsf@jondo.cante.net>
 <7vskf954sr.fsf@alter.siamese.dyndns.org> <87ab1gaol2.fsf@jondo.cante.net>
 <7vr5usyj3i.fsf@alter.siamese.dyndns.org> <873a78a2dc.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 09:32:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi1Nc-0006ER-Ib
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 09:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbZHaHce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 03:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbZHaHce
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 03:32:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbZHaHce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 03:32:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2D771FDBF;
	Mon, 31 Aug 2009 03:32:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GJkgmWdnCGMk5KPvsGmE7GDu9uE=; b=vACWSH
	Zro6P8TGYFD1423xygsOESMJLdml9ZHWDQ/rVPWElU+4yhPW3UUeHYXw1GgShPMl
	u1Us5Z8KmEtNKrPKxkC3Ihl1gIsJTUNGdEMA8gAvG23LBYoM/wgqv0CliwASgV7y
	PM+4UMtNOKZr0MzPgJ//q/dy0s9EwLCyykcQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LmBNpLhveAfme7ODBThpfZM2IVbDac0w
	Q1BmsD8U3WCNP+GEO/WKyxtIjFrIrHEtQy6T3OumtzsXFfmq2hHPAEsaop1An0Jf
	egUV1MkDiYliNpZucdgwr7lt3S47k3mqFA2K29NwCuCNRWlhs27l68wj51DpS3WJ
	o2GDQHcFNmg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 810F41FDBE;
	Mon, 31 Aug 2009 03:32:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEE1D1FDBD; Mon, 31 Aug
 2009 03:32:28 -0400 (EDT)
In-Reply-To: <873a78a2dc.fsf@jondo.cante.net> (Jari Aalto's message of "Mon\,
 31 Aug 2009 10\:06\:39 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 716C5D44-9600-11DE-8D34-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127465>

Jari Aalto <jari.aalto@cante.net> writes:

> I could offer patches, but not in any time frame to do it in one-swoop
> do-it-all patch. To distribute time and effort to do so, it would be
> sensible to handle one manual at a time. The whole work would eventually
> get done.

Yeah, that's the spirit, and that is why I said you do not necessarily
have to do all the work yourself.  It would be expected of that volunteer
to keep an eye on patches other helpful folks may send to cover the issue,
vet them to make sure they do not introduce silly typos, AsciiDoc
breakages, and needless conflicts.

As to guidelines, I think your "spell all top-level headlines in caps" is
a reasonable one, as "man" backend for AsciiDoc does that anyway.

For the ancient "Synopsis" issue, SD5-XCU-ERN-97 would be a reasonable
guideline to follow (http://www.opengroup.org/austin/docs/austin_325.txt).

> There could be section in TODO.
>
>     RFH - Request for help: Manual page adjustments
>
>     - If you have some spare time, the following manual pages adjustment
>       is needed for all git manuals ....
>
> Or 2-weekly RFH post could announce the need. That would be one way to
> coordinate participants.

I would leave such a procedural issue to the volunteer who heads the
effort to decide.  If you are asking me to decide, then you are not
volunteering yourself, but you are volunteering _me_ for the job ;-).

Thanks.
