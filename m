From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git clone -q ends with early EOF
Date: Wed, 18 Sep 2013 12:50:00 -0700
Message-ID: <xmqqa9j9vriv.fsf@gitster.dls.corp.google.com>
References: <201309181444.19070.marex@denx.de>
	<20130918181443.GA18821@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marek Vasut <marex@denx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 18 21:50:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMNlS-0006tG-3s
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 21:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab3IRTuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 15:50:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab3IRTuL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 15:50:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8673B43D13;
	Wed, 18 Sep 2013 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g+NEp7pZgaougS4WxN0bxx0kDKQ=; b=Wz+Mnv
	TFb925sd0yUd8Hub5Bj1YPe8EvG1zPLP6OXWqJx0GS5kWsbrdlRCNP6RIiAXcnYU
	AJ7HZQYQVhdopdkaT6AWrZC9iMbI/0bwQBa5cC28THYnkxzhYvEEhUBZQSNO/bDe
	1vLjg9+g1DsLscUo+StbxjhmtZKIielD5ljow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WdGZw9LaMbru1+cU6TPd4X+3uzqdoknz
	/g8neP0LxVHXj75Ag8pXT6qy5KsBUAf5v+nHd3mXfbCa8oO+ahZQkllzA6qIY3aO
	0KvOPBZ3NGMp3PBnM528dcKjlxvwKjI5HP75Ncy0I1TZ2Tp3JEujoXN67XRKlRGw
	8GRWnRJMBIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78B8643D12;
	Wed, 18 Sep 2013 19:50:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9736C43CFE;
	Wed, 18 Sep 2013 19:50:09 +0000 (UTC)
In-Reply-To: <20130918181443.GA18821@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Sep 2013 14:14:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 864A8D56-209B-11E3-9D5F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234988>

Jeff King <peff@peff.net> writes:

> The keepalive patch is not in any released version yet, but we have been
> running it in production at GitHub for a few weeks.

That is good to hear; I'd feel safer to bump the scheduled
graduation date to 'master' for the topic in that case.

Like tomorrow ;-)
