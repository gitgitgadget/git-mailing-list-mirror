From: Junio C Hamano <gitster@pobox.com>
Subject: Re: non-fast-forward advice breaks tests on OS X
Date: Thu, 12 Apr 2012 08:35:11 -0700
Message-ID: <7v8vi1gdzk.fsf@alter.siamese.dyndns.org>
References: <9F768A58-DEB0-43E1-8AE4-B2A5C4E6CDE9@silverinsanity.com>
 <20120412133701.GA367@gmail.com> <20120412140049.GB367@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:35:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIM3P-00044O-Kp
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 17:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536Ab2DLPfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 11:35:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40715 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757178Ab2DLPfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 11:35:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 183B16774;
	Thu, 12 Apr 2012 11:35:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Smv3gw/kcadsZs0ewz2MIWNq2gM=; b=tgKU/C
	Jn44PZbP81ukFH8zCCYMIeteI1vQxuF6aHePrdVp/ulfRyC6zsTy9u+tzT6mPKsg
	PI7TsL3gKsayercDOxqVVKzwg4kXzIMTu6xduzcq2JUMSQhh51PC1WtLXszH83F8
	lPBYu+BCysrKli/eLnFSscC/CbR87OGuGhGJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TCNuB6yVUSOuccnG6hSLt5hQ5CPQh/uD
	G/OFZYs1ojGxPtHwHkxWAL+esq4UWuxLSrxBzF7uU8N4fZCf8MywzRqmrQFyRxpf
	7NR4Q/Bt++ON2jnsmHTvNBqflbppLG4WzYk6fusVu37az1hZVQb9CC0uXxMfnRTk
	p+6hHpzlN+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08AF66772;
	Thu, 12 Apr 2012 11:35:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DA3B6771; Thu, 12 Apr 2012
 11:35:14 -0400 (EDT)
In-Reply-To: <20120412140049.GB367@gmail.com> (Christopher Tiwald's message
 of "Thu, 12 Apr 2012 10:00:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1947E22C-84B5-11E1-ACE2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195336>

Christopher Tiwald <christiwald@gmail.com> writes:

>> I also run 10.7.3 on a MacBook Pro. I will investigate this now and see
>> if I can get tests to break. I know the original patch passed the test
>> suite on this machine.
>
> Ah ha, I wasn't running the proper tests. I'll send a patch to the
> affected ones later today.

Please do so.  I assume that the test vectors were expecting specific
error/advice messages that need to be updated?
