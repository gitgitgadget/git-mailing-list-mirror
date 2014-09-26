From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/39] Lockfile correctness and refactoring
Date: Fri, 26 Sep 2014 09:31:49 -0700
Message-ID: <xmqqwq8q8hsa.fsf@gitster.dls.corp.google.com>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 26 18:32:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXYR4-0001dM-Aa
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 18:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbaIZQbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 12:31:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58893 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754647AbaIZQbw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2014 12:31:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F0753A88E;
	Fri, 26 Sep 2014 12:31:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s+Ihzlj3vCf/QjeQCVmFjupwnkI=; b=QK7ZUD
	uAF0/WioNhzNxR6yVEeWkcXE4aM7CviUZMYZg+BwtLO0do2CwaCyUn4BX20tOKoB
	QIyisWaJoJJYsWmcC1Tzv39o5AAyo+uuMTPJx4UvQ0Qay00EKsxuesACWcVNgu+Q
	3iHbUAeUjFAzO+5dTJDx+HS0vWWsHAyNotPDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kZ//N1nqWEffx8Lnj33DYEQU0IU0ct55
	OL6jQERljGwLYU/C5peU34w03fp2JDME8H4K0rpNN3ubakY5ReKS+qbjBG/moQ3C
	alN7hOOEakelrxX5JjcY521TA98pLRDRXnpoXqXb2Tbs24rVhPDPfitD8m1UPPFS
	rNiSJ7TMry0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 016CE3A88D;
	Fri, 26 Sep 2014 12:31:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7C1093A88C;
	Fri, 26 Sep 2014 12:31:51 -0400 (EDT)
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 26 Sep 2014 12:08:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E8C099C-459A-11E4-979B-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257547>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * Rebase to current master.

When you say this, could you be a bit more descriptive?  Has the
series updated to use something new that appeared on 'master' since
the last series was posted and needed to be rebased?  Or did you
just made sure that the series applied on top of the current master
still works, even though you have been running "rebase -i" on the
same fork point since the previous round?

If the former, naming what it now uses i.e. "rebased to current
master, to redo PATCH x,y,z using the new X recently graduated"
would be helpful.

If the latter, well, not rebasing is preferrable if the changes are
still viable on the previous fork point, to be absolutely honest.

Thanks.
