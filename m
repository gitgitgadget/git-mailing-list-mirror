From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Mon, 03 Jun 2013 08:30:27 -0700
Message-ID: <7vk3mbjjos.fsf@alter.siamese.dyndns.org>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
	<51A7A73C.6070103@web.de> <20130531194051.GC1072@serenity.lan>
	<20130603145405.GJ1072@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jun 03 17:30:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjWib-0003Os-AP
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 17:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758579Ab3FCPai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 11:30:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37208 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139Ab3FCPad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 11:30:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36C7A24F9F;
	Mon,  3 Jun 2013 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kgCtbJVNTZXKurBgEjKRKygSzp4=; b=OYIAvH
	pKm3YB86iC5E9Wt9cnaMMAdKmOPSJTIFNCM6Xha/8UacQN3rqe0EUBJSiq8awTXx
	S/elkDNTMEsEurhwinFgoPn/ng4nnIeeJJFvNIZCIF8q1DvGZl02yhznJ+TS9vjB
	obuY6RWwINzWF02OGtqo8WS7gJwwOuzjXIyMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tkzyWyqa9bYSg6MXC4Pw5KgI5NuWD+m/
	mFQ/qKaUu5tqgZHCoZJg4MStRL+vavMFNHggmZByCDTc64vcZ2AgruovW81r4sVr
	Y/HwXMFLO6Ly8PHdiKY1RIbfgNZnQbkw+9hDRlmWN6/wV1ZXGhpbHUYzbY34nFea
	cGsYo387vhg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A10024F9E;
	Mon,  3 Jun 2013 15:30:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC33C24F8F;
	Mon,  3 Jun 2013 15:30:30 +0000 (UTC)
In-Reply-To: <20130603145405.GJ1072@serenity.lan> (John Keeping's message of
	"Mon, 3 Jun 2013 15:54:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 867D7F96-CC62-11E2-B1C4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226223>

John Keeping <john@keeping.me.uk> writes:

> I started looking at this over the weekend but didn't get time to get
> something ready to be submitted.  I did find a couple of issues in
> cmd_foreach that make me think this topic should be dropped when "next"
> is rewound and held in pu waiting for a re-roll.

Thanks for a heads-up.
