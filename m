From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to cut extra liftime of expired loose objects
Date: Mon, 30 May 2016 11:53:26 -0700
Message-ID: <xmqqpos38jix.fsf@gitster.mtv.corp.google.com>
References: <574C6D9B.1080200@kdbg.org>
	<20160530182405.GA17253@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 30 20:53:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7SJh-00012t-GR
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161859AbcE3Sxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:53:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161557AbcE3Sx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:53:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BB0720481;
	Mon, 30 May 2016 14:53:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CAK7gYJF23eQ4F9mNfV4OurOxfk=; b=ftRw2s
	hdq+FQ3vwCOFZbyKoLovgo7rzP6zF2Fr7aQ9HyjPmk9ts3hkRWSHpnuVLiqCQECj
	EpQjWA1TB4uQYpxFX4KIPOWOBPc7NmGHnUDy8ekukPy8YxxmwJ2PUE0TAF5PV1W0
	l7p/1teZTXqO1uAmpoLeK3j62PIeNTuYI5YMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UPTipm0wZHf4KUJcRmfrRlJt4bdH+qQ8
	3iHQnQGrjXZCymVJW4pofYnVWgpYI+E1n7yRYXj/VmgX8OKLS7ahd3lntN9gFS3k
	XpN0YHDgnb3Y2hJ3pCBNHUTwc6mwoepuvVifY0EySPf8Izi6s/GprP8ZbavHWPRW
	KIxV43UapW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4435A20480;
	Mon, 30 May 2016 14:53:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3C152047D;
	Mon, 30 May 2016 14:53:27 -0400 (EDT)
In-Reply-To: <20160530182405.GA17253@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 30 May 2016 14:24:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CB89E934-2697-11E6-A4C2-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295925>

Jeff King <peff@peff.net> writes:

> I think we should consider dropping the default time to something more
> like 1 day. The 2-week period predates reflogs, I believe (OTOH, it does
> save objects which you might have used with "git add" but never actually
> committed).

Your belief is shared by me.
