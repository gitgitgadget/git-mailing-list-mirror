From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/15] Towards a more awesome git branch
Date: Mon, 10 Jun 2013 09:02:11 -0700
Message-ID: <7vli6ij6nw.fsf@alter.siamese.dyndns.org>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
	<CACsJy8D8FoiVFT5cNbXyxeAngAUJ1X3AdQOGK41FVWyZyEaSKw@mail.gmail.com>
	<CALkWK0kY1P_rLF45L37swzgLhgT7nxmcGpJGjAAhbQheA8pN7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:02:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um4Y3-000088-4I
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab3FJQCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 12:02:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072Ab3FJQCN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 12:02:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 051CB26522;
	Mon, 10 Jun 2013 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5dR5jKjwMQZkF889onFw0kG7utU=; b=w97Tam
	BB4yPQKINAywg5wU1bq6EE7hNt/SQJD+F00oBwyKniu3SlpPOTlM13I/pWYYjl+x
	WBuB3SKAkZFKNTvZwXzDvrzVc3CcZFJn5lwB2lARRVwzjMhzjiMhdbpv76LB1raB
	Z1O7pQ7R3DIx0T9xWc2jJdyiDhcyYD+y7yg/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ewKmeD1JrJBg93KD2KGK7T/BGoYPJ28a
	mNga3TvVWjUN09ZxM1VgrKytA3AFtUqfGfiJ0rLMCdo6DIDOdeLrxQQ9rPcGPn/m
	b60jwLUwNhZt+wZB1ht/iTMwhoWsTXXZa9ONp1tdIWYmqU/KQIihwqL+SLBLXqUV
	MxO2kwei5vs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F085026521;
	Mon, 10 Jun 2013 16:02:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70C4F26520;
	Mon, 10 Jun 2013 16:02:12 +0000 (UTC)
In-Reply-To: <CALkWK0kY1P_rLF45L37swzgLhgT7nxmcGpJGjAAhbQheA8pN7Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 10 Jun 2013 17:38:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CC27284-D1E7-11E2-88C6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227308>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> [-CC: Duy, since he has left the community]
>
> Junio: since Duy is no longer around to guide us, I will rely on your guidance.
>
> Duy Nguyen wrote:
>> I'm starting to think this is a half-baked solution. It hides
>> problems, for example commit placeholders should produce empty string,
>> not the literal placeholders.
>
> Why should they produce empty strings?  Aren't they equivalent to
> invalid placeholders?

I haven't even skimmed the series, so responding to a comment given
as a response to 00/15 is a bit difficult, but I _think_ this refers
to this issue: what should "%(cD)" produce when given to for-each-ref
and you have a tag that points at non committish?

http://thread.gmane.org/gmane.comp.version-control.git/226343/focus=226460

I may be guessing incorrectly what Duy's comment is about, though.

I'll hopefully have something more concrete and useful after I have
a chance to read the series, but not now.
