From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Move api-command.txt from ./technical/ to ./howto
Date: Fri, 21 Dec 2012 10:33:58 -0800
Message-ID: <7v38yz1ch5.fsf@alter.siamese.dyndns.org>
References: <1595193006.286662.1356112971883.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Fri Dec 21 19:34:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm7QN-0007yb-R3
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 19:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab2LUSeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 13:34:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949Ab2LUSeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 13:34:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9A82A723;
	Fri, 21 Dec 2012 13:34:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B127QTlpo2dQ8yyEMS+e01juqqo=; b=jGTZzK
	/RPceUGabZUvZTGbG45Bz2Bs1aFg3p4/Jg/UU32ubXmqA/05UbQTH5RvpBXKIss6
	QPHDmRiqqc9n3G5ZuZv95Pq7+oa4m8VSinfDwle7yAoy3jxwx5pPNgQE4fXVrVRm
	AvaRvKvyYmcoru+rIVW5+OstbqACCWkpAf1T8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mhzQjwkyOehmviD3uhOCNNcf7fSDibO9
	NihXj7Bcpq3mbkzzc5wiBzKtgHBmMc1n95eso1nCbOW1KYgU/qDNysrSf3p2I+Hq
	74L+s5pT+sjc24XmQMiiEINegI4DDKrVkIjR/hmkKtcvnezBVOs0ZnmygRQvNpON
	tV7JfExdaz0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7B1FA722;
	Fri, 21 Dec 2012 13:34:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF974A721; Fri, 21 Dec 2012
 13:34:00 -0500 (EST)
In-Reply-To: <1595193006.286662.1356112971883.JavaMail.ngmail@webmail14.arcor-online.net>
 (Thomas Ackermann's message of "Fri, 21 Dec 2012 19:02:51 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD1AF26A-4B9C-11E2-8073-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212000>

Thomas Ackermann <th.acker@arcor.de> writes:

> "api-command.txt" describes a different kind of API than the other api-* documents.
> So better move it to the howto documents in ./Documentation/howto and rename
> to "new-command.txt".
>
> [PATCH 1/3] Move ./technical/api-command.txt to ./howto/new-command.txt
> [PATCH 2/3] Add new-command.txt to ./Documentation/Makefile
> [PATCH 3/3] Amend new-command.txt to be processed correctly by howto-index.sh
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>

Seems good from a cursory look, but I think this is better done in a
single patch.  If you do not mind, I'll squash them into one.


Thanks.
