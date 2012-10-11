From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default documented in "man git-push"?
Date: Thu, 11 Oct 2012 09:17:50 -0700
Message-ID: <7vehl57zkh.fsf@alter.siamese.dyndns.org>
References: <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
 <7vvcer4chm.fsf@alter.siamese.dyndns.org>
 <CACsJy8D5TCP+77NObD7Q58k6OKQhbZKU-i4tb2RX40xj5CPsgw@mail.gmail.com>
 <7va9w23i45.fsf@alter.siamese.dyndns.org>
 <CACsJy8BeWuKT_jUyRYf3cKrp7Jx07J2jPEZd96KbWEY+aiX24w@mail.gmail.com>
 <7vmx00u1nz.fsf@alter.siamese.dyndns.org> <20121011124326.GA30589@do>
 <vpqhaq13xdq.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 11 18:18:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMLSW-0003LG-2t
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 18:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab2JKQRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 12:17:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678Ab2JKQRx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 12:17:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E5C18928;
	Thu, 11 Oct 2012 12:17:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nl8vwly4caaSVeeO/Wxgf2im/J8=; b=W9UXuW
	UtsSs9fWs/8or+5AB0hntn7oMU29JzlFTH3oTwJmwYXNGmJOSVHLnnMSNO8lr7AO
	1hI/JfFU/idSWrGYKJzBPy1b9B3yeXu6Xm5WbBhdQY54DG/22WZf6G0RZ5BZTukm
	RJM3fJVtV0KE8Q2dcrVgfVvNT/5L2KRMQWQGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A+Fazcf6GhpN/B1TgGuONq2q6G7srs2N
	JRj75BpcXhIUr2HvR3NzuPzJO4MMi2MZAkb/BhA6Iz2vRY0yieUF6+GxF1fRQbsx
	9/HLqvrr6DlQG4UrEa/Yk4TmeYdRzgOFiygXB80VJLWrULNEJaUPH5lU06zSoFNH
	uidpr5G+z2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B9308927;
	Thu, 11 Oct 2012 12:17:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFB228926; Thu, 11 Oct 2012
 12:17:51 -0400 (EDT)
In-Reply-To: <vpqhaq13xdq.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Thu, 11 Oct 2012 16:18:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34C08812-13BF-11E2-BCEE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207483>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Fri, Oct 05, 2012 at 01:03:28PM -0700, Junio C Hamano wrote:
>>
>>> OK, the messages are supposed to advise how to turn them off, so we
>>> would want some code updates in that case.
>>
>> Something like this? It turns out none of the advice messages says
>> anything about advice.*.
>
> Personally, I'm fine with the current situation. Advanced users can read
> the documentation, and for others, the messages are usually more helpful
> than annoying.

OK, you convinced me.

> I disagree. Having advices turned on doesn't harm anyone. I don't
> remember anyone complaining about the verbosity of Git's advices. I've
> seen *many* more people complaining about the user-unfriendliness of
> Git.
>
> I'm fine with very verbose (and scary) messages when the user did
> something wrong (for example, the advice.implicitIdentity is something
> you should never see if you configured Git properly before commiting).
> But the user should not feel blamed for using the default configuration
> of advice messages. The tripple repetition in "git status" shown above
> really sounds like "hey, dumb user, why did you not set
> advice.statusHints already", and is doubly scary for newbies, because
> they are not told how to set the variable, nor what a config variable is
> to Git.

Let's let the list of advice.* messages in Documentation/config.txt
do their job.

Nguyen, thanks for taking a look.  I do agree the extra "here is how
to rob helpful hints from yourself before you learn them" seems to
do more harm than good.
