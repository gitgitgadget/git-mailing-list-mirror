From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! graph: output padding for merge subsequent
 parents
Date: Mon, 11 Feb 2013 08:42:21 -0800
Message-ID: <7vehgmol8y.fsf@alter.siamese.dyndns.org>
References: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
 <20130210131647.GA2270@serenity.lan>
 <7vliawt19c.fsf@alter.siamese.dyndns.org>
 <20130210210229.GB2270@serenity.lan>
 <7vwqufrdzd.fsf@alter.siamese.dyndns.org>
 <20130211105433.GA3245@farnsworth.metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:42:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wSu-0001m9-86
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900Ab3BKQmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:42:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35848 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757870Ab3BKQmY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:42:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69F46B72C;
	Mon, 11 Feb 2013 11:42:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MoE9nvL2m9AUl3ETm0kffyglBJc=; b=iF+ybF
	PLoiP824g9urG3VYcI3A9ikF+BJUUZaC+7yvo3sC7mTMdR3MGVlWNKpH2c7t8D3k
	VGCFZ/RSvrQ5kDO0HysOS4rRk8skqy9dkNnRfO1K772kGGb6tsacVr28UNaQX2AN
	B/w6sJ6vTmU+i6zP40VN56aUjpGwRmPQ6criI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oQtfgpakEcopJ6/bg8ZzgaurXa5Wcasb
	EZIdUGcfO7vsfw1uLsf4CLcZK/C7ZPzmj89PMeLpQ8h6zMCqj+oDxkixd3+vnJJq
	El/QsjbuTxLm54Z3WT1sIaRw64Um00wDKkWAvx6ZnS5B6djP9FPt+zd4omC/IT0s
	9DovPFw/McU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E0CCB72B;
	Mon, 11 Feb 2013 11:42:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D94D1B728; Mon, 11 Feb 2013
 11:42:22 -0500 (EST)
In-Reply-To: <20130211105433.GA3245@farnsworth.metanate.com> (John Keeping's
 message of "Mon, 11 Feb 2013 10:54:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 025471CA-746A-11E2-8408-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216050>

John Keeping <john@keeping.me.uk> writes:

> Perhaps it's best to leave the patch as it originally was to guarantee
> that we can't get stuck in graph_show_commit(), even when it's called at
> an unexpected time, but I see you've already squashed this change in.
>
> Would you prefer me to resend the original patch or send an update with
> this change and the above reasoning in the commit message?

Yes, please.  Let's have the original (I think I have it in my
reflog so no need to resend it) and this update on top as a separate
patch with an updated log message.
