From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Mon, 18 Mar 2013 18:46:43 -0700
Message-ID: <7v38vsma9o.fsf@alter.siamese.dyndns.org>
References: <20130318220224.3b23a381@hoelz.ro>
 <20130318231043.GD5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Hoelz <rob@hoelz.ro>, git@vger.kernel.org,
	josh@joshtriplett.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 02:47:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHldx-0000H2-FW
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 02:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933049Ab3CSBqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 21:46:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57943 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757492Ab3CSBqp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 21:46:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50977B750;
	Mon, 18 Mar 2013 21:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lRUfaJBYtSIlhHXKffL1/O4qIg0=; b=adgtXp
	HgG+SLIYVPYYjzdc8T5GE7YLV1JTeAI1cESHQpW9QKBjea+6/kS+e8K6A3C47VWE
	KyiGXidQSkerK7EbR5ElpUFA1leuzVxUp0xVKsg9rk7SGAScLXe6xOUop8rXJsvT
	J4l2Tndv7mYTO/JJi8jaW+uHEgYYFylVeS4jI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLXeZ6xvlh5tKbOS5X4QhnOIsURZKjEc
	J9Qb1aJl1XH8DmYLwAk4/W3D1GHcPssUCZcCmx1/H3B6ln822dsICEeWzSmTxPBd
	PiPlJ4oKhHRVaG+TwVjY+93iDFHyI6cL57YvrxIZs3/GqBT/yap9ZUwszjgdIod3
	z/tXprUstBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45127B74F;
	Mon, 18 Mar 2013 21:46:45 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2487B74E; Mon, 18 Mar 2013
 21:46:44 -0400 (EDT)
In-Reply-To: <20130318231043.GD5062@elie.Belkin> (Jonathan Nieder's message
 of "Mon, 18 Mar 2013 16:10:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAC2F652-9036-11E2-A421-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218468>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Test nits:
> ...
> Hope that helps,
>
> Jonathan Nieder (3):
>   push test: use test_config where appropriate
>   push test: simplify check of push result
>   push test: rely on &&-chaining instead of 'if bad; then echo Oops; fi'

Are these supposed to be follow-up patches?  Preparatory steps that
Rob can reroll on top?  Something else?
