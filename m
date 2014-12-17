From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improving git branch
Date: Wed, 17 Dec 2014 12:53:49 -0800
Message-ID: <xmqqvbla80bm.fsf@gitster.dls.corp.google.com>
References: <CAHQ6N+qBUcBcG8RC6Co+k_GmJDXCynmyfZmvTjz4bQyH1wG3DA@mail.gmail.com>
	<549168DD.1080906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 17 21:53:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1LbY-0000uK-HC
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 21:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbaLQUxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 15:53:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750790AbaLQUxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 15:53:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54BF828F2D;
	Wed, 17 Dec 2014 15:53:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aH8607v4acaDsoHNS3t0v1haM9Y=; b=lk4FXO
	/VxaJzF7/hOdC4wylaZldcx9/Bk/pm2lf/mLVPr77+WGHyim/AsYddyZERBv0Wcl
	u1BDwJVFKKzGbXNVCP8Jx0nxBJ4tCyBX84H+m4+9YFSKGW/FSt2fePvJvtz9mrH9
	D5Q8nQUFwHYHq3YopdGBUJHDZbZuomC7R2f44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lLR/Wm94u+lLrgu2c+slaAOg12U7GlUT
	vs54DH/Vc1oNPpnT+ZPNh8+qSOv9In465pTNPfjOjk3K2UveSyCHiznjN9aIwQ8s
	R0/Lr6FaTKrU/eemWzW8k9LCXOd1KPtWH419b6dQzwUMKSr/CedU5tmYHb52tY72
	hI2Tryvwh1g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A8AE28F2C;
	Wed, 17 Dec 2014 15:53:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE80528F2A;
	Wed, 17 Dec 2014 15:53:52 -0500 (EST)
In-Reply-To: <549168DD.1080906@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 17 Dec 2014 12:28:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF0A2E58-862E-11E4-8E30-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261496>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Rather than extending "git branch" any further[*], I suggest a bolder
> strategy:
>
> - unify/merge for-each-ref and pretty formats (and code) as far as possible
> - leverage that for the list modes of branch and tag
>
> That would allow everyone to get their favourite listing, just like for
> logs. Otherwise it would be very difficult to agree on *the* proper
> format for an extended branch or tag list.
>
> Michael
>
>
> [*] I know I'm a sinner, too.

Actually this is not a "bolder" strategy, but the unification has
been discussed and agreed to be the longer-term direction for quite
a while, I think.  Didn't Peff have this in his "things to do when
absolutely bored" box?
