From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2010, #03; Wed, 10)
Date: Thu, 11 Mar 2010 04:13:34 -0800
Message-ID: <7v1vfr2h01.fsf@alter.siamese.dyndns.org>
References: <7v7hpj4k7w.fsf@alter.siamese.dyndns.org>
 <201003111209.10445.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 11 13:13:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NphGu-0004tR-KK
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 13:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519Ab0CKMNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 07:13:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554Ab0CKMNn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 07:13:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3C2CA0150;
	Thu, 11 Mar 2010 07:13:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GvDj9sJwBcRn+dvm0sbHUdtqJfM=; b=CdQ8z3
	NjJcqv8M1NPJUqBroxzJSYIDKDP7RMYyNiz8592AV3qePSU88Y+vGWbFcyyWQ+ru
	njF9K1fGhlJ24jDsQhpoqjCyrcciB6Ik0Xw4G67k76oPhQRXhw/f8aar/6P99jgB
	r3CGFXVbN3Ok0Y5BcyPGJEc02G0P4aMpwNNXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kazu/BrJyAAY2+Te0pKZf0MyiijIahUM
	ykXF7TMGDetyfAH+2LAHNzJDp+WpvgOzIKYrVVmKcr5a2nacL3IxsuWo09gXA+yN
	iUUVezYpqRLx/SoEGhhcJ+NAdIx6ldOGFq0/Qipkfksod0t+OFIEAS5MpOJHNL9F
	C8wDvmsPoDg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 907ABA014F;
	Thu, 11 Mar 2010 07:13:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4A22A014D; Thu, 11 Mar
 2010 07:13:35 -0500 (EST)
In-Reply-To: <201003111209.10445.johan@herland.net> (Johan Herland's message
 of "Thu\, 11 Mar 2010 12\:09\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 86E5CEE6-2D07-11DF-B4C0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141956>

Johan Herland <johan@herland.net> writes:

>> * tr/notes-display (2010-03-10) 13 commits
>> ...
>> Re-rolled.  I think this is ready for 'next'.  Comments?
>
> I just reviewed it, and it looks good to me.

Thanks.  There still are a few niggles as you pointed out (e.g. I share
the feeling that the auto-initialization should go and be replaced with a
BUG()), but most of them are minor and not showstopper, I think.

Thomas, I am Ok with a replacement series, or incremental updates on top
of what we have now.  Please let me know which way you prefer.
