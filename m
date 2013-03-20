From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3200 (branch): modernize style
Date: Wed, 20 Mar 2013 14:34:48 -0700
Message-ID: <7vhak5dabr.fsf@alter.siamese.dyndns.org>
References: <1363782612-19260-1-git-send-email-artagnon@gmail.com>
 <7vwqt1dcp1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 22:35:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIQfI-000238-6D
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 22:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478Ab3CTVew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 17:34:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197Ab3CTVev (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 17:34:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D42A082;
	Wed, 20 Mar 2013 17:34:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WCnGF37gqcJdCOalCobFLujfI6w=; b=b+rT8S
	eSrQAhHkJhwAqCtuc1WAnWCr+VSCNsn74F3KFJafB/rKWT5Xk83WBIQ7SJnpL4cM
	PJiJ8y8VUh3KdbDNz0LCr55p1ZRVCxE4hdDsvBQSKi62jY4cQSxEF/kBO+ZiJsoD
	+kn8RXa/v9wGCn0tRPgxWImySW6F0xKr54rxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BG9frJQe34FxhFRHGqMA6NEyHuLxNyNb
	xRPXFfzwgvwfwLARdS01PTKrp9oXKbVAXMfUamiIwQdEEzmIp5YkojAezN8BhLzs
	7UledUgNENRAwbdKU0sfq855PGFK6PMqUWzQl73mIb1IpRP7I9rrQTppEsXGIo/N
	CTkcH1UrOV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB980A081;
	Wed, 20 Mar 2013 17:34:50 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 682EAA080; Wed, 20 Mar 2013
 17:34:50 -0400 (EDT)
In-Reply-To: <7vwqt1dcp1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 20 Mar 2013 13:43:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEC2CAA8-91A5-11E2-B163-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218683>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>>  Another random patch. Found it while grep'ping around.  I thought I
>>  could automate my work, which would have been the case if it was
>>  consistently inconsistent.  Unfortunately, it wasn't, and I ended up
>>  doing a lot of manual janitorial work :|
>
> Thanks.  It would have been nicer to also fix the redirection,
> e.g. "cmd >target" (not "cmd > target") that appear in the first
> hunk, i.e. this on top (I'll squash this in myself).

By the way, please pick a time when a file is quiescent, next time
when your grep urges you to do a file-wide clean-up.  I _think_ I
got the conflicts with an in-flight topic resolved correctly, but I
may have made trivial and stupid mistakes while doing so.

Thanks.
