From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] i18n: mark OPTION_NUMBER (-NUM) for translation
Date: Wed, 06 Feb 2013 07:47:39 -0800
Message-ID: <7va9rho350.fsf@alter.siamese.dyndns.org>
References: <20130205121552.GA16601@lanh>
 <883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com> <8d6d4d869ea58e0a26b3bb6377fc102728948997.1360080194.git.worldhello.net@gmail.com> <7vd2weu1sq.fsf@alter.siamese.dyndns.org> <CANYiYbF1cS=K9M0cwE5V0pUJMPEYGiJOjJwg5KQScCf8pjyTqw@mail.gmail.com> <7vpq0enoui.fsf@alter.siamese.dyndns.org> <CANYiYbF8DCPxqGQ2AFFXpSm0nO+wFDg=qrn9C8uoZO6fj__NHA@mail.gmail.com> <7vip66njpj.fsf@alter.siamese.dyndns.org> <CACsJy8DcXuFqjBtufQq1-0Vm3H4uxs03Crx+akY-kbrVgY8vUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 16:48:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U37EE-0004Lq-Ok
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab3BFPrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:47:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707Ab3BFPrm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 10:47:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EFF7B158;
	Wed,  6 Feb 2013 10:47:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I4mNajaLIKX9eI9F+H7l+d8xBsQ=; b=p4D47j
	dngm5PQLteJro2no3DAqodXDgQrBsB6XSR1vochZHN2rWXxvpM2GI5oevB4+LL8T
	/k86TCm9CSA/VvPJA3yAmwqjo5nVgvavbfACDzf6EQ0U5y1l0jaAOGhP/EeZX/de
	P5/k8liCmksKmBbK44RJNylb5zrIPnrK+41zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MxnQiNZpTEb5PPzhDzYjWz9ceVcq2F4c
	0lxXUDHes8jvMcq2ho8TIjcN2DvmXmO52hH30Fl1UtwluH9/tttxK+xRw8gqaGPZ
	t9RjXiBJHFKzYlGUlf7iLhsXKTBHKfk2vDPOutgS27D8936+3U6XSxOcpjBGs0rb
	lZk0Guebk2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23483B156;
	Wed,  6 Feb 2013 10:47:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82B28B153; Wed,  6 Feb 2013
 10:47:41 -0500 (EST)
In-Reply-To: <CACsJy8DcXuFqjBtufQq1-0Vm3H4uxs03Crx+akY-kbrVgY8vUw@mail.gmail.com> (Duy
 Nguyen's message of "Wed, 6 Feb 2013 17:45:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A6CC246-7074-11E2-8C41-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215590>

Duy Nguyen <pclouds@gmail.com> writes:

> How about utf8_fwprintf? wprintf() deals with wide characters and
> returns the number of wide characters, I think the name fits. And we
> could just drop utf8_ and use the existing name, because we don't use
> wchar_t* anyway.

Please, no.  That line of reasoning shows a horrible design taste
(or lack of taste).  "We don't use X right now" (or "We will promise
never to use X", for that matter) is never a good reason to abuse a
name that normal people would closely associate with X to something
that is completely different.  That leads to more confusion, not
less.

I guess utf8_fprintf() is not so bad after all.  fprintf() without
the utf8_ prefix is perfectly capable of showing a string encoded in
UTF-8, and anybody can correctly guess that the magic utf8_ prefix
would introduce (i.e. the difference between utf8_fprintf and
fprintf) can only be about the return value.  It can be reasonably
expected that everybody would then know that the display column
count can be the only sane return value that is different from what
fprintf() would return.
