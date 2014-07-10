From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2 06/19] rebase -i: Stop on root commits with empty log messages
Date: Thu, 10 Jul 2014 09:57:29 -0700
Message-ID: <xmqqmwch883q.fsf@gitster.dls.corp.google.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<00ca9dc0d1750301aa22c2bb78976b141233cef3.1404323078.git.bafain@gmail.com>
	<xmqq8uo38p28.fsf@gitster.dls.corp.google.com>
	<53BE5D0D.8090308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 18:57:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5HfC-0006pT-7D
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 18:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbaGJQ5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 12:57:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59144 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbaGJQ5h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 12:57:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D96B026864;
	Thu, 10 Jul 2014 12:57:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ATYn4V+T+EKRLaU9U2uQbLYKkQA=; b=cniRlb
	rueiEz3S7VnInuD6QGPugaIfx2A4NRhXX5SN454j/L6WCJ+KuThdxlDoyTT4Xk9F
	tm3cGJ0+ZN5BECcVPH4rhSqlJPbolPXTe3duRrdkDSTplh5XMPBhmzu6tEkW1QFx
	OFzRVDn+5+da0f9OyWNlxm8K+mrCfzK3PWVFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l+ErLbiolF6aXHnKHnwfOSzEnfiNSKS+
	UXIRXEWCf+1A5pd2AecyIpCQMbZavadrsU3KyE58k5M/nZyRacZAbwZM32rBJROo
	m5LGRELXibiMVGXfsB+EGGCD1u1hX15aL+N7DjERpRFkFyLh6rGZUiNJBkpn2BtW
	GhNUeFf3yko=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD71B26863;
	Thu, 10 Jul 2014 12:57:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6065F2685A;
	Thu, 10 Jul 2014 12:57:16 -0400 (EDT)
In-Reply-To: <53BE5D0D.8090308@gmail.com> (Fabian Ruch's message of "Thu, 10
	Jul 2014 11:29:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3F3AD646-0853-11E4-B4F5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253191>

Fabian Ruch <bafain@gmail.com> writes:

> ...
> Do you want me to replace this patch with a patch
>
>     rebase -i: Always allow picking of commits with empty log messages
>
> that makes git-rebase--interactive cherry-pick commits using
> --allow-empty-message?

I do not "want" any particular behaviour change.  I wanted you to
clarify what changed behaviour you are trying to implement and why,
and that was why I was asking these questions.
