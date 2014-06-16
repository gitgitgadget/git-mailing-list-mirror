From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] submodule config lookup API
Date: Mon, 16 Jun 2014 10:58:25 -0700
Message-ID: <xmqq38f4spmm.fsf@gitster.dls.corp.google.com>
References: <20140605060425.GA23874@sandbox-ub>
	<xmqqy4x14wn8.fsf@gitster.dls.corp.google.com>
	<20140613224156.GA4345@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 19:58:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbB3-0004jk-Vy
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 19:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbaFPR6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 13:58:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57814 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbaFPR6h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 13:58:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A959E1FB9B;
	Mon, 16 Jun 2014 13:58:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EaaMqRO4fhIxiI7MVdmvpFOT8ac=; b=Gz821D
	LO+vzlUhgHjz9EsMmuxmGO+2uj4tqIF8EUVvHP0GnWtIi4+zKhzFVHLdfuHeyjNK
	QgDhqSsvpTA0g1yPYu7cPzeVHPw8NtERRXh91Aa01KjjUUqbiaMjvyTDm3RScz3u
	HtDT8jruKsNhlHIphaxXuueyfdm24tv1emj1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k/685/IRPhqrPKJeQdT4OFkUqcoLfTbS
	D227aBaTWRiBBxf6y9huC5EdXfOV5J5ShRWK9GnkV5sTgi+QG5Wr5FybOTrwK8hD
	6CuyKCOZwXtBBBdbhFXZJyQX1JC9GSejQ9iWg7yYsv1v02iwUi/qGgmG4EB+9WSZ
	Cqx+QoRlZOA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E41D1FB99;
	Mon, 16 Jun 2014 13:58:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 12E731FB96;
	Mon, 16 Jun 2014 13:58:25 -0400 (EDT)
In-Reply-To: <20140613224156.GA4345@sandbox-ub> (Heiko Voigt's message of
	"Sat, 14 Jun 2014 00:41:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D0052AB4-F57F-11E3-B2B7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251741>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Thu, Jun 12, 2014 at 02:59:23PM -0700, Junio C Hamano wrote:
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>> 
>> >  t/t7410-submodule-config.sh                      | 141 ++++++++
>> 
>> We already use 7410 for something else in 'pu'; please avoid dups
>> waiting to happen.
>
> Sorry about that. Should I use 7411 even though that other series is
> still work in progress?

Surely.

What would be an alternative?  Tell the other series to rename?  ;-)
