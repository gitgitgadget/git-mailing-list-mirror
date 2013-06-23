From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/16] remote: remove dead code in read_branches_file()
Date: Sun, 23 Jun 2013 01:07:50 -0700
Message-ID: <7vhagpfdwp.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-6-git-send-email-artagnon@gmail.com>
	<7v1u7vkslz.fsf@alter.siamese.dyndns.org>
	<CALkWK0mYmhnOL-F+StuKWSeQ48EsQSAnS0_6u-B8KKq+RrOW5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 10:08:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqfL4-000768-9z
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 10:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053Ab3FWIHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 04:07:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877Ab3FWIHw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 04:07:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 243AD26842;
	Sun, 23 Jun 2013 08:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ec5EIpteqQevf62Smwy1NBKlmyw=; b=ykHXqXBmof7ExTUt5x4m
	Bst3fz3e6EDx3f4daCgadqEfOCnCj4ozAf8Smn543HJhjUL2xTYogDbdUVeQmQPF
	CQzbLSzMjVUvGgA4JXq+rvtJMqhxrXwLDBK7XgUivaAR/z+b1xdVHJlXGgOdqvSC
	QO5DYDOLRF/SHze3lcDYZmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=d6jnbM7I1Yh6p2YV6xeQMnVbMgEWXl54OaztgDhq5mA9BL
	Tm4hVfiXjmZNMgDXMC1hHqUXs4A7tiGgKSQH9o7AFyqn8J1Xe5SjhjIKDxAlChsT
	OCcZkFBVBE8KziRZnpVVsemV1KPkm9C4EAmtLWCRe4D6x57FSqubKGedru/po=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C95826841;
	Sun, 23 Jun 2013 08:07:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A928C2683F;
	Sun, 23 Jun 2013 08:07:51 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00307E96-DBDC-11E2-B273-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228732>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> Reminds me of the strategy to deprecate functionality in X (cf.
>> http://lwn.net/Articles/536520/) ;-)
>
> Leaving dead code around to confuse readers? :\

Did you actually read what was quoted?

We broke the use case to access jgarzik/netdev-2.6 only by having
jgarzik remote accidentally, and waited for quite a while (since
early 2008 until now) to see if anobody screamed.  Nobody did.  We
now know we can remove that feature.

That is exactly what Keith is describing, isn't it?
