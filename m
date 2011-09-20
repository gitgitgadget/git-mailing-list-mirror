From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-update-index: refer to 'ls-files'
Date: Tue, 20 Sep 2011 12:50:54 -0700
Message-ID: <7vmxdz56xt.fsf@alter.siamese.dyndns.org>
References: <1316521427-20855-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 21:51:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R66LO-0002q0-WB
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 21:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871Ab1ITTu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 15:50:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab1ITTu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 15:50:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50217406C;
	Tue, 20 Sep 2011 15:50:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yrCzj6i+tiQ75vWfmGdT4nFztbo=; b=HNO1oL
	ddG0hxQEQqEjaJNmrvOabbidPaL1yKBQKNFTBszDeEiYeHVtNVYe1UUzwArjbEfN
	7vSHC1Kj/V72Yzvc98eaULWNwNyOZTY68/f/VnGMndX+rWbPAROZZ+8D6USM0SDv
	gX3TXZOvJ+LZqQ9Pua8rqp6WMLIJw62R8zsXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FlKOZoEKn4HHM8Or2c1U1FECqUr8BE84
	e+FUXtETdMP/PqSztWPbvcGYTCJVBLP9xj3KBUsFhCwBn90o1eWN5zP6MxsMouHV
	/kPnn0wuFDCZl0BbEYNieFhUqQwA7KW/Mmyts2tGqDv3nXuQtU9oyTpimxF8GZl0
	WZ7Xd+klRgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48A6A406B;
	Tue, 20 Sep 2011 15:50:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB42A406A; Tue, 20 Sep 2011
 15:50:55 -0400 (EDT)
In-Reply-To: <1316521427-20855-1-git-send-email-stefan.naewe@gmail.com>
 (Stefan Naewe's message of "Tue, 20 Sep 2011 14:23:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAA85D4C-E3C1-11E0-95FC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181785>

Stefan Naewe <stefan.naewe@gmail.com> writes:

> 'ls-files' refers to 'update-index' to show how the 'assume unchanged'
> can be seen. This makes the connection 'bi-directional'.

Thanks, but for that bi-directional connection, I think the place you
inserted the new text is suboptimal. There is a single paragraph with two
sentences to teach how to set and how to unset. Adding another to teach
how to inspect would flow the resulting logic more naturally.
