From: Junio C Hamano <gitster@pobox.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Wed, 23 Jun 2010 13:26:41 -0700
Message-ID: <7vmxulebr2.fsf@alter.siamese.dyndns.org>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
 <i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com>
 <n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
 <alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
 <AANLkTinPrObdQh1vZLo0tlq2bZn7BXKvHWLktI2pR5LY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Aghiles <aghilesk@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 22:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORWXG-00034q-BE
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 22:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab0FWU05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 16:26:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab0FWU04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 16:26:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B8EBBDC03;
	Wed, 23 Jun 2010 16:26:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RG7asw9olJc+1CHcUXQfh/T4vEY=; b=O5cBtC
	TD0PbkyjaaqcK471G22NbO5mr8iY7LaKED0JSzYYKmSti0BomClLQ2x+isK6sdYn
	SrCZbKDc2oXr+qqzCFgQQpMb7Cde47dXqQBwV4RNh+LCsQbaMR5xBEhCFD/rLHxG
	dTz39En3p6pQD187HM/w0fadlfQbYmRKb9eMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NsNRazI/VQeKVg4QyOQABVEnsdC3ae0r
	yN4mIIcTFj7O5/K3/hX2HQtfsrQuvo1xYLt7xt/S8KhjUsVdAw89FdmaTtXxliaz
	7CbZbpHfy/F+yljMHK0bV18pe/DEUd//Z3vInk7hDO3GVak+r+L5bBLk8kSCSJuj
	lTuUkUjjZpg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B4F4BDBFC;
	Wed, 23 Jun 2010 16:26:49 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C2D2BDBF7; Wed, 23 Jun
 2010 16:26:43 -0400 (EDT)
In-Reply-To: <AANLkTinPrObdQh1vZLo0tlq2bZn7BXKvHWLktI2pR5LY@mail.gmail.com>
 (Jay Soffian's message of "Wed\, 23 Jun 2010 15\:36\:51 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6BE6AC0-7F05-11DF-BB5F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149546>

Jay Soffian <jaysoffian@gmail.com> writes:

> Speaking of which, I'd love a switch to "git show $merge_commit" which
> does "git log $merge_commit^..$merge_commit^2" but I've been too lazy
> to write it. 9/10 times that I use .., it's in this context. :-)

Doesn't "git show -p --first-parent $merge" work for you?
