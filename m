From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_name.c: update comment to mention :/foo syntax
Date: Tue, 21 Sep 2010 16:29:33 -0700
Message-ID: <7vpqw6u142.fsf@alter.siamese.dyndns.org>
References: <7ab60e32582447ad792602ff405dcee464ef1414.1284830388.git.kirr@landau.phys.spbu.ru> <1285016477-22222-1-git-send-email-Matthieu.Moy@imag.fr> <7v62xzug94.fsf@alter.siamese.dyndns.org> <vpq8w2ug8u0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 22 01:29:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyCHS-0000QX-3L
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 01:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab0IUX3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 19:29:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab0IUX3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 19:29:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EEA3D8ECA;
	Tue, 21 Sep 2010 19:29:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cC9qj8hkJt3X9TyHpBriaT9vGYM=; b=fOFNO2
	aXez0wAzOnaR8dwBJVNO0+j8wrdHPnWWnoDrDqSwLHEw9MXhjRGIOrDB9toU3hKO
	bq6KvMXrICjUU4cbKKWQKEeTaGnFIbQJkBm55+VOw0910p4LgvfJITS0cUA3JPBg
	J5M3WZqWmlZV2ZoJid+Qfkgou0RbIlJxfn/wg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cJ5oZe3UsMAtSZZ4Hxc3FVWbt4l3aRG9
	u3rtoYznBDW7RwW1BPgVI3UiQeNZpYEKdZ3xAMAKN8/psKrz2R6yczl/4w7fjc3m
	N8K2Yffq7OcTTJrHIHZFJikINxPVS8ceqBFDYXMKT2WnWHEHKimKRTpMNDJ/yVtV
	ugU9VkJLWBo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BD97D8EC6;
	Tue, 21 Sep 2010 19:29:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C26BBD8EC5; Tue, 21 Sep
 2010 19:29:34 -0400 (EDT)
In-Reply-To: <vpq8w2ug8u0.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue\, 21 Sep 2010 22\:06\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 19663D32-C5D8-11DF-A975-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156769>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>> +	 * :/foo -> last commit whose subject starts with foo
>>
>> Documenting what hasn't been is a good thing, but is it really up-to-date?
>>
>> Isn't it "a randomly chosen recent commit whose subject contains regexp
>> foo" these days?
>
> I don't know.

I was vaguely recalling this one when I wrote the above.

commit 57895105c4ff083d7c9bc59b2b88b9b5176c1915
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Apr 23 08:20:20 2010 -0700

    Make :/ accept a regex rather than a fixed pattern
    
    This also makes it trigger anywhere in the commit message, rather than
    just at the beginning. Which tends to be a lot more useful.
    
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
