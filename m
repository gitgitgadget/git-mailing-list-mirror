From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 18:56:06 -0800
Message-ID: <7vd2xb9kjd.fsf@alter.siamese.dyndns.org>
References: <A0DB01D693D8EF439496BC8B037A0AEF322039A7@xmb-rcd-x15.cisco.com>
 <20130111212325.GA18193@sigill.intra.peff.net>
 <CALWbr2xasF1y9j3G=-fQ9Wwg41Ymv=MMsWoqyuhweDov9KpRvg@mail.gmail.com>
 <7vy5fz9xdl.fsf@alter.siamese.dyndns.org>
 <CALWbr2wtAzz7yWb_Z_V0LFt5ddZcRSs7_rea2w=ghdC847mEyQ@mail.gmail.com>
 <7vmwwf9sx9.fsf@alter.siamese.dyndns.org> <50F0B643.20201@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, Jeff King <peff@peff.net>,
	"Matt Seitz \(matseitz\)" <matseitz@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Ben Aveling <bena.001@optusnet.com.au>
X-From: git-owner@vger.kernel.org Sat Jan 12 03:56:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtrGp-0001Bd-Rc
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 03:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475Ab3ALC4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 21:56:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985Ab3ALC4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 21:56:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 421D0AF38;
	Fri, 11 Jan 2013 21:56:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yMCGKJdbsXukgWly9jnsvouFl6s=; b=L618fJ
	ZwqPgm/6VHfWMK1r4NrE82nI/IuSV4DsURlZ6yFUoZw7Kjhs6o7hxAdz8cYpz38L
	+6YPE0CiRClONLznw131s3T+3iSCwmfnLgbhZ8R3nhem+fScCCf1qWTD5afiw1IX
	fhhFMzzbsnQbqZg8Uooe5It2IHkmwa61710y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o2qkL8qsQxk04U+1hoSGI3pk56Y8j2eS
	EPGtCp/zjer8rOny1kwRhqNFVZM4MD9P1uHI7kL0PDKMX/cOE9X4ifwf/DsJHBR9
	QWIc2IkhU+TyvqxUifA2Mv7Qon7gr9PV9TEh2N9ooweBR4ueBvgVdc9Y8HtZnz82
	NFYTkUU1bHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34A56AF34;
	Fri, 11 Jan 2013 21:56:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3855AF1A; Fri, 11 Jan 2013
 21:56:07 -0500 (EST)
In-Reply-To: <50F0B643.20201@optusnet.com.au> (Ben Aveling's message of "Sat,
 12 Jan 2013 12:02:59 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CDAF2BA-5C63-11E2-B48F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213257>

Ben Aveling <bena.001@optusnet.com.au> writes:

> On 12/01/2013 10:54 AM, Junio C Hamano wrote:
>> Antoine Pelisse <apelisse@gmail.com> writes:
>>
>>> I would simply go for:
>>>
>>>    What Message-ID are you replying to (if any)?
>>>
>>> If I don't know what to answer, I would definitely not say y/yes/n/no,
>>> but press enter directly.
>> Sounds sensible (even though technically you reply to a message
>> that has that message ID, and not to a message ID ;-)).
>>
>> Any better phrasing from others?  If not, I'd say we adopt this
>> text.
>
> I guess it depends on how much we mind if people accidentally miss the
> message ID.
>
> If we don't mind much, we could say something like:
>
>   What Message-ID are you replying to [Default=None]?
>
>
> If we are concerned that when a Message-ID exists, it should be
> provided, we could split to 2 questions:
>
>   Are you replying to an existing Message [Y/n]?
>
> And then, if the answer is Y,
>
>   What Message-ID are you replying to?

Eewww.  Now we come back to full circles.

It sometimes helps to follow the in-reply-to chain to see what has
already been said in the thread, I guess ;-)
