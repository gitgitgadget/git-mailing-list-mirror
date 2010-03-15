From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] cherry: support --abbrev option
Date: Mon, 15 Mar 2010 10:13:55 -0700
Message-ID: <7vwrxdse24.fsf@alter.siamese.dyndns.org>
References: <1268668999-4188-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 18:14:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDrk-0003mN-NY
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965503Ab0COROE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 13:14:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965428Ab0COROB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:14:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 283CEA2604;
	Mon, 15 Mar 2010 13:14:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=OBW5kLEdG4q7rKTYINEVW/aCVqM=; b=bI6EXwqj7+aJwebbg57N8Hb
	UJz8DMOPzMJ6Zs2NDIgH2hIF9Jfk9v7Dw03chAToDBAHObb6dHKI/nUDo/pNwFas
	2JHmMuwiFLHmtWew3mXwjU91AG7AuobfgjYfDMQ/EArJPfIY/QF6ef7vFI1VLFw2
	eiWgjV6+IeX/O9Ik7MYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=cC6f1TQ7KLHeGr2zPWXo0rTLHjm0f33k2Bqw8jp9IIYGoSe+K
	Af2tGqY3fhwBc6yOofwNHymvIUNdEl6eqq2vpTwJobD+7dlUTDouqwDsVol7upku
	m27n5CN+Nrtxv6KlKTrTks88KnqSQ5oSZnL0kR8p23MSv/5DSWqD2z0Vi4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02730A2603;
	Mon, 15 Mar 2010 13:13:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72AFAA2600; Mon, 15 Mar
 2010 13:13:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 24F5ACAE-3056-11DF-A1C5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142224>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> Switch to parse-options API while we're at it.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> I sometimes find it useful to look at the commit-subject together with
> the SHA-1s. Using --abbrev increases the chance that the lines fits on
> an 80 character wide terminal, making the output easier to read.

Even though "cherry" historically was meant to be a low-level helper for
Porcelain scripts, I've seen people use it as the top-level UI, and I
think what the patch tries to do makes sense.
