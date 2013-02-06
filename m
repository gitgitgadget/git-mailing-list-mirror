From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] i18n: mark OPTION_NUMBER (-NUM) for translation
Date: Tue, 05 Feb 2013 20:35:04 -0800
Message-ID: <7vip66njpj.fsf@alter.siamese.dyndns.org>
References: <20130205121552.GA16601@lanh>
 <883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com> <8d6d4d869ea58e0a26b3bb6377fc102728948997.1360080194.git.worldhello.net@gmail.com> <7vd2weu1sq.fsf@alter.siamese.dyndns.org> <CANYiYbF1cS=K9M0cwE5V0pUJMPEYGiJOjJwg5KQScCf8pjyTqw@mail.gmail.com> <7vpq0enoui.fsf@alter.siamese.dyndns.org> <CANYiYbF8DCPxqGQ2AFFXpSm0nO+wFDg=qrn9C8uoZO6fj__NHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 05:35:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2wjV-0007Zc-78
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 05:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757074Ab3BFEfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 23:35:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757066Ab3BFEfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 23:35:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2723DBA36;
	Tue,  5 Feb 2013 23:35:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OlS9Q5ILpNmBoZQHAPx5C2iNCIM=; b=It31qn
	CBLzbH9SshoQQbhY9lpjX4oZlEvcNesuZPGR6isenh0gU1kKRS+KV+HKoVTtz91V
	U34liqFllmCrhbYlCSCq9JvsFeJlsqLMtzw8AJg2Y/idHvkGojQ5AF8uz6+NWvrk
	xrK4IQLZV8alLfS6nqGgOUpuoVUUdZCG5XvY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e9dzcz90JOpy2vUzGKnTgjUWRc6Fptp4
	IHWAD29PrOe3uUL4wDkUPTDWWQxYd+sH/zKVriFCvcV4u7pK5jKl/LOXdEYeosuA
	9Mnc54uX55tIoVDKkKvKCuqhI7qoZK7dBWZZOoIcVGMccyQiPv4iTORzwQ8Qvw6c
	jIj4uKGrgNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCA82BA32;
	Tue,  5 Feb 2013 23:35:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93511BA2D; Tue,  5 Feb 2013
 23:35:11 -0500 (EST)
In-Reply-To: <CANYiYbF8DCPxqGQ2AFFXpSm0nO+wFDg=qrn9C8uoZO6fj__NHA@mail.gmail.com> (Jiang
 Xin's message of "Wed, 6 Feb 2013 11:02:27 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98138226-7016-11E2-A5B8-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215560>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/2/6 Junio C Hamano <gitster@pobox.com>:
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>> I agree, a helper named 'utf8_fprintf' in utf8.c is better.
>>> I will send a patch latter.
>>
>> Yeah, the idea of a helper function I agree with; I am not thrilled
>> with the name utf8_fprintf() though.  People use the return value of
>> fprintf() for error detection (negative return value means an error)
>> most of the time (even though non-negative value gives the number of
>> bytes shown), but the primary use of the return value from the
>> utf8_fprintf() function will be to get the display width, and the
>> name does not quite capture that.
>>
>
> How about this since [PATCH v3]:
>
> diff --git a/utf8.c b/utf8.c
> index 52dbd..b893a 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -443,8 +443,11 @@ int utf8_fprintf(FILE *stream, const char *format, ...)
>         strbuf_vaddf(&buf, format, arg);
>         va_end (arg);
>
> -       fputs(buf.buf, stream);
> -       columns = utf8_strwidth(buf.buf);
> +       columns = fputs(buf.buf, stream);
> +       /* If no error occurs, and really write something (columns > 0),
> +        * calculate really columns width with utf8_strwidth. */
> +       if (columns > 0)
> +               columns = utf8_strwidth(buf.buf);
>         strbuf_release(&buf);
>         return columns;
>  }

Yeah, the error checking is necessary; it would make your intention
more clear to say:

	if (0 <= columns)
		columns = utf8_strwidth(buf.buf);

though, as buf.buf _may_ be an empty string, and with the "if"
statement you are saying "we return the width only when output did
not result in an error".

The above bugfix does not address my original concern about
the name, though.
