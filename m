From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH di/fast-import-deltified-tree] Windows: define S_ISUID
 properly
Date: Wed, 21 Sep 2011 08:13:31 -0700
Message-ID: <7v39fq2ajo.fsf@alter.siamese.dyndns.org>
References: <4E798538.7070106@viscovery.net>
 <loom.20110921T092135-714@post.gmane.org>
 <7vfwjq2hoo.fsf@alter.siamese.dyndns.org>
 <CA+gfSn8VaTLcrLqb3HGJpjL5WJMHZz4kPPUtyeHPCsdmO5iU8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 17:13:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6OUa-0000Yh-N9
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 17:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab1IUPNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 11:13:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab1IUPNf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 11:13:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D607C51F6;
	Wed, 21 Sep 2011 11:13:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OrZWs/1eVog7rK63FsTEsg1BRtM=; b=TzGSNg
	advwvA3YvRt7yn41EMK61kfiF3A9qHuL7fTis2AVPv+N4YfC4+e0SbqljM6VstNA
	C05CPFY+Xe1HsLqj2tbLrLhf+3nG/XhClTxRKF2HNbmKfEDT8qbEFRNTbRXCBz8g
	1TAQ6b1zE78MNJU1zQ+S4JyIQDXQt/ave5kaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gfjxw5MSovOao1NI8edaYJhRxkQMNj00
	nbxq8LHqzL4EyQ1ZLw0AQsnTsHSEepEZqoXbOSelsqvJ3AG0HL3fdGe8bOjKGY3u
	1y9KLDC58iQWtKSHOGNfEuxzHaRzOAQJLRH3xFS69QMgD5Z/6spO4JVa+pT5Xvb3
	C82YQO+NMiM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDC6151F5;
	Wed, 21 Sep 2011 11:13:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D8B051F4; Wed, 21 Sep 2011
 11:13:33 -0400 (EDT)
In-Reply-To: <CA+gfSn8VaTLcrLqb3HGJpjL5WJMHZz4kPPUtyeHPCsdmO5iU8g@mail.gmail.com> (Dmitry
 Ivankov's message of "Wed, 21 Sep 2011 19:44:55 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 457008F8-E464-11E0-A5F8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181849>

Dmitry Ivankov <divanorama@gmail.com> writes:

>> And it would be even better to use a value that does not overlap with the
>> usual bits for do-not-delta bit if possible.
>
> Depends on what is a usual bit. I'll use linux defines for mode bits.

Failed -- was too subtle to extract a hoped-for response "come to think of
it we should have done it as a separate field in the structure".
