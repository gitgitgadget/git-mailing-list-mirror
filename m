From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] rebase -i: support --root without --onto
Date: Tue, 26 Jun 2012 15:09:19 -0700
Message-ID: <7vbok5afow.fsf@alter.siamese.dyndns.org>
References: <8d50b9665c6b31af25464f92ada57da90c2ca8a7.1340747724.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:09:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjdwt-0004cY-Cp
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 00:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab2FZWJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 18:09:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab2FZWJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 18:09:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF9799F4E;
	Tue, 26 Jun 2012 18:09:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5K2aLrGD3WVU3AHAaXAZ/V3JV7I=; b=G+mBzd
	LmhrvhAmOTIORRbDedX1qdSDAtV1N+ulH7wVy0ZYa1G5oApk55SlG8JANYpnqZPg
	A7X4brrfR/mYWfsx6BAO3KynBZMNJrcMQtomsiZj0WE3G0dPvhxFnNgHFaonaID5
	u702HREWyj+vwXUTsXqRd+eUENk1sdMzdh9PI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W/LRo5oKu2Bk8MyaOav73AdMgqN60MUp
	dLdjGnrxOghBVaNveZe2efjsboHF5te5Y4ydjKfMQiUnKF+n4b+OTW5WMVj/ZLzj
	zvBmPKaX3QFKDqQBpoeJ+LBgYbJwP/l6OSIG9O8CDmxj7m3nVq903DLwtOsDaW27
	hGcxfKh63FU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7EEB9F4D;
	Tue, 26 Jun 2012 18:09:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B9AD9F4C; Tue, 26 Jun 2012
 18:09:21 -0400 (EDT)
In-Reply-To: <8d50b9665c6b31af25464f92ada57da90c2ca8a7.1340747724.git.chris@arachsys.com>
 (Chris Webb's message of "Tue, 26 Jun 2012 22:55:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94D99140-BFDB-11E1-A4EB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200691>

Chris Webb <chris@arachsys.com> writes:

> +		# Set the correct commit message and author info on the
> +		# sentinel root before cherry-picking the original changes
> +		# without committing (-n).  Finally, update the sentinel again
> +		# to include these changes.  If the cherry-pick results in a
> +		# conflict, this means our behaviour is similar to a standard
> +		# failed cherry-pick during rebase, with a dirty index to
> +		# resolve before manually running git commit --amend then git
> +		# rebase --continue.

Thanks; very readable and understandable.
