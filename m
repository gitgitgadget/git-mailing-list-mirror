From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make color.ui default to 'auto'
Date: Wed, 15 May 2013 10:34:54 -0700
Message-ID: <7v8v3gcfk1.fsf@alter.siamese.dyndns.org>
References: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
	<1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vy5bgckr4.fsf@alter.siamese.dyndns.org>
	<vpqhai4fbsn.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 15 19:35:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcfbZ-0003yN-NF
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 19:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759819Ab3EORe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 13:34:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759832Ab3EORe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 13:34:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 980941F3F7;
	Wed, 15 May 2013 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xrJ4aO3F6yW+DXyO68Z8Nhu/A8k=; b=GJwO4n
	JwkBFr9Qdw4gcUS8spsHKkHOtnCdTdrZYqxnhymAAzS1m/N+xra49T2wRf+VKGk4
	K5BVXi/pF+v2d/6f3ZRmmMNBsK5AJEYXCsgEdAKqTVWVMZErq8bWBRTZxiidO7vl
	3J4Q6Agg4KYRaTe8HPH9Khm4GEDWIG127qk7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XRYcCU+tSGTMYn4QWb3TiX1oawEy6gH9
	tslkKvzWQXPQNwUD7Pg7Y/O5NYtnkX+oIp5vqMpjD+ccqKHEVWeA2/LlKf503Wy6
	oZ4gW1pd+wEbLTY+s1n1Tfl1rkY75nD5HBubkg/PTdOB9yfMS2AyOewhX7NXI2hm
	s+qlyuIgMn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 900631F3F6;
	Wed, 15 May 2013 17:34:56 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D4CE1F3F3;
	Wed, 15 May 2013 17:34:55 +0000 (UTC)
In-Reply-To: <vpqhai4fbsn.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 15 May 2013 18:27:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C22DE1AC-BD85-11E2-96AD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224430>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> The above two paragraphs do not make a good justification [*1*].
>> The former can just as easily websearch for "enable colours in git"
>
> I disagree: I do not know anyone who would be really harmed by colors
> ...

I actually am one of them (light cyan or green on white background
with small font is very hard to read for me), but I think you are
missing the entire point, which is not "is anyone harmed?"

This patch is not even about deciding if colored output should be
the default.  That has already been decided by documentation for us
long time ago; the patch does not have to (and should not) argue for
and justify why color is good.  Our recommendation has been "use
color=auto", and change of the in-code default is merely to make the
default in line with that recommendation.
