From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3400 (rebase): add failing test for a peculiar rev spec
Date: Fri, 19 Apr 2013 10:28:08 -0700
Message-ID: <7v7gjy2zx3.fsf@alter.siamese.dyndns.org>
References: <1366275155-26244-1-git-send-email-artagnon@gmail.com>
	<7vmwsv94jo.fsf@alter.siamese.dyndns.org>
	<CALkWK0=RDCCSxOJ2TU4=tniSRTg9VJohJ8Pf6uN9E=fd3jg=_Q@mail.gmail.com>
	<7vvc7i330b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 19:28:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTF6d-0000sF-Ta
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 19:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab3DSR2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 13:28:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054Ab3DSR2L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 13:28:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE22115753;
	Fri, 19 Apr 2013 17:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A9b7jBQPck9ZBpfyMyp64pb8uNM=; b=Tp/QPT
	wyMTKLO4d1QHGSFYvF18kKYwlvvSrt4qnfoQ9kTXXE38n2s6Z4tmE38pZHrQHLoS
	46h3Whd5h4BPBqtRL6slYjILzcUuMizi7ssFqsxM9gWlMtkNYuS1BUw8v1YHnGx7
	bAlhFB3t/f60Hg8tgXKSugEEUs93sVEYZvp30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fb+E9p1qS6QmBUStzTiFu/n40mhIfwa7
	nkmIyhie4f7orAW47JzSKHHEGguQNkqmzii4ohf3kAnQuoyIMpJQgFK/xZKUM0bF
	QRJhHlxQ1b3hJOezeNeHOfDvy2vn6Ims1ZnTEkyKXwfDVMxLGUh/HkwNawkBdF9c
	cVIGcMW+buA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B46F515752;
	Fri, 19 Apr 2013 17:28:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 346441574F;
	Fri, 19 Apr 2013 17:28:10 +0000 (UTC)
In-Reply-To: <7vvc7i330b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 19 Apr 2013 09:21:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8189F88A-A916-11E2-8150-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221782>

Junio C Hamano <gitster@pobox.com> writes:

> That would make this
>
> 	":/!(a=Ramkumar)(s=move diff.wordRegex)~4"
>
> a way to find the fourth-generation parent of ...

... 0b830ac52137 (Documentation: move diff.wordRegex from config.txt
to diff-config.txt, 2012-11-13)

I had a log output on another terminal and cut&paste a wrong one in
the original message.
