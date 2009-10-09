From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2009, #01; Wed, 07)
Date: Thu, 08 Oct 2009 23:47:09 -0700
Message-ID: <7v7hv56p3m.fsf@alter.siamese.dyndns.org>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org>
 <4ACD8D8E.3060606@gmail.com>
 <40aa078e0910081115q1bf924e8s22f3ee11dbe7c8b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:51:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw9Jh-0005Ea-I6
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbZJIGsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 02:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755994AbZJIGsA
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:48:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787AbZJIGr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 02:47:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA17051AF8;
	Fri,  9 Oct 2009 02:47:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eCfhFYAV8JkNuzyFNphJn6qsfKU=; b=mZCpbf
	dGa/1K0DX4xEad9VKbhnseC3sP87Xy88FSq0qrnLLmGn33PMaPDc7/83QqtE56Va
	vtfGUTFyisHww8vgoYtRjNarxOIxB2XZZDnUF/nXGlM/ofY+azmGkqr1PwK1KQks
	iLkXMhyoaDSzMa6Djr5IC0ekjFXG+l4dNisok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hMz0ZEd5mAwE5+klEgxTTjRuWAIb6FGT
	5AWYZz2/K7+gLaxRkjDaru6I/sWKeGXBupmjcpneW6q1rSk6CebCfkEPeuunxAFY
	aWC4p8Ull87LEC6X2AS3HAMSDiTS7V0H/OMND9U2Ts+cAtNUCMqmWdq7bfbrVScI
	+I2yI9iqszY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC87F51AF7;
	Fri,  9 Oct 2009 02:47:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 236CB51AF6; Fri,  9 Oct
 2009 02:47:11 -0400 (EDT)
In-Reply-To: <40aa078e0910081115q1bf924e8s22f3ee11dbe7c8b7@mail.gmail.com>
 (Erik Faye-Lund's message of "Thu\, 8 Oct 2009 20\:15\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 943B7E96-B49F-11DE-AC09-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129740>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> On Thu, Oct 8, 2009 at 8:58 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>> Junio C Hamano said the following on 08.10.2009 08:33:
>>>
>>> * ef/msys-imap (2009-10-03) 7 commits
>> ...
>> Don't forget about the MSVC patch ontop of this series:
>> Message-ID: <18cd41840910031300i32c74b15t74eb9eee23ff8469@mail.gmail.com>
>> Subject: [PATCH] MSVC: Enable OpenSSL, and translate -lcrypto
>
> I will include it in the next round I send out (unless someone objects)

Thanks.
