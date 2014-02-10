From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bash completion patch
Date: Mon, 10 Feb 2014 10:38:21 -0800
Message-ID: <xmqqsirqstia.fsf@gitster.dls.corp.google.com>
References: <CAHtLG6Qgxq84Eo__vaXw5RAmyRuPnK-pt6n36+cjT8nVnRQN=w@mail.gmail.com>
	<vpqk3d9o83t.fsf@anie.imag.fr>
	<xmqq4n4d5rcn.fsf@gitster.dls.corp.google.com>
	<874n48ll1i.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>,
	git <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Feb 10 19:38:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCvkY-0007fR-MF
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 19:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbaBJSia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 13:38:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbaBJSi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 13:38:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61E866A5D4;
	Mon, 10 Feb 2014 13:38:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xal3NQa3lGp/zCcUY8lln0QsVew=; b=aDXbG8
	secDNSfzzUnIiNw9QbnvDhZKpHpNw2WQFGxfznfpUKbxkuwfM50RWYMYx0W9Zo9h
	SR+A8STYSbQfSPf0t6aKDmCg3UrErX6/4jzuldDxsaduYfy0mdSIbnUJE4LNMhkn
	is/q6dXXMKNvX5lU46Lgq8CI7zMehNpCO3sz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HuS/BClsJRFdmcPyaF6JjoQ+qYFk77y7
	A8Utf4NgrdwWX5esTlHpBKbEOxPjo//qpI33TiTnVWXBBQhW6sbWE7Qowtlll5Ph
	oAFiILfs6xOURNXlgP8zwuwYYn0NH2G4jxUniMl4n3TQDQHj2BPq9burQFsfeyev
	AY0UGSC8I44=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A49E6A5D2;
	Mon, 10 Feb 2014 13:38:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 844E06A5CD;
	Mon, 10 Feb 2014 13:38:24 -0500 (EST)
In-Reply-To: <874n48ll1i.fsf@thomasrast.ch> (Thomas Rast's message of "Sun, 09
	Feb 2014 09:58:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 86298774-9282-11E3-94B6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241920>

Thomas Rast <tr@thomasrast.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
> [...]
>>> don't forget to Cc Junio if
>>> you think your patch is ready for inclusion.
>>
>> Heh, thanks.  Everybody seems to think anything they send out to the
>> list is ready for inclusion, so the last part may not be a piece of
>> advice that is practically very useful, though ;-)
>
> That happens to me a lot, too.  Perhaps it would be a clearer signal if
> you had an alias (or just something like gitster+patch) that we can send
> it to if we mean "please include" instead of "what do you think of this"?

The intention from regulars like you I can read from the tone of the
message (or if you want to you can mention it in the log message).

If a clearer signal is really needed, perhaps we should say
something like:

    Send any patch that has not been reviewed on the list fist to
    the list and area experts (you can learn who they are by running
    "git blame" and "git shortlog" on the part of the system you are
    touching) for review.  Once the patch gains list consensus that
    it is a good change, and the maintainer hasn't picked it up
    (perhaps it fell through cracks), resend it to the maintainer
    with Cc: to the list.

We could phrase it more brutally:

    If it is the first time a particular patch is sent to the list, it
    almost always is not ready for inclusion.

but I do not think that is a good idea.
