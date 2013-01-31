From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 12:44:50 -0800
Message-ID: <7vsj5hf5fh.fsf@alter.siamese.dyndns.org>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org> <20130131190747.GE27340@google.com>
 <7vip6dgmx2.fsf@alter.siamese.dyndns.org> <20130131195712.GH27340@google.com>
 <7va9rpgm06.fsf@alter.siamese.dyndns.org> <20130131201144.GJ27340@google.com>
 <7vwqutf5jv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 21:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U110V-0001bg-R8
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab3AaUoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:44:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41051 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506Ab3AaUow (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 15:44:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E42EC28A;
	Thu, 31 Jan 2013 15:44:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aBYDxHme71hg40+xVp8RzIQWxPY=; b=umxyWq
	fmuIzYgqZETzEehb5xeQiQ4EKG2uudGzThrf+bEdAGdGg2eH8YmilEUme+y1NlPv
	vuIUFIFrPKmT8e0afKXVppoJm6rcOsDIv/Pq6Z27s5jG9mCPtA/LC6nkCAiuCbH0
	AYn9AHJXGBcsq+Vasbn8I5Gy7IogovkYG2uWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h1vu7jg91hag6OI2on/JQ3J35Zq8qOpZ
	WM8nP4s36qXtxkOTiV2KXEzNjGUTZAl66s+N7m2C17ze/5838dRM/9pAyRz4pn2F
	WXbfRXsz/nemEiod2fE/+UGfpRuz/5jo3WvAQkEMfnSKkQxqX7RT450+5XOl+hJ7
	DSfAJBRd5ww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6349EC289;
	Thu, 31 Jan 2013 15:44:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2EE2C288; Thu, 31 Jan 2013
 15:44:51 -0500 (EST)
In-Reply-To: <7vwqutf5jv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 31 Jan 2013 12:42:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F9C60B2-6BE7-11E2-9370-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215169>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Am I really the only one that doesn't see the "--print" change as
>> hiding an option and sees burying "tracking" in the text as
>> qualitatively different?
>
> Sorry, but I do not understand the question.
>
> We are hiding/burying the "--print" option to make it clear that it
> is not a member with the same footing as others belonging to the
> group of options to the command.  It is accepted, but there is no
> reason for the user to choose it over --normalize.
>
> We want to make sure that "tracking" does not appear as if it is a
> member of the pull.default set with equal rights as others.  It is
> accepted, but there is no reason for the user to choose it over
> "upstream".

Now I re-read the proposed update, I think it is an improvement over
a straight revert in that it makes it clear that 'tracking' does not
belong, but I still think it is better to make it a sidenote to the
'upstream'.  It makes the connection between the two stronger.
