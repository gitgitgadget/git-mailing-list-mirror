From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t9700/test.pl: don't access private object members,
 use 	public access methods
Date: Tue, 29 Jun 2010 09:33:23 -0700
Message-ID: <7v8w5xbxyk.fsf@alter.siamese.dyndns.org>
References: <OYRSzEHOHSti8exa5KJzWIUEyJ8xb2sfcvm4pUcvYhBXldZMw8JzP6a6cRcRRIZjiOtW9kzmnVA@cipher.nrlssc.navy.mil> <AANLkTik3L7VcjezVK_8PCKsSpNFaTfYNvsOAgckhv-6K@mail.gmail.com> <9GBPdCANIkJqMOijhTovNxubG4uDjhkPBiOv42hdrzS-K6oLSFiVLg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jun 29 18:33:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTdkm-0003Q6-4z
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 18:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab0F2Qdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 12:33:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab0F2Qdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 12:33:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ACBEC0023;
	Tue, 29 Jun 2010 12:33:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YKdYufpU2Qd/pGJFdVvi5K+Uqt8=; b=oPYwtg
	8FEABAFpUM6jFTdefH4AAqcXnFPrchwbtehVCT8TGVcLTEJAC8dCFprKIn+ySSVu
	R6LUnjqktuGjwwAy8+M6f5bB9ecjHfd0flydrEAVoHF5cQ169xBeIVJkuNU6AqEi
	9CpLZKlfiijyZcOLLnoigr8YHYJf8y8jv8rqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tNDxw3HfW1GI8jTcl4ZrXSHx11lEtC+L
	OPxg5sonC/ez34dCcEHqHWcKDuC/SPEDgLmrs34ySR3AnHZrWM4DzQKu7FFHiT7H
	sreTkb6JUcLasTOVk4kPs+I+kpANead74I+pGMQ7gKj/9AjK3E+nHUS1bqmYjpKH
	DeOk/vCdD4M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BFA0C001D;
	Tue, 29 Jun 2010 12:33:30 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45BECC001C; Tue, 29 Jun
 2010 12:33:25 -0400 (EDT)
In-Reply-To: <9GBPdCANIkJqMOijhTovNxubG4uDjhkPBiOv42hdrzS-K6oLSFiVLg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue\, 29 Jun 2010 08\:21\:00 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D035F44-839C-11DF-9599-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149916>

Brandon Casey <casey@nrlssc.navy.mil> writes:

>>> There are public access methods available for retrieving and setting these
>>> variables, so let's use them instead.
>>>
>>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>> 
>> This looks good, sorry for the API mistake on my part.
>
> No problem.

Thanks, both of you.
