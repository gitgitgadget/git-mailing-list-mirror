From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking branch for a rebase
Date: Mon, 07 Sep 2009 01:25:38 -0700
Message-ID: <7vzl97xit9.fsf@alter.siamese.dyndns.org>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
 <20090904185949.GA21583@atjola.homenet>
 <20090905061250.GA29863@coredump.intra.peff.net>
 <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net>
 <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
 <4AA4C0CE.2070300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:26:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZYe-0003ip-FJ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbZIGIZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbZIGIZu
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:25:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbZIGIZt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:25:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 658FF28F98;
	Mon,  7 Sep 2009 04:25:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OJLvTzS0s+4xzIzYDusOM7tvt/M=; b=FnW6hu
	k/t+oeQidfNGRoZYKtph6D0kZJel0ksBko5n4gv65ZhL0pzbxC+j6tO/u13pXWPw
	SnLUKxvmqZtnPEWLZOdq4EO8mCzOZeq0UCiGXKR23Cbhs+Oi1jFWdnAeM19R8/cW
	BCzIQQed3IEGrg0AZI+A2FoM+z7cjWvEu7ZPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h4UqAj6c66guMfTmG7HMy1TAC5HM9KCe
	riWCPQq03gkEfb6utsSofT4cI5QubYVE+uWNX0RTKuHAY33jKdJzU4IidShdc0m/
	wlSnxLU4AfqTP38eqD5l21ceDBogYvn4A/7pWvBfRJZJviushn/P0m7GAtuNtHLG
	qtkss7Xg9b4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 247EE28F8F;
	Mon,  7 Sep 2009 04:25:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D71928F89; Mon,  7 Sep
 2009 04:25:40 -0400 (EDT)
In-Reply-To: <4AA4C0CE.2070300@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon\, 07 Sep 2009 10\:14\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A78B802-9B88-11DE-95BD-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127904>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> @^

"@" itself is not reserved, even though "@{" is, so this is not an
option.

> @{^}

This _could_ work, although it is rather cryptic.
