From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Harmful LESS flags
Date: Thu, 24 Apr 2014 12:29:21 -0700
Message-ID: <xmqq8uquv84u.fsf@gitster.dls.corp.google.com>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
	<87lhuvb9kr.fsf@fencepost.gnu.org>
	<xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
	<87tx9ia5zq.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: d9ba@mailtor.net, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 21:29:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdPKx-0006Wo-DJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 21:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbaDXT30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 15:29:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51262 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306AbaDXT3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 15:29:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 666EC7F779;
	Thu, 24 Apr 2014 15:29:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D9A85Yy+70KHSduXIB6Fbg+niLk=; b=pqWqQ8
	+yIXNa/IvXrZKS//07oJ3JjSay2a/kzxoH8ElUkOmLIU+phAqwLBRzkXvY/7H3FL
	q9t3ZfVYgGqcH+1VrKrymX5MxQmXwXDw0OUwzwac0OUzNmPP6YJ64NwytYoBAuGQ
	ovb72n1LxexQkSe/o3xcLgtXQ+RedYJFh2pLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IjN83YdVOck8AEB9IXQXOiBFFykFEUfK
	gf/yghZrhDvK56CPtUgkQNZJJ4o48eAHbk+w2+zNIH1I2WSluBwq9Sp7ZZq8IsD5
	hwKkZ3d/Ih1qiI8jEOmWn9jKldK4echABEXov+MClFL+QMhTx7OJmsF68KYDnnWe
	1tB1+4zzLCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 488EA7F778;
	Thu, 24 Apr 2014 15:29:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFF4A7F773;
	Thu, 24 Apr 2014 15:29:22 -0400 (EDT)
In-Reply-To: <87tx9ia5zq.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 24 Apr 2014 21:21:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD459638-CBE6-11E3-B00A-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247003>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Traditionally, because the tool grew in a context of being used in a
>> project whose participants are at least not malicious, always having
>> to be on the lookout for fear of middle-of-line tabs hiding bad
>> contents near the right edges of lines has never been an issue.
>
> My beef is not with "hiding bad contents" but with "hiding contents".
> It makes the output useless for seeing what is actually happening as
> soon as the option starts having an effect.

My suspicion is that one of the reasons why S was chosen to be in
the default was to mildly discourage people from busting the usual
line-length limit, but I am not Linus ;-)
