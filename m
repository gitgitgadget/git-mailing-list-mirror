From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] mark private symbols static
Date: Thu, 15 Jan 2015 09:52:18 -0800
Message-ID: <xmqqzj9k6iel.fsf@gitster.dls.corp.google.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
	<20150115071827.GG11028@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:52:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBoar-00078e-7a
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 18:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbbAORwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 12:52:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752198AbbAORwY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 12:52:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82E412EADD;
	Thu, 15 Jan 2015 12:52:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QQlaZABcr9+IX5cIIQC8YXIruUo=; b=shbPgQ
	iERjcE2N+rV1jtSusMWjmPSE57X6/r7xiL6j64U5rBzeuiyy+DzQY4PCSDdzd42s
	HptcExNaOm/jm3nx9ttpjvYG6N1q6MWKgEfeS24xNcQqFbpUd1ZCyaPc6ZuIYZjh
	J7aNTuBfdmiIAthEvi69Ehr6dSajyGB1dJ0Us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tu305uzDQuTqp+qQs1hYap1IDleYgYe1
	QzzPOcc6uD9sxuE88i0p6Q94UrfIhfj6sqkz0LE7YAha6LayS6FerurRzX3PCxYg
	TEXnbEUbjubRYoUGDSLAdLkFfOI6wml/el7zSijduP7/pOFRBNbPD+3PLJ2JUygU
	w0MfOtJkz3o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 79F0A2EADC;
	Thu, 15 Jan 2015 12:52:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 288B12EAD9;
	Thu, 15 Jan 2015 12:52:20 -0500 (EST)
In-Reply-To: <20150115071827.GG11028@peff.net> (Jeff King's message of "Thu,
	15 Jan 2015 02:18:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 411939E6-9CDF-11E4-AB33-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262493>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 14, 2015 at 03:40:45PM -0800, Junio C Hamano wrote:
>
>> Here are a handful of patches to make symbols that are only used
>> within a .c file as static.  This is not the kind of changes we
>> would want to do in the pre-release freeze period, and it is just
>> for reference.  I may later come back to them after 2.3 final is
>> tagged.
>
> I commented specifically on the ones that are in areas I touch a lot,
> but all of them look fine to me.

Thanks for reviews.

The primary reason I sent out this series was to show the reasoning
in 00/10 to decide what *not* to touch, by the way, to send a signal
to those who may want to throw unnecessary churn at the codebase, by
the way ;-)
