From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing --graph --all output with detached branches
Date: Mon, 23 May 2016 14:18:31 -0700
Message-ID: <xmqqa8jg8od4.fsf@gitster.mtv.corp.google.com>
References: <CA+cck7FPzK-zccBVzphY_N41acOvqjwmDmgQH7ZE3SHG2k1rFw@mail.gmail.com>
	<xmqqvb2aoz13.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Bj=C3=B8rnar?= Snoksrud <snoksrud@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:18:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4xFJ-0007Qf-Na
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 23:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbcEWVSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 17:18:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63385 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751745AbcEWVSg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 17:18:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C502F1D2F6;
	Mon, 23 May 2016 17:18:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LeaUcaSdVZG4
	GZSN1mi0QRc9IEQ=; b=ab5JnIU8ybPfqRzQH5uVgK+YlEsT3Vkj8J1RHXo1u7d3
	vKLdK52dePYXq5yzbJ7N1KXSaCYhTX9N9tIMrrVjmSEDgayxeVCSfC7QHmVzWIxK
	F6C0q7CGTWpRb97MhYQts6oyur2tBGQRLZUW8ttz5GUK9xf7IVMHRex8idcC7qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xF1+Eh
	ei6fHxSw1Y9nTeeEqXFkfr8fQjkd/vj7Q+E6vDwCTKldKPKggkXpemTldA1JF2+B
	C+x/n963VLL+P+qKpROvTeo4Qo4Q3aYiS1bRF6QkENeQ4d6eVfAMkftI2TwJU/Hi
	rAXx3FG+9YHeT/OJChAs2GEJyQyVpt+gE9r14=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BCEA01D2F5;
	Mon, 23 May 2016 17:18:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 472451D2F4;
	Mon, 23 May 2016 17:18:34 -0400 (EDT)
In-Reply-To: <xmqqvb2aoz13.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 19 May 2016 08:20:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E81F1A68-212B-11E6-BD77-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295392>

Junio C Hamano <gitster@pobox.com> writes:

> Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com> writes:
>
>> .. which indicates that `foo` is contained within `bar`. Maybe
>>
>> *   ff4265f  (HEAD -> master) Merge branch 'bar'
>> |\
>> | * 0bbc311  (bar) 5
>> | * b1c9c49  4
>> |
>> | * ce053f9  (foo) 3
>> |/
>> * 8b62de9  2
>> * cb7e7e2  1
>>
>> .. would be better?
>
> Yes, it would be.

Another possibility would be to shift the columns between 4 and 3.
