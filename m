From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: start warning upcoming default change for
 push.default
Date: Thu, 21 Jun 2012 10:21:21 -0700
Message-ID: <7vk3z0shri.fsf@alter.siamese.dyndns.org>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
 <1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vehp9x3yz.fsf@alter.siamese.dyndns.org> <vpqpq8t96zw.fsf@bauges.imag.fr>
 <7va9zxvkyp.fsf@alter.siamese.dyndns.org>
 <7v62alvk2e.fsf@alter.siamese.dyndns.org> <vpqd34su0io.fsf@bauges.imag.fr>
 <7vobocsipo.fsf@alter.siamese.dyndns.org> <vpq62aksicy.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 21 19:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shl4U-0005jh-9m
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 19:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759954Ab2FURVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 13:21:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759928Ab2FURVY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 13:21:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DF169232;
	Thu, 21 Jun 2012 13:21:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eBSaMUdlYgj9h+CYpVh2/GSc2a8=; b=cJDmvs
	2++VXiath4BHXxWmjExJkKwRaF0I19/h2yUQfesE8F2zKbTzrSx6Z1HzlmkKwdto
	ZbKnMiWlN1OXIQXhTTr1+JN1ag4j9bgOeoLxdi9CROh65Njhze3q+ylmlK2oSSrU
	okT4yx0y5yO3vyqtfy8qJHoQYzHlPcqGuwPno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jqsMpZzv+lCdI1RV2sSZepG90qL1KEzD
	3uXcb9D76tbk6MFzjjR+/DNV1jSOdrO9nHOThGUPb+VGBX7CGbBQUmJa/jA8Nosp
	kW/x3+Fez4EysjISWLtG4V+X54i79K32vfy2AQ45ncdBEmJD76/nPtfgGARtwjqi
	bG9EjK1RtbI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05AD69231;
	Thu, 21 Jun 2012 13:21:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77264922D; Thu, 21 Jun 2012
 13:21:23 -0400 (EDT)
In-Reply-To: <vpq62aksicy.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 21 Jun 2012 19:08:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 865C62B0-BBC5-11E1-88ED-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200409>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Re-read the part you omitted with [...].  Doesn't it say something
>> about "only available"?
>
> It does, but it seems you're trying hard to avoid telling the user "you
> should use 'current'", where 'current' is the only reasonable option for
> this user. I still don't understand what problem you're trying to solve.

I am avoiding to say "you should use simple/current".  Choice
between matching and simple/current is for the user to make (mostly
dictated by the project's workflow) and we cannot make a suggestion
better than what user knows.

Choice between simple and current is mechanically derivable. If the
user also uses older version of git, simple is not an option.
