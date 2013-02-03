From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Getting started contributing.
Date: Sun, 03 Feb 2013 11:46:33 -0800
Message-ID: <7v1ucx9o4m.fsf@alter.siamese.dyndns.org>
References: <1359872508519-7576834.post@n2.nabble.com>
 <7vd2whalax.fsf@alter.siamese.dyndns.org>
 <CACsJy8AYOAwLKufQ34brk1agyFAX9xjgAE9_LAcRx=RGxcEZzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: adamfraser <adamfraser0@gmail.com>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 20:47:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U25Wm-0005ZP-BF
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 20:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab3BCTqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 14:46:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431Ab3BCTqh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 14:46:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA6D2C049;
	Sun,  3 Feb 2013 14:46:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dxCaxvukGHlNuXMiULNsQGVEx80=; b=HzyPDe
	dIYgq3x4UVSDkNpqP5gFj17gG10ZXvFDFsUjB0o7G8fwZBVg3I0KWyQfo3x1eaWx
	o/Iqq+9cTLLxuBW6HByNS7kpWs2l+FTcfLS+NQinc3Lvl0jT/adeapysbIOLvgMb
	fXn+8j1MGUSMclkfYQ8Y2aq0paIm6JigeAl1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ePNj3NMI6u+DCugYetHgqCgExZyECmVy
	DZNJs3+B+cBdBRP8hD6nlDT5QAEH6ZqL2mub8iCgU79QwPLRz8utTH4RIHlQUa7I
	sQ51dqJD8RbcOwfOSoY77aP8NPfcN/xL7RXnaXzOxB2AG2789N1/2eanbz34X2jP
	4SFKOw/EIn4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE834C048;
	Sun,  3 Feb 2013 14:46:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63D24C046; Sun,  3 Feb 2013
 14:46:36 -0500 (EST)
In-Reply-To: <CACsJy8AYOAwLKufQ34brk1agyFAX9xjgAE9_LAcRx=RGxcEZzg@mail.gmail.com> (Duy
 Nguyen's message of "Sun, 3 Feb 2013 16:54:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B6FA336-6E3A-11E2-B396-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215327>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Feb 3, 2013 at 2:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> On the other hand, there probably still are many loose ends.
>
> A few other things
>
>  - Mark more strings for translation (not as easy as it sounds, some
> strings can't be translated)

True, but not a good advice for somebody new, exactly for the reason
you stated, i.e. some strings must not be translated.

>  - Color more in the output where it makes sense

Eeek.

>  - Stop/Warn the user from updating HEAD (e.g. checkout another
> branch) while in the middle of a rebase (some makes sense, most is by
> mistake)

Perhaps, but again probably not for somebody new who hasn't mastered
various workflows and understood why it may make sense to allow it.
