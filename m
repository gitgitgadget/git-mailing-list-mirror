From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] t4018: an infrastructure to test hunk headers
Date: Sun, 23 Mar 2014 12:36:45 -0700
Message-ID: <xmqq38i8so4y.fsf@gitster.dls.corp.google.com>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
	<52505977c20a480941ae1f85f50ffb7a0bbffedb.1395433874.git.j6t@kdbg.org>
	<xmqqk3bnrz3m.fsf@gitster.dls.corp.google.com>
	<532D3411.2000109@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brandon Casey <drafnel@gmail.com>,
	git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:37:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRoCh-0007HB-RN
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 20:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbaCWThA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 15:37:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbaCWTg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 15:36:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18A1D75E4E;
	Sun, 23 Mar 2014 15:36:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vF/ZRkYmfp87g9lZFInbYfVtgf4=; b=k7y8SK
	UGYfyTIiemgMeTppJjHMFKuirsd5vKsrVpCzryZ13btwXBKPgYEm4VFwDNNeFWQA
	U2SF4X+Q6ykPLZblHncdlkhJIwtdXs3ydmvIHb6vRrmJLkYhOo3SF0CK+l6cn7xq
	RUuqowi0SkuwVNMzKjUEf1gNKAe4ajcZWYwRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o2EB1ye0F/k2GtravwKBDtubEzG81/6r
	Bm1qvNSwHauyusCjLW2M86Ap0XPyeUEbUPznIqwH5BeoKuNOqCsw1paaN4Jj1zyV
	73gvFYm9FIT3C5AG4jNNOBfFDa9p1EU1ctUHGGR68Z0WtZ+/xQAyrHurSv0Vmj2C
	TdaB2q+JYVI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F24E275E4C;
	Sun, 23 Mar 2014 15:36:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CDD975E49;
	Sun, 23 Mar 2014 15:36:50 -0400 (EDT)
In-Reply-To: <532D3411.2000109@kdbg.org> (Johannes Sixt's message of "Sat, 22
	Mar 2014 07:56:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7AB3CB60-B2C2-11E3-8575-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244802>

Johannes Sixt <j6t@kdbg.org> writes:

> I see what you mean. Notice, however, that we also test whether
> the regular expressions can be compiled successfully, and for this
> it is desirable to have the complete list of userdiff drivers.
> Until we have at least one test-case for each driver, we wouldn't
> get the complete list.

I missed the fact that we lack "here is a pair of test files in this
lang $p; go find diff between them and make sure we have the right
hunk header" for many $p.

So the kind of improvements I wondered about are allowed to come
later, but shouldn't be done in this series, especiallly not at this
step in the series.

Thanks.
