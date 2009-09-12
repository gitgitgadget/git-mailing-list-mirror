From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2009, #02; Mon, 07)
Date: Fri, 11 Sep 2009 21:38:09 -0700
Message-ID: <7vskeslqvi.fsf@alter.siamese.dyndns.org>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
 <7veiqdngs0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jan Engelhardt <jengelh@medozas.de>,
	Johan Herland <johan@herland.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 06:39:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmKO1-0004tq-49
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 06:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbZILEic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 00:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbZILEic
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 00:38:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbZILEib (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 00:38:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BFD72FB27;
	Sat, 12 Sep 2009 00:38:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jF7e++5KM5GT3x/8y+mHctRAnpc=; b=VUqWCe
	CpRzfAdBocIF35ViiIIP6rkqGon8+L1bVRRERWTZwNl47wwTnTxBeXxq0p279gJj
	qWCZzmt9/+L0DP6zny80L1t3VkvNtVH4VXEyu7J1Gg1FyijDb51lB60HVKvlHWM9
	6XkgtoxZoBq/q9hyj5L391PIfIXT+ju1zElk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UfcHhPxMLI/oPeQjqwfR0mWLc8bJCGfg
	ZxO5ZimRRqpS0Xtr+63v+RQQvco12U2QvNxGE52yRjjXy+HYkuWGGbGPiNFIWWlw
	Ez6cw/fGK3DwO+/QGCwJ+UQAs39/vk36D6yBMvFBe5ER+G0Lfuij7960d9eZvYpf
	K+4fKq/kKpo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E72DC2FB26;
	Sat, 12 Sep 2009 00:38:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 445FC2FB25; Sat, 12 Sep
 2009 00:38:11 -0400 (EDT)
In-Reply-To: <7veiqdngs0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 11 Sep 2009 17\:33\:19 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1BBD5E66-9F56-11DE-AF0D-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128237>

Junio C Hamano <gitster@pobox.com> writes:

> * jk/unwanted-advices (2009-09-06) 2 commits
>  - status: make "how to stage" messages optional
>  - push: make non-fast-forward help message configurable
>
> If I missed the v2 or later that uses 'advice.*" instead, I am sorry, and
> please let me know.

Found them; thanks.
