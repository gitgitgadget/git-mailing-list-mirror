From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 0/2] Mixing English and a local language
Date: Wed, 12 Sep 2012 11:18:06 -0700
Message-ID: <7vligfcdgh.fsf@alter.siamese.dyndns.org>
References: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
 <CACsJy8CG72PzvndV7C4a9hspxhprKn2tcb49HxeZ14pmEDycGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 20:18:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBrW0-0000OF-FH
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 20:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760977Ab2ILSSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 14:18:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760968Ab2ILSSK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 14:18:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02E689523;
	Wed, 12 Sep 2012 14:18:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v0Mq3hcJ3OyjVwJWJWv0PJMS+Wg=; b=ZxEJXE
	/IPEfePLWsOImimXtSJiqckZw2NBCPehG9H/fWxtJ+Rd3sjDzz+eB+kSlAzpN5N1
	8o/48kc8KL3dzwW7kEsq67YvSPh1nvDLcCu6HXbN6ANkdRh+KuuKJHihRP8Pg2Wn
	C/62ZZglnX+HTb2ZpRVQFZ9hO5ysRrvYIO3OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F+KsOzLQiVUqM424j3wLLJxsKSgfIBzB
	zsjV6KvRHPhGSNMME3pNS9nFxVXpjtoIuXD72zdgYgCM6ziZPNVkN1a6cx/0MUnx
	OpLn3I93kgtd1wenVD4Gr3t6LXyZWLMkeVG95pkiJr5XZuuWeHJED9VQatPLPgYm
	WfX9ywy1Npg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5BFC9522;
	Wed, 12 Sep 2012 14:18:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42AA99521; Wed, 12 Sep 2012
 14:18:08 -0400 (EDT)
In-Reply-To: <CACsJy8CG72PzvndV7C4a9hspxhprKn2tcb49HxeZ14pmEDycGQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 12 Sep 2012 21:05:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 340E405A-FD06-11E1-8EDA-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205320>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Should I interpret the silence as "I don't care, if you want it, go
> for it" or "not acceptable, but no reasons given"?

I do not speak for the others, but the reason I didn't respond is
none of the above. It is somewhere between "Meh" and "Anything that
says 'local language' and 'English' cannot be worth looking at."

I _think_ the patch was inspired by $gmane/204979, where I said:

    Or "LC_ALL=C LANG=C git format-patch ...".

    It does not bother me (even though I do not read Vietnamese), but
    this has been brought up a few times, and we may want to revert the
    i18n of the diffstat summary.  It does not seem to add much value to
    the system but annoys people.  After all, the "upstream" diffstat
    does not localizes this string (I just checked diffstat-1.55 with
    Jan 2012 timestamp).

and I have been waiting to see what others think.  I am so far
taking the silence in the thread to mean they do not mind seeing the
diffstat summary untranslated and they do not mind seeing it in
Klingon, as long as the three numbers are there with (+) and (-)
markings.

It is bad enough having to decide where the boundary between 'local
language' and 'C locale' should be drawn in the mixture.  I am not
enthused by an attempt to make the boundary tweakable, and worse
yet, to do so per command.

IMHO, we should just decide where to draw the line and be done with
it.  The users already know or can be trained to know to choose the
greatest common denominator when interacting with others.
