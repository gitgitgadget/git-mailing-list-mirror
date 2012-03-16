From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 05:17:16 -0700
Message-ID: <7vty1oivub.fsf@alter.siamese.dyndns.org>
References: <4F63205A.6000202@seap.minhap.es>
 <vpqlin0n8w5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 16 13:18:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8W7L-0004j8-7z
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 13:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761596Ab2CPMRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 08:17:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934Ab2CPMRe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 08:17:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F15A61BB;
	Fri, 16 Mar 2012 08:17:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dYS93XalUap4HQnPud3y2fo5aac=; b=TEgCi5
	F9K6fwRbzHsTL5Dbqqirz3fjsLBvjrEM0M0rPQy+/oHLRXSgFG34L78KnEUq/XJ0
	v3Q9NQpyzv1rgIAKmD1xGAENtHq5oBJKWj85Rt3rO1KvXCMLqursJJ7M+OPOvXWg
	oo9KLNsMd/qva2Y6eMIS8oVNg52N4PRFH1JeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mblhSVFywy1+Ogms+gi7oOmKPZ64hKxC
	E9elfXVdKiX2ZtRvin9o+Ji6BOjL+vC9sPV8jtZCPJU/9XI5QM8dKAhUItIVFySV
	7/WfXiPwVL+W4lJidjLq8J995+x3No5gpWFb/g6ajGHYm9ZoW1chXiEiUft0xqva
	n4qouZ6KAGY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9690061BA;
	Fri, 16 Mar 2012 08:17:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EF8161B9; Fri, 16 Mar 2012
 08:17:18 -0400 (EDT)
In-Reply-To: <vpqlin0n8w5.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 16 Mar 2012 11:21:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F93FAFE0-6F61-11E1-B141-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193257>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
>
>> +# You can re-order the commit lines to affect the order on which
>> +# the commits will be applied.
>
> That's probably the main use of "rebase -i", so it deserves a mention,
> yes.

Erm, read in isolation by people like you who _know_ what the command
does, the addition might look sensible, but I find that line of thinking
somewhat disturbing in the first place.

These are meant to be a short _reminder_ for people who _learned_ how the
command they already _know_ is spelled.

If the user does not even know that one of the primary use of the command
is to reorder, isn't he playing with fire?

If we come up with a politely worded message that makes the user realize
that the user does not know what he is doing and gently nudges the user to
read the documentation before continuing to potentially harm himself, that
would be a good addition, but...

So, I dunno.
