From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] merge-recursive: use "up-to-date" instead of
 "uptodate" in error message for consistency
Date: Wed, 07 Jul 2010 17:26:22 -0700
Message-ID: <7vd3uystsh.fsf@alter.siamese.dyndns.org>
References: <7vbpajzro3.fsf@alter.siamese.dyndns.org>
 <9aea70210996b395f5fc04ae48a372f9b51ba182.1278489069.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 08 02:26:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWewr-0001tA-RE
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 02:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155Ab0GHA0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 20:26:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756763Ab0GHA0g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 20:26:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 40329C26A6;
	Wed,  7 Jul 2010 20:26:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zwBmyUEb4jjgink1gKALWcGooNI=; b=Qq+iec
	5HaJwL8V4CC4aEVhJuwFtpdIwld5lBE6sjxTadKpTljctZCziaNtMEdZiwb+taVj
	DLp9HvjlBUUxerv1BcctHJ33x9HZKm2DpHdODS/SpGBqpg0azYnMfMDwd86O/9rS
	M0FjeqdnFEJ+dUKIxIbNpI5GN78Ydj0gApr+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MNDx/aVFa+g7kvR4wzgWICTGfOLj324m
	99dylyObFf5rK9BU7T0Bd225Ox+90/cjrAuNkHcFNArmuSyewHWUJnf1HzJ4s1yg
	FWHYZWFpVbSqzCqoocwMEta7RUCjqNNOYE+ZIG+pXB0zVfARV4fQJHOVFaqAUDHB
	1628xzkhxig=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8343C26A3;
	Wed,  7 Jul 2010 20:26:29 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1B66C26A2; Wed,  7 Jul
 2010 20:26:23 -0400 (EDT)
In-Reply-To: <9aea70210996b395f5fc04ae48a372f9b51ba182.1278489069.git.nicolas.s.dev@gmx.fr> (Nicolas Sebrecht's message of "Wed\,  7 Jul 2010 09\:54\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7403D76E-8A27-11DF-A189-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150518>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
> ---
>
> The 07/07/10, Junio C Hamano wrote:
>
>> The "struct unpack_trees_error_msgs" mechanism was introduced so that we
>> can change the Porcelain level messages without breaking the plumbing API,
>> which these messages are part of.  Please see 8ccba00 (unpack-trees: allow
>> Porcelain to give different error messages, 2008-05-17) and fadd069
>> (merge-recursive: give less scary messages when merge did not start,
>> 2009-09-07) for backstory.
>
> Oh, thanks. I was unaware of this mechanism and didn't care about what I was
> touching.

I suspect that the documentation patch talks about a nonexistent reality.
See 8ccba00 again ;-)
