From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Documentation/git-commit.txt: correct a few minor
 grammatical mistakes
Date: Tue, 19 Feb 2013 09:33:57 -0800
Message-ID: <7va9r06we2.fsf@alter.siamese.dyndns.org>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
 <1361247427-438-4-git-send-email-drafnel@gmail.com>
 <20130219064304.GG19757@elie.Belkin>
 <CA+sFfMf8juf0rQh6S2sW=_LmsbhPc=c+erVppsZbAw-+h-4CqQ@mail.gmail.com>
 <20130219072924.GJ19757@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 18:34:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7r5G-0000k1-QS
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 18:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758801Ab3BSReA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 12:34:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758798Ab3BSRd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 12:33:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 046ECBEF5;
	Tue, 19 Feb 2013 12:33:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cEPPynGjKZPopRP6DjsdGlOYF48=; b=Ryb2dY
	IQA0WZlTJI09kp/7kT2i9zy9ODZeJ+FBRGWcmsKbqa86KGPlqQK//HlLwmAUcIqz
	iCNkd4HmMb7IAGRlddJSiulkgnQOlQ4O6glJNRI6LoLP1w9M97CDQw2LKPt1hPvo
	iG/9ns6A5AZsvuy+jGBJ1AkPHrVCmS+VKeAYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bLrQL8tEaXlM/gXLJ9WTuXxfrXAhxn6y
	nwBDp3LIrMzr9WqAdH5QS9zMo5a3flTNkF6iQB+kjdrxC3N2INjioLJWEE1jlW4C
	Mlhebbj/a4tIcR6JXAK5QAwSlJF7OYPPJvrLqkai/ozwZXrkUFglYJ4IaBZLG74h
	yI2Rj5Tc9Ws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBBD2BEF4;
	Tue, 19 Feb 2013 12:33:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69D9BBEF2; Tue, 19 Feb 2013
 12:33:58 -0500 (EST)
In-Reply-To: <20130219072924.GJ19757@elie.Belkin> (Jonathan Nieder's message
 of "Mon, 18 Feb 2013 23:29:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AB8FE0E-7ABA-11E2-9A40-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216637>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Brandon Casey wrote:
>
>> Hmm, I think the original text was more confusing than I realized.  I
>> think we should reorder the cleanup modes, placing "default" last, and
>> then describe default in terms of either strip or whitespace depending
>> on whether an editor will be spawned.
>
> Sounds good to me. :)

Will take 1-3 of the series for now, as the above seems to indicate
that I'll see a quick reroll of 4/4.

Thanks both for patches and review.
