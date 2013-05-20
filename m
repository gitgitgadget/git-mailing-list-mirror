From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] Doc rebase: Describe rebase as excluding merge commits
Date: Sun, 19 May 2013 21:43:35 -0700
Message-ID: <7v1u92xnuw.fsf@alter.siamese.dyndns.org>
References: <1368964329-1600-1-git-send-email-philipoakley@iee.org>
	<1368964329-1600-2-git-send-email-philipoakley@iee.org>
	<20130519180804.GE3362@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 06:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeHwl-0001i2-ME
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 06:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121Ab3ETEnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 00:43:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822Ab3ETEnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 00:43:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B190A16049;
	Mon, 20 May 2013 04:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k9MERDvIAghtxz0/dyxMmWSMZoA=; b=ve5qfI
	ovYmLcHqU3ZFVRIA6ybn7Q/nwQ8Kg9ihXRMUlQemfkPnnzB3ED0OesSDtmib8OUL
	DSpMKXtLb4Kn4SmowxFx3s6hQHEfrAvxgtZhTZOzSL6hv32ddkHC795UEEYOGD2f
	xe/KokumA0tZOyxiXbqLKbtfKXagqupMFVV2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RpSKLNnWS4drSVgurKg1m6PEYrAKEUYb
	Rop7cYQh/9/slENWHFHS249WFHpiP3Io+6Zul86xaZPUcXZ9KQwbRoBgK2c6cvZZ
	jnlw0nW04CLkagqYDy1pcOwo0UIKr8Da8edTyVHBGx8t4d9Ds4TSTYrwvCmc39wc
	wnMqIKcYN60=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A83DB16048;
	Mon, 20 May 2013 04:43:38 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D40C16045;
	Mon, 20 May 2013 04:43:37 +0000 (UTC)
In-Reply-To: <20130519180804.GE3362@elie.Belkin> (Jonathan Nieder's message of
	"Sun, 19 May 2013 11:08:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D668C95E-C107-11E2-B341-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224934>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Philip Oakley wrote:
>
>> Describe rebase in the description section.
>
> It already does that. :)  I think you mean "start with a summary",
> which is a valuable improvement.

It indeed is a good idea to give the "high-level introduction" at
the very beginning, but I do not think it should describe only one
of the three major modes of "git rebase" (i.e. no -m, no -i), like
the proposed patch text does.  We should instead say what it is used
for and why the user would want to use it that is common across
these modes at a very high level.

> 	DESCRIPTION
> 	-----------
> 	<brief description of the purpose of the command, including some token
> 	mention of *why* a user would want to use it (e.g., "so that the patches
> 	apply cleanly to their new base").>

Exactly.
